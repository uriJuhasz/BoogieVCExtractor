
procedure f(x:int, g:int) returns (r:int);
//	requires x>=0;
//	requires g>0;
	
//	ensures r>=0;

implementation f(x:int, g:int) returns (r:int)
{
	var y : int;

	y := x + 1;
	assert(y>x);
}
	

