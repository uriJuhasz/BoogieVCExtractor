type TSeqSlice = TStSlice;

const unique Sn: TStItem TRefRef;
axiom !IsStaticStItem(Sn);

const unique SNC: TStItem TRefReg;
axiom !IsStaticStItem(SNC);

const unique Se: TStItem TRefRef;
axiom IsStaticStItem(Se);

const unique Sp: TStItem TRefRef;
axiom !IsStaticStItem(Sp);

const unique SPC: TStItem TRefReg;
axiom !IsStaticStItem(SPC);

const unique Sb: TStItem TRefRef;
axiom IsStaticStItem(Sb);


function StSliceAxSeqStaticeEl(slice: TStSlice) returns (bool)
  {(forall o: TRef, o': TRef :: slice[El][o][o'] ==> slice[El][o] == slice[El][o'])}

function StSliceAxSeqStaticeSb(slice: TStSlice) returns (bool)
  {(forall o: TRef, o': TRef :: {slice[Sb][o], slice[Sb][o']} slice[El][o][o'] ==> slice[Sb][o] == slice[Sb][o'])}

function StSliceAxSeqStaticeSe(slice: TStSlice) returns (bool)
  {(forall o: TRef, o': TRef :: {slice[Se][o], slice[Se][o']} slice[El][o][o'] ==> slice[Se][o] == slice[Se][o'])}

function StSliceSeqInvbNN(s: TSeqSlice) returns (bool)
  {(forall o: TRef:: s[Sb][o] != null)}

function StSliceSeqInveNN(s: TSeqSlice) returns (bool)
  {(forall o: TRef:: s[Se][o] != null)}



function StSliceSeqAx(slice: TStSlice) returns (bool)
{  
     StSliceAxSeqStaticeEl(slice)
  && StSliceAxSeqStaticeSb(slice)
  && StSliceAxSeqStaticeSe(slice)
  && StSliceSeqInvbNN(slice)
  && StSliceSeqInveNN(slice)
}



function StSeqInvp(s: TSeqSlice, r: TReg, r': TReg) returns (bool)
{(
forall o: TRef, o': TRef :: {s[Sp][o], s[Sn][o']} (r[o] && r'[o']) ==> (
  s[Sp][o] == o' <==> s[Sn][o'] == o
))}

function StSeqInvb(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef::  r[o] ==> (
  o == s[Sb][o] <==> s[Sp][o] == null
))}

function StSeqInve(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef::  r[o] ==> (
  o == s[Se][o] <==> s[Sn][o] == null
))}

function StSeqInvNC1(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef:: {s[Se][o]} r[o] ==> (
  Equal(s[SNC][s[Se][o]], Empty)
))}

function StSeqInvNC2(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef :: {s[SNC][s[Sn][o]], s[Sn][o], s[SNC][o]} r[o] ==> (
  o != s[Se][o] ==> Equal(s[SNC][o], AddEl(s[SNC][s[Sn][o]], s[Sn][o]))
))}

function StSeqInvPC1(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef:: r[o] ==> (
  Equal(s[SPC][s[Sb][o]], Empty)
))}

function StSeqInvPC2(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef:: {s[SPC][s[Sp][o]], s[Sp][o], s[SPC][o]} r[o] ==> (
  o != s[Sb][o] ==> Equal(s[SPC][o], AddEl(s[SPC][s[Sp][o]], s[Sp][o]))
))}

function StSeqInvEl(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef:: r[o] ==> (
  Equal(s[El][o], Union(s[SPC][o], AddEl(s[SNC][o], o)))
))}

function StSeqInvPCNC(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef:: r[o] ==> (
  Disjoint(s[SPC][o], s[SNC][o])
))}

function StSeqInvNCo(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef:: r[o] ==> (
  !s[SNC][o][o]
))}

function StSeqInvPCo(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef:: r[o] ==> (
  !s[SPC][o][o]
))}

function StSeqInvNCe(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef:: r[o] ==> (
  o != s[Se][o] ==> s[SNC][o][s[Se][o]]
))}

function StSeqInvPCb(s: TSeqSlice, r: TReg) returns (bool)
{(
forall o: TRef:: r[o] ==> (
  o != s[Sb][o] ==> s[SPC][o][s[Sb][o]]
))}

function StSeqInvNCNC(s: TSeqSlice, r: TReg, r': TReg) returns (bool)
{(
forall o: TRef, o': TRef :: {s[SNC][o'], s[SNC][o]} (r[o] && r'[o']) ==> (
  s[SNC][o][o'] ==> Subset(s[SNC][o'], s[SNC][o])
))}

function StSeqInvPCPC(s: TSeqSlice, r: TReg, r': TReg) returns (bool)
{(
forall o: TRef, o': TRef :: {s[SPC][o'], s[SPC][o]} (r[o] && r'[o']) ==> (
  s[SPC][o][o'] ==> Subset(s[SPC][o'], s[SPC][o])
))}

function StSeqInv(s: TSeqSlice, r: TReg) returns (bool)
{
     StSeqInvp(s, r, r)
  && StSeqInvb(s, r)
  && StSeqInve(s, r)
  && StSeqInvNC1(s, r)
  && StSeqInvNC2(s, r)
  && StSeqInvPC1(s, r)
  && StSeqInvPC2(s, r)
  && StSeqInvEl(s, r)
  && StSeqInvPCNC(s, r)
  && StSeqInvNCo(s, r)
  && StSeqInvPCo(s, r)
  && StSeqInvNCe(s, r)
  && StSeqInvPCb(s, r)
  && StSeqInvNCNC(s, r, r)
  && StSeqInvPCPC(s, r, r)
}

