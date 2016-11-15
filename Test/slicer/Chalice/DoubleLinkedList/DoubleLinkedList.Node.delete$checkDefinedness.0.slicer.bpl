type Integer = int;
type Boolean = bool;
type HeapType = <a>[ref,Field (a)]a;
type MaskType = <a>[ref,Field (a)][PermissionComponent]int;
type CreditsType = [ref]int;
type ArgSeq = <T>[int]T;
type string = int;
type Field m0;
type ref;
type PermissionComponent;
type PartialHeapType;
type ModuleName;
type TypeName;
type Mu;
const null : ref;
const unique perm$R : PermissionComponent;
const unique perm$N : PermissionComponent;
const Permission$denominator : int;
const Permission$FullFraction : int;
const Permission$Zero : [PermissionComponent]int;
const Permission$Full : [PermissionComponent]int;
const ZeroMask : MaskType;
const unique joinable : Field (int);
const unique token#t : TypeName;
const unique forkK : Field (int);
const channelK : int;
const monitorK : int;
const predicateK : int;
const emptyPartialHeap : PartialHeapType;
const CurrentModule : ModuleName;
const CanAssumeFunctionDefs : bool;
const unique mu : Field (Mu);
const $LockBottom : Mu;
const unique held : Field (int);
const unique rdheld : Field (bool);
const ZeroCredits : CreditsType;
const unique Node#t : TypeName;
const unique module#default : ModuleName;
const unique Node.next : Field (ref);
const unique Node.prev : Field (ref);
const unique Node.inv : Field (int);
const unique Node.invLeft : Field (int);
const unique Node.invRight : Field (int);
const $old_Heap : HeapType;
const $old_Mask : MaskType;
const $old_SecMask : MaskType;
const $old_Credits : CreditsType;
function Fractions(int) : int;
function IsGoodState(PartialHeapType) : bool;
function combine(PartialHeapType,PartialHeapType) : PartialHeapType;
function heapFragment <T> (T) : PartialHeapType;
function dtype(ref) : TypeName;
function MuBelow(Mu,Mu) : bool;
function Acquire$Heap(int) : HeapType;
function Acquire$Mask(int) : MaskType;
function Acquire$SecMask(int) : MaskType;
function Acquire$Credits(int) : CreditsType;
function LastSeen$Heap(Mu,int) : HeapType;
function LastSeen$Mask(Mu,int) : MaskType;
function LastSeen$SecMask(Mu,int) : MaskType;
function LastSeen$Credits(Mu,int) : CreditsType;
function wf(HeapType,MaskType,MaskType) : bool;
function IsGoodInhaleState(HeapType,HeapType,MaskType,MaskType) : bool;
function IsGoodExhaleState(HeapType,HeapType,MaskType,MaskType) : bool;
function {:expand  false} CanRead <T> (MaskType,MaskType,ref,Field (T)) : bool;
function {:expand  false} CanReadForSure <T> (MaskType,ref,Field (T)) : bool;
function {:expand  false} CanWrite <T> (MaskType,ref,Field (T)) : bool;
function {:expand  true} IsGoodMask(MaskType) : bool;
function DecPerm <T> (MaskType,ref,Field (T),int) : MaskType;
function DecEpsilons <T> (MaskType,ref,Field (T),int) : MaskType;
function IncPerm <T> (MaskType,ref,Field (T),int) : MaskType;
function IncEpsilons <T> (MaskType,ref,Field (T),int) : MaskType;
function Havocing <T,U> (HeapType,ref,Field (T),U) : HeapType;
function Call$Heap(int) : HeapType;
function Call$Mask(int) : MaskType;
function Call$SecMask(int) : MaskType;
function Call$Credits(int) : CreditsType;
function Call$Args(int) : ArgSeq;
function EmptyMask(MaskType) : bool;
function EmptyCredits(CreditsType) : bool;
function NonPredicateField <T> (Field (T)) : bool;
function PredicateField <T> (Field (T)) : bool;
function submask(MaskType,MaskType) : bool;
function ite <T> (bool,T,T) : T;
function #Node.inv#trigger(ref) : bool;
function #Node.invLeft#trigger(ref) : bool;
function #Node.invRight#trigger(ref) : bool;
var Heap : HeapType;
var Mask : MaskType;
var SecMask : MaskType;
var Credits : CreditsType;
var methodK#_170 : int;
var Mask_$_0 : MaskType;
var predVer#_172_$_0 : int;
var unfoldingK#_179 : int;
var unfoldingMask#_175_$_0 : MaskType;
var unfoldingHeap#_174_$_1 : HeapType;
var unfoldingMask#_175_$_1 : MaskType;
var unfoldingMask#_175_$_2 : MaskType;
var unfoldingMask#_175_$_3 : MaskType;
var unfoldingMask#_175_$_5 : MaskType;
var unfoldingSecMask#_176_$_5 : MaskType;
var unfoldingSecMask#_176_$_11 : MaskType;
var unfoldingMask#_175_$_7 : MaskType;
var SecMask_$_0 : MaskType;
var SecMask_$_1 : MaskType;
var SecMask_$_2 : MaskType;
var SecMask_$_4 : MaskType;
var SecMask_$_6 : MaskType;
var Heap_$_0 : HeapType;
var Mask_$_1 : MaskType;
var Mask_$_3 : MaskType;
var unfoldingK#_289 : int;
var unfoldingHeap#_284_$_0 : HeapType;
var unfoldingMask#_285_$_0 : MaskType;
var unfoldingSecMask#_286_$_0 : MaskType;
var unfoldingCredits#_287_$_0 : CreditsType;
var unfoldingMask#_285_$_1 : MaskType;
var unfoldingSecMask#_286_$_18 : MaskType;
var unfoldingHeap#_284_$_2 : HeapType;
var unfoldingMask#_285_$_2 : MaskType;
var unfoldingMask#_285_$_3 : MaskType;
var unfoldingMask#_285_$_4 : MaskType;
var unfoldingMask#_285_$_6 : MaskType;
var unfoldingSecMask#_286_$_24 : MaskType;
var unfoldingSecMask#_286_$_30 : MaskType;
var unfoldingMask#_285_$_8 : MaskType;
var unfoldingMask#_285_$_7 : MaskType;
var predRec#_311_$_0 : ref;
var predVer#_312_$_0 : int;
var unfoldingSecMask#_286_$_25 : MaskType;
var unfoldingSecMask#_286_$_26 : MaskType;
var unfoldingSecMask#_286_$_27 : MaskType;
var unfoldingSecMask#_286_$_29 : MaskType;
var unfoldingSecMask#_286_$_28 : MaskType;
var unfoldingMask#_285_$_5 : MaskType;
var predRec#_302_$_0 : ref;
var predVer#_303_$_0 : int;
var unfoldingSecMask#_286_$_19 : MaskType;
var unfoldingSecMask#_286_$_20 : MaskType;
var unfoldingSecMask#_286_$_21 : MaskType;
var unfoldingSecMask#_286_$_23 : MaskType;
var unfoldingSecMask#_286_$_22 : MaskType;
var oldVers#_300_$_0 : int;
var unfoldingHeap#_284_$_1 : HeapType;
var newVers#_301_$_0 : int;
var unfoldingSecMask#_286_$_1 : MaskType;
var unfoldingSecMask#_286_$_3 : MaskType;
var unfoldingSecMask#_286_$_4 : MaskType;
var unfoldingSecMask#_286_$_6 : MaskType;
var unfoldingSecMask#_286_$_7 : MaskType;
var unfoldingSecMask#_286_$_9 : MaskType;
var unfoldingSecMask#_286_$_13 : MaskType;
var unfoldingSecMask#_286_$_17 : MaskType;
var unfoldingSecMask#_286_$_14 : MaskType;
var unfoldingSecMask#_286_$_16 : MaskType;
var unfoldingSecMask#_286_$_15 : MaskType;
var unfoldingSecMask#_286_$_10 : MaskType;
var unfoldingSecMask#_286_$_12 : MaskType;
var unfoldingSecMask#_286_$_11 : MaskType;
var unfoldingSecMask#_286_$_8 : MaskType;
var unfoldingSecMask#_286_$_5 : MaskType;
var unfoldingSecMask#_286_$_2 : MaskType;
var Mask_$_2 : MaskType;
var unfoldingK#_222 : int;
var unfoldingMask#_218_$_0 : MaskType;
var unfoldingHeap#_217_$_1 : HeapType;
var unfoldingMask#_218_$_1 : MaskType;
var unfoldingMask#_218_$_2 : MaskType;
var unfoldingMask#_218_$_3 : MaskType;
var unfoldingMask#_218_$_5 : MaskType;
var unfoldingSecMask#_219_$_5 : MaskType;
var unfoldingSecMask#_176_$_12 : MaskType;
var unfoldingSecMask#_176_$_13 : MaskType;
var unfoldingSecMask#_176_$_14 : MaskType;
var unfoldingK#_254 : int;
var unfoldingMask#_250_$_0 : MaskType;
var unfoldingHeap#_249_$_1 : HeapType;
var unfoldingMask#_250_$_1 : MaskType;
var unfoldingMask#_250_$_2 : MaskType;
var unfoldingMask#_250_$_3 : MaskType;
var unfoldingMask#_250_$_5 : MaskType;
var unfoldingSecMask#_251_$_5 : MaskType;
var unfoldingSecMask#_219_$_6 : MaskType;
var unfoldingSecMask#_219_$_7 : MaskType;
var unfoldingSecMask#_219_$_8 : MaskType;
var unfoldingSecMask#_219_$_9 : MaskType;
var unfoldingMask#_250_$_4 : MaskType;
var predRec#_266_$_0 : ref;
var predVer#_267_$_0 : int;
var unfoldingSecMask#_251_$_0 : MaskType;
var unfoldingSecMask#_251_$_1 : MaskType;
var unfoldingSecMask#_251_$_2 : MaskType;
var unfoldingSecMask#_251_$_4 : MaskType;
var unfoldingSecMask#_251_$_3 : MaskType;
var oldVers#_264_$_0 : int;
var unfoldingHeap#_249_$_0 : HeapType;
var newVers#_265_$_0 : int;
var unfoldingSecMask#_176_$_15 : MaskType;
var unfoldingMask#_218_$_4 : MaskType;
var predRec#_234_$_0 : ref;
var predVer#_235_$_0 : int;
var unfoldingSecMask#_219_$_0 : MaskType;
var unfoldingSecMask#_219_$_1 : MaskType;
var unfoldingSecMask#_219_$_2 : MaskType;
var unfoldingSecMask#_219_$_4 : MaskType;
var unfoldingSecMask#_219_$_3 : MaskType;
var oldVers#_232_$_0 : int;
var unfoldingHeap#_217_$_0 : HeapType;
var newVers#_233_$_0 : int;
var SecMask_$_5 : MaskType;
var SecMask_$_3 : MaskType;
var unfoldingMask#_175_$_6 : MaskType;
var predRec#_201_$_0 : ref;
var predVer#_202_$_0 : int;
var unfoldingSecMask#_176_$_6 : MaskType;
var unfoldingSecMask#_176_$_7 : MaskType;
var unfoldingSecMask#_176_$_8 : MaskType;
var unfoldingSecMask#_176_$_10 : MaskType;
var unfoldingSecMask#_176_$_9 : MaskType;
var unfoldingMask#_175_$_4 : MaskType;
var predRec#_192_$_0 : ref;
var predVer#_193_$_0 : int;
var unfoldingSecMask#_176_$_0 : MaskType;
var unfoldingSecMask#_176_$_1 : MaskType;
var unfoldingSecMask#_176_$_2 : MaskType;
var unfoldingSecMask#_176_$_4 : MaskType;
var unfoldingSecMask#_176_$_3 : MaskType;
var oldVers#_190_$_0 : int;
var unfoldingHeap#_174_$_0 : HeapType;
var newVers#_191_$_0 : int;
var predRec#_171 : ref;
var predFlag#_173 : bool;
var predVer#_172 : int;
var predFlag#_178 : bool;
var unfoldingHeap#_174 : HeapType;
var unfoldingMask#_175 : MaskType;
var unfoldingSecMask#_176 : MaskType;
var unfoldingCredits#_177 : CreditsType;
var oldVers#_190 : int;
var newVers#_191 : int;
var predRec#_192 : ref;
var predFlag#_194 : bool;
var predVer#_193 : int;
var predRec#_201 : ref;
var predFlag#_203 : bool;
var predVer#_202 : int;
var predFlag#_221 : bool;
var unfoldingHeap#_217 : HeapType;
var unfoldingMask#_218 : MaskType;
var unfoldingSecMask#_219 : MaskType;
var unfoldingCredits#_220 : CreditsType;
var oldVers#_232 : int;
var newVers#_233 : int;
var predRec#_234 : ref;
var predFlag#_236 : bool;
var predVer#_235 : int;
var predFlag#_253 : bool;
var unfoldingHeap#_249 : HeapType;
var unfoldingMask#_250 : MaskType;
var unfoldingSecMask#_251 : MaskType;
var unfoldingCredits#_252 : CreditsType;
var oldVers#_264 : int;
var newVers#_265 : int;
var predRec#_266 : ref;
var predFlag#_268 : bool;
var predVer#_267 : int;
var predFlag#_288 : bool;
var unfoldingHeap#_284 : HeapType;
var unfoldingMask#_285 : MaskType;
var unfoldingSecMask#_286 : MaskType;
var unfoldingCredits#_287 : CreditsType;
var oldVers#_300 : int;
var newVers#_301 : int;
var predRec#_302 : ref;
var predFlag#_304 : bool;
var predVer#_303 : int;
var predRec#_311 : ref;
var predFlag#_313 : bool;
var predVer#_312 : int;
procedure Node.delete$checkDefinedness (this : ref) returns (newList#0 : ref)
{
	var methodK#_170 : int;
	var predRec#_171 : ref;
	var predFlag#_173 : bool;
	var predVer#_172 : int;
	var unfoldingK#_179 : int;
	var predFlag#_178 : bool;
	var unfoldingHeap#_174 : HeapType;
	var unfoldingMask#_175 : MaskType;
	var unfoldingSecMask#_176 : MaskType;
	var unfoldingCredits#_177 : CreditsType;
	var oldVers#_190 : int;
	var newVers#_191 : int;
	var predRec#_192 : ref;
	var predFlag#_194 : bool;
	var predVer#_193 : int;
	var predRec#_201 : ref;
	var predFlag#_203 : bool;
	var predVer#_202 : int;
	var unfoldingK#_222 : int;
	var predFlag#_221 : bool;
	var unfoldingHeap#_217 : HeapType;
	var unfoldingMask#_218 : MaskType;
	var unfoldingSecMask#_219 : MaskType;
	var unfoldingCredits#_220 : CreditsType;
	var oldVers#_232 : int;
	var newVers#_233 : int;
	var predRec#_234 : ref;
	var predFlag#_236 : bool;
	var predVer#_235 : int;
	var unfoldingK#_254 : int;
	var predFlag#_253 : bool;
	var unfoldingHeap#_249 : HeapType;
	var unfoldingMask#_250 : MaskType;
	var unfoldingSecMask#_251 : MaskType;
	var unfoldingCredits#_252 : CreditsType;
	var oldVers#_264 : int;
	var newVers#_265 : int;
	var predRec#_266 : ref;
	var predFlag#_268 : bool;
	var predVer#_267 : int;
	var unfoldingK#_289 : int;
	var predFlag#_288 : bool;
	var unfoldingHeap#_284 : HeapType;
	var unfoldingMask#_285 : MaskType;
	var unfoldingSecMask#_286 : MaskType;
	var unfoldingCredits#_287 : CreditsType;
	var oldVers#_300 : int;
	var newVers#_301 : int;
	var predRec#_302 : ref;
	var predFlag#_304 : bool;
	var predVer#_303 : int;
	var predRec#_311 : ref;
	var predFlag#_313 : bool;
	var predVer#_312 : int;
	var Mask_$_0 : MaskType;
	var predVer#_172_$_0 : int;
	var unfoldingMask#_175_$_0 : MaskType;
	var oldVers#_190_$_0 : int;
	var newVers#_191_$_0 : int;
	var unfoldingHeap#_174_$_0 : HeapType;
	var unfoldingHeap#_174_$_1 : HeapType;
	var unfoldingMask#_175_$_1 : MaskType;
	var unfoldingMask#_175_$_2 : MaskType;
	var unfoldingMask#_175_$_3 : MaskType;
	var unfoldingMask#_175_$_4 : MaskType;
	var predRec#_192_$_0 : ref;
	var predVer#_193_$_0 : int;
	var unfoldingSecMask#_176_$_0 : MaskType;
	var unfoldingSecMask#_176_$_1 : MaskType;
	var unfoldingSecMask#_176_$_2 : MaskType;
	var unfoldingSecMask#_176_$_3 : MaskType;
	var unfoldingSecMask#_176_$_4 : MaskType;
	var unfoldingMask#_175_$_5 : MaskType;
	var unfoldingSecMask#_176_$_5 : MaskType;
	var unfoldingMask#_175_$_6 : MaskType;
	var predRec#_201_$_0 : ref;
	var predVer#_202_$_0 : int;
	var unfoldingSecMask#_176_$_6 : MaskType;
	var unfoldingSecMask#_176_$_7 : MaskType;
	var unfoldingSecMask#_176_$_8 : MaskType;
	var unfoldingSecMask#_176_$_9 : MaskType;
	var unfoldingSecMask#_176_$_10 : MaskType;
	var unfoldingSecMask#_176_$_11 : MaskType;
	var unfoldingMask#_175_$_7 : MaskType;
	var SecMask_$_0 : MaskType;
	var SecMask_$_1 : MaskType;
	var SecMask_$_2 : MaskType;
	var SecMask_$_3 : MaskType;
	var SecMask_$_4 : MaskType;
	var SecMask_$_5 : MaskType;
	var SecMask_$_6 : MaskType;
	var unfoldingMask#_218_$_0 : MaskType;
	var oldVers#_232_$_0 : int;
	var newVers#_233_$_0 : int;
	var unfoldingHeap#_217_$_0 : HeapType;
	var unfoldingHeap#_217_$_1 : HeapType;
	var unfoldingMask#_218_$_1 : MaskType;
	var unfoldingMask#_218_$_2 : MaskType;
	var unfoldingMask#_218_$_3 : MaskType;
	var unfoldingMask#_218_$_4 : MaskType;
	var predRec#_234_$_0 : ref;
	var predVer#_235_$_0 : int;
	var unfoldingSecMask#_219_$_0 : MaskType;
	var unfoldingSecMask#_219_$_1 : MaskType;
	var unfoldingSecMask#_219_$_2 : MaskType;
	var unfoldingSecMask#_219_$_3 : MaskType;
	var unfoldingSecMask#_219_$_4 : MaskType;
	var unfoldingMask#_218_$_5 : MaskType;
	var unfoldingSecMask#_219_$_5 : MaskType;
	var unfoldingSecMask#_176_$_12 : MaskType;
	var unfoldingSecMask#_176_$_13 : MaskType;
	var unfoldingSecMask#_176_$_14 : MaskType;
	var unfoldingSecMask#_176_$_15 : MaskType;
	var unfoldingMask#_250_$_0 : MaskType;
	var oldVers#_264_$_0 : int;
	var newVers#_265_$_0 : int;
	var unfoldingHeap#_249_$_0 : HeapType;
	var unfoldingHeap#_249_$_1 : HeapType;
	var unfoldingMask#_250_$_1 : MaskType;
	var unfoldingMask#_250_$_2 : MaskType;
	var unfoldingMask#_250_$_3 : MaskType;
	var unfoldingMask#_250_$_4 : MaskType;
	var predRec#_266_$_0 : ref;
	var predVer#_267_$_0 : int;
	var unfoldingSecMask#_251_$_0 : MaskType;
	var unfoldingSecMask#_251_$_1 : MaskType;
	var unfoldingSecMask#_251_$_2 : MaskType;
	var unfoldingSecMask#_251_$_3 : MaskType;
	var unfoldingSecMask#_251_$_4 : MaskType;
	var unfoldingMask#_250_$_5 : MaskType;
	var unfoldingSecMask#_251_$_5 : MaskType;
	var unfoldingSecMask#_219_$_6 : MaskType;
	var unfoldingSecMask#_219_$_7 : MaskType;
	var unfoldingSecMask#_219_$_8 : MaskType;
	var unfoldingSecMask#_219_$_9 : MaskType;
	var Heap_$_0 : HeapType;
	var Mask_$_1 : MaskType;
	var Mask_$_2 : MaskType;
	var Mask_$_3 : MaskType;
	var unfoldingHeap#_284_$_0 : HeapType;
	var unfoldingMask#_285_$_0 : MaskType;
	var unfoldingSecMask#_286_$_0 : MaskType;
	var unfoldingCredits#_287_$_0 : CreditsType;
	var unfoldingMask#_285_$_1 : MaskType;
	var unfoldingSecMask#_286_$_1 : MaskType;
	var unfoldingSecMask#_286_$_2 : MaskType;
	var unfoldingSecMask#_286_$_3 : MaskType;
	var unfoldingSecMask#_286_$_4 : MaskType;
	var unfoldingSecMask#_286_$_5 : MaskType;
	var unfoldingSecMask#_286_$_6 : MaskType;
	var unfoldingSecMask#_286_$_7 : MaskType;
	var unfoldingSecMask#_286_$_8 : MaskType;
	var unfoldingSecMask#_286_$_9 : MaskType;
	var unfoldingSecMask#_286_$_10 : MaskType;
	var unfoldingSecMask#_286_$_11 : MaskType;
	var unfoldingSecMask#_286_$_12 : MaskType;
	var unfoldingSecMask#_286_$_13 : MaskType;
	var unfoldingSecMask#_286_$_14 : MaskType;
	var unfoldingSecMask#_286_$_15 : MaskType;
	var unfoldingSecMask#_286_$_16 : MaskType;
	var unfoldingSecMask#_286_$_17 : MaskType;
	var unfoldingSecMask#_286_$_18 : MaskType;
	var oldVers#_300_$_0 : int;
	var newVers#_301_$_0 : int;
	var unfoldingHeap#_284_$_1 : HeapType;
	var unfoldingHeap#_284_$_2 : HeapType;
	var unfoldingMask#_285_$_2 : MaskType;
	var unfoldingMask#_285_$_3 : MaskType;
	var unfoldingMask#_285_$_4 : MaskType;
	var unfoldingMask#_285_$_5 : MaskType;
	var predRec#_302_$_0 : ref;
	var predVer#_303_$_0 : int;
	var unfoldingSecMask#_286_$_19 : MaskType;
	var unfoldingSecMask#_286_$_20 : MaskType;
	var unfoldingSecMask#_286_$_21 : MaskType;
	var unfoldingSecMask#_286_$_22 : MaskType;
	var unfoldingSecMask#_286_$_23 : MaskType;
	var unfoldingMask#_285_$_6 : MaskType;
	var unfoldingSecMask#_286_$_24 : MaskType;
	var unfoldingMask#_285_$_7 : MaskType;
	var predRec#_311_$_0 : ref;
	var predVer#_312_$_0 : int;
	var unfoldingSecMask#_286_$_25 : MaskType;
	var unfoldingSecMask#_286_$_26 : MaskType;
	var unfoldingSecMask#_286_$_27 : MaskType;
	var unfoldingSecMask#_286_$_28 : MaskType;
	var unfoldingSecMask#_286_$_29 : MaskType;
	var unfoldingSecMask#_286_$_30 : MaskType;
	var unfoldingMask#_285_$_8 : MaskType;
	var $_$_condition : bool;
	var $_$_condition_$0 : bool;
	var $_$_condition_$1 : bool;
	var $_$_condition_$2 : bool;
	var $_$_condition_$3 : bool;
	var $_$_condition_$4 : bool;
	var $_$_condition_$5 : bool;
	var $_$_condition_$6 : bool;
	var $_$_condition_$7 : bool;
	var $_$_condition_$8 : bool;
	var $_$_condition_$9 : bool;
	var $_$_condition_$10 : bool;
	var $_$_condition_$11 : bool;
	var $_$_condition_$12 : bool;
	var $_$_condition_$13 : bool;
	var $_$_condition_$14 : bool;
	var $_$_condition_$15 : bool;
	var $_$_condition_$16 : bool;
	var $_$_condition_$17 : bool;
	var $_$_condition_$18 : bool;
	var $_$_condition_$19 : bool;
	var $_$_condition_$20 : bool;
	var $_$_condition_$21 : bool;
	var $_$_condition_$22 : bool;
	var $_$_condition_$23 : bool;
	var $_$_condition_$24 : bool;
	var $_$_condition_$25 : bool;
	var $_$_condition_$26 : bool;
	var $_$_condition_$27 : bool;
	var $_$_condition_$28 : bool;
	var $_$_condition_$29 : bool;
	var $_$_condition_$30 : bool;
	var $_$_condition_$31 : bool;
	var $_$_condition_$32 : bool;
	var $_$_condition_$33 : bool;
	var $_$_condition_$34 : bool;
	var $_$_condition_$35 : bool;
	var $_$_condition_$36 : bool;
	var $_$_condition_$37 : bool;
	var $_$_condition_$38 : bool;
	var $_$_condition_$39 : bool;
	var $_$_condition_$40 : bool;
	var $_$_condition_$41 : bool;
	var $_$_condition_$42 : bool;
	var $_$_condition_$43 : bool;
	var $_$_condition_$44 : bool;
	var $_$_condition_$45 : bool;
	var $_$_condition_$46 : bool;
	var $_$_condition_$47 : bool;
	var $_$_condition_$48 : bool;
	var $_$_condition_$49 : bool;
	var $_$_condition_$50 : bool;
	var $_$_condition_$51 : bool;
$start:
	assume Permission$denominator > 0;
	assume (Permission$Zero[perm$R] == 0) && (Permission$Zero[perm$N] == 0);
	assume (Permission$Full[perm$R] == Permission$FullFraction) && (Permission$Full[perm$N] == 0);
	assume (forall<T> o : ref, f : Field (T) , pc : PermissionComponent :: ( ZeroMask[o,f][pc] == 0 ));
	assume IsGoodMask(ZeroMask);
	assume NonPredicateField(joinable);
	assume NonPredicateField(forkK);
	assume (forall  n : Integer :: {Fractions(n)} ( Fractions(n) == (n * Permission$denominator) ));
	assume (forall  x : Integer, y : Integer :: ( ((0 <= x) && (x <= y)) ==> (Fractions(x) <= Fractions(y)) ));
	assume Permission$FullFraction == Fractions(100);
	assume (0 < channelK) && ((1000 * channelK) < Fractions(1));
	assume (0 < monitorK) && ((1000 * monitorK) < Fractions(1));
	assume (0 < predicateK) && ((1000 * predicateK) < Fractions(1));
	assume (predicateK == channelK) && (channelK == monitorK);
	assume (forall  a : PartialHeapType, b : PartialHeapType :: {IsGoodState(combine(a,b))} ( IsGoodState(combine(a,b)) <==> (IsGoodState(a) && IsGoodState(b)) ));
	assume IsGoodState(emptyPartialHeap);
	assume NonPredicateField(mu);
	assume (forall  m : Mu, n_$0 : Mu :: {MuBelow(m,n_$0),MuBelow(n_$0,m)} ( !(MuBelow(m,n_$0) && MuBelow(n_$0,m)) ));
	assume (forall  m_$0 : Mu, n_$1 : Mu, o_$0 : Mu :: {MuBelow(m_$0,n_$1),MuBelow(n_$1,o_$0)} ( (MuBelow(m_$0,n_$1) && MuBelow(n_$1,o_$0)) ==> MuBelow(m_$0,o_$0) ));
	assume (forall  m_$1 : Mu, n_$2 : Mu :: ( MuBelow(m_$1,n_$2) ==> (!(n_$2 == $LockBottom)) ));
	assume NonPredicateField(held);
	assume NonPredicateField(rdheld);
	assume (forall  ih : HeapType, h : HeapType, m_$2 : MaskType, sm : MaskType :: {IsGoodInhaleState(ih,h,m_$2,sm)} ( IsGoodInhaleState(ih,h,m_$2,sm) <==> ((((((forall<T> o_$1 : ref, f_$0 : Field (T)  :: {ih[o_$1,f_$0]} ( CanRead(m_$2,sm,o_$1,f_$0) ==> (ih[o_$1,f_$0] == h[o_$1,f_$0]) ))) && ((forall  o_$2 : ref :: {ih[o_$2,held]} ( (0 < ih[o_$2,held]) <==> (0 < h[o_$2,held]) )))) && ((forall  o_$3 : ref :: {ih[o_$3,rdheld]} ( ih[o_$3,rdheld] <==> h[o_$3,rdheld] )))) && ((forall  o_$4 : ref :: {h[o_$4,held]} ( (0 < h[o_$4,held]) ==> (ih[o_$4,mu] == h[o_$4,mu]) )))) && ((forall  o_$5 : ref :: {h[o_$5,rdheld]} ( h[o_$5,rdheld] ==> (ih[o_$5,mu] == h[o_$5,mu]) )))) ));
	assume (forall  eh : HeapType, h_$0 : HeapType, m_$3 : MaskType, sm_$0 : MaskType :: {IsGoodExhaleState(eh,h_$0,m_$3,sm_$0)} ( IsGoodExhaleState(eh,h_$0,m_$3,sm_$0) <==> (((((((((forall<T> o_$6 : ref, f_$1 : Field (T)  :: {eh[o_$6,f_$1]} ( CanRead(m_$3,sm_$0,o_$6,f_$1) ==> (eh[o_$6,f_$1] == h_$0[o_$6,f_$1]) ))) && ((forall  o_$7 : ref :: {eh[o_$7,held]} ( (0 < eh[o_$7,held]) <==> (0 < h_$0[o_$7,held]) )))) && ((forall  o_$8 : ref :: {eh[o_$8,rdheld]} ( eh[o_$8,rdheld] <==> h_$0[o_$8,rdheld] )))) && ((forall  o_$9 : ref :: {h_$0[o_$9,held]} ( (0 < h_$0[o_$9,held]) ==> (eh[o_$9,mu] == h_$0[o_$9,mu]) )))) && ((forall  o_$10 : ref :: {h_$0[o_$10,rdheld]} ( h_$0[o_$10,rdheld] ==> (eh[o_$10,mu] == h_$0[o_$10,mu]) )))) && ((forall  o_$11 : ref :: {h_$0[o_$11,forkK]} {eh[o_$11,forkK]} ( h_$0[o_$11,forkK] == eh[o_$11,forkK] )))) && ((forall  o_$12 : ref :: {h_$0[o_$12,held]} {eh[o_$12,held]} ( h_$0[o_$12,held] == eh[o_$12,held] )))) && ((forall  o_$13 : ref, f_$2 : Field (Integer)  :: {eh[o_$13,f_$2],PredicateField(f_$2)} ( PredicateField(f_$2) ==> (h_$0[o_$13,f_$2] <= eh[o_$13,f_$2]) )))) ));
	assume (forall<T> m_$4 : MaskType, sm_$1 : MaskType, obj : ref, f_$3 : Field (T)  :: {CanRead(m_$4,sm_$1,obj,f_$3)} {:expand  false}( CanRead(m_$4,sm_$1,obj,f_$3) <==> ((((0 < m_$4[obj,f_$3][perm$R]) || (0 < m_$4[obj,f_$3][perm$N])) || (0 < sm_$1[obj,f_$3][perm$R])) || (0 < sm_$1[obj,f_$3][perm$N])) ));
	assume (forall<T> m_$5 : MaskType, obj_$0 : ref, f_$4 : Field (T)  :: {CanReadForSure(m_$5,obj_$0,f_$4)} {:expand  false}( CanReadForSure(m_$5,obj_$0,f_$4) <==> ((0 < m_$5[obj_$0,f_$4][perm$R]) || (0 < m_$5[obj_$0,f_$4][perm$N])) ));
	assume (forall<T> m_$6 : MaskType, obj_$1 : ref, f_$5 : Field (T)  :: {CanWrite(m_$6,obj_$1,f_$5)} {:expand  false}( CanWrite(m_$6,obj_$1,f_$5) <==> ((m_$6[obj_$1,f_$5][perm$R] == Permission$FullFraction) && (m_$6[obj_$1,f_$5][perm$N] == 0)) ));
	assume (forall  m_$7 : MaskType :: {IsGoodMask(m_$7)} {:expand  true}( IsGoodMask(m_$7) <==> ((forall<T> o_$14 : ref, f_$6 : Field (T)  :: ( ((0 <= m_$7[o_$14,f_$6][perm$R]) && (NonPredicateField(f_$6) ==> ((m_$7[o_$14,f_$6][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14,f_$6][perm$N]) ==> (m_$7[o_$14,f_$6][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14,f_$6][perm$N] < 0) ==> (0 < m_$7[o_$14,f_$6][perm$R])) ))) ));
	assume (forall  h_$1 : HeapType, m_$8 : MaskType, sm_$2 : MaskType, o_$15 : ref, q : ref :: {wf(h_$1,m_$8,sm_$2),h_$1[o_$15,mu],h_$1[q,mu]} ( (((wf(h_$1,m_$8,sm_$2) && (!(o_$15 == q))) && ((0 < h_$1[o_$15,held]) || h_$1[o_$15,rdheld])) && ((0 < h_$1[q,held]) || h_$1[q,rdheld])) ==> (!(h_$1[o_$15,mu] == h_$1[q,mu])) ));
	assume (forall<T,U> m_$9 : MaskType, o_$16 : ref, f_$7 : Field (T) , howMuch : Integer, q_$0 : ref, g : Field (U)  :: {DecPerm(m_$9,o_$16,f_$7,howMuch)[q_$0,g][perm$R]} ( DecPerm(m_$9,o_$16,f_$7,howMuch)[q_$0,g][perm$R] == ite((o_$16 == q_$0) && (f_$7 == g),m_$9[q_$0,g][perm$R] - howMuch,m_$9[q_$0,g][perm$R]) ));
	assume (forall<T,U> m_$10 : MaskType, o_$17 : ref, f_$8 : Field (T) , howMuch_$0 : Integer, q_$1 : ref, g_$0 : Field (U)  :: {DecPerm(m_$10,o_$17,f_$8,howMuch_$0)[q_$1,g_$0][perm$N]} ( DecEpsilons(m_$10,o_$17,f_$8,howMuch_$0)[q_$1,g_$0][perm$N] == ite((o_$17 == q_$1) && (f_$8 == g_$0),m_$10[q_$1,g_$0][perm$N] - howMuch_$0,m_$10[q_$1,g_$0][perm$N]) ));
	assume (forall<T,U> m_$11 : MaskType, o_$18 : ref, f_$9 : Field (T) , howMuch_$1 : Integer, q_$2 : ref, g_$1 : Field (U)  :: {IncPerm(m_$11,o_$18,f_$9,howMuch_$1)[q_$2,g_$1][perm$R]} ( IncPerm(m_$11,o_$18,f_$9,howMuch_$1)[q_$2,g_$1][perm$R] == ite((o_$18 == q_$2) && (f_$9 == g_$1),m_$11[q_$2,g_$1][perm$R] + howMuch_$1,m_$11[q_$2,g_$1][perm$R]) ));
	assume (forall<T,U> m_$12 : MaskType, o_$19 : ref, f_$10 : Field (T) , howMuch_$2 : Integer, q_$3 : ref, g_$2 : Field (U)  :: {IncPerm(m_$12,o_$19,f_$10,howMuch_$2)[q_$3,g_$2][perm$N]} ( IncEpsilons(m_$12,o_$19,f_$10,howMuch_$2)[q_$3,g_$2][perm$N] == ite((o_$19 == q_$3) && (f_$10 == g_$2),m_$12[q_$3,g_$2][perm$N] + howMuch_$2,m_$12[q_$3,g_$2][perm$N]) ));
	assume (forall<T,U> h_$2 : HeapType, o_$20 : ref, f_$11 : Field (T) , newValue : U, q_$4 : ref, g_$3 : Field (U)  :: {Havocing(h_$2,o_$20,f_$11,newValue)[q_$4,g_$3]} ( Havocing(h_$2,o_$20,f_$11,newValue)[q_$4,g_$3] == ite((o_$20 == q_$4) && (f_$11 == g_$3),newValue,h_$2[q_$4,g_$3]) ));
	assume (forall  m_$13 : MaskType :: {EmptyMask(m_$13)} ( EmptyMask(m_$13) <==> ((forall<T> o_$21 : ref, f_$12 : Field (T)  :: ( NonPredicateField(f_$12) ==> ((m_$13[o_$21,f_$12][perm$R] <= 0) && (m_$13[o_$21,f_$12][perm$N] <= 0)) ))) ));
	assume (forall  o_$22 : ref :: ( ZeroCredits[o_$22] == 0 ));
	assume (forall  c : CreditsType :: {EmptyCredits(c)} ( EmptyCredits(c) <==> ((forall  o_$23 : ref :: ( (!(o_$23 == null)) ==> (c[o_$23] == 0) ))) ));
	assume (forall<T> f_$13 : Field (T)  :: ( NonPredicateField(f_$13) ==> (!PredicateField(f_$13)) ));
	assume (forall<T> f_$14 : Field (T)  :: ( PredicateField(f_$14) ==> (!NonPredicateField(f_$14)) ));
	assume (forall  m1 : MaskType, m2 : MaskType :: {submask(m1,m2)} ( submask(m1,m2) <==> ((forall<T> o_$24 : ref, f_$15 : Field (T)  :: ( (m1[o_$24,f_$15][perm$R] < m2[o_$24,f_$15][perm$R]) || ((m1[o_$24,f_$15][perm$R] == m2[o_$24,f_$15][perm$R]) && (m1[o_$24,f_$15][perm$N] <= m2[o_$24,f_$15][perm$N])) ))) ));
	assume (forall<T> con : Boolean, a_$0 : T, b_$0 : T :: {ite(con,a_$0,b_$0)} ( con ==> (ite(con,a_$0,b_$0) == a_$0) ));
	assume (forall<T> con_$0 : Boolean, a_$1 : T, b_$1 : T :: {ite(con_$0,a_$1,b_$1)} ( (!con_$0) ==> (ite(con_$0,a_$1,b_$1) == b_$1) ));
	assume (forall  x_$0 : Integer, y_$0 : Integer :: {x_$0 mod y_$0} {x_$0 div y_$0} ( (x_$0 mod y_$0) == (x_$0 - ((x_$0 div y_$0) * y_$0)) ));
	assume (forall  x_$1 : Integer, y_$1 : Integer :: {x_$1 mod y_$1} ( (0 < y_$1) ==> ((0 <= (x_$1 mod y_$1)) && ((x_$1 mod y_$1) < y_$1)) ));
	assume (forall  x_$2 : Integer, y_$2 : Integer :: {x_$2 mod y_$2} ( (y_$2 < 0) ==> ((y_$2 < (x_$2 mod y_$2)) && ((x_$2 mod y_$2) <= 0)) ));
	assume (forall  a_$2 : Integer, b_$2 : Integer, d : Integer :: {a_$2 mod d,b_$2 mod d} ( (((2 <= d) && ((a_$2 mod d) == (b_$2 mod d))) && (a_$2 < b_$2)) ==> ((a_$2 + d) <= b_$2) ));
	assume NonPredicateField(Node.next);
	assume NonPredicateField(Node.prev);
	assume PredicateField(Node.inv);
	assume PredicateField(Node.invLeft);
	assume PredicateField(Node.invRight);
	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	assume IsGoodMask(Mask);
	assume IsGoodMask(SecMask);
	assume (this == null) || (dtype(this) == Node#t);
	assume (newList#0 == null) || (dtype(newList#0) == Node#t);
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_170) && ((1000 * methodK#_170) < Fractions(1));
	assume CanAssumeFunctionDefs;
	assert { :msg "  31.18: Receiver might be null." } !(this == null);
	assume !(this == null);
	assume wf(Heap,ZeroMask,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_0 == ZeroMask[this,Node.inv := ZeroMask[this,Node.inv][perm$R := ZeroMask[this,Node.inv][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[this,Node.inv]));
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume #Node.inv#trigger(this);
	assume predVer#_172_$_0 == Heap[this,Node.inv];
	assume (0 < unfoldingK#_179) && ((1000 * unfoldingK#_179) < Fractions(1));
	assert { :msg "  32.28: Receiver might be null." } true ==> (!(this == null));
	assume wf(Heap,Mask_$_0,ZeroMask);
	assert { :msg "  32.18: Unfolding might fail. The permission at 32.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  32.18: Unfolding might fail. Insufficient fraction at 32.28 for Node.inv." } (Fractions(100) <= Mask_$_0[this,Node.inv][perm$R]) && ((Fractions(100) == Mask_$_0[this,Node.inv][perm$R]) ==> (0 <= Mask_$_0[this,Node.inv][perm$N]));
	assume unfoldingMask#_175_$_0 == Mask_$_0[this,Node.inv := Mask_$_0[this,Node.inv][perm$R := Mask_$_0[this,Node.inv][perm$R] - Fractions(100)]];
	if ($_$_condition) { goto anon251_Then; } else { goto anon251_Else; }
anon251_Then:
	assume false;
	goto $exit;
anon251_Else:
	assume !false;
	if ($_$_condition_$0) { goto anon261_Then; } else { goto anon261_Else; }
anon261_Then:
	assume !CanRead(unfoldingMask#_175_$_0,ZeroMask,this,Node.inv);
	assume oldVers#_190_$_0 == Heap[this,Node.inv];
	assume unfoldingHeap#_174_$_0 == Heap[this,Node.inv := newVers#_191_$_0];
	assume oldVers#_190_$_0 < unfoldingHeap#_174_$_0[this,Node.inv];
	assume unfoldingHeap#_174_$_1 == unfoldingHeap#_174_$_0;
	goto anon22;
anon261_Else:
	assume CanRead(unfoldingMask#_175_$_0,ZeroMask,this,Node.inv);
	assume unfoldingHeap#_174_$_1 == Heap;
	goto anon22;
anon22:
	assume IsGoodMask(unfoldingMask#_175_$_0);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_0,ZeroMask);
	assume IsGoodMask(unfoldingMask#_175_$_0);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_0,ZeroMask);
	assume !(this == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_0,ZeroMask);
	assume (unfoldingHeap#_174_$_1[this,Node.prev] == null) || (dtype(unfoldingHeap#_174_$_1[this,Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingMask#_175_$_1 == unfoldingMask#_175_$_0[this,Node.prev := unfoldingMask#_175_$_0[this,Node.prev][perm$N := unfoldingMask#_175_$_0[this,Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_1,ZeroMask);
	assume IsGoodMask(unfoldingMask#_175_$_1);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[this,Node.prev]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_1,ZeroMask);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_1,ZeroMask);
	assume !(this == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_1,ZeroMask);
	assume (unfoldingHeap#_174_$_1[this,Node.next] == null) || (dtype(unfoldingHeap#_174_$_1[this,Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingMask#_175_$_2 == unfoldingMask#_175_$_1[this,Node.next := unfoldingMask#_175_$_1[this,Node.next][perm$N := unfoldingMask#_175_$_1[this,Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_2,ZeroMask);
	assume IsGoodMask(unfoldingMask#_175_$_2);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[this,Node.next]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_2,ZeroMask);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_2,ZeroMask);
	assume !(this == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_2,ZeroMask);
	assume true;
	assume 1 > 0;
	assume unfoldingMask#_175_$_3 == unfoldingMask#_175_$_2[this,mu := unfoldingMask#_175_$_2[this,mu][perm$N := unfoldingMask#_175_$_2[this,mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_3,ZeroMask);
	assume IsGoodMask(unfoldingMask#_175_$_3);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[this,mu]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_3,ZeroMask);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_3,ZeroMask);
	if ($_$_condition_$1) { goto anon262_Then; } else { goto anon262_Else; }
anon262_Then:
	assume !(unfoldingHeap#_174_$_1[this,Node.prev] == null);
	assume !(unfoldingHeap#_174_$_1[this,Node.prev] == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_3,ZeroMask);
	assume Fractions(100) > 0;
	assume unfoldingMask#_175_$_4 == unfoldingMask#_175_$_3[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft := unfoldingMask#_175_$_3[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft][perm$R := unfoldingMask#_175_$_3[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_175_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,ZeroMask);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,ZeroMask);
	assume predRec#_192_$_0 == Heap[this,Node.prev];
	assume #Node.invLeft#trigger(Heap[this,Node.prev]);
	assume predVer#_193_$_0 == unfoldingHeap#_174_$_1[Heap[this,Node.prev],Node.invLeft];
	if ($_$_condition_$2) { goto anon263_Then; } else { goto anon263_Else; }
anon262_Else:
	assume unfoldingHeap#_174_$_1[this,Node.prev] == null;
	assume unfoldingMask#_175_$_5 == unfoldingMask#_175_$_3;
	assume unfoldingSecMask#_176_$_5 == ZeroMask;
	if ($_$_condition_$3) { goto anon271_Then; } else { goto anon271_Else; }
anon263_Then:
	assume false;
	goto $exit;
anon263_Else:
	assume !false;
	assume !(predRec#_192_$_0 == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,ZeroMask);
	assume (unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.prev] == null) || (dtype(unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_176_$_0 == ZeroMask[predRec#_192_$_0,Node.prev := ZeroMask[predRec#_192_$_0,Node.prev][perm$N := ZeroMask[predRec#_192_$_0,Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingSecMask#_176_$_0,unfoldingSecMask#_176_$_0);
	assume IsGoodMask(unfoldingMask#_175_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.prev]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_0);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_0);
	assume !(predRec#_192_$_0 == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_0);
	assume (unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.next] == null) || (dtype(unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_176_$_1 == unfoldingSecMask#_176_$_0[predRec#_192_$_0,Node.next := unfoldingSecMask#_176_$_0[predRec#_192_$_0,Node.next][perm$N := unfoldingSecMask#_176_$_0[predRec#_192_$_0,Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingSecMask#_176_$_1,unfoldingSecMask#_176_$_1);
	assume IsGoodMask(unfoldingMask#_175_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.next]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_1);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_1);
	assume !(predRec#_192_$_0 == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_1);
	assume true;
	assume 1 > 0;
	assume unfoldingSecMask#_176_$_2 == unfoldingSecMask#_176_$_1[predRec#_192_$_0,mu := unfoldingSecMask#_176_$_1[predRec#_192_$_0,mu][perm$N := unfoldingSecMask#_176_$_1[predRec#_192_$_0,mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingSecMask#_176_$_2,unfoldingSecMask#_176_$_2);
	assume IsGoodMask(unfoldingMask#_175_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[predRec#_192_$_0,mu]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_2);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_2);
	if ($_$_condition_$4) { goto anon270_Then; } else { goto anon270_Else; }
anon271_Then:
	assume !(unfoldingHeap#_174_$_1[this,Node.next] == null);
	assume !(unfoldingHeap#_174_$_1[this,Node.next] == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_5,unfoldingSecMask#_176_$_5);
	assume Fractions(100) > 0;
	assume unfoldingMask#_175_$_6 == unfoldingMask#_175_$_5[unfoldingHeap#_174_$_1[this,Node.next],Node.invRight := unfoldingMask#_175_$_5[unfoldingHeap#_174_$_1[this,Node.next],Node.invRight][perm$R := unfoldingMask#_175_$_5[unfoldingHeap#_174_$_1[this,Node.next],Node.invRight][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_175_$_6);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.next],Node.invRight]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_5);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_5);
	assume predRec#_201_$_0 == Heap[this,Node.next];
	assume #Node.invRight#trigger(Heap[this,Node.next]);
	assume predVer#_202_$_0 == unfoldingHeap#_174_$_1[Heap[this,Node.next],Node.invRight];
	if ($_$_condition_$6) { goto anon272_Then; } else { goto anon272_Else; }
anon271_Else:
	assume unfoldingHeap#_174_$_1[this,Node.next] == null;
	assume unfoldingSecMask#_176_$_11 == unfoldingSecMask#_176_$_5;
	assume unfoldingMask#_175_$_7 == unfoldingMask#_175_$_5;
	goto anon58;
anon270_Then:
	assume !(unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.prev] == null);
	assume !(unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.prev] == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_2);
	assume Fractions(100) > 0;
	assume unfoldingSecMask#_176_$_3 == unfoldingSecMask#_176_$_2[unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.prev],Node.invLeft := unfoldingSecMask#_176_$_2[unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.prev],Node.invLeft][perm$R := unfoldingSecMask#_176_$_2[unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_175_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.prev],Node.invLeft]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_3);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_4,unfoldingSecMask#_176_$_3);
	assume unfoldingSecMask#_176_$_4 == unfoldingSecMask#_176_$_3;
	goto anon39;
anon270_Else:
	assume unfoldingHeap#_174_$_1[predRec#_192_$_0,Node.prev] == null;
	assume unfoldingSecMask#_176_$_4 == unfoldingSecMask#_176_$_2;
	goto anon39;
anon39:
	assume MuBelow(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],mu],unfoldingHeap#_174_$_1[this,mu]);
	assume unfoldingMask#_175_$_5 == unfoldingMask#_175_$_4;
	assume unfoldingSecMask#_176_$_5 == unfoldingSecMask#_176_$_4;
	if ($_$_condition_$5) { goto anon271_Then; } else { goto anon271_Else; }
anon272_Then:
	assume false;
	goto $exit;
anon272_Else:
	assume !false;
	assume !(predRec#_201_$_0 == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_5);
	assume (unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.prev] == null) || (dtype(unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_176_$_6 == unfoldingSecMask#_176_$_5[predRec#_201_$_0,Node.prev := unfoldingSecMask#_176_$_5[predRec#_201_$_0,Node.prev][perm$N := unfoldingSecMask#_176_$_5[predRec#_201_$_0,Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingSecMask#_176_$_6,unfoldingSecMask#_176_$_6);
	assume IsGoodMask(unfoldingMask#_175_$_6);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.prev]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_6);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_6);
	assume !(predRec#_201_$_0 == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_6);
	assume (unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.next] == null) || (dtype(unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_176_$_7 == unfoldingSecMask#_176_$_6[predRec#_201_$_0,Node.next := unfoldingSecMask#_176_$_6[predRec#_201_$_0,Node.next][perm$N := unfoldingSecMask#_176_$_6[predRec#_201_$_0,Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingSecMask#_176_$_7,unfoldingSecMask#_176_$_7);
	assume IsGoodMask(unfoldingMask#_175_$_6);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.next]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_7);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_7);
	assume !(predRec#_201_$_0 == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_7);
	assume true;
	assume 1 > 0;
	assume unfoldingSecMask#_176_$_8 == unfoldingSecMask#_176_$_7[predRec#_201_$_0,mu := unfoldingSecMask#_176_$_7[predRec#_201_$_0,mu][perm$N := unfoldingSecMask#_176_$_7[predRec#_201_$_0,mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingSecMask#_176_$_8,unfoldingSecMask#_176_$_8);
	assume IsGoodMask(unfoldingMask#_175_$_6);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[predRec#_201_$_0,mu]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_8);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_8);
	if ($_$_condition_$7) { goto anon279_Then; } else { goto anon279_Else; }
anon58:
	assume IsGoodMask(unfoldingMask#_175_$_7);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_11);
	if ($_$_condition_$8) { goto anon280_Then; } else { goto anon280_Else; }
anon279_Then:
	assume !(unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.next] == null);
	assume !(unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.next] == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_8);
	assume Fractions(100) > 0;
	assume unfoldingSecMask#_176_$_9 == unfoldingSecMask#_176_$_8[unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.next],Node.invRight := unfoldingSecMask#_176_$_8[unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.next],Node.invRight][perm$R := unfoldingSecMask#_176_$_8[unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.next],Node.invRight][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_175_$_6);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.next],Node.invRight]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_9);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_6,unfoldingSecMask#_176_$_9);
	assume unfoldingSecMask#_176_$_10 == unfoldingSecMask#_176_$_9;
	goto anon57;
anon279_Else:
	assume unfoldingHeap#_174_$_1[predRec#_201_$_0,Node.next] == null;
	assume unfoldingSecMask#_176_$_10 == unfoldingSecMask#_176_$_8;
	goto anon57;
anon57:
	assume MuBelow(unfoldingHeap#_174_$_1[this,mu],unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.next],mu]);
	assume unfoldingSecMask#_176_$_11 == unfoldingSecMask#_176_$_10;
	assume unfoldingMask#_175_$_7 == unfoldingMask#_175_$_6;
	goto anon58;
anon280_Then:
	assume false;
	goto $exit;
anon280_Else:
	assume !false;
	assume !(this == null);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume (Heap[this,Node.prev] == null) || (dtype(Heap[this,Node.prev]) == Node#t);
	assume 1 > 0;
	assume SecMask_$_0 == ZeroMask[this,Node.prev := ZeroMask[this,Node.prev][perm$N := ZeroMask[this,Node.prev][perm$N] + 1]];
	assume wf(Heap,SecMask_$_0,SecMask_$_0);
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[this,Node.prev]));
	assume wf(Heap,Mask_$_0,SecMask_$_0);
	assume wf(Heap,Mask_$_0,SecMask_$_0);
	assume !(this == null);
	assume wf(Heap,Mask_$_0,SecMask_$_0);
	assume (Heap[this,Node.next] == null) || (dtype(Heap[this,Node.next]) == Node#t);
	assume 1 > 0;
	assume SecMask_$_1 == SecMask_$_0[this,Node.next := SecMask_$_0[this,Node.next][perm$N := SecMask_$_0[this,Node.next][perm$N] + 1]];
	assume wf(Heap,SecMask_$_1,SecMask_$_1);
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[this,Node.next]));
	assume wf(Heap,Mask_$_0,SecMask_$_1);
	assume wf(Heap,Mask_$_0,SecMask_$_1);
	assume !(this == null);
	assume wf(Heap,Mask_$_0,SecMask_$_1);
	assume true;
	assume 1 > 0;
	assume SecMask_$_2 == SecMask_$_1[this,mu := SecMask_$_1[this,mu][perm$N := SecMask_$_1[this,mu][perm$N] + 1]];
	assume wf(Heap,SecMask_$_2,SecMask_$_2);
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[this,mu]));
	assume wf(Heap,Mask_$_0,SecMask_$_2);
	assume wf(Heap,Mask_$_0,SecMask_$_2);
	if ($_$_condition_$9) { goto anon290_Then; } else { goto anon290_Else; }
anon290_Then:
	assume !(Heap[this,Node.prev] == null);
	assume !(Heap[this,Node.prev] == null);
	assume wf(Heap,Mask_$_0,SecMask_$_2);
	assume Fractions(100) > 0;
	assume SecMask_$_3 == SecMask_$_2[Heap[this,Node.prev],Node.invLeft := SecMask_$_2[Heap[this,Node.prev],Node.invLeft][perm$R := SecMask_$_2[Heap[this,Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[Heap[this,Node.prev],Node.invLeft]));
	assume wf(Heap,Mask_$_0,SecMask_$_3);
	assume wf(Heap,Mask_$_0,SecMask_$_3);
	assume SecMask_$_4 == SecMask_$_3;
	if ($_$_condition_$10) { goto anon291_Then; } else { goto anon291_Else; }
anon290_Else:
	assume Heap[this,Node.prev] == null;
	assume SecMask_$_4 == SecMask_$_2;
	if ($_$_condition_$11) { goto anon291_Then; } else { goto anon291_Else; }
anon291_Then:
	assume !(Heap[this,Node.next] == null);
	assume !(Heap[this,Node.next] == null);
	assume wf(Heap,Mask_$_0,SecMask_$_4);
	assume Fractions(100) > 0;
	assume SecMask_$_5 == SecMask_$_4[Heap[this,Node.next],Node.invRight := SecMask_$_4[Heap[this,Node.next],Node.invRight][perm$R := SecMask_$_4[Heap[this,Node.next],Node.invRight][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[Heap[this,Node.next],Node.invRight]));
	assume wf(Heap,Mask_$_0,SecMask_$_5);
	assume wf(Heap,Mask_$_0,SecMask_$_5);
	assume SecMask_$_6 == SecMask_$_5;
	goto anon82;
anon291_Else:
	assume Heap[this,Node.next] == null;
	assume SecMask_$_6 == SecMask_$_4;
	goto anon82;
anon82:
	assert { :msg "  33.22: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  33.22: Location might not be readable." } true ==> CanRead(unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_11,this,Node.prev);
	if ($_$_condition_$12) { goto anon292_Then; } else { goto anon292_Else; }
anon292_Then:
	assume !(unfoldingHeap#_174_$_1[this,Node.prev] == null);
	assume (0 < unfoldingK#_222) && ((1000 * unfoldingK#_222) < Fractions(1));
	assert { :msg "  34.31: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  34.31: Location might not be readable." } true ==> CanRead(unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_11,this,Node.prev);
	assert { :msg "  34.31: Receiver might be null." } true ==> (!(unfoldingHeap#_174_$_1[this,Node.prev] == null));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_11);
	assert { :msg "  34.21: Unfolding might fail. The permission at 34.31 might not be positive." } Fractions(100) > 0;
	assert { :msg "  34.21: Unfolding might fail. Insufficient fraction at 34.31 for Node.invLeft." } (Fractions(100) <= unfoldingMask#_175_$_7[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft][perm$R]) && ((Fractions(100) == unfoldingMask#_175_$_7[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft][perm$R]) ==> (0 <= unfoldingMask#_175_$_7[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft][perm$N]));
	assume unfoldingMask#_218_$_0 == unfoldingMask#_175_$_7[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft := unfoldingMask#_175_$_7[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft][perm$R := unfoldingMask#_175_$_7[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft][perm$R] - Fractions(100)]];
	if ($_$_condition_$13) { goto anon293_Then; } else { goto anon293_Else; }
anon292_Else:
	assume unfoldingHeap#_174_$_1[this,Node.prev] == null;
	assert { :msg "  39.34: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  39.34: Location might not be readable." } true ==> CanRead(unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_11,this,mu);
	goto anon187;
anon293_Then:
	assume false;
	goto $exit;
anon293_Else:
	assume !false;
	if ($_$_condition_$14) { goto anon300_Then; } else { goto anon300_Else; }
anon187:
	assume ite(!(Heap[this,Node.prev] == null),ite(!(Heap[Heap[this,Node.prev],Node.prev] == null),(forall  o#_281 : ref :: ( (((0 < Heap[o#_281,held]) || Heap[o#_281,rdheld]) || (ZeroCredits[o#_281] < 0)) ==> MuBelow(Heap[o#_281,mu],Heap[Heap[Heap[this,Node.prev],Node.prev],mu]) )),(forall  o#_282 : ref :: ( (((0 < Heap[o#_282,held]) || Heap[o#_282,rdheld]) || (ZeroCredits[o#_282] < 0)) ==> MuBelow(Heap[o#_282,mu],Heap[Heap[this,Node.prev],mu]) ))),(forall  o#_283 : ref :: ( (((0 < Heap[o#_283,held]) || Heap[o#_283,rdheld]) || (ZeroCredits[o#_283] < 0)) ==> MuBelow(Heap[o#_283,mu],Heap[this,mu]) )));
	assume IsGoodMask(Mask_$_0);
	assume wf(Heap,Mask_$_0,SecMask_$_6);
	assume Heap == Heap;
	assume Mask_$_0 == Mask;
	assume SecMask_$_6 == SecMask;
	assume ZeroCredits == Credits;
	assert { :msg "  40.17: Receiver might be null." } !(this == null);
	assume !(this == null);
	assume wf(Heap_$_0,ZeroMask,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_1 == ZeroMask[this,Node.inv := ZeroMask[this,Node.inv][perm$R := ZeroMask[this,Node.inv][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_1);
	assume IsGoodState(heapFragment(Heap_$_0[this,Node.inv]));
	assume wf(Heap_$_0,Mask_$_1,ZeroMask);
	assume wf(Heap_$_0,Mask_$_1,ZeroMask);
	if ($_$_condition_$28) { goto anon344_Then; } else { goto anon344_Else; }
anon300_Then:
	assume !CanRead(unfoldingMask#_218_$_0,unfoldingSecMask#_176_$_11,unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft);
	assume oldVers#_232_$_0 == unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft];
	assume unfoldingHeap#_217_$_0 == unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft := newVers#_233_$_0];
	assume oldVers#_232_$_0 < unfoldingHeap#_217_$_0[unfoldingHeap#_217_$_0[this,Node.prev],Node.invLeft];
	assume unfoldingHeap#_217_$_1 == unfoldingHeap#_217_$_0;
	goto anon99;
anon300_Else:
	assume CanRead(unfoldingMask#_218_$_0,unfoldingSecMask#_176_$_11,unfoldingHeap#_174_$_1[this,Node.prev],Node.invLeft);
	assume unfoldingHeap#_217_$_1 == unfoldingHeap#_174_$_1;
	goto anon99;
anon99:
	assume IsGoodMask(unfoldingMask#_218_$_0);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_0,unfoldingSecMask#_176_$_11);
	assume IsGoodMask(unfoldingMask#_218_$_0);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_0,unfoldingSecMask#_176_$_11);
	assume !(unfoldingHeap#_217_$_1[this,Node.prev] == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_0,unfoldingSecMask#_176_$_11);
	assume (unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev] == null) || (dtype(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingMask#_218_$_1 == unfoldingMask#_218_$_0[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev := unfoldingMask#_218_$_0[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev][perm$N := unfoldingMask#_218_$_0[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_1,unfoldingSecMask#_176_$_11);
	assume IsGoodMask(unfoldingMask#_218_$_1);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_1,unfoldingSecMask#_176_$_11);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_1,unfoldingSecMask#_176_$_11);
	assume !(unfoldingHeap#_217_$_1[this,Node.prev] == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_1,unfoldingSecMask#_176_$_11);
	assume (unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.next] == null) || (dtype(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingMask#_218_$_2 == unfoldingMask#_218_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.next := unfoldingMask#_218_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.next][perm$N := unfoldingMask#_218_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_2,unfoldingSecMask#_176_$_11);
	assume IsGoodMask(unfoldingMask#_218_$_2);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.next]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_2,unfoldingSecMask#_176_$_11);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_2,unfoldingSecMask#_176_$_11);
	assume !(unfoldingHeap#_217_$_1[this,Node.prev] == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_2,unfoldingSecMask#_176_$_11);
	assume true;
	assume 1 > 0;
	assume unfoldingMask#_218_$_3 == unfoldingMask#_218_$_2[unfoldingHeap#_217_$_1[this,Node.prev],mu := unfoldingMask#_218_$_2[unfoldingHeap#_217_$_1[this,Node.prev],mu][perm$N := unfoldingMask#_218_$_2[unfoldingHeap#_217_$_1[this,Node.prev],mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_3,unfoldingSecMask#_176_$_11);
	assume IsGoodMask(unfoldingMask#_218_$_3);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],mu]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_3,unfoldingSecMask#_176_$_11);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_3,unfoldingSecMask#_176_$_11);
	if ($_$_condition_$15) { goto anon301_Then; } else { goto anon301_Else; }
anon301_Then:
	assume !(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev] == null);
	assume !(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev] == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_3,unfoldingSecMask#_176_$_11);
	assume Fractions(100) > 0;
	assume unfoldingMask#_218_$_4 == unfoldingMask#_218_$_3[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft := unfoldingMask#_218_$_3[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft][perm$R := unfoldingMask#_218_$_3[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_218_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_176_$_11);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_176_$_11);
	assume predRec#_234_$_0 == Heap[Heap[this,Node.prev],Node.prev];
	assume #Node.invLeft#trigger(Heap[Heap[this,Node.prev],Node.prev]);
	assume predVer#_235_$_0 == unfoldingHeap#_217_$_1[Heap[Heap[this,Node.prev],Node.prev],Node.invLeft];
	if ($_$_condition_$16) { goto anon302_Then; } else { goto anon302_Else; }
anon301_Else:
	assume unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev] == null;
	assume unfoldingMask#_218_$_5 == unfoldingMask#_218_$_3;
	assume unfoldingSecMask#_219_$_5 == unfoldingSecMask#_176_$_11;
	goto anon117;
anon302_Then:
	assume false;
	goto $exit;
anon302_Else:
	assume !false;
	assume !(predRec#_234_$_0 == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_176_$_11);
	assume (unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.prev] == null) || (dtype(unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_219_$_0 == unfoldingSecMask#_176_$_11[predRec#_234_$_0,Node.prev := unfoldingSecMask#_176_$_11[predRec#_234_$_0,Node.prev][perm$N := unfoldingSecMask#_176_$_11[predRec#_234_$_0,Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_217_$_1,unfoldingSecMask#_219_$_0,unfoldingSecMask#_219_$_0);
	assume IsGoodMask(unfoldingMask#_218_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.prev]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_0);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_0);
	assume !(predRec#_234_$_0 == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_0);
	assume (unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.next] == null) || (dtype(unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_219_$_1 == unfoldingSecMask#_219_$_0[predRec#_234_$_0,Node.next := unfoldingSecMask#_219_$_0[predRec#_234_$_0,Node.next][perm$N := unfoldingSecMask#_219_$_0[predRec#_234_$_0,Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_217_$_1,unfoldingSecMask#_219_$_1,unfoldingSecMask#_219_$_1);
	assume IsGoodMask(unfoldingMask#_218_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.next]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_1);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_1);
	assume !(predRec#_234_$_0 == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_1);
	assume true;
	assume 1 > 0;
	assume unfoldingSecMask#_219_$_2 == unfoldingSecMask#_219_$_1[predRec#_234_$_0,mu := unfoldingSecMask#_219_$_1[predRec#_234_$_0,mu][perm$N := unfoldingSecMask#_219_$_1[predRec#_234_$_0,mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_217_$_1,unfoldingSecMask#_219_$_2,unfoldingSecMask#_219_$_2);
	assume IsGoodMask(unfoldingMask#_218_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[predRec#_234_$_0,mu]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_2);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_2);
	if ($_$_condition_$17) { goto anon309_Then; } else { goto anon309_Else; }
anon117:
	assume IsGoodMask(unfoldingMask#_218_$_5);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_5);
	if ($_$_condition_$18) { goto anon310_Then; } else { goto anon310_Else; }
anon309_Then:
	assume !(unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.prev] == null);
	assume !(unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.prev] == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_2);
	assume Fractions(100) > 0;
	assume unfoldingSecMask#_219_$_3 == unfoldingSecMask#_219_$_2[unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.prev],Node.invLeft := unfoldingSecMask#_219_$_2[unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.prev],Node.invLeft][perm$R := unfoldingSecMask#_219_$_2[unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_218_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.prev],Node.invLeft]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_3);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_4,unfoldingSecMask#_219_$_3);
	assume unfoldingSecMask#_219_$_4 == unfoldingSecMask#_219_$_3;
	goto anon116;
anon309_Else:
	assume unfoldingHeap#_217_$_1[predRec#_234_$_0,Node.prev] == null;
	assume unfoldingSecMask#_219_$_4 == unfoldingSecMask#_219_$_2;
	goto anon116;
anon116:
	assume MuBelow(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],mu],unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],mu]);
	assume unfoldingMask#_218_$_5 == unfoldingMask#_218_$_4;
	assume unfoldingSecMask#_219_$_5 == unfoldingSecMask#_219_$_4;
	goto anon117;
anon310_Then:
	assume false;
	goto $exit;
anon310_Else:
	assume !false;
	assume !(unfoldingHeap#_174_$_1[this,Node.prev] == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_11);
	assume (unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev] == null) || (dtype(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_176_$_12 == unfoldingSecMask#_176_$_11[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev := unfoldingSecMask#_176_$_11[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev][perm$N := unfoldingSecMask#_176_$_11[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingSecMask#_176_$_12,unfoldingSecMask#_176_$_12);
	assume IsGoodMask(unfoldingMask#_175_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_12);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_12);
	assume !(unfoldingHeap#_174_$_1[this,Node.prev] == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_12);
	assume (unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.next] == null) || (dtype(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_176_$_13 == unfoldingSecMask#_176_$_12[unfoldingHeap#_174_$_1[this,Node.prev],Node.next := unfoldingSecMask#_176_$_12[unfoldingHeap#_174_$_1[this,Node.prev],Node.next][perm$N := unfoldingSecMask#_176_$_12[unfoldingHeap#_174_$_1[this,Node.prev],Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingSecMask#_176_$_13,unfoldingSecMask#_176_$_13);
	assume IsGoodMask(unfoldingMask#_175_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.next]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_13);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_13);
	assume !(unfoldingHeap#_174_$_1[this,Node.prev] == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_13);
	assume true;
	assume 1 > 0;
	assume unfoldingSecMask#_176_$_14 == unfoldingSecMask#_176_$_13[unfoldingHeap#_174_$_1[this,Node.prev],mu := unfoldingSecMask#_176_$_13[unfoldingHeap#_174_$_1[this,Node.prev],mu][perm$N := unfoldingSecMask#_176_$_13[unfoldingHeap#_174_$_1[this,Node.prev],mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_174_$_1,unfoldingSecMask#_176_$_14,unfoldingSecMask#_176_$_14);
	assume IsGoodMask(unfoldingMask#_175_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],mu]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_14);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_14);
	if ($_$_condition_$19) { goto anon317_Then; } else { goto anon317_Else; }
anon317_Then:
	assume !(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev] == null);
	assume !(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev] == null);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_14);
	assume Fractions(100) > 0;
	assume unfoldingSecMask#_176_$_15 == unfoldingSecMask#_176_$_14[unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev],Node.invLeft := unfoldingSecMask#_176_$_14[unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev],Node.invLeft][perm$R := unfoldingSecMask#_176_$_14[unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_175_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev],Node.invLeft]));
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_15);
	assume wf(unfoldingHeap#_174_$_1,unfoldingMask#_175_$_7,unfoldingSecMask#_176_$_15);
	goto anon133;
anon317_Else:
	assume unfoldingHeap#_174_$_1[unfoldingHeap#_174_$_1[this,Node.prev],Node.prev] == null;
	goto anon133;
anon133:
	assert { :msg "  35.25: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  35.25: Location might not be readable." } true ==> CanRead(unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_5,this,Node.prev);
	assert { :msg "  35.25: Receiver might be null." } true ==> (!(unfoldingHeap#_217_$_1[this,Node.prev] == null));
	assert { :msg "  35.25: Location might not be readable." } true ==> CanRead(unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_5,unfoldingHeap#_217_$_1[this,Node.prev],Node.prev);
	if ($_$_condition_$20) { goto anon318_Then; } else { goto anon318_Else; }
anon318_Then:
	assume !(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev] == null);
	assume (0 < unfoldingK#_254) && ((1000 * unfoldingK#_254) < Fractions(1));
	assert { :msg "  36.35: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  36.35: Location might not be readable." } true ==> CanRead(unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_5,this,Node.prev);
	assert { :msg "  36.35: Receiver might be null." } true ==> (!(unfoldingHeap#_217_$_1[this,Node.prev] == null));
	assert { :msg "  36.35: Location might not be readable." } true ==> CanRead(unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_5,unfoldingHeap#_217_$_1[this,Node.prev],Node.prev);
	assert { :msg "  36.35: Receiver might be null." } true ==> (!(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev] == null));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_5);
	assert { :msg "  36.25: Unfolding might fail. The permission at 36.35 might not be positive." } Fractions(100) > 0;
	assert { :msg "  36.25: Unfolding might fail. Insufficient fraction at 36.35 for Node.invLeft." } (Fractions(100) <= unfoldingMask#_218_$_5[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft][perm$R]) && ((Fractions(100) == unfoldingMask#_218_$_5[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft][perm$R]) ==> (0 <= unfoldingMask#_218_$_5[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft][perm$N]));
	assume unfoldingMask#_250_$_0 == unfoldingMask#_218_$_5[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft := unfoldingMask#_218_$_5[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft][perm$R := unfoldingMask#_218_$_5[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft][perm$R] - Fractions(100)]];
	if ($_$_condition_$21) { goto anon319_Then; } else { goto anon319_Else; }
anon318_Else:
	assume unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev] == null;
	assert { :msg "  38.38: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  38.38: Location might not be readable." } true ==> CanRead(unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_5,this,Node.prev);
	assert { :msg "  38.38: Receiver might be null." } true ==> (!(unfoldingHeap#_217_$_1[this,Node.prev] == null));
	assert { :msg "  38.38: Location might not be readable." } true ==> CanRead(unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_5,unfoldingHeap#_217_$_1[this,Node.prev],mu);
	goto anon187;
anon319_Then:
	assume false;
	goto $exit;
anon319_Else:
	assume !false;
	if ($_$_condition_$22) { goto anon326_Then; } else { goto anon326_Else; }
anon326_Then:
	assume !CanRead(unfoldingMask#_250_$_0,unfoldingSecMask#_219_$_5,unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft);
	assume oldVers#_264_$_0 == unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft];
	assume unfoldingHeap#_249_$_0 == unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft := newVers#_265_$_0];
	assume oldVers#_264_$_0 < unfoldingHeap#_249_$_0[unfoldingHeap#_249_$_0[unfoldingHeap#_249_$_0[this,Node.prev],Node.prev],Node.invLeft];
	assume unfoldingHeap#_249_$_1 == unfoldingHeap#_249_$_0;
	goto anon150;
anon326_Else:
	assume CanRead(unfoldingMask#_250_$_0,unfoldingSecMask#_219_$_5,unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.invLeft);
	assume unfoldingHeap#_249_$_1 == unfoldingHeap#_217_$_1;
	goto anon150;
anon150:
	assume IsGoodMask(unfoldingMask#_250_$_0);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_0,unfoldingSecMask#_219_$_5);
	assume IsGoodMask(unfoldingMask#_250_$_0);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_0,unfoldingSecMask#_219_$_5);
	assume !(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev] == null);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_0,unfoldingSecMask#_219_$_5);
	assume (unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev] == null) || (dtype(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingMask#_250_$_1 == unfoldingMask#_250_$_0[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev := unfoldingMask#_250_$_0[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev][perm$N := unfoldingMask#_250_$_0[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_1,unfoldingSecMask#_219_$_5);
	assume IsGoodMask(unfoldingMask#_250_$_1);
	assume IsGoodState(heapFragment(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev]));
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_1,unfoldingSecMask#_219_$_5);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_1,unfoldingSecMask#_219_$_5);
	assume !(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev] == null);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_1,unfoldingSecMask#_219_$_5);
	assume (unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.next] == null) || (dtype(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingMask#_250_$_2 == unfoldingMask#_250_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.next := unfoldingMask#_250_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.next][perm$N := unfoldingMask#_250_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_2,unfoldingSecMask#_219_$_5);
	assume IsGoodMask(unfoldingMask#_250_$_2);
	assume IsGoodState(heapFragment(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.next]));
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_2,unfoldingSecMask#_219_$_5);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_2,unfoldingSecMask#_219_$_5);
	assume !(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev] == null);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_2,unfoldingSecMask#_219_$_5);
	assume true;
	assume 1 > 0;
	assume unfoldingMask#_250_$_3 == unfoldingMask#_250_$_2[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],mu := unfoldingMask#_250_$_2[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],mu][perm$N := unfoldingMask#_250_$_2[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_3,unfoldingSecMask#_219_$_5);
	assume IsGoodMask(unfoldingMask#_250_$_3);
	assume IsGoodState(heapFragment(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],mu]));
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_3,unfoldingSecMask#_219_$_5);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_3,unfoldingSecMask#_219_$_5);
	if ($_$_condition_$23) { goto anon327_Then; } else { goto anon327_Else; }
anon327_Then:
	assume !(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev] == null);
	assume !(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev] == null);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_3,unfoldingSecMask#_219_$_5);
	assume Fractions(100) > 0;
	assume unfoldingMask#_250_$_4 == unfoldingMask#_250_$_3[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev],Node.invLeft := unfoldingMask#_250_$_3[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev],Node.invLeft][perm$R := unfoldingMask#_250_$_3[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_250_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev],Node.invLeft]));
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_219_$_5);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_219_$_5);
	assume predRec#_266_$_0 == Heap[Heap[Heap[this,Node.prev],Node.prev],Node.prev];
	assume #Node.invLeft#trigger(Heap[Heap[Heap[this,Node.prev],Node.prev],Node.prev]);
	assume predVer#_267_$_0 == unfoldingHeap#_249_$_1[Heap[Heap[Heap[this,Node.prev],Node.prev],Node.prev],Node.invLeft];
	if ($_$_condition_$24) { goto anon328_Then; } else { goto anon328_Else; }
anon327_Else:
	assume unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev] == null;
	assume unfoldingMask#_250_$_5 == unfoldingMask#_250_$_3;
	assume unfoldingSecMask#_251_$_5 == unfoldingSecMask#_219_$_5;
	goto anon168;
anon328_Then:
	assume false;
	goto $exit;
anon328_Else:
	assume !false;
	assume !(predRec#_266_$_0 == null);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_219_$_5);
	assume (unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.prev] == null) || (dtype(unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_251_$_0 == unfoldingSecMask#_219_$_5[predRec#_266_$_0,Node.prev := unfoldingSecMask#_219_$_5[predRec#_266_$_0,Node.prev][perm$N := unfoldingSecMask#_219_$_5[predRec#_266_$_0,Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_249_$_1,unfoldingSecMask#_251_$_0,unfoldingSecMask#_251_$_0);
	assume IsGoodMask(unfoldingMask#_250_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.prev]));
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_0);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_0);
	assume !(predRec#_266_$_0 == null);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_0);
	assume (unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.next] == null) || (dtype(unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_251_$_1 == unfoldingSecMask#_251_$_0[predRec#_266_$_0,Node.next := unfoldingSecMask#_251_$_0[predRec#_266_$_0,Node.next][perm$N := unfoldingSecMask#_251_$_0[predRec#_266_$_0,Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_249_$_1,unfoldingSecMask#_251_$_1,unfoldingSecMask#_251_$_1);
	assume IsGoodMask(unfoldingMask#_250_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.next]));
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_1);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_1);
	assume !(predRec#_266_$_0 == null);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_1);
	assume true;
	assume 1 > 0;
	assume unfoldingSecMask#_251_$_2 == unfoldingSecMask#_251_$_1[predRec#_266_$_0,mu := unfoldingSecMask#_251_$_1[predRec#_266_$_0,mu][perm$N := unfoldingSecMask#_251_$_1[predRec#_266_$_0,mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_249_$_1,unfoldingSecMask#_251_$_2,unfoldingSecMask#_251_$_2);
	assume IsGoodMask(unfoldingMask#_250_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_249_$_1[predRec#_266_$_0,mu]));
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_2);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_2);
	if ($_$_condition_$25) { goto anon335_Then; } else { goto anon335_Else; }
anon168:
	assume IsGoodMask(unfoldingMask#_250_$_5);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_5,unfoldingSecMask#_251_$_5);
	if ($_$_condition_$26) { goto anon336_Then; } else { goto anon336_Else; }
anon335_Then:
	assume !(unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.prev] == null);
	assume !(unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.prev] == null);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_2);
	assume Fractions(100) > 0;
	assume unfoldingSecMask#_251_$_3 == unfoldingSecMask#_251_$_2[unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.prev],Node.invLeft := unfoldingSecMask#_251_$_2[unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.prev],Node.invLeft][perm$R := unfoldingSecMask#_251_$_2[unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_250_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.prev],Node.invLeft]));
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_3);
	assume wf(unfoldingHeap#_249_$_1,unfoldingMask#_250_$_4,unfoldingSecMask#_251_$_3);
	assume unfoldingSecMask#_251_$_4 == unfoldingSecMask#_251_$_3;
	goto anon167;
anon335_Else:
	assume unfoldingHeap#_249_$_1[predRec#_266_$_0,Node.prev] == null;
	assume unfoldingSecMask#_251_$_4 == unfoldingSecMask#_251_$_2;
	goto anon167;
anon167:
	assume MuBelow(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],Node.prev],mu],unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],mu]);
	assume unfoldingMask#_250_$_5 == unfoldingMask#_250_$_4;
	assume unfoldingSecMask#_251_$_5 == unfoldingSecMask#_251_$_4;
	goto anon168;
anon336_Then:
	assume false;
	goto $exit;
anon336_Else:
	assume !false;
	assume !(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev] == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_5);
	assume (unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev] == null) || (dtype(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_219_$_6 == unfoldingSecMask#_219_$_5[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev := unfoldingSecMask#_219_$_5[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev][perm$N := unfoldingSecMask#_219_$_5[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_217_$_1,unfoldingSecMask#_219_$_6,unfoldingSecMask#_219_$_6);
	assume IsGoodMask(unfoldingMask#_218_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_6);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_6);
	assume !(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev] == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_6);
	assume (unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.next] == null) || (dtype(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_219_$_7 == unfoldingSecMask#_219_$_6[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.next := unfoldingSecMask#_219_$_6[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.next][perm$N := unfoldingSecMask#_219_$_6[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_217_$_1,unfoldingSecMask#_219_$_7,unfoldingSecMask#_219_$_7);
	assume IsGoodMask(unfoldingMask#_218_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.next]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_7);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_7);
	assume !(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev] == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_7);
	assume true;
	assume 1 > 0;
	assume unfoldingSecMask#_219_$_8 == unfoldingSecMask#_219_$_7[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],mu := unfoldingSecMask#_219_$_7[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],mu][perm$N := unfoldingSecMask#_219_$_7[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_217_$_1,unfoldingSecMask#_219_$_8,unfoldingSecMask#_219_$_8);
	assume IsGoodMask(unfoldingMask#_218_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],mu]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_8);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_8);
	if ($_$_condition_$27) { goto anon343_Then; } else { goto anon343_Else; }
anon343_Then:
	assume !(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev] == null);
	assume !(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev] == null);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_8);
	assume Fractions(100) > 0;
	assume unfoldingSecMask#_219_$_9 == unfoldingSecMask#_219_$_8[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev],Node.invLeft := unfoldingSecMask#_219_$_8[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev],Node.invLeft][perm$R := unfoldingSecMask#_219_$_8[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_218_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev],Node.invLeft]));
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_9);
	assume wf(unfoldingHeap#_217_$_1,unfoldingMask#_218_$_5,unfoldingSecMask#_219_$_9);
	goto anon184;
anon343_Else:
	assume unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[unfoldingHeap#_217_$_1[this,Node.prev],Node.prev],Node.prev] == null;
	goto anon184;
anon184:
	assert { :msg "  37.38: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  37.38: Location might not be readable." } true ==> CanRead(unfoldingMask#_250_$_5,unfoldingSecMask#_251_$_5,this,Node.prev);
	assert { :msg "  37.38: Receiver might be null." } true ==> (!(unfoldingHeap#_249_$_1[this,Node.prev] == null));
	assert { :msg "  37.38: Location might not be readable." } true ==> CanRead(unfoldingMask#_250_$_5,unfoldingSecMask#_251_$_5,unfoldingHeap#_249_$_1[this,Node.prev],Node.prev);
	assert { :msg "  37.38: Receiver might be null." } true ==> (!(unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev] == null));
	assert { :msg "  37.38: Location might not be readable." } true ==> CanRead(unfoldingMask#_250_$_5,unfoldingSecMask#_251_$_5,unfoldingHeap#_249_$_1[unfoldingHeap#_249_$_1[this,Node.prev],Node.prev],mu);
	goto anon187;
anon344_Then:
	assume !(newList#0 == null);
	assert { :msg "  41.36: Receiver might be null." } !(newList#0 == null);
	assume !(newList#0 == null);
	assume wf(Heap_$_0,Mask_$_1,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_2 == Mask_$_1[newList#0,Node.inv := Mask_$_1[newList#0,Node.inv][perm$R := Mask_$_1[newList#0,Node.inv][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_2);
	assume IsGoodState(heapFragment(Heap_$_0[newList#0,Node.inv]));
	assume wf(Heap_$_0,Mask_$_2,ZeroMask);
	assume wf(Heap_$_0,Mask_$_2,ZeroMask);
	assume Mask_$_3 == Mask_$_2;
	goto anon189;
anon344_Else:
	assume newList#0 == null;
	assume Mask_$_3 == Mask_$_1;
	goto anon189;
anon189:
	assume (0 < unfoldingK#_289) && ((1000 * unfoldingK#_289) < Fractions(1));
	assert { :msg "  42.31: Receiver might be null." } true ==> (!(this == null));
	assume unfoldingHeap#_284_$_0 == Heap;
	assume unfoldingMask#_285_$_0 == Mask;
	assume unfoldingSecMask#_286_$_0 == SecMask;
	assume unfoldingCredits#_287_$_0 == Credits;
	assume wf(unfoldingHeap#_284_$_0,unfoldingMask#_285_$_0,unfoldingSecMask#_286_$_0);
	assert { :msg "  42.21: Unfolding might fail. The permission at 42.31 might not be positive." } Fractions(100) > 0;
	assert { :msg "  42.21: Unfolding might fail. Insufficient fraction at 42.31 for Node.inv." } (Fractions(100) <= unfoldingMask#_285_$_0[this,Node.inv][perm$R]) && ((Fractions(100) == unfoldingMask#_285_$_0[this,Node.inv][perm$R]) ==> (0 <= unfoldingMask#_285_$_0[this,Node.inv][perm$N]));
	assume unfoldingMask#_285_$_1 == unfoldingMask#_285_$_0[this,Node.inv := unfoldingMask#_285_$_0[this,Node.inv][perm$R := unfoldingMask#_285_$_0[this,Node.inv][perm$R] - Fractions(100)]];
	if ($_$_condition_$29) { goto anon345_Then; } else { goto anon345_Else; }
anon345_Then:
	assume (false || ((((predVer#_172_$_0 == unfoldingHeap#_284_$_0[this,Node.inv]) && (this == this)) && true) && true)) || ((((Heap_$_0[this,Node.inv] == unfoldingHeap#_284_$_0[this,Node.inv]) && (this == this)) && true) && true);
	if ($_$_condition_$30) { goto anon346_Then; } else { goto anon346_Else; }
anon345_Else:
	assume !((false || ((((predVer#_172_$_0 == unfoldingHeap#_284_$_0[this,Node.inv]) && (this == this)) && true) && true)) || ((((Heap_$_0[this,Node.inv] == unfoldingHeap#_284_$_0[this,Node.inv]) && (this == this)) && true) && true));
	assume unfoldingSecMask#_286_$_18 == unfoldingSecMask#_286_$_0;
	if ($_$_condition_$31) { goto anon356_Then; } else { goto anon356_Else; }
anon346_Then:
	assume (((Heap_$_0[this,Node.inv] == unfoldingHeap#_284_$_0[this,Node.inv]) && (this == this)) && true) && true;
	if ($_$_condition_$32) { goto anon347_Then; } else { goto anon347_Else; }
anon346_Else:
	assume !((((Heap_$_0[this,Node.inv] == unfoldingHeap#_284_$_0[this,Node.inv]) && (this == this)) && true) && true);
	if ($_$_condition_$33) { goto anon347_Then; } else { goto anon347_Else; }
anon356_Then:
	assume !CanRead(unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_18,this,Node.inv);
	assume oldVers#_300_$_0 == unfoldingHeap#_284_$_0[this,Node.inv];
	assume unfoldingHeap#_284_$_1 == unfoldingHeap#_284_$_0[this,Node.inv := newVers#_301_$_0];
	assume oldVers#_300_$_0 < unfoldingHeap#_284_$_1[this,Node.inv];
	assume unfoldingHeap#_284_$_2 == unfoldingHeap#_284_$_1;
	goto anon214;
anon356_Else:
	assume CanRead(unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_18,this,Node.inv);
	assume unfoldingHeap#_284_$_2 == unfoldingHeap#_284_$_0;
	goto anon214;
anon347_Then:
	assume !(unfoldingHeap#_284_$_0[this,Node.prev] == null);
	assume MuBelow(unfoldingHeap#_284_$_0[unfoldingHeap#_284_$_0[this,Node.prev],mu],unfoldingHeap#_284_$_0[this,mu]);
	if ($_$_condition_$34) { goto anon348_Then; } else { goto anon348_Else; }
anon347_Else:
	assume unfoldingHeap#_284_$_0[this,Node.prev] == null;
	if ($_$_condition_$35) { goto anon348_Then; } else { goto anon348_Else; }
anon348_Then:
	assume !(unfoldingHeap#_284_$_0[this,Node.next] == null);
	assume MuBelow(unfoldingHeap#_284_$_0[this,mu],unfoldingHeap#_284_$_0[unfoldingHeap#_284_$_0[this,Node.next],mu]);
	goto anon197;
anon348_Else:
	assume unfoldingHeap#_284_$_0[this,Node.next] == null;
	goto anon197;
anon197:
	assume unfoldingSecMask#_286_$_1 == unfoldingSecMask#_286_$_0[this,Node.prev := unfoldingSecMask#_286_$_0[this,Node.prev][perm$N := unfoldingSecMask#_286_$_0[this,Node.prev][perm$N] - 1]];
	assume wf(unfoldingHeap#_284_$_0,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_1);
	if ($_$_condition_$36) { goto anon349_Then; } else { goto anon349_Else; }
anon349_Then:
	assume unfoldingSecMask#_286_$_1[this,Node.prev][perm$N] < 0;
	assume unfoldingSecMask#_286_$_2 == unfoldingSecMask#_286_$_1[this,Node.prev := unfoldingSecMask#_286_$_1[this,Node.prev][perm$N := 0]];
	assume unfoldingSecMask#_286_$_3 == unfoldingSecMask#_286_$_2;
	goto anon199;
anon349_Else:
	assume 0 <= unfoldingSecMask#_286_$_1[this,Node.prev][perm$N];
	assume unfoldingSecMask#_286_$_3 == unfoldingSecMask#_286_$_1;
	goto anon199;
anon199:
	assume wf(unfoldingHeap#_284_$_0,unfoldingSecMask#_286_$_3,unfoldingSecMask#_286_$_3);
	assume wf(unfoldingHeap#_284_$_0,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_3);
	assume unfoldingSecMask#_286_$_4 == unfoldingSecMask#_286_$_3[this,Node.next := unfoldingSecMask#_286_$_3[this,Node.next][perm$N := unfoldingSecMask#_286_$_3[this,Node.next][perm$N] - 1]];
	assume wf(unfoldingHeap#_284_$_0,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_4);
	if ($_$_condition_$37) { goto anon350_Then; } else { goto anon350_Else; }
anon350_Then:
	assume unfoldingSecMask#_286_$_4[this,Node.next][perm$N] < 0;
	assume unfoldingSecMask#_286_$_5 == unfoldingSecMask#_286_$_4[this,Node.next := unfoldingSecMask#_286_$_4[this,Node.next][perm$N := 0]];
	assume unfoldingSecMask#_286_$_6 == unfoldingSecMask#_286_$_5;
	goto anon201;
anon350_Else:
	assume 0 <= unfoldingSecMask#_286_$_4[this,Node.next][perm$N];
	assume unfoldingSecMask#_286_$_6 == unfoldingSecMask#_286_$_4;
	goto anon201;
anon201:
	assume wf(unfoldingHeap#_284_$_0,unfoldingSecMask#_286_$_6,unfoldingSecMask#_286_$_6);
	assume wf(unfoldingHeap#_284_$_0,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_6);
	assume unfoldingSecMask#_286_$_7 == unfoldingSecMask#_286_$_6[this,mu := unfoldingSecMask#_286_$_6[this,mu][perm$N := unfoldingSecMask#_286_$_6[this,mu][perm$N] - 1]];
	assume wf(unfoldingHeap#_284_$_0,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_7);
	if ($_$_condition_$38) { goto anon351_Then; } else { goto anon351_Else; }
anon351_Then:
	assume unfoldingSecMask#_286_$_7[this,mu][perm$N] < 0;
	assume unfoldingSecMask#_286_$_8 == unfoldingSecMask#_286_$_7[this,mu := unfoldingSecMask#_286_$_7[this,mu][perm$N := 0]];
	assume unfoldingSecMask#_286_$_9 == unfoldingSecMask#_286_$_8;
	goto anon203;
anon351_Else:
	assume 0 <= unfoldingSecMask#_286_$_7[this,mu][perm$N];
	assume unfoldingSecMask#_286_$_9 == unfoldingSecMask#_286_$_7;
	goto anon203;
anon203:
	assume wf(unfoldingHeap#_284_$_0,unfoldingSecMask#_286_$_9,unfoldingSecMask#_286_$_9);
	assume wf(unfoldingHeap#_284_$_0,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_9);
	if ($_$_condition_$39) { goto anon352_Then; } else { goto anon352_Else; }
anon352_Then:
	assume !(unfoldingHeap#_284_$_0[this,Node.prev] == null);
	assume unfoldingSecMask#_286_$_10 == unfoldingSecMask#_286_$_9[unfoldingHeap#_284_$_0[this,Node.prev],Node.invLeft := unfoldingSecMask#_286_$_9[unfoldingHeap#_284_$_0[this,Node.prev],Node.invLeft][perm$R := unfoldingSecMask#_286_$_9[unfoldingHeap#_284_$_0[this,Node.prev],Node.invLeft][perm$R] - Fractions(100)]];
	if ($_$_condition_$40) { goto anon353_Then; } else { goto anon353_Else; }
anon352_Else:
	assume unfoldingHeap#_284_$_0[this,Node.prev] == null;
	assume unfoldingSecMask#_286_$_13 == unfoldingSecMask#_286_$_9;
	if ($_$_condition_$41) { goto anon354_Then; } else { goto anon354_Else; }
anon353_Then:
	assume unfoldingSecMask#_286_$_10[unfoldingHeap#_284_$_0[this,Node.prev],Node.invLeft][perm$R] < 0;
	assume unfoldingSecMask#_286_$_11 == unfoldingSecMask#_286_$_10[unfoldingHeap#_284_$_0[this,Node.prev],Node.invLeft := unfoldingSecMask#_286_$_10[unfoldingHeap#_284_$_0[this,Node.prev],Node.invLeft][perm$R := 0]];
	assume unfoldingSecMask#_286_$_12 == unfoldingSecMask#_286_$_11;
	goto anon206;
anon353_Else:
	assume 0 <= unfoldingSecMask#_286_$_10[unfoldingHeap#_284_$_0[this,Node.prev],Node.invLeft][perm$R];
	assume unfoldingSecMask#_286_$_12 == unfoldingSecMask#_286_$_10;
	goto anon206;
anon354_Then:
	assume !(unfoldingHeap#_284_$_0[this,Node.next] == null);
	assume unfoldingSecMask#_286_$_14 == unfoldingSecMask#_286_$_13[unfoldingHeap#_284_$_0[this,Node.next],Node.invRight := unfoldingSecMask#_286_$_13[unfoldingHeap#_284_$_0[this,Node.next],Node.invRight][perm$R := unfoldingSecMask#_286_$_13[unfoldingHeap#_284_$_0[this,Node.next],Node.invRight][perm$R] - Fractions(100)]];
	if ($_$_condition_$43) { goto anon355_Then; } else { goto anon355_Else; }
anon354_Else:
	assume unfoldingHeap#_284_$_0[this,Node.next] == null;
	assume unfoldingSecMask#_286_$_17 == unfoldingSecMask#_286_$_13;
	goto anon211;
anon206:
	assume wf(unfoldingHeap#_284_$_0,unfoldingSecMask#_286_$_12,unfoldingSecMask#_286_$_12);
	assume wf(unfoldingHeap#_284_$_0,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_12);
	assume unfoldingSecMask#_286_$_13 == unfoldingSecMask#_286_$_12;
	if ($_$_condition_$42) { goto anon354_Then; } else { goto anon354_Else; }
anon355_Then:
	assume unfoldingSecMask#_286_$_14[unfoldingHeap#_284_$_0[this,Node.next],Node.invRight][perm$R] < 0;
	assume unfoldingSecMask#_286_$_15 == unfoldingSecMask#_286_$_14[unfoldingHeap#_284_$_0[this,Node.next],Node.invRight := unfoldingSecMask#_286_$_14[unfoldingHeap#_284_$_0[this,Node.next],Node.invRight][perm$R := 0]];
	assume unfoldingSecMask#_286_$_16 == unfoldingSecMask#_286_$_15;
	goto anon210;
anon355_Else:
	assume 0 <= unfoldingSecMask#_286_$_14[unfoldingHeap#_284_$_0[this,Node.next],Node.invRight][perm$R];
	assume unfoldingSecMask#_286_$_16 == unfoldingSecMask#_286_$_14;
	goto anon210;
anon211:
	assume wf(unfoldingHeap#_284_$_0,unfoldingSecMask#_286_$_17,unfoldingSecMask#_286_$_17);
	assume unfoldingSecMask#_286_$_18 == unfoldingSecMask#_286_$_17;
	if ($_$_condition_$44) { goto anon356_Then; } else { goto anon356_Else; }
anon210:
	assume wf(unfoldingHeap#_284_$_0,unfoldingSecMask#_286_$_16,unfoldingSecMask#_286_$_16);
	assume wf(unfoldingHeap#_284_$_0,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_16);
	assume unfoldingSecMask#_286_$_17 == unfoldingSecMask#_286_$_16;
	goto anon211;
anon214:
	assume IsGoodMask(unfoldingMask#_285_$_1);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_18);
	assume IsGoodMask(unfoldingMask#_285_$_1);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_18);
	assume !(this == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_1,unfoldingSecMask#_286_$_18);
	assume (unfoldingHeap#_284_$_2[this,Node.prev] == null) || (dtype(unfoldingHeap#_284_$_2[this,Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingMask#_285_$_2 == unfoldingMask#_285_$_1[this,Node.prev := unfoldingMask#_285_$_1[this,Node.prev][perm$N := unfoldingMask#_285_$_1[this,Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_2,unfoldingSecMask#_286_$_18);
	assume IsGoodMask(unfoldingMask#_285_$_2);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[this,Node.prev]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_2,unfoldingSecMask#_286_$_18);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_2,unfoldingSecMask#_286_$_18);
	assume !(this == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_2,unfoldingSecMask#_286_$_18);
	assume (unfoldingHeap#_284_$_2[this,Node.next] == null) || (dtype(unfoldingHeap#_284_$_2[this,Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingMask#_285_$_3 == unfoldingMask#_285_$_2[this,Node.next := unfoldingMask#_285_$_2[this,Node.next][perm$N := unfoldingMask#_285_$_2[this,Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_3,unfoldingSecMask#_286_$_18);
	assume IsGoodMask(unfoldingMask#_285_$_3);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[this,Node.next]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_3,unfoldingSecMask#_286_$_18);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_3,unfoldingSecMask#_286_$_18);
	assume !(this == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_3,unfoldingSecMask#_286_$_18);
	assume true;
	assume 1 > 0;
	assume unfoldingMask#_285_$_4 == unfoldingMask#_285_$_3[this,mu := unfoldingMask#_285_$_3[this,mu][perm$N := unfoldingMask#_285_$_3[this,mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_4,unfoldingSecMask#_286_$_18);
	assume IsGoodMask(unfoldingMask#_285_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[this,mu]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_4,unfoldingSecMask#_286_$_18);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_4,unfoldingSecMask#_286_$_18);
	if ($_$_condition_$45) { goto anon357_Then; } else { goto anon357_Else; }
anon357_Then:
	assume !(unfoldingHeap#_284_$_2[this,Node.prev] == null);
	assume !(unfoldingHeap#_284_$_2[this,Node.prev] == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_4,unfoldingSecMask#_286_$_18);
	assume Fractions(100) > 0;
	assume unfoldingMask#_285_$_5 == unfoldingMask#_285_$_4[unfoldingHeap#_284_$_2[this,Node.prev],Node.invLeft := unfoldingMask#_285_$_4[unfoldingHeap#_284_$_2[this,Node.prev],Node.invLeft][perm$R := unfoldingMask#_285_$_4[unfoldingHeap#_284_$_2[this,Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_285_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[unfoldingHeap#_284_$_2[this,Node.prev],Node.invLeft]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_18);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_18);
	assume predRec#_302_$_0 == Heap_$_0[this,Node.prev];
	assume #Node.invLeft#trigger(Heap_$_0[this,Node.prev]);
	assume predVer#_303_$_0 == unfoldingHeap#_284_$_2[Heap_$_0[this,Node.prev],Node.invLeft];
	if ($_$_condition_$46) { goto anon358_Then; } else { goto anon358_Else; }
anon357_Else:
	assume unfoldingHeap#_284_$_2[this,Node.prev] == null;
	assume unfoldingMask#_285_$_6 == unfoldingMask#_285_$_4;
	assume unfoldingSecMask#_286_$_24 == unfoldingSecMask#_286_$_18;
	if ($_$_condition_$47) { goto anon366_Then; } else { goto anon366_Else; }
anon358_Then:
	assume false;
	goto $exit;
anon358_Else:
	assume !false;
	assume !(predRec#_302_$_0 == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_18);
	assume (unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.prev] == null) || (dtype(unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_286_$_19 == unfoldingSecMask#_286_$_18[predRec#_302_$_0,Node.prev := unfoldingSecMask#_286_$_18[predRec#_302_$_0,Node.prev][perm$N := unfoldingSecMask#_286_$_18[predRec#_302_$_0,Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_284_$_2,unfoldingSecMask#_286_$_19,unfoldingSecMask#_286_$_19);
	assume IsGoodMask(unfoldingMask#_285_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.prev]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_19);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_19);
	assume !(predRec#_302_$_0 == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_19);
	assume (unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.next] == null) || (dtype(unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_286_$_20 == unfoldingSecMask#_286_$_19[predRec#_302_$_0,Node.next := unfoldingSecMask#_286_$_19[predRec#_302_$_0,Node.next][perm$N := unfoldingSecMask#_286_$_19[predRec#_302_$_0,Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_284_$_2,unfoldingSecMask#_286_$_20,unfoldingSecMask#_286_$_20);
	assume IsGoodMask(unfoldingMask#_285_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.next]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_20);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_20);
	assume !(predRec#_302_$_0 == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_20);
	assume true;
	assume 1 > 0;
	assume unfoldingSecMask#_286_$_21 == unfoldingSecMask#_286_$_20[predRec#_302_$_0,mu := unfoldingSecMask#_286_$_20[predRec#_302_$_0,mu][perm$N := unfoldingSecMask#_286_$_20[predRec#_302_$_0,mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_284_$_2,unfoldingSecMask#_286_$_21,unfoldingSecMask#_286_$_21);
	assume IsGoodMask(unfoldingMask#_285_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[predRec#_302_$_0,mu]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_21);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_21);
	if ($_$_condition_$48) { goto anon365_Then; } else { goto anon365_Else; }
anon366_Then:
	assume !(unfoldingHeap#_284_$_2[this,Node.next] == null);
	assume !(unfoldingHeap#_284_$_2[this,Node.next] == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_6,unfoldingSecMask#_286_$_24);
	assume Fractions(100) > 0;
	assume unfoldingMask#_285_$_7 == unfoldingMask#_285_$_6[unfoldingHeap#_284_$_2[this,Node.next],Node.invRight := unfoldingMask#_285_$_6[unfoldingHeap#_284_$_2[this,Node.next],Node.invRight][perm$R := unfoldingMask#_285_$_6[unfoldingHeap#_284_$_2[this,Node.next],Node.invRight][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_285_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[unfoldingHeap#_284_$_2[this,Node.next],Node.invRight]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_24);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_24);
	assume predRec#_311_$_0 == Heap_$_0[this,Node.next];
	assume #Node.invRight#trigger(Heap_$_0[this,Node.next]);
	assume predVer#_312_$_0 == unfoldingHeap#_284_$_2[Heap_$_0[this,Node.next],Node.invRight];
	if ($_$_condition_$50) { goto anon367_Then; } else { goto anon367_Else; }
anon366_Else:
	assume unfoldingHeap#_284_$_2[this,Node.next] == null;
	assume unfoldingSecMask#_286_$_30 == unfoldingSecMask#_286_$_24;
	assume unfoldingMask#_285_$_8 == unfoldingMask#_285_$_6;
	goto anon250;
anon365_Then:
	assume !(unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.prev] == null);
	assume !(unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.prev] == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_21);
	assume Fractions(100) > 0;
	assume unfoldingSecMask#_286_$_22 == unfoldingSecMask#_286_$_21[unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.prev],Node.invLeft := unfoldingSecMask#_286_$_21[unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.prev],Node.invLeft][perm$R := unfoldingSecMask#_286_$_21[unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.prev],Node.invLeft][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_285_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.prev],Node.invLeft]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_22);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_5,unfoldingSecMask#_286_$_22);
	assume unfoldingSecMask#_286_$_23 == unfoldingSecMask#_286_$_22;
	goto anon231;
anon365_Else:
	assume unfoldingHeap#_284_$_2[predRec#_302_$_0,Node.prev] == null;
	assume unfoldingSecMask#_286_$_23 == unfoldingSecMask#_286_$_21;
	goto anon231;
anon231:
	assume MuBelow(unfoldingHeap#_284_$_2[unfoldingHeap#_284_$_2[this,Node.prev],mu],unfoldingHeap#_284_$_2[this,mu]);
	assume unfoldingMask#_285_$_6 == unfoldingMask#_285_$_5;
	assume unfoldingSecMask#_286_$_24 == unfoldingSecMask#_286_$_23;
	if ($_$_condition_$49) { goto anon366_Then; } else { goto anon366_Else; }
anon367_Then:
	assume false;
	goto $exit;
anon367_Else:
	assume !false;
	assume !(predRec#_311_$_0 == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_24);
	assume (unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.prev] == null) || (dtype(unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.prev]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_286_$_25 == unfoldingSecMask#_286_$_24[predRec#_311_$_0,Node.prev := unfoldingSecMask#_286_$_24[predRec#_311_$_0,Node.prev][perm$N := unfoldingSecMask#_286_$_24[predRec#_311_$_0,Node.prev][perm$N] + 1]];
	assume wf(unfoldingHeap#_284_$_2,unfoldingSecMask#_286_$_25,unfoldingSecMask#_286_$_25);
	assume IsGoodMask(unfoldingMask#_285_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.prev]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_25);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_25);
	assume !(predRec#_311_$_0 == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_25);
	assume (unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.next] == null) || (dtype(unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.next]) == Node#t);
	assume 1 > 0;
	assume unfoldingSecMask#_286_$_26 == unfoldingSecMask#_286_$_25[predRec#_311_$_0,Node.next := unfoldingSecMask#_286_$_25[predRec#_311_$_0,Node.next][perm$N := unfoldingSecMask#_286_$_25[predRec#_311_$_0,Node.next][perm$N] + 1]];
	assume wf(unfoldingHeap#_284_$_2,unfoldingSecMask#_286_$_26,unfoldingSecMask#_286_$_26);
	assume IsGoodMask(unfoldingMask#_285_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.next]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_26);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_26);
	assume !(predRec#_311_$_0 == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_26);
	assume true;
	assume 1 > 0;
	assume unfoldingSecMask#_286_$_27 == unfoldingSecMask#_286_$_26[predRec#_311_$_0,mu := unfoldingSecMask#_286_$_26[predRec#_311_$_0,mu][perm$N := unfoldingSecMask#_286_$_26[predRec#_311_$_0,mu][perm$N] + 1]];
	assume wf(unfoldingHeap#_284_$_2,unfoldingSecMask#_286_$_27,unfoldingSecMask#_286_$_27);
	assume IsGoodMask(unfoldingMask#_285_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[predRec#_311_$_0,mu]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_27);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_27);
	if ($_$_condition_$51) { goto anon374_Then; } else { goto anon374_Else; }
anon250:
	assume IsGoodMask(unfoldingMask#_285_$_8);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_8,unfoldingSecMask#_286_$_30);
	assert { :msg "  42.38: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  42.38: Location might not be readable." } true ==> CanRead(unfoldingMask#_285_$_8,unfoldingSecMask#_286_$_30,this,Node.next);
	assume Heap[this,Node.next] == newList#0;
	assume IsGoodMask(Mask_$_3);
	assume wf(Heap_$_0,Mask_$_3,ZeroMask);
	goto $exit;
anon374_Then:
	assume !(unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.next] == null);
	assume !(unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.next] == null);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_27);
	assume Fractions(100) > 0;
	assume unfoldingSecMask#_286_$_28 == unfoldingSecMask#_286_$_27[unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.next],Node.invRight := unfoldingSecMask#_286_$_27[unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.next],Node.invRight][perm$R := unfoldingSecMask#_286_$_27[unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.next],Node.invRight][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_285_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_284_$_2[unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.next],Node.invRight]));
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_28);
	assume wf(unfoldingHeap#_284_$_2,unfoldingMask#_285_$_7,unfoldingSecMask#_286_$_28);
	assume unfoldingSecMask#_286_$_29 == unfoldingSecMask#_286_$_28;
	goto anon249;
anon374_Else:
	assume unfoldingHeap#_284_$_2[predRec#_311_$_0,Node.next] == null;
	assume unfoldingSecMask#_286_$_29 == unfoldingSecMask#_286_$_27;
	goto anon249;
anon249:
	assume MuBelow(unfoldingHeap#_284_$_2[this,mu],unfoldingHeap#_284_$_2[unfoldingHeap#_284_$_2[this,Node.next],mu]);
	assume unfoldingSecMask#_286_$_30 == unfoldingSecMask#_286_$_29;
	assume unfoldingMask#_285_$_8 == unfoldingMask#_285_$_7;
	goto anon250;
}
