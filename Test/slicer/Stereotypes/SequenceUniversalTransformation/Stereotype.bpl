type TStItem T;
type TStSlice = <T> [TStItem T] T;

function IsStaticStItem<T>(TStItem T) returns (bool);

const unique El: TStItem TRefReg;
axiom IsStaticStItem(El);

function StSliceAxEl(slice: TStSlice) returns (bool)
  {(forall o: TRef, o': TRef :: (o != null && o' != null) ==> (Disjoint(slice[El][o], slice[El][o']) || Equal(slice[El][o], slice[El][o'])))}

function StSliceAxElo(slice: TStSlice) returns (bool)
  {(forall o: TRef :: o != null ==> slice[El][o][o])}

function StSliceAxRegNN(slice: TStSlice) returns (bool)
  {(forall sliceItem: TStItem TRefReg, o: TRef ::  {slice[sliceItem][o]} !slice[sliceItem][o][null])}


function StSliceAxRefEl(slice: TStSlice) returns (bool)
  {(forall sliceItem: TStItem TRefRef, o: TRef ::  {slice[sliceItem][o]} slice[sliceItem][o] != null ==> slice[El][o][slice[sliceItem][o]])}


function StSliceAxRegEl(slice: TStSlice) returns (bool)
  {(forall sliceItem: TStItem TRefReg, o: TRef ::  {slice[sliceItem][o]} Subset(slice[sliceItem][o], slice[El][o]))}


function StSliceAxStaticeEl(slice: TStSlice) returns (bool)
  {(forall o: TRef, o': TRef :: {slice[El][o], slice[El][o']} slice[El][o][o'] ==> slice[El][o] == slice[El][o'])}

function StSliceAxStaticeSb(slice: TStSlice) returns (bool)
  {(forall o: TRef, o': TRef :: {slice[Sb][o], slice[Sb][o']} slice[El][o][o'] ==> slice[Sb][o] == slice[Sb][o'])}

function StSliceAxStaticeSe(slice: TStSlice) returns (bool)
  {(forall o: TRef, o': TRef :: {slice[Se][o], slice[Se][o']} slice[El][o][o'] ==> slice[Se][o] == slice[Se][o'])}


function StSliceAx(slice: TStSlice) returns (bool)
{  
     StSliceAxEl(slice)
  && StSliceAxElo(slice)
  && StSliceAxRegNN(slice)
  && StSliceAxRefEl(slice)
  && StSliceAxRegEl(slice)
  && StSliceAxStaticeEl(slice)
  && StSliceAxStaticeSb(slice)
  && StSliceAxStaticeSe(slice)
}
