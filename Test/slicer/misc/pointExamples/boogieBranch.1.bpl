procedure m(b1:bool,b2:bool) returns (x:int)
	ensures x>0;
{
	x := 0;
	if (b1)
	{
		x:=x+1;
	}else{
		x:=x+2;
	}
	if (b2)
	{
		x:=x+3;
	}else{
		x:=x+4;
	}
}
