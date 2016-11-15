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
type Seq m0;
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
const unique AVLTree#t : TypeName;
const unique module#default : ModuleName;
const unique AVLTree.root : Field (ref);
const unique AVLTree.keys : Field (Seq (int));
const unique AVLTree.valid : Field (int);
const unique AVLTreeNode#t : TypeName;
const unique AVLTreeNode.key : Field (int);
const unique AVLTreeNode.height : Field (int);
const unique AVLTreeNode.left : Field (ref);
const unique AVLTreeNode.right : Field (ref);
const unique AVLTreeNode.keys : Field (Seq (int));
const unique AVLTreeNode.balanceFactor : Field (int);
const unique AVLTreeNode.valid : Field (int);
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
function CanRead <T> (MaskType,MaskType,ref,Field (T)) : bool;
function CanReadForSure <T> (MaskType,ref,Field (T)) : bool;
function CanWrite <T> (MaskType,ref,Field (T)) : bool;
function IsGoodMask(MaskType) : bool;
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
function Seq#Length <T> (Seq (T)) : int;
function Seq#Empty <T> () : Seq (T);
function Seq#Singleton <T> (T) : Seq (T);
function Seq#Build <T> (Seq (T),int,T,int) : Seq (T);
function Seq#Append <T> (Seq (T),Seq (T)) : Seq (T);
function Seq#Index <T> (Seq (T),int) : T;
function Seq#Contains <T> (Seq (T),T) : bool;
function Seq#Equal <T> (Seq (T),Seq (T)) : bool;
function Seq#SameUntil <T> (Seq (T),Seq (T),int) : bool;
function Seq#Take <T> (Seq (T),int) : Seq (T);
function Seq#Drop <T> (Seq (T),int) : Seq (T);
function Seq#Range(int,int) : Seq (int);
function #AVLTree.valid#trigger(ref) : bool;
function #AVLTreeNode.valid#trigger(ref) : bool;
var Heap : HeapType;
var Mask : MaskType;
var SecMask : MaskType;
var Credits : CreditsType;
var this#664 : ref;
var this#680 : ref;
var this#693 : ref;
var methodK#_2144 : int;
var Mask_$_0 : MaskType;
var Mask_$_1 : MaskType;
var Mask_$_2 : MaskType;
var Mask_$_3 : MaskType;
var Mask_$_4 : MaskType;
var Mask_$_5 : MaskType;
var Mask_$_6 : MaskType;
var Mask_$_7 : MaskType;
var Mask_$_8 : MaskType;
var Mask_$_9 : MaskType;
var Mask_$_11 : MaskType;
var Mask_$_13 : MaskType;
var Mask_$_15 : MaskType;
var Mask_$_17 : MaskType;
var predRec#_2191_$_0 : ref;
var predVer#_2192_$_0 : int;
var SecMask_$_0 : MaskType;
var SecMask_$_1 : MaskType;
var SecMask_$_2 : MaskType;
var SecMask_$_3 : MaskType;
var SecMask_$_4 : MaskType;
var SecMask_$_5 : MaskType;
var SecMask_$_7 : MaskType;
var SecMask_$_9 : MaskType;
var SecMask_$_11 : MaskType;
var SecMask_$_13 : MaskType;
var SecMask_$_15 : MaskType;
var SecMask_$_17 : MaskType;
var SecMask_$_19 : MaskType;
var SecMask_$_21 : MaskType;
var k#98#644 : int;
var exhaleHeap#_2214_$_0 : HeapType;
var unfoldK#_2216 : int;
var Mask_$_18 : MaskType;
var SecMask_$_72 : MaskType;
var Heap_$_1 : HeapType;
var Mask_$_19 : MaskType;
var Mask_$_20 : MaskType;
var Mask_$_21 : MaskType;
var Mask_$_22 : MaskType;
var Mask_$_23 : MaskType;
var Mask_$_24 : MaskType;
var Mask_$_26 : MaskType;
var Mask_$_28 : MaskType;
var Mask_$_30 : MaskType;
var Mask_$_32 : MaskType;
var Mask_$_34 : MaskType;
var Mask_$_36 : MaskType;
var Mask_$_38 : MaskType;
var Mask_$_40 : MaskType;
var r#66_$_0 : ref;
var k#99#653 : int;
var exhaleHeap#_2242_$_0 : HeapType;
var unfoldK#_2244 : int;
var Mask_$_41 : MaskType;
var SecMask_$_123 : MaskType;
var Heap_$_3 : HeapType;
var Mask_$_42 : MaskType;
var Mask_$_43 : MaskType;
var Mask_$_44 : MaskType;
var Mask_$_45 : MaskType;
var Mask_$_46 : MaskType;
var Mask_$_47 : MaskType;
var Mask_$_49 : MaskType;
var Mask_$_51 : MaskType;
var Mask_$_53 : MaskType;
var Mask_$_55 : MaskType;
var Mask_$_57 : MaskType;
var Mask_$_59 : MaskType;
var Mask_$_61 : MaskType;
var Mask_$_63 : MaskType;
var exhaleHeap#_2270_$_0 : HeapType;
var Heap_$_4 : HeapType;
var methodCallK#_2276 : int;
var this#664_$_0 : ref;
var exhaleMask#_2278_$_0 : MaskType;
var exhaleMask#_2278_$_1 : MaskType;
var exhaleMask#_2278_$_2 : MaskType;
var exhaleMask#_2278_$_3 : MaskType;
var exhaleMask#_2278_$_4 : MaskType;
var exhaleMask#_2278_$_5 : MaskType;
var SecMask_$_175 : MaskType;
var exhaleMask#_2278_$_7 : MaskType;
var exhaleMask#_2278_$_9 : MaskType;
var exhaleMask#_2278_$_11 : MaskType;
var exhaleMask#_2278_$_13 : MaskType;
var exhaleMask#_2278_$_15 : MaskType;
var SecMask_$_227 : MaskType;
var exhaleMask#_2278_$_17 : MaskType;
var exhaleMask#_2278_$_19 : MaskType;
var exhaleMask#_2278_$_21 : MaskType;
var exhaleHeap#_2277_$_0 : HeapType;
var Mask_$_64 : MaskType;
var Mask_$_65 : MaskType;
var Mask_$_66 : MaskType;
var Mask_$_67 : MaskType;
var Heap_$_5 : HeapType;
var Heap_$_6 : HeapType;
var exhaleHeap#_2331_$_0 : HeapType;
var methodCallK#_2337 : int;
var exhaleMask#_2339_$_0 : MaskType;
var exhaleMask#_2339_$_1 : MaskType;
var exhaleMask#_2339_$_2 : MaskType;
var exhaleMask#_2339_$_3 : MaskType;
var exhaleMask#_2339_$_4 : MaskType;
var exhaleMask#_2339_$_5 : MaskType;
var SecMask_$_279 : MaskType;
var exhaleMask#_2339_$_7 : MaskType;
var exhaleMask#_2339_$_9 : MaskType;
var exhaleMask#_2339_$_11 : MaskType;
var exhaleMask#_2339_$_13 : MaskType;
var exhaleMask#_2339_$_15 : MaskType;
var SecMask_$_331 : MaskType;
var exhaleMask#_2339_$_17 : MaskType;
var exhaleMask#_2339_$_19 : MaskType;
var exhaleMask#_2339_$_21 : MaskType;
var exhaleHeap#_2338_$_0 : HeapType;
var Mask_$_68 : MaskType;
var Mask_$_69 : MaskType;
var Mask_$_70 : MaskType;
var Mask_$_71 : MaskType;
var Heap_$_7 : HeapType;
var methodCallK#_2392 : int;
var exhaleMask#_2394_$_0 : MaskType;
var exhaleMask#_2394_$_1 : MaskType;
var exhaleMask#_2394_$_2 : MaskType;
var exhaleMask#_2394_$_3 : MaskType;
var exhaleMask#_2394_$_4 : MaskType;
var exhaleMask#_2394_$_5 : MaskType;
var SecMask_$_383 : MaskType;
var exhaleMask#_2394_$_7 : MaskType;
var exhaleMask#_2394_$_9 : MaskType;
var exhaleMask#_2394_$_11 : MaskType;
var exhaleMask#_2394_$_13 : MaskType;
var exhaleMask#_2394_$_15 : MaskType;
var SecMask_$_435 : MaskType;
var exhaleMask#_2394_$_17 : MaskType;
var exhaleMask#_2394_$_19 : MaskType;
var exhaleMask#_2394_$_21 : MaskType;
var exhaleHeap#_2393_$_0 : HeapType;
var Mask_$_72 : MaskType;
var Mask_$_73 : MaskType;
var Mask_$_74 : MaskType;
var Mask_$_75 : MaskType;
var exhaleMask#_2444_$_0 : MaskType;
var SecMask_$_486 : MaskType;
var exhaleMask#_2444_$_1 : MaskType;
var exhaleMask#_2444_$_2 : MaskType;
var exhaleMask#_2444_$_3 : MaskType;
var exhaleHeap#_2443_$_0 : HeapType;
var SecMask_$_436 : MaskType;
var SecMask_$_438 : MaskType;
var SecMask_$_439 : MaskType;
var SecMask_$_441 : MaskType;
var SecMask_$_442 : MaskType;
var SecMask_$_444 : MaskType;
var SecMask_$_445 : MaskType;
var SecMask_$_447 : MaskType;
var SecMask_$_448 : MaskType;
var SecMask_$_450 : MaskType;
var SecMask_$_451 : MaskType;
var SecMask_$_453 : MaskType;
var SecMask_$_457 : MaskType;
var SecMask_$_461 : MaskType;
var SecMask_$_465 : MaskType;
var SecMask_$_469 : MaskType;
var SecMask_$_473 : MaskType;
var SecMask_$_477 : MaskType;
var SecMask_$_481 : MaskType;
var SecMask_$_485 : MaskType;
var SecMask_$_482 : MaskType;
var SecMask_$_484 : MaskType;
var SecMask_$_483 : MaskType;
var SecMask_$_478 : MaskType;
var SecMask_$_480 : MaskType;
var SecMask_$_479 : MaskType;
var SecMask_$_474 : MaskType;
var SecMask_$_476 : MaskType;
var SecMask_$_475 : MaskType;
var SecMask_$_470 : MaskType;
var SecMask_$_472 : MaskType;
var SecMask_$_471 : MaskType;
var SecMask_$_466 : MaskType;
var SecMask_$_468 : MaskType;
var SecMask_$_467 : MaskType;
var SecMask_$_462 : MaskType;
var SecMask_$_464 : MaskType;
var SecMask_$_463 : MaskType;
var SecMask_$_458 : MaskType;
var SecMask_$_460 : MaskType;
var SecMask_$_459 : MaskType;
var SecMask_$_454 : MaskType;
var SecMask_$_456 : MaskType;
var SecMask_$_455 : MaskType;
var SecMask_$_452 : MaskType;
var SecMask_$_449 : MaskType;
var SecMask_$_446 : MaskType;
var SecMask_$_443 : MaskType;
var SecMask_$_440 : MaskType;
var SecMask_$_437 : MaskType;
var exhaleMask#_2394_$_20 : MaskType;
var exhaleMask#_2394_$_18 : MaskType;
var exhaleMask#_2394_$_16 : MaskType;
var exhaleMask#_2394_$_14 : MaskType;
var SecMask_$_434 : MaskType;
var SecMask_$_384 : MaskType;
var SecMask_$_386 : MaskType;
var SecMask_$_387 : MaskType;
var SecMask_$_389 : MaskType;
var SecMask_$_390 : MaskType;
var SecMask_$_392 : MaskType;
var SecMask_$_393 : MaskType;
var SecMask_$_395 : MaskType;
var SecMask_$_396 : MaskType;
var SecMask_$_398 : MaskType;
var SecMask_$_399 : MaskType;
var SecMask_$_401 : MaskType;
var SecMask_$_405 : MaskType;
var SecMask_$_409 : MaskType;
var SecMask_$_413 : MaskType;
var SecMask_$_417 : MaskType;
var SecMask_$_421 : MaskType;
var SecMask_$_425 : MaskType;
var SecMask_$_429 : MaskType;
var SecMask_$_433 : MaskType;
var SecMask_$_430 : MaskType;
var SecMask_$_432 : MaskType;
var SecMask_$_431 : MaskType;
var SecMask_$_426 : MaskType;
var SecMask_$_428 : MaskType;
var SecMask_$_427 : MaskType;
var SecMask_$_422 : MaskType;
var SecMask_$_424 : MaskType;
var SecMask_$_423 : MaskType;
var SecMask_$_418 : MaskType;
var SecMask_$_420 : MaskType;
var SecMask_$_419 : MaskType;
var SecMask_$_414 : MaskType;
var SecMask_$_416 : MaskType;
var SecMask_$_415 : MaskType;
var SecMask_$_410 : MaskType;
var SecMask_$_412 : MaskType;
var SecMask_$_411 : MaskType;
var SecMask_$_406 : MaskType;
var SecMask_$_408 : MaskType;
var SecMask_$_407 : MaskType;
var SecMask_$_402 : MaskType;
var SecMask_$_404 : MaskType;
var SecMask_$_403 : MaskType;
var SecMask_$_400 : MaskType;
var SecMask_$_397 : MaskType;
var SecMask_$_394 : MaskType;
var SecMask_$_391 : MaskType;
var SecMask_$_388 : MaskType;
var SecMask_$_385 : MaskType;
var exhaleMask#_2394_$_12 : MaskType;
var exhaleMask#_2394_$_10 : MaskType;
var exhaleMask#_2394_$_8 : MaskType;
var exhaleMask#_2394_$_6 : MaskType;
var SecMask_$_382 : MaskType;
var SecMask_$_332 : MaskType;
var SecMask_$_334 : MaskType;
var SecMask_$_335 : MaskType;
var SecMask_$_337 : MaskType;
var SecMask_$_338 : MaskType;
var SecMask_$_340 : MaskType;
var SecMask_$_341 : MaskType;
var SecMask_$_343 : MaskType;
var SecMask_$_344 : MaskType;
var SecMask_$_346 : MaskType;
var SecMask_$_347 : MaskType;
var SecMask_$_349 : MaskType;
var SecMask_$_353 : MaskType;
var SecMask_$_357 : MaskType;
var SecMask_$_361 : MaskType;
var SecMask_$_365 : MaskType;
var SecMask_$_369 : MaskType;
var SecMask_$_373 : MaskType;
var SecMask_$_377 : MaskType;
var SecMask_$_381 : MaskType;
var SecMask_$_378 : MaskType;
var SecMask_$_380 : MaskType;
var SecMask_$_379 : MaskType;
var SecMask_$_374 : MaskType;
var SecMask_$_376 : MaskType;
var SecMask_$_375 : MaskType;
var SecMask_$_370 : MaskType;
var SecMask_$_372 : MaskType;
var SecMask_$_371 : MaskType;
var SecMask_$_366 : MaskType;
var SecMask_$_368 : MaskType;
var SecMask_$_367 : MaskType;
var SecMask_$_362 : MaskType;
var SecMask_$_364 : MaskType;
var SecMask_$_363 : MaskType;
var SecMask_$_358 : MaskType;
var SecMask_$_360 : MaskType;
var SecMask_$_359 : MaskType;
var SecMask_$_354 : MaskType;
var SecMask_$_356 : MaskType;
var SecMask_$_355 : MaskType;
var SecMask_$_350 : MaskType;
var SecMask_$_352 : MaskType;
var SecMask_$_351 : MaskType;
var SecMask_$_348 : MaskType;
var SecMask_$_345 : MaskType;
var SecMask_$_342 : MaskType;
var SecMask_$_339 : MaskType;
var SecMask_$_336 : MaskType;
var SecMask_$_333 : MaskType;
var exhaleMask#_2339_$_20 : MaskType;
var exhaleMask#_2339_$_18 : MaskType;
var exhaleMask#_2339_$_16 : MaskType;
var exhaleMask#_2339_$_14 : MaskType;
var SecMask_$_330 : MaskType;
var SecMask_$_280 : MaskType;
var SecMask_$_282 : MaskType;
var SecMask_$_283 : MaskType;
var SecMask_$_285 : MaskType;
var SecMask_$_286 : MaskType;
var SecMask_$_288 : MaskType;
var SecMask_$_289 : MaskType;
var SecMask_$_291 : MaskType;
var SecMask_$_292 : MaskType;
var SecMask_$_294 : MaskType;
var SecMask_$_295 : MaskType;
var SecMask_$_297 : MaskType;
var SecMask_$_301 : MaskType;
var SecMask_$_305 : MaskType;
var SecMask_$_309 : MaskType;
var SecMask_$_313 : MaskType;
var SecMask_$_317 : MaskType;
var SecMask_$_321 : MaskType;
var SecMask_$_325 : MaskType;
var SecMask_$_329 : MaskType;
var SecMask_$_326 : MaskType;
var SecMask_$_328 : MaskType;
var SecMask_$_327 : MaskType;
var SecMask_$_322 : MaskType;
var SecMask_$_324 : MaskType;
var SecMask_$_323 : MaskType;
var SecMask_$_318 : MaskType;
var SecMask_$_320 : MaskType;
var SecMask_$_319 : MaskType;
var SecMask_$_314 : MaskType;
var SecMask_$_316 : MaskType;
var SecMask_$_315 : MaskType;
var SecMask_$_310 : MaskType;
var SecMask_$_312 : MaskType;
var SecMask_$_311 : MaskType;
var SecMask_$_306 : MaskType;
var SecMask_$_308 : MaskType;
var SecMask_$_307 : MaskType;
var SecMask_$_302 : MaskType;
var SecMask_$_304 : MaskType;
var SecMask_$_303 : MaskType;
var SecMask_$_298 : MaskType;
var SecMask_$_300 : MaskType;
var SecMask_$_299 : MaskType;
var SecMask_$_296 : MaskType;
var SecMask_$_293 : MaskType;
var SecMask_$_290 : MaskType;
var SecMask_$_287 : MaskType;
var SecMask_$_284 : MaskType;
var SecMask_$_281 : MaskType;
var exhaleMask#_2339_$_12 : MaskType;
var exhaleMask#_2339_$_10 : MaskType;
var exhaleMask#_2339_$_8 : MaskType;
var exhaleMask#_2339_$_6 : MaskType;
var SecMask_$_278 : MaskType;
var SecMask_$_228 : MaskType;
var SecMask_$_230 : MaskType;
var SecMask_$_231 : MaskType;
var SecMask_$_233 : MaskType;
var SecMask_$_234 : MaskType;
var SecMask_$_236 : MaskType;
var SecMask_$_237 : MaskType;
var SecMask_$_239 : MaskType;
var SecMask_$_240 : MaskType;
var SecMask_$_242 : MaskType;
var SecMask_$_243 : MaskType;
var SecMask_$_245 : MaskType;
var SecMask_$_249 : MaskType;
var SecMask_$_253 : MaskType;
var SecMask_$_257 : MaskType;
var SecMask_$_261 : MaskType;
var SecMask_$_265 : MaskType;
var SecMask_$_269 : MaskType;
var SecMask_$_273 : MaskType;
var SecMask_$_277 : MaskType;
var SecMask_$_274 : MaskType;
var SecMask_$_276 : MaskType;
var SecMask_$_275 : MaskType;
var SecMask_$_270 : MaskType;
var SecMask_$_272 : MaskType;
var SecMask_$_271 : MaskType;
var SecMask_$_266 : MaskType;
var SecMask_$_268 : MaskType;
var SecMask_$_267 : MaskType;
var SecMask_$_262 : MaskType;
var SecMask_$_264 : MaskType;
var SecMask_$_263 : MaskType;
var SecMask_$_258 : MaskType;
var SecMask_$_260 : MaskType;
var SecMask_$_259 : MaskType;
var SecMask_$_254 : MaskType;
var SecMask_$_256 : MaskType;
var SecMask_$_255 : MaskType;
var SecMask_$_250 : MaskType;
var SecMask_$_252 : MaskType;
var SecMask_$_251 : MaskType;
var SecMask_$_246 : MaskType;
var SecMask_$_248 : MaskType;
var SecMask_$_247 : MaskType;
var SecMask_$_244 : MaskType;
var SecMask_$_241 : MaskType;
var SecMask_$_238 : MaskType;
var SecMask_$_235 : MaskType;
var SecMask_$_232 : MaskType;
var SecMask_$_229 : MaskType;
var k#101#678 : int;
var exhaleMask#_2278_$_20 : MaskType;
var exhaleMask#_2278_$_18 : MaskType;
var exhaleMask#_2278_$_16 : MaskType;
var exhaleMask#_2278_$_14 : MaskType;
var SecMask_$_226 : MaskType;
var SecMask_$_176 : MaskType;
var SecMask_$_178 : MaskType;
var SecMask_$_179 : MaskType;
var SecMask_$_181 : MaskType;
var SecMask_$_182 : MaskType;
var SecMask_$_184 : MaskType;
var SecMask_$_185 : MaskType;
var SecMask_$_187 : MaskType;
var SecMask_$_188 : MaskType;
var SecMask_$_190 : MaskType;
var SecMask_$_191 : MaskType;
var SecMask_$_193 : MaskType;
var SecMask_$_197 : MaskType;
var SecMask_$_201 : MaskType;
var SecMask_$_205 : MaskType;
var SecMask_$_209 : MaskType;
var SecMask_$_213 : MaskType;
var SecMask_$_217 : MaskType;
var SecMask_$_221 : MaskType;
var SecMask_$_225 : MaskType;
var SecMask_$_222 : MaskType;
var SecMask_$_224 : MaskType;
var SecMask_$_223 : MaskType;
var SecMask_$_218 : MaskType;
var SecMask_$_220 : MaskType;
var SecMask_$_219 : MaskType;
var SecMask_$_214 : MaskType;
var SecMask_$_216 : MaskType;
var SecMask_$_215 : MaskType;
var SecMask_$_210 : MaskType;
var SecMask_$_212 : MaskType;
var SecMask_$_211 : MaskType;
var SecMask_$_206 : MaskType;
var SecMask_$_208 : MaskType;
var SecMask_$_207 : MaskType;
var SecMask_$_202 : MaskType;
var SecMask_$_204 : MaskType;
var SecMask_$_203 : MaskType;
var SecMask_$_198 : MaskType;
var SecMask_$_200 : MaskType;
var SecMask_$_199 : MaskType;
var SecMask_$_194 : MaskType;
var SecMask_$_196 : MaskType;
var SecMask_$_195 : MaskType;
var SecMask_$_192 : MaskType;
var SecMask_$_189 : MaskType;
var SecMask_$_186 : MaskType;
var SecMask_$_183 : MaskType;
var SecMask_$_180 : MaskType;
var SecMask_$_177 : MaskType;
var exhaleMask#_2278_$_12 : MaskType;
var exhaleMask#_2278_$_10 : MaskType;
var exhaleMask#_2278_$_8 : MaskType;
var exhaleMask#_2278_$_6 : MaskType;
var SecMask_$_174 : MaskType;
var SecMask_$_124 : MaskType;
var SecMask_$_126 : MaskType;
var SecMask_$_127 : MaskType;
var SecMask_$_129 : MaskType;
var SecMask_$_130 : MaskType;
var SecMask_$_132 : MaskType;
var SecMask_$_133 : MaskType;
var SecMask_$_135 : MaskType;
var SecMask_$_136 : MaskType;
var SecMask_$_138 : MaskType;
var SecMask_$_139 : MaskType;
var SecMask_$_141 : MaskType;
var SecMask_$_145 : MaskType;
var SecMask_$_149 : MaskType;
var SecMask_$_153 : MaskType;
var SecMask_$_157 : MaskType;
var SecMask_$_161 : MaskType;
var SecMask_$_165 : MaskType;
var SecMask_$_169 : MaskType;
var SecMask_$_173 : MaskType;
var SecMask_$_170 : MaskType;
var SecMask_$_172 : MaskType;
var SecMask_$_171 : MaskType;
var SecMask_$_166 : MaskType;
var SecMask_$_168 : MaskType;
var SecMask_$_167 : MaskType;
var SecMask_$_162 : MaskType;
var SecMask_$_164 : MaskType;
var SecMask_$_163 : MaskType;
var SecMask_$_158 : MaskType;
var SecMask_$_160 : MaskType;
var SecMask_$_159 : MaskType;
var SecMask_$_154 : MaskType;
var SecMask_$_156 : MaskType;
var SecMask_$_155 : MaskType;
var SecMask_$_150 : MaskType;
var SecMask_$_152 : MaskType;
var SecMask_$_151 : MaskType;
var SecMask_$_146 : MaskType;
var SecMask_$_148 : MaskType;
var SecMask_$_147 : MaskType;
var SecMask_$_142 : MaskType;
var SecMask_$_144 : MaskType;
var SecMask_$_143 : MaskType;
var SecMask_$_140 : MaskType;
var SecMask_$_137 : MaskType;
var SecMask_$_134 : MaskType;
var SecMask_$_131 : MaskType;
var SecMask_$_128 : MaskType;
var SecMask_$_125 : MaskType;
var k#100#662 : int;
var Mask_$_62 : MaskType;
var Mask_$_60 : MaskType;
var Mask_$_58 : MaskType;
var Mask_$_56 : MaskType;
var Mask_$_54 : MaskType;
var Mask_$_52 : MaskType;
var Mask_$_50 : MaskType;
var Mask_$_48 : MaskType;
var oldVers#_2264_$_0 : int;
var Heap_$_2 : HeapType;
var newVers#_2265_$_0 : int;
var SecMask_$_73 : MaskType;
var SecMask_$_75 : MaskType;
var SecMask_$_76 : MaskType;
var SecMask_$_78 : MaskType;
var SecMask_$_79 : MaskType;
var SecMask_$_81 : MaskType;
var SecMask_$_82 : MaskType;
var SecMask_$_84 : MaskType;
var SecMask_$_85 : MaskType;
var SecMask_$_87 : MaskType;
var SecMask_$_88 : MaskType;
var SecMask_$_90 : MaskType;
var SecMask_$_94 : MaskType;
var SecMask_$_98 : MaskType;
var SecMask_$_102 : MaskType;
var SecMask_$_106 : MaskType;
var SecMask_$_110 : MaskType;
var SecMask_$_114 : MaskType;
var SecMask_$_118 : MaskType;
var SecMask_$_122 : MaskType;
var SecMask_$_119 : MaskType;
var SecMask_$_121 : MaskType;
var SecMask_$_120 : MaskType;
var SecMask_$_115 : MaskType;
var SecMask_$_117 : MaskType;
var SecMask_$_116 : MaskType;
var SecMask_$_111 : MaskType;
var SecMask_$_113 : MaskType;
var SecMask_$_112 : MaskType;
var SecMask_$_107 : MaskType;
var SecMask_$_109 : MaskType;
var SecMask_$_108 : MaskType;
var SecMask_$_103 : MaskType;
var SecMask_$_105 : MaskType;
var SecMask_$_104 : MaskType;
var SecMask_$_99 : MaskType;
var SecMask_$_101 : MaskType;
var SecMask_$_100 : MaskType;
var SecMask_$_95 : MaskType;
var SecMask_$_97 : MaskType;
var SecMask_$_96 : MaskType;
var SecMask_$_91 : MaskType;
var SecMask_$_93 : MaskType;
var SecMask_$_92 : MaskType;
var SecMask_$_89 : MaskType;
var SecMask_$_86 : MaskType;
var SecMask_$_83 : MaskType;
var SecMask_$_80 : MaskType;
var SecMask_$_77 : MaskType;
var SecMask_$_74 : MaskType;
var Mask_$_39 : MaskType;
var Mask_$_37 : MaskType;
var Mask_$_35 : MaskType;
var Mask_$_33 : MaskType;
var Mask_$_31 : MaskType;
var Mask_$_29 : MaskType;
var Mask_$_27 : MaskType;
var Mask_$_25 : MaskType;
var oldVers#_2236_$_0 : int;
var Heap_$_0 : HeapType;
var newVers#_2237_$_0 : int;
var SecMask_$_22 : MaskType;
var SecMask_$_24 : MaskType;
var SecMask_$_25 : MaskType;
var SecMask_$_27 : MaskType;
var SecMask_$_28 : MaskType;
var SecMask_$_30 : MaskType;
var SecMask_$_31 : MaskType;
var SecMask_$_33 : MaskType;
var SecMask_$_34 : MaskType;
var SecMask_$_36 : MaskType;
var SecMask_$_37 : MaskType;
var SecMask_$_39 : MaskType;
var SecMask_$_43 : MaskType;
var SecMask_$_47 : MaskType;
var SecMask_$_51 : MaskType;
var SecMask_$_55 : MaskType;
var SecMask_$_59 : MaskType;
var SecMask_$_63 : MaskType;
var SecMask_$_67 : MaskType;
var SecMask_$_71 : MaskType;
var SecMask_$_68 : MaskType;
var SecMask_$_70 : MaskType;
var SecMask_$_69 : MaskType;
var SecMask_$_64 : MaskType;
var SecMask_$_66 : MaskType;
var SecMask_$_65 : MaskType;
var SecMask_$_60 : MaskType;
var SecMask_$_62 : MaskType;
var SecMask_$_61 : MaskType;
var SecMask_$_56 : MaskType;
var SecMask_$_58 : MaskType;
var SecMask_$_57 : MaskType;
var SecMask_$_52 : MaskType;
var SecMask_$_54 : MaskType;
var SecMask_$_53 : MaskType;
var SecMask_$_48 : MaskType;
var SecMask_$_50 : MaskType;
var SecMask_$_49 : MaskType;
var SecMask_$_44 : MaskType;
var SecMask_$_46 : MaskType;
var SecMask_$_45 : MaskType;
var SecMask_$_40 : MaskType;
var SecMask_$_42 : MaskType;
var SecMask_$_41 : MaskType;
var SecMask_$_38 : MaskType;
var SecMask_$_35 : MaskType;
var SecMask_$_32 : MaskType;
var SecMask_$_29 : MaskType;
var SecMask_$_26 : MaskType;
var SecMask_$_23 : MaskType;
var SecMask_$_20 : MaskType;
var SecMask_$_18 : MaskType;
var SecMask_$_16 : MaskType;
var SecMask_$_14 : MaskType;
var SecMask_$_12 : MaskType;
var SecMask_$_10 : MaskType;
var SecMask_$_8 : MaskType;
var SecMask_$_6 : MaskType;
var Mask_$_16 : MaskType;
var Mask_$_14 : MaskType;
var Mask_$_12 : MaskType;
var Mask_$_10 : MaskType;
var predRec#_2191 : ref;
var predFlag#_2193 : bool;
var predVer#_2192 : int;
var assertHeap#_2210 : HeapType;
var assertMask#_2211 : MaskType;
var assertSecMask#_2212 : MaskType;
var assertCredits#_2213 : CreditsType;
var exhaleMask#_2215 : MaskType;
var exhaleHeap#_2214 : HeapType;
var oldVers#_2236 : int;
var newVers#_2237 : int;
var assertHeap#_2238 : HeapType;
var assertMask#_2239 : MaskType;
var assertSecMask#_2240 : MaskType;
var assertCredits#_2241 : CreditsType;
var exhaleMask#_2243 : MaskType;
var exhaleHeap#_2242 : HeapType;
var oldVers#_2264 : int;
var newVers#_2265 : int;
var assertHeap#_2266 : HeapType;
var assertMask#_2267 : MaskType;
var assertSecMask#_2268 : MaskType;
var assertCredits#_2269 : CreditsType;
var exhaleMask#_2271 : MaskType;
var exhaleHeap#_2270 : HeapType;
var callHeap#_2272 : HeapType;
var callMask#_2273 : MaskType;
var callSecMask#_2274 : MaskType;
var callCredits#_2275 : CreditsType;
var exhaleMask#_2278 : MaskType;
var exhaleHeap#_2277 : HeapType;
var assertHeap#_2327 : HeapType;
var assertMask#_2328 : MaskType;
var assertSecMask#_2329 : MaskType;
var assertCredits#_2330 : CreditsType;
var exhaleMask#_2332 : MaskType;
var exhaleHeap#_2331 : HeapType;
var callHeap#_2333 : HeapType;
var callMask#_2334 : MaskType;
var callSecMask#_2335 : MaskType;
var callCredits#_2336 : CreditsType;
var exhaleMask#_2339 : MaskType;
var exhaleHeap#_2338 : HeapType;
var callHeap#_2388 : HeapType;
var callMask#_2389 : MaskType;
var callSecMask#_2390 : MaskType;
var callCredits#_2391 : CreditsType;
var exhaleMask#_2394 : MaskType;
var exhaleHeap#_2393 : HeapType;
var exhaleMask#_2444 : MaskType;
var exhaleHeap#_2443 : HeapType;
procedure AVLTreeNode.rebalanceRL (this : ref) returns (r#66 : ref)
{
	var methodK#_2144 : int;
	var predRec#_2191 : ref;
	var predFlag#_2193 : bool;
	var predVer#_2192 : int;
	var assertHeap#_2210 : HeapType;
	var assertMask#_2211 : MaskType;
	var assertSecMask#_2212 : MaskType;
	var assertCredits#_2213 : CreditsType;
	var exhaleMask#_2215 : MaskType;
	var exhaleHeap#_2214 : HeapType;
	var k#98#644 : int;
	var unfoldK#_2216 : int;
	var oldVers#_2236 : int;
	var newVers#_2237 : int;
	var assertHeap#_2238 : HeapType;
	var assertMask#_2239 : MaskType;
	var assertSecMask#_2240 : MaskType;
	var assertCredits#_2241 : CreditsType;
	var exhaleMask#_2243 : MaskType;
	var exhaleHeap#_2242 : HeapType;
	var k#99#653 : int;
	var unfoldK#_2244 : int;
	var oldVers#_2264 : int;
	var newVers#_2265 : int;
	var assertHeap#_2266 : HeapType;
	var assertMask#_2267 : MaskType;
	var assertSecMask#_2268 : MaskType;
	var assertCredits#_2269 : CreditsType;
	var exhaleMask#_2271 : MaskType;
	var exhaleHeap#_2270 : HeapType;
	var k#100#662 : int;
	var methodCallK#_2276 : int;
	var this#664 : ref;
	var callHeap#_2272 : HeapType;
	var callMask#_2273 : MaskType;
	var callSecMask#_2274 : MaskType;
	var callCredits#_2275 : CreditsType;
	var exhaleMask#_2278 : MaskType;
	var exhaleHeap#_2277 : HeapType;
	var assertHeap#_2327 : HeapType;
	var assertMask#_2328 : MaskType;
	var assertSecMask#_2329 : MaskType;
	var assertCredits#_2330 : CreditsType;
	var exhaleMask#_2332 : MaskType;
	var exhaleHeap#_2331 : HeapType;
	var k#101#678 : int;
	var methodCallK#_2337 : int;
	var this#680 : ref;
	var callHeap#_2333 : HeapType;
	var callMask#_2334 : MaskType;
	var callSecMask#_2335 : MaskType;
	var callCredits#_2336 : CreditsType;
	var exhaleMask#_2339 : MaskType;
	var exhaleHeap#_2338 : HeapType;
	var methodCallK#_2392 : int;
	var this#693 : ref;
	var callHeap#_2388 : HeapType;
	var callMask#_2389 : MaskType;
	var callSecMask#_2390 : MaskType;
	var callCredits#_2391 : CreditsType;
	var exhaleMask#_2394 : MaskType;
	var exhaleHeap#_2393 : HeapType;
	var exhaleMask#_2444 : MaskType;
	var exhaleHeap#_2443 : HeapType;
	var Mask_$_0 : MaskType;
	var Mask_$_1 : MaskType;
	var Mask_$_2 : MaskType;
	var Mask_$_3 : MaskType;
	var Mask_$_4 : MaskType;
	var Mask_$_5 : MaskType;
	var Mask_$_6 : MaskType;
	var Mask_$_7 : MaskType;
	var Mask_$_8 : MaskType;
	var Mask_$_9 : MaskType;
	var Mask_$_10 : MaskType;
	var Mask_$_11 : MaskType;
	var Mask_$_12 : MaskType;
	var Mask_$_13 : MaskType;
	var Mask_$_14 : MaskType;
	var Mask_$_15 : MaskType;
	var Mask_$_16 : MaskType;
	var Mask_$_17 : MaskType;
	var predRec#_2191_$_0 : ref;
	var predVer#_2192_$_0 : int;
	var SecMask_$_0 : MaskType;
	var SecMask_$_1 : MaskType;
	var SecMask_$_2 : MaskType;
	var SecMask_$_3 : MaskType;
	var SecMask_$_4 : MaskType;
	var SecMask_$_5 : MaskType;
	var SecMask_$_6 : MaskType;
	var SecMask_$_7 : MaskType;
	var SecMask_$_8 : MaskType;
	var SecMask_$_9 : MaskType;
	var SecMask_$_10 : MaskType;
	var SecMask_$_11 : MaskType;
	var SecMask_$_12 : MaskType;
	var SecMask_$_13 : MaskType;
	var SecMask_$_14 : MaskType;
	var SecMask_$_15 : MaskType;
	var SecMask_$_16 : MaskType;
	var SecMask_$_17 : MaskType;
	var SecMask_$_18 : MaskType;
	var SecMask_$_19 : MaskType;
	var SecMask_$_20 : MaskType;
	var SecMask_$_21 : MaskType;
	var exhaleHeap#_2214_$_0 : HeapType;
	var Mask_$_18 : MaskType;
	var SecMask_$_22 : MaskType;
	var SecMask_$_23 : MaskType;
	var SecMask_$_24 : MaskType;
	var SecMask_$_25 : MaskType;
	var SecMask_$_26 : MaskType;
	var SecMask_$_27 : MaskType;
	var SecMask_$_28 : MaskType;
	var SecMask_$_29 : MaskType;
	var SecMask_$_30 : MaskType;
	var SecMask_$_31 : MaskType;
	var SecMask_$_32 : MaskType;
	var SecMask_$_33 : MaskType;
	var SecMask_$_34 : MaskType;
	var SecMask_$_35 : MaskType;
	var SecMask_$_36 : MaskType;
	var SecMask_$_37 : MaskType;
	var SecMask_$_38 : MaskType;
	var SecMask_$_39 : MaskType;
	var SecMask_$_40 : MaskType;
	var SecMask_$_41 : MaskType;
	var SecMask_$_42 : MaskType;
	var SecMask_$_43 : MaskType;
	var SecMask_$_44 : MaskType;
	var SecMask_$_45 : MaskType;
	var SecMask_$_46 : MaskType;
	var SecMask_$_47 : MaskType;
	var SecMask_$_48 : MaskType;
	var SecMask_$_49 : MaskType;
	var SecMask_$_50 : MaskType;
	var SecMask_$_51 : MaskType;
	var SecMask_$_52 : MaskType;
	var SecMask_$_53 : MaskType;
	var SecMask_$_54 : MaskType;
	var SecMask_$_55 : MaskType;
	var SecMask_$_56 : MaskType;
	var SecMask_$_57 : MaskType;
	var SecMask_$_58 : MaskType;
	var SecMask_$_59 : MaskType;
	var SecMask_$_60 : MaskType;
	var SecMask_$_61 : MaskType;
	var SecMask_$_62 : MaskType;
	var SecMask_$_63 : MaskType;
	var SecMask_$_64 : MaskType;
	var SecMask_$_65 : MaskType;
	var SecMask_$_66 : MaskType;
	var SecMask_$_67 : MaskType;
	var SecMask_$_68 : MaskType;
	var SecMask_$_69 : MaskType;
	var SecMask_$_70 : MaskType;
	var SecMask_$_71 : MaskType;
	var SecMask_$_72 : MaskType;
	var oldVers#_2236_$_0 : int;
	var newVers#_2237_$_0 : int;
	var Heap_$_0 : HeapType;
	var Heap_$_1 : HeapType;
	var Mask_$_19 : MaskType;
	var Mask_$_20 : MaskType;
	var Mask_$_21 : MaskType;
	var Mask_$_22 : MaskType;
	var Mask_$_23 : MaskType;
	var Mask_$_24 : MaskType;
	var Mask_$_25 : MaskType;
	var Mask_$_26 : MaskType;
	var Mask_$_27 : MaskType;
	var Mask_$_28 : MaskType;
	var Mask_$_29 : MaskType;
	var Mask_$_30 : MaskType;
	var Mask_$_31 : MaskType;
	var Mask_$_32 : MaskType;
	var Mask_$_33 : MaskType;
	var Mask_$_34 : MaskType;
	var Mask_$_35 : MaskType;
	var Mask_$_36 : MaskType;
	var Mask_$_37 : MaskType;
	var Mask_$_38 : MaskType;
	var Mask_$_39 : MaskType;
	var Mask_$_40 : MaskType;
	var r#66_$_0 : ref;
	var exhaleHeap#_2242_$_0 : HeapType;
	var Mask_$_41 : MaskType;
	var SecMask_$_73 : MaskType;
	var SecMask_$_74 : MaskType;
	var SecMask_$_75 : MaskType;
	var SecMask_$_76 : MaskType;
	var SecMask_$_77 : MaskType;
	var SecMask_$_78 : MaskType;
	var SecMask_$_79 : MaskType;
	var SecMask_$_80 : MaskType;
	var SecMask_$_81 : MaskType;
	var SecMask_$_82 : MaskType;
	var SecMask_$_83 : MaskType;
	var SecMask_$_84 : MaskType;
	var SecMask_$_85 : MaskType;
	var SecMask_$_86 : MaskType;
	var SecMask_$_87 : MaskType;
	var SecMask_$_88 : MaskType;
	var SecMask_$_89 : MaskType;
	var SecMask_$_90 : MaskType;
	var SecMask_$_91 : MaskType;
	var SecMask_$_92 : MaskType;
	var SecMask_$_93 : MaskType;
	var SecMask_$_94 : MaskType;
	var SecMask_$_95 : MaskType;
	var SecMask_$_96 : MaskType;
	var SecMask_$_97 : MaskType;
	var SecMask_$_98 : MaskType;
	var SecMask_$_99 : MaskType;
	var SecMask_$_100 : MaskType;
	var SecMask_$_101 : MaskType;
	var SecMask_$_102 : MaskType;
	var SecMask_$_103 : MaskType;
	var SecMask_$_104 : MaskType;
	var SecMask_$_105 : MaskType;
	var SecMask_$_106 : MaskType;
	var SecMask_$_107 : MaskType;
	var SecMask_$_108 : MaskType;
	var SecMask_$_109 : MaskType;
	var SecMask_$_110 : MaskType;
	var SecMask_$_111 : MaskType;
	var SecMask_$_112 : MaskType;
	var SecMask_$_113 : MaskType;
	var SecMask_$_114 : MaskType;
	var SecMask_$_115 : MaskType;
	var SecMask_$_116 : MaskType;
	var SecMask_$_117 : MaskType;
	var SecMask_$_118 : MaskType;
	var SecMask_$_119 : MaskType;
	var SecMask_$_120 : MaskType;
	var SecMask_$_121 : MaskType;
	var SecMask_$_122 : MaskType;
	var SecMask_$_123 : MaskType;
	var oldVers#_2264_$_0 : int;
	var newVers#_2265_$_0 : int;
	var Heap_$_2 : HeapType;
	var Heap_$_3 : HeapType;
	var Mask_$_42 : MaskType;
	var Mask_$_43 : MaskType;
	var Mask_$_44 : MaskType;
	var Mask_$_45 : MaskType;
	var Mask_$_46 : MaskType;
	var Mask_$_47 : MaskType;
	var Mask_$_48 : MaskType;
	var Mask_$_49 : MaskType;
	var Mask_$_50 : MaskType;
	var Mask_$_51 : MaskType;
	var Mask_$_52 : MaskType;
	var Mask_$_53 : MaskType;
	var Mask_$_54 : MaskType;
	var Mask_$_55 : MaskType;
	var Mask_$_56 : MaskType;
	var Mask_$_57 : MaskType;
	var Mask_$_58 : MaskType;
	var Mask_$_59 : MaskType;
	var Mask_$_60 : MaskType;
	var Mask_$_61 : MaskType;
	var Mask_$_62 : MaskType;
	var Mask_$_63 : MaskType;
	var exhaleHeap#_2270_$_0 : HeapType;
	var Heap_$_4 : HeapType;
	var this#664_$_0 : ref;
	var exhaleHeap#_2277_$_0 : HeapType;
	var exhaleMask#_2278_$_0 : MaskType;
	var exhaleMask#_2278_$_1 : MaskType;
	var exhaleMask#_2278_$_2 : MaskType;
	var exhaleMask#_2278_$_3 : MaskType;
	var exhaleMask#_2278_$_4 : MaskType;
	var exhaleMask#_2278_$_5 : MaskType;
	var exhaleMask#_2278_$_6 : MaskType;
	var SecMask_$_124 : MaskType;
	var SecMask_$_125 : MaskType;
	var SecMask_$_126 : MaskType;
	var SecMask_$_127 : MaskType;
	var SecMask_$_128 : MaskType;
	var SecMask_$_129 : MaskType;
	var SecMask_$_130 : MaskType;
	var SecMask_$_131 : MaskType;
	var SecMask_$_132 : MaskType;
	var SecMask_$_133 : MaskType;
	var SecMask_$_134 : MaskType;
	var SecMask_$_135 : MaskType;
	var SecMask_$_136 : MaskType;
	var SecMask_$_137 : MaskType;
	var SecMask_$_138 : MaskType;
	var SecMask_$_139 : MaskType;
	var SecMask_$_140 : MaskType;
	var SecMask_$_141 : MaskType;
	var SecMask_$_142 : MaskType;
	var SecMask_$_143 : MaskType;
	var SecMask_$_144 : MaskType;
	var SecMask_$_145 : MaskType;
	var SecMask_$_146 : MaskType;
	var SecMask_$_147 : MaskType;
	var SecMask_$_148 : MaskType;
	var SecMask_$_149 : MaskType;
	var SecMask_$_150 : MaskType;
	var SecMask_$_151 : MaskType;
	var SecMask_$_152 : MaskType;
	var SecMask_$_153 : MaskType;
	var SecMask_$_154 : MaskType;
	var SecMask_$_155 : MaskType;
	var SecMask_$_156 : MaskType;
	var SecMask_$_157 : MaskType;
	var SecMask_$_158 : MaskType;
	var SecMask_$_159 : MaskType;
	var SecMask_$_160 : MaskType;
	var SecMask_$_161 : MaskType;
	var SecMask_$_162 : MaskType;
	var SecMask_$_163 : MaskType;
	var SecMask_$_164 : MaskType;
	var SecMask_$_165 : MaskType;
	var SecMask_$_166 : MaskType;
	var SecMask_$_167 : MaskType;
	var SecMask_$_168 : MaskType;
	var SecMask_$_169 : MaskType;
	var SecMask_$_170 : MaskType;
	var SecMask_$_171 : MaskType;
	var SecMask_$_172 : MaskType;
	var SecMask_$_173 : MaskType;
	var SecMask_$_174 : MaskType;
	var SecMask_$_175 : MaskType;
	var exhaleMask#_2278_$_7 : MaskType;
	var exhaleMask#_2278_$_8 : MaskType;
	var exhaleMask#_2278_$_9 : MaskType;
	var exhaleMask#_2278_$_10 : MaskType;
	var exhaleMask#_2278_$_11 : MaskType;
	var exhaleMask#_2278_$_12 : MaskType;
	var exhaleMask#_2278_$_13 : MaskType;
	var exhaleMask#_2278_$_14 : MaskType;
	var SecMask_$_176 : MaskType;
	var SecMask_$_177 : MaskType;
	var SecMask_$_178 : MaskType;
	var SecMask_$_179 : MaskType;
	var SecMask_$_180 : MaskType;
	var SecMask_$_181 : MaskType;
	var SecMask_$_182 : MaskType;
	var SecMask_$_183 : MaskType;
	var SecMask_$_184 : MaskType;
	var SecMask_$_185 : MaskType;
	var SecMask_$_186 : MaskType;
	var SecMask_$_187 : MaskType;
	var SecMask_$_188 : MaskType;
	var SecMask_$_189 : MaskType;
	var SecMask_$_190 : MaskType;
	var SecMask_$_191 : MaskType;
	var SecMask_$_192 : MaskType;
	var SecMask_$_193 : MaskType;
	var SecMask_$_194 : MaskType;
	var SecMask_$_195 : MaskType;
	var SecMask_$_196 : MaskType;
	var SecMask_$_197 : MaskType;
	var SecMask_$_198 : MaskType;
	var SecMask_$_199 : MaskType;
	var SecMask_$_200 : MaskType;
	var SecMask_$_201 : MaskType;
	var SecMask_$_202 : MaskType;
	var SecMask_$_203 : MaskType;
	var SecMask_$_204 : MaskType;
	var SecMask_$_205 : MaskType;
	var SecMask_$_206 : MaskType;
	var SecMask_$_207 : MaskType;
	var SecMask_$_208 : MaskType;
	var SecMask_$_209 : MaskType;
	var SecMask_$_210 : MaskType;
	var SecMask_$_211 : MaskType;
	var SecMask_$_212 : MaskType;
	var SecMask_$_213 : MaskType;
	var SecMask_$_214 : MaskType;
	var SecMask_$_215 : MaskType;
	var SecMask_$_216 : MaskType;
	var SecMask_$_217 : MaskType;
	var SecMask_$_218 : MaskType;
	var SecMask_$_219 : MaskType;
	var SecMask_$_220 : MaskType;
	var SecMask_$_221 : MaskType;
	var SecMask_$_222 : MaskType;
	var SecMask_$_223 : MaskType;
	var SecMask_$_224 : MaskType;
	var SecMask_$_225 : MaskType;
	var SecMask_$_226 : MaskType;
	var exhaleMask#_2278_$_15 : MaskType;
	var SecMask_$_227 : MaskType;
	var exhaleMask#_2278_$_16 : MaskType;
	var exhaleMask#_2278_$_17 : MaskType;
	var exhaleMask#_2278_$_18 : MaskType;
	var exhaleMask#_2278_$_19 : MaskType;
	var exhaleMask#_2278_$_20 : MaskType;
	var exhaleMask#_2278_$_21 : MaskType;
	var Mask_$_64 : MaskType;
	var Mask_$_65 : MaskType;
	var Mask_$_66 : MaskType;
	var Mask_$_67 : MaskType;
	var Heap_$_5 : HeapType;
	var Heap_$_6 : HeapType;
	var exhaleHeap#_2331_$_0 : HeapType;
	var exhaleHeap#_2338_$_0 : HeapType;
	var exhaleMask#_2339_$_0 : MaskType;
	var exhaleMask#_2339_$_1 : MaskType;
	var exhaleMask#_2339_$_2 : MaskType;
	var exhaleMask#_2339_$_3 : MaskType;
	var exhaleMask#_2339_$_4 : MaskType;
	var exhaleMask#_2339_$_5 : MaskType;
	var exhaleMask#_2339_$_6 : MaskType;
	var SecMask_$_228 : MaskType;
	var SecMask_$_229 : MaskType;
	var SecMask_$_230 : MaskType;
	var SecMask_$_231 : MaskType;
	var SecMask_$_232 : MaskType;
	var SecMask_$_233 : MaskType;
	var SecMask_$_234 : MaskType;
	var SecMask_$_235 : MaskType;
	var SecMask_$_236 : MaskType;
	var SecMask_$_237 : MaskType;
	var SecMask_$_238 : MaskType;
	var SecMask_$_239 : MaskType;
	var SecMask_$_240 : MaskType;
	var SecMask_$_241 : MaskType;
	var SecMask_$_242 : MaskType;
	var SecMask_$_243 : MaskType;
	var SecMask_$_244 : MaskType;
	var SecMask_$_245 : MaskType;
	var SecMask_$_246 : MaskType;
	var SecMask_$_247 : MaskType;
	var SecMask_$_248 : MaskType;
	var SecMask_$_249 : MaskType;
	var SecMask_$_250 : MaskType;
	var SecMask_$_251 : MaskType;
	var SecMask_$_252 : MaskType;
	var SecMask_$_253 : MaskType;
	var SecMask_$_254 : MaskType;
	var SecMask_$_255 : MaskType;
	var SecMask_$_256 : MaskType;
	var SecMask_$_257 : MaskType;
	var SecMask_$_258 : MaskType;
	var SecMask_$_259 : MaskType;
	var SecMask_$_260 : MaskType;
	var SecMask_$_261 : MaskType;
	var SecMask_$_262 : MaskType;
	var SecMask_$_263 : MaskType;
	var SecMask_$_264 : MaskType;
	var SecMask_$_265 : MaskType;
	var SecMask_$_266 : MaskType;
	var SecMask_$_267 : MaskType;
	var SecMask_$_268 : MaskType;
	var SecMask_$_269 : MaskType;
	var SecMask_$_270 : MaskType;
	var SecMask_$_271 : MaskType;
	var SecMask_$_272 : MaskType;
	var SecMask_$_273 : MaskType;
	var SecMask_$_274 : MaskType;
	var SecMask_$_275 : MaskType;
	var SecMask_$_276 : MaskType;
	var SecMask_$_277 : MaskType;
	var SecMask_$_278 : MaskType;
	var SecMask_$_279 : MaskType;
	var exhaleMask#_2339_$_7 : MaskType;
	var exhaleMask#_2339_$_8 : MaskType;
	var exhaleMask#_2339_$_9 : MaskType;
	var exhaleMask#_2339_$_10 : MaskType;
	var exhaleMask#_2339_$_11 : MaskType;
	var exhaleMask#_2339_$_12 : MaskType;
	var exhaleMask#_2339_$_13 : MaskType;
	var exhaleMask#_2339_$_14 : MaskType;
	var SecMask_$_280 : MaskType;
	var SecMask_$_281 : MaskType;
	var SecMask_$_282 : MaskType;
	var SecMask_$_283 : MaskType;
	var SecMask_$_284 : MaskType;
	var SecMask_$_285 : MaskType;
	var SecMask_$_286 : MaskType;
	var SecMask_$_287 : MaskType;
	var SecMask_$_288 : MaskType;
	var SecMask_$_289 : MaskType;
	var SecMask_$_290 : MaskType;
	var SecMask_$_291 : MaskType;
	var SecMask_$_292 : MaskType;
	var SecMask_$_293 : MaskType;
	var SecMask_$_294 : MaskType;
	var SecMask_$_295 : MaskType;
	var SecMask_$_296 : MaskType;
	var SecMask_$_297 : MaskType;
	var SecMask_$_298 : MaskType;
	var SecMask_$_299 : MaskType;
	var SecMask_$_300 : MaskType;
	var SecMask_$_301 : MaskType;
	var SecMask_$_302 : MaskType;
	var SecMask_$_303 : MaskType;
	var SecMask_$_304 : MaskType;
	var SecMask_$_305 : MaskType;
	var SecMask_$_306 : MaskType;
	var SecMask_$_307 : MaskType;
	var SecMask_$_308 : MaskType;
	var SecMask_$_309 : MaskType;
	var SecMask_$_310 : MaskType;
	var SecMask_$_311 : MaskType;
	var SecMask_$_312 : MaskType;
	var SecMask_$_313 : MaskType;
	var SecMask_$_314 : MaskType;
	var SecMask_$_315 : MaskType;
	var SecMask_$_316 : MaskType;
	var SecMask_$_317 : MaskType;
	var SecMask_$_318 : MaskType;
	var SecMask_$_319 : MaskType;
	var SecMask_$_320 : MaskType;
	var SecMask_$_321 : MaskType;
	var SecMask_$_322 : MaskType;
	var SecMask_$_323 : MaskType;
	var SecMask_$_324 : MaskType;
	var SecMask_$_325 : MaskType;
	var SecMask_$_326 : MaskType;
	var SecMask_$_327 : MaskType;
	var SecMask_$_328 : MaskType;
	var SecMask_$_329 : MaskType;
	var SecMask_$_330 : MaskType;
	var exhaleMask#_2339_$_15 : MaskType;
	var SecMask_$_331 : MaskType;
	var exhaleMask#_2339_$_16 : MaskType;
	var exhaleMask#_2339_$_17 : MaskType;
	var exhaleMask#_2339_$_18 : MaskType;
	var exhaleMask#_2339_$_19 : MaskType;
	var exhaleMask#_2339_$_20 : MaskType;
	var exhaleMask#_2339_$_21 : MaskType;
	var Mask_$_68 : MaskType;
	var Mask_$_69 : MaskType;
	var Mask_$_70 : MaskType;
	var Mask_$_71 : MaskType;
	var Heap_$_7 : HeapType;
	var exhaleHeap#_2393_$_0 : HeapType;
	var exhaleMask#_2394_$_0 : MaskType;
	var exhaleMask#_2394_$_1 : MaskType;
	var exhaleMask#_2394_$_2 : MaskType;
	var exhaleMask#_2394_$_3 : MaskType;
	var exhaleMask#_2394_$_4 : MaskType;
	var exhaleMask#_2394_$_5 : MaskType;
	var exhaleMask#_2394_$_6 : MaskType;
	var SecMask_$_332 : MaskType;
	var SecMask_$_333 : MaskType;
	var SecMask_$_334 : MaskType;
	var SecMask_$_335 : MaskType;
	var SecMask_$_336 : MaskType;
	var SecMask_$_337 : MaskType;
	var SecMask_$_338 : MaskType;
	var SecMask_$_339 : MaskType;
	var SecMask_$_340 : MaskType;
	var SecMask_$_341 : MaskType;
	var SecMask_$_342 : MaskType;
	var SecMask_$_343 : MaskType;
	var SecMask_$_344 : MaskType;
	var SecMask_$_345 : MaskType;
	var SecMask_$_346 : MaskType;
	var SecMask_$_347 : MaskType;
	var SecMask_$_348 : MaskType;
	var SecMask_$_349 : MaskType;
	var SecMask_$_350 : MaskType;
	var SecMask_$_351 : MaskType;
	var SecMask_$_352 : MaskType;
	var SecMask_$_353 : MaskType;
	var SecMask_$_354 : MaskType;
	var SecMask_$_355 : MaskType;
	var SecMask_$_356 : MaskType;
	var SecMask_$_357 : MaskType;
	var SecMask_$_358 : MaskType;
	var SecMask_$_359 : MaskType;
	var SecMask_$_360 : MaskType;
	var SecMask_$_361 : MaskType;
	var SecMask_$_362 : MaskType;
	var SecMask_$_363 : MaskType;
	var SecMask_$_364 : MaskType;
	var SecMask_$_365 : MaskType;
	var SecMask_$_366 : MaskType;
	var SecMask_$_367 : MaskType;
	var SecMask_$_368 : MaskType;
	var SecMask_$_369 : MaskType;
	var SecMask_$_370 : MaskType;
	var SecMask_$_371 : MaskType;
	var SecMask_$_372 : MaskType;
	var SecMask_$_373 : MaskType;
	var SecMask_$_374 : MaskType;
	var SecMask_$_375 : MaskType;
	var SecMask_$_376 : MaskType;
	var SecMask_$_377 : MaskType;
	var SecMask_$_378 : MaskType;
	var SecMask_$_379 : MaskType;
	var SecMask_$_380 : MaskType;
	var SecMask_$_381 : MaskType;
	var SecMask_$_382 : MaskType;
	var SecMask_$_383 : MaskType;
	var exhaleMask#_2394_$_7 : MaskType;
	var exhaleMask#_2394_$_8 : MaskType;
	var exhaleMask#_2394_$_9 : MaskType;
	var exhaleMask#_2394_$_10 : MaskType;
	var exhaleMask#_2394_$_11 : MaskType;
	var exhaleMask#_2394_$_12 : MaskType;
	var exhaleMask#_2394_$_13 : MaskType;
	var exhaleMask#_2394_$_14 : MaskType;
	var SecMask_$_384 : MaskType;
	var SecMask_$_385 : MaskType;
	var SecMask_$_386 : MaskType;
	var SecMask_$_387 : MaskType;
	var SecMask_$_388 : MaskType;
	var SecMask_$_389 : MaskType;
	var SecMask_$_390 : MaskType;
	var SecMask_$_391 : MaskType;
	var SecMask_$_392 : MaskType;
	var SecMask_$_393 : MaskType;
	var SecMask_$_394 : MaskType;
	var SecMask_$_395 : MaskType;
	var SecMask_$_396 : MaskType;
	var SecMask_$_397 : MaskType;
	var SecMask_$_398 : MaskType;
	var SecMask_$_399 : MaskType;
	var SecMask_$_400 : MaskType;
	var SecMask_$_401 : MaskType;
	var SecMask_$_402 : MaskType;
	var SecMask_$_403 : MaskType;
	var SecMask_$_404 : MaskType;
	var SecMask_$_405 : MaskType;
	var SecMask_$_406 : MaskType;
	var SecMask_$_407 : MaskType;
	var SecMask_$_408 : MaskType;
	var SecMask_$_409 : MaskType;
	var SecMask_$_410 : MaskType;
	var SecMask_$_411 : MaskType;
	var SecMask_$_412 : MaskType;
	var SecMask_$_413 : MaskType;
	var SecMask_$_414 : MaskType;
	var SecMask_$_415 : MaskType;
	var SecMask_$_416 : MaskType;
	var SecMask_$_417 : MaskType;
	var SecMask_$_418 : MaskType;
	var SecMask_$_419 : MaskType;
	var SecMask_$_420 : MaskType;
	var SecMask_$_421 : MaskType;
	var SecMask_$_422 : MaskType;
	var SecMask_$_423 : MaskType;
	var SecMask_$_424 : MaskType;
	var SecMask_$_425 : MaskType;
	var SecMask_$_426 : MaskType;
	var SecMask_$_427 : MaskType;
	var SecMask_$_428 : MaskType;
	var SecMask_$_429 : MaskType;
	var SecMask_$_430 : MaskType;
	var SecMask_$_431 : MaskType;
	var SecMask_$_432 : MaskType;
	var SecMask_$_433 : MaskType;
	var SecMask_$_434 : MaskType;
	var exhaleMask#_2394_$_15 : MaskType;
	var SecMask_$_435 : MaskType;
	var exhaleMask#_2394_$_16 : MaskType;
	var exhaleMask#_2394_$_17 : MaskType;
	var exhaleMask#_2394_$_18 : MaskType;
	var exhaleMask#_2394_$_19 : MaskType;
	var exhaleMask#_2394_$_20 : MaskType;
	var exhaleMask#_2394_$_21 : MaskType;
	var Mask_$_72 : MaskType;
	var Mask_$_73 : MaskType;
	var Mask_$_74 : MaskType;
	var Mask_$_75 : MaskType;
	var exhaleHeap#_2443_$_0 : HeapType;
	var exhaleMask#_2444_$_0 : MaskType;
	var SecMask_$_436 : MaskType;
	var SecMask_$_437 : MaskType;
	var SecMask_$_438 : MaskType;
	var SecMask_$_439 : MaskType;
	var SecMask_$_440 : MaskType;
	var SecMask_$_441 : MaskType;
	var SecMask_$_442 : MaskType;
	var SecMask_$_443 : MaskType;
	var SecMask_$_444 : MaskType;
	var SecMask_$_445 : MaskType;
	var SecMask_$_446 : MaskType;
	var SecMask_$_447 : MaskType;
	var SecMask_$_448 : MaskType;
	var SecMask_$_449 : MaskType;
	var SecMask_$_450 : MaskType;
	var SecMask_$_451 : MaskType;
	var SecMask_$_452 : MaskType;
	var SecMask_$_453 : MaskType;
	var SecMask_$_454 : MaskType;
	var SecMask_$_455 : MaskType;
	var SecMask_$_456 : MaskType;
	var SecMask_$_457 : MaskType;
	var SecMask_$_458 : MaskType;
	var SecMask_$_459 : MaskType;
	var SecMask_$_460 : MaskType;
	var SecMask_$_461 : MaskType;
	var SecMask_$_462 : MaskType;
	var SecMask_$_463 : MaskType;
	var SecMask_$_464 : MaskType;
	var SecMask_$_465 : MaskType;
	var SecMask_$_466 : MaskType;
	var SecMask_$_467 : MaskType;
	var SecMask_$_468 : MaskType;
	var SecMask_$_469 : MaskType;
	var SecMask_$_470 : MaskType;
	var SecMask_$_471 : MaskType;
	var SecMask_$_472 : MaskType;
	var SecMask_$_473 : MaskType;
	var SecMask_$_474 : MaskType;
	var SecMask_$_475 : MaskType;
	var SecMask_$_476 : MaskType;
	var SecMask_$_477 : MaskType;
	var SecMask_$_478 : MaskType;
	var SecMask_$_479 : MaskType;
	var SecMask_$_480 : MaskType;
	var SecMask_$_481 : MaskType;
	var SecMask_$_482 : MaskType;
	var SecMask_$_483 : MaskType;
	var SecMask_$_484 : MaskType;
	var SecMask_$_485 : MaskType;
	var SecMask_$_486 : MaskType;
	var exhaleMask#_2444_$_1 : MaskType;
	var exhaleMask#_2444_$_2 : MaskType;
	var exhaleMask#_2444_$_3 : MaskType;
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
	var $_$_condition_$52 : bool;
	var $_$_condition_$53 : bool;
	var $_$_condition_$54 : bool;
	var $_$_condition_$55 : bool;
	var $_$_condition_$56 : bool;
	var $_$_condition_$57 : bool;
	var $_$_condition_$58 : bool;
	var $_$_condition_$59 : bool;
	var $_$_condition_$60 : bool;
	var $_$_condition_$61 : bool;
	var $_$_condition_$62 : bool;
	var $_$_condition_$63 : bool;
	var $_$_condition_$64 : bool;
	var $_$_condition_$65 : bool;
	var $_$_condition_$66 : bool;
	var $_$_condition_$67 : bool;
	var $_$_condition_$68 : bool;
	var $_$_condition_$69 : bool;
	var $_$_condition_$70 : bool;
	var $_$_condition_$71 : bool;
	var $_$_condition_$72 : bool;
	var $_$_condition_$73 : bool;
	var $_$_condition_$74 : bool;
	var $_$_condition_$75 : bool;
	var $_$_condition_$76 : bool;
	var $_$_condition_$77 : bool;
	var $_$_condition_$78 : bool;
	var $_$_condition_$79 : bool;
	var $_$_condition_$80 : bool;
	var $_$_condition_$81 : bool;
	var $_$_condition_$82 : bool;
	var $_$_condition_$83 : bool;
	var $_$_condition_$84 : bool;
	var $_$_condition_$85 : bool;
	var $_$_condition_$86 : bool;
	var $_$_condition_$87 : bool;
	var $_$_condition_$88 : bool;
	var $_$_condition_$89 : bool;
	var $_$_condition_$90 : bool;
	var $_$_condition_$91 : bool;
	var $_$_condition_$92 : bool;
	var $_$_condition_$93 : bool;
	var $_$_condition_$94 : bool;
	var $_$_condition_$95 : bool;
	var $_$_condition_$96 : bool;
	var $_$_condition_$97 : bool;
	var $_$_condition_$98 : bool;
	var $_$_condition_$99 : bool;
	var $_$_condition_$100 : bool;
	var $_$_condition_$101 : bool;
	var $_$_condition_$102 : bool;
	var $_$_condition_$103 : bool;
	var $_$_condition_$104 : bool;
	var $_$_condition_$105 : bool;
	var $_$_condition_$106 : bool;
	var $_$_condition_$107 : bool;
	var $_$_condition_$108 : bool;
	var $_$_condition_$109 : bool;
	var $_$_condition_$110 : bool;
	var $_$_condition_$111 : bool;
	var $_$_condition_$112 : bool;
	var $_$_condition_$113 : bool;
	var $_$_condition_$114 : bool;
	var $_$_condition_$115 : bool;
	var $_$_condition_$116 : bool;
	var $_$_condition_$117 : bool;
	var $_$_condition_$118 : bool;
	var $_$_condition_$119 : bool;
	var $_$_condition_$120 : bool;
	var $_$_condition_$121 : bool;
	var $_$_condition_$122 : bool;
	var $_$_condition_$123 : bool;
	var $_$_condition_$124 : bool;
	var $_$_condition_$125 : bool;
	var $_$_condition_$126 : bool;
	var $_$_condition_$127 : bool;
	var $_$_condition_$128 : bool;
	var $_$_condition_$129 : bool;
	var $_$_condition_$130 : bool;
	var $_$_condition_$131 : bool;
	var $_$_condition_$132 : bool;
	var $_$_condition_$133 : bool;
	var $_$_condition_$134 : bool;
	var $_$_condition_$135 : bool;
	var $_$_condition_$136 : bool;
	var $_$_condition_$137 : bool;
	var $_$_condition_$138 : bool;
	var $_$_condition_$139 : bool;
	var $_$_condition_$140 : bool;
	var $_$_condition_$141 : bool;
	var $_$_condition_$142 : bool;
	var $_$_condition_$143 : bool;
	var $_$_condition_$144 : bool;
	var $_$_condition_$145 : bool;
	var $_$_condition_$146 : bool;
	var $_$_condition_$147 : bool;
	var $_$_condition_$148 : bool;
	var $_$_condition_$149 : bool;
	var $_$_condition_$150 : bool;
	var $_$_condition_$151 : bool;
	var $_$_condition_$152 : bool;
	var $_$_condition_$153 : bool;
	var $_$_condition_$154 : bool;
	var $_$_condition_$155 : bool;
	var $_$_condition_$156 : bool;
	var $_$_condition_$157 : bool;
	var $_$_condition_$158 : bool;
	var $_$_condition_$159 : bool;
	var $_$_condition_$160 : bool;
	var $_$_condition_$161 : bool;
	var $_$_condition_$162 : bool;
	var $_$_condition_$163 : bool;
	var $_$_condition_$164 : bool;
	var $_$_condition_$165 : bool;
	var $_$_condition_$166 : bool;
	var $_$_condition_$167 : bool;
	var $_$_condition_$168 : bool;
	var $_$_condition_$169 : bool;
	var $_$_condition_$170 : bool;
	var $_$_condition_$171 : bool;
	var $_$_condition_$172 : bool;
	var $_$_condition_$173 : bool;
	var $_$_condition_$174 : bool;
	var $_$_condition_$175 : bool;
	var $_$_condition_$176 : bool;
	var $_$_condition_$177 : bool;
	var $_$_condition_$178 : bool;
	var $_$_condition_$179 : bool;
	var $_$_condition_$180 : bool;
	var $_$_condition_$181 : bool;
	var $_$_condition_$182 : bool;
	var $_$_condition_$183 : bool;
	var $_$_condition_$184 : bool;
	var $_$_condition_$185 : bool;
	var $_$_condition_$186 : bool;
	var $_$_condition_$187 : bool;
	var $_$_condition_$188 : bool;
	var $_$_condition_$189 : bool;
	var $_$_condition_$190 : bool;
	var $_$_condition_$191 : bool;
	var $_$_condition_$192 : bool;
	var $_$_condition_$193 : bool;
	var $_$_condition_$194 : bool;
	var $_$_condition_$195 : bool;
	var $_$_condition_$196 : bool;
	var $_$_condition_$197 : bool;
	var $_$_condition_$198 : bool;
	var $_$_condition_$199 : bool;
	var $_$_condition_$200 : bool;
	var $_$_condition_$201 : bool;
	var $_$_condition_$202 : bool;
	var $_$_condition_$203 : bool;
	var $_$_condition_$204 : bool;
	var $_$_condition_$205 : bool;
	var $_$_condition_$206 : bool;
	var $_$_condition_$207 : bool;
	var $_$_condition_$208 : bool;
	var $_$_condition_$209 : bool;
	var $_$_condition_$210 : bool;
	var $_$_condition_$211 : bool;
	var $_$_condition_$212 : bool;
	var $_$_condition_$213 : bool;
	var $_$_condition_$214 : bool;
	var $_$_condition_$215 : bool;
	var $_$_condition_$216 : bool;
	var $_$_condition_$217 : bool;
	var $_$_condition_$218 : bool;
	var $_$_condition_$219 : bool;
	var $_$_condition_$220 : bool;
	var $_$_condition_$221 : bool;
	var $_$_condition_$222 : bool;
	var $_$_condition_$223 : bool;
	var $_$_condition_$224 : bool;
	var $_$_condition_$225 : bool;
	var $_$_condition_$226 : bool;
	var $_$_condition_$227 : bool;
	var $_$_condition_$228 : bool;
	var $_$_condition_$229 : bool;
	var $_$_condition_$230 : bool;
	var $_$_condition_$231 : bool;
	var $_$_condition_$232 : bool;
	var $_$_condition_$233 : bool;
	var $_$_condition_$234 : bool;
	var $_$_condition_$235 : bool;
	var $_$_condition_$236 : bool;
	var $_$_condition_$237 : bool;
	var $_$_condition_$238 : bool;
	var $_$_condition_$239 : bool;
	var $_$_condition_$240 : bool;
	var $_$_condition_$241 : bool;
	var $_$_condition_$242 : bool;
	var $_$_condition_$243 : bool;
	var $_$_condition_$244 : bool;
	var $_$_condition_$245 : bool;
	var $_$_condition_$246 : bool;
	var $_$_condition_$247 : bool;
	var $_$_condition_$248 : bool;
	var $_$_condition_$249 : bool;
	var $_$_condition_$250 : bool;
	var $_$_condition_$251 : bool;
	var $_$_condition_$252 : bool;
	var $_$_condition_$253 : bool;
	var $_$_condition_$254 : bool;
	var $_$_condition_$255 : bool;
	var $_$_condition_$256 : bool;
	var $_$_condition_$257 : bool;
	var $_$_condition_$258 : bool;
	var $_$_condition_$259 : bool;
	var $_$_condition_$260 : bool;
	var $_$_condition_$261 : bool;
	var $_$_condition_$262 : bool;
	var $_$_condition_$263 : bool;
	var $_$_condition_$264 : bool;
	var $_$_condition_$265 : bool;
	var $_$_condition_$266 : bool;
	var $_$_condition_$267 : bool;
	var $_$_condition_$268 : bool;
	var $_$_condition_$269 : bool;
	var $_$_condition_$270 : bool;
	var $_$_condition_$271 : bool;
	var $_$_condition_$272 : bool;
	var $_$_condition_$273 : bool;
	var $_$_condition_$274 : bool;
	var $_$_condition_$275 : bool;
	var $_$_condition_$276 : bool;
	var $_$_condition_$277 : bool;
	var $_$_condition_$278 : bool;
	var $_$_condition_$279 : bool;
	var $_$_condition_$280 : bool;
	var $_$_condition_$281 : bool;
	var $_$_condition_$282 : bool;
	var $_$_condition_$283 : bool;
	var $_$_condition_$284 : bool;
	var $_$_condition_$285 : bool;
	var $_$_condition_$286 : bool;
	var $_$_condition_$287 : bool;
	var $_$_condition_$288 : bool;
	var $_$_condition_$289 : bool;
	var $_$_condition_$290 : bool;
	var $_$_condition_$291 : bool;
	var $_$_condition_$292 : bool;
	var $_$_condition_$293 : bool;
	var $_$_condition_$294 : bool;
	var $_$_condition_$295 : bool;
	var $_$_condition_$296 : bool;
	var $_$_condition_$297 : bool;
	var $_$_condition_$298 : bool;
	var $_$_condition_$299 : bool;
	var $_$_condition_$300 : bool;
	var $_$_condition_$301 : bool;
	var $_$_condition_$302 : bool;
	var $_$_condition_$303 : bool;
	var $_$_condition_$304 : bool;
	var $_$_condition_$305 : bool;
	var $_$_condition_$306 : bool;
	var $_$_condition_$307 : bool;
	var $_$_condition_$308 : bool;
	var $_$_condition_$309 : bool;
	var $_$_condition_$310 : bool;
	var $_$_condition_$311 : bool;
	var $_$_condition_$312 : bool;
	var $_$_condition_$313 : bool;
	var $_$_condition_$314 : bool;
	var $_$_condition_$315 : bool;
	var $_$_condition_$316 : bool;
	var $_$_condition_$317 : bool;
	var $_$_condition_$318 : bool;
	var $_$_condition_$319 : bool;
	var $_$_condition_$320 : bool;
	var $_$_condition_$321 : bool;
	var $_$_condition_$322 : bool;
	var $_$_condition_$323 : bool;
	var $_$_condition_$324 : bool;
	var $_$_condition_$325 : bool;
	var $_$_condition_$326 : bool;
	var $_$_condition_$327 : bool;
	var $_$_condition_$328 : bool;
	var $_$_condition_$329 : bool;
	var $_$_condition_$330 : bool;
	var $_$_condition_$331 : bool;
	var $_$_condition_$332 : bool;
	var $_$_condition_$333 : bool;
	var $_$_condition_$334 : bool;
	var $_$_condition_$335 : bool;
	var $_$_condition_$336 : bool;
	var $_$_condition_$337 : bool;
	var $_$_condition_$338 : bool;
	var $_$_condition_$339 : bool;
	var $_$_condition_$340 : bool;
	var $_$_condition_$341 : bool;
	var $_$_condition_$342 : bool;
	var $_$_condition_$343 : bool;
	var $_$_condition_$344 : bool;
	var $_$_condition_$345 : bool;
	var $_$_condition_$346 : bool;
	var $_$_condition_$347 : bool;
	var $_$_condition_$348 : bool;
	var $_$_condition_$349 : bool;
	var $_$_condition_$350 : bool;
	var $_$_condition_$351 : bool;
	var $_$_condition_$352 : bool;
	var $_$_condition_$353 : bool;
	var $_$_condition_$354 : bool;
	var $_$_condition_$355 : bool;
	var $_$_condition_$356 : bool;
	var $_$_condition_$357 : bool;
	var $_$_condition_$358 : bool;
	var $_$_condition_$359 : bool;
	var $_$_condition_$360 : bool;
	var $_$_condition_$361 : bool;
	var $_$_condition_$362 : bool;
	var $_$_condition_$363 : bool;
	var $_$_condition_$364 : bool;
	var $_$_condition_$365 : bool;
	var $_$_condition_$366 : bool;
	var $_$_condition_$367 : bool;
	var $_$_condition_$368 : bool;
	var $_$_condition_$369 : bool;
	var $_$_condition_$370 : bool;
	var $_$_condition_$371 : bool;
	var $_$_condition_$372 : bool;
	var $_$_condition_$373 : bool;
	var $_$_condition_$374 : bool;
	var $_$_condition_$375 : bool;
	var $_$_condition_$376 : bool;
	var $_$_condition_$377 : bool;
	var $_$_condition_$378 : bool;
	var $_$_condition_$379 : bool;
	var $_$_condition_$380 : bool;
	var $_$_condition_$381 : bool;
	var $_$_condition_$382 : bool;
	var $_$_condition_$383 : bool;
	var $_$_condition_$384 : bool;
	var $_$_condition_$385 : bool;
	var $_$_condition_$386 : bool;
	var $_$_condition_$387 : bool;
	var $_$_condition_$388 : bool;
	var $_$_condition_$389 : bool;
	var $_$_condition_$390 : bool;
	var $_$_condition_$391 : bool;
	var $_$_condition_$392 : bool;
	var $_$_condition_$393 : bool;
	var $_$_condition_$394 : bool;
	var $_$_condition_$395 : bool;
	var $_$_condition_$396 : bool;
	var $_$_condition_$397 : bool;
	var $_$_condition_$398 : bool;
	var $_$_condition_$399 : bool;
	var $_$_condition_$400 : bool;
	var $_$_condition_$401 : bool;
	var $_$_condition_$402 : bool;
	var $_$_condition_$403 : bool;
	var $_$_condition_$404 : bool;
	var $_$_condition_$405 : bool;
	var $_$_condition_$406 : bool;
	var $_$_condition_$407 : bool;
	var $_$_condition_$408 : bool;
	var $_$_condition_$409 : bool;
	var $_$_condition_$410 : bool;
	var $_$_condition_$411 : bool;
	var $_$_condition_$412 : bool;
	var $_$_condition_$413 : bool;
	var $_$_condition_$414 : bool;
	var $_$_condition_$415 : bool;
	var $_$_condition_$416 : bool;
	var $_$_condition_$417 : bool;
	var $_$_condition_$418 : bool;
	var $_$_condition_$419 : bool;
	var $_$_condition_$420 : bool;
	var $_$_condition_$421 : bool;
	var $_$_condition_$422 : bool;
	var $_$_condition_$423 : bool;
	var $_$_condition_$424 : bool;
	var $_$_condition_$425 : bool;
	var $_$_condition_$426 : bool;
	var $_$_condition_$427 : bool;
	var $_$_condition_$428 : bool;
	var $_$_condition_$429 : bool;
	var $_$_condition_$430 : bool;
	var $_$_condition_$431 : bool;
	var $_$_condition_$432 : bool;
	var $_$_condition_$433 : bool;
	var $_$_condition_$434 : bool;
	var $_$_condition_$435 : bool;
	var $_$_condition_$436 : bool;
	var $_$_condition_$437 : bool;
	var $_$_condition_$438 : bool;
	var $_$_condition_$439 : bool;
	var $_$_condition_$440 : bool;
	var $_$_condition_$441 : bool;
	var $_$_condition_$442 : bool;
	var $_$_condition_$443 : bool;
	var $_$_condition_$444 : bool;
	var $_$_condition_$445 : bool;
	var $_$_condition_$446 : bool;
	var $_$_condition_$447 : bool;
	var $_$_condition_$448 : bool;
	var $_$_condition_$449 : bool;
	var $_$_condition_$450 : bool;
	var $_$_condition_$451 : bool;
	var $_$_condition_$452 : bool;
	var $_$_condition_$453 : bool;
	var $_$_condition_$454 : bool;
	var $_$_condition_$455 : bool;
	var $_$_condition_$456 : bool;
	var $_$_condition_$457 : bool;
	var $_$_condition_$458 : bool;
	var $_$_condition_$459 : bool;
	var $_$_condition_$460 : bool;
	var $_$_condition_$461 : bool;
	var $_$_condition_$462 : bool;
	var $_$_condition_$463 : bool;
	var $_$_condition_$464 : bool;
	var $_$_condition_$465 : bool;
	var $_$_condition_$466 : bool;
	var $_$_condition_$467 : bool;
	var $_$_condition_$468 : bool;
	var $_$_condition_$469 : bool;
	var $_$_condition_$470 : bool;
	var $_$_condition_$471 : bool;
	var $_$_condition_$472 : bool;
	var $_$_condition_$473 : bool;
	var $_$_condition_$474 : bool;
	var $_$_condition_$475 : bool;
	var $_$_condition_$476 : bool;
	var $_$_condition_$477 : bool;
	var $_$_condition_$478 : bool;
	var $_$_condition_$479 : bool;
	var $_$_condition_$480 : bool;
	var $_$_condition_$481 : bool;
	var $_$_condition_$482 : bool;
	var $_$_condition_$483 : bool;
	var $_$_condition_$484 : bool;
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
	assume (forall<T> m_$4 : MaskType, sm_$1 : MaskType, obj : ref, f_$3 : Field (T)  :: {CanRead(m_$4,sm_$1,obj,f_$3)} ( CanRead(m_$4,sm_$1,obj,f_$3) <==> ((((0 < m_$4[obj,f_$3][perm$R]) || (0 < m_$4[obj,f_$3][perm$N])) || (0 < sm_$1[obj,f_$3][perm$R])) || (0 < sm_$1[obj,f_$3][perm$N])) ));
	assume (forall<T> m_$5 : MaskType, obj_$0 : ref, f_$4 : Field (T)  :: {CanReadForSure(m_$5,obj_$0,f_$4)} ( CanReadForSure(m_$5,obj_$0,f_$4) <==> ((0 < m_$5[obj_$0,f_$4][perm$R]) || (0 < m_$5[obj_$0,f_$4][perm$N])) ));
	assume (forall<T> m_$6 : MaskType, obj_$1 : ref, f_$5 : Field (T)  :: {CanWrite(m_$6,obj_$1,f_$5)} ( CanWrite(m_$6,obj_$1,f_$5) <==> ((m_$6[obj_$1,f_$5][perm$R] == Permission$FullFraction) && (m_$6[obj_$1,f_$5][perm$N] == 0)) ));
	assume (forall  m_$7 : MaskType :: {IsGoodMask(m_$7)} ( IsGoodMask(m_$7) <==> ((forall<T> o_$14 : ref, f_$6 : Field (T)  :: ( ((0 <= m_$7[o_$14,f_$6][perm$R]) && (NonPredicateField(f_$6) ==> ((m_$7[o_$14,f_$6][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14,f_$6][perm$N]) ==> (m_$7[o_$14,f_$6][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14,f_$6][perm$N] < 0) ==> (0 < m_$7[o_$14,f_$6][perm$R])) ))) ));
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
	assume (forall<T> s : Seq (T)  :: {Seq#Length(s)} ( 0 <= Seq#Length(s) ));
	assume (forall<T> :: Seq#Length((Seq#Empty() : Seq (T) )) == 0);
	assume (forall<T> s_$0 : Seq (T)  :: {Seq#Length(s_$0)} ( (Seq#Length(s_$0) == 0) ==> (s_$0 == (Seq#Empty() : Seq (T) )) ));
	assume (forall<T> t : T :: {Seq#Length(Seq#Singleton(t))} ( Seq#Length(Seq#Singleton(t)) == 1 ));
	assume (forall<T> s_$1 : Seq (T) , i : Integer, v : T, len : Integer :: {Seq#Length(Seq#Build(s_$1,i,v,len))} ( (0 <= len) ==> (Seq#Length(Seq#Build(s_$1,i,v,len)) == len) ));
	assume (forall<T> s0 : Seq (T) , s1 : Seq (T)  :: {Seq#Length(Seq#Append(s0,s1))} ( Seq#Length(Seq#Append(s0,s1)) == (Seq#Length(s0) + Seq#Length(s1)) ));
	assume (forall<T> t_$0 : T :: {Seq#Index(Seq#Singleton(t_$0),0)} ( Seq#Index(Seq#Singleton(t_$0),0) == t_$0 ));
	assume (forall<T> s0_$0 : Seq (T) , s1_$0 : Seq (T) , n_$3 : Integer :: {Seq#Index(Seq#Append(s0_$0,s1_$0),n_$3)} ( ((n_$3 < Seq#Length(s0_$0)) ==> (Seq#Index(Seq#Append(s0_$0,s1_$0),n_$3) == Seq#Index(s0_$0,n_$3))) && ((Seq#Length(s0_$0) <= n_$3) ==> (Seq#Index(Seq#Append(s0_$0,s1_$0),n_$3) == Seq#Index(s1_$0,n_$3 - Seq#Length(s0_$0)))) ));
	assume (forall<T> s_$2 : Seq (T) , i_$0 : Integer, v_$0 : T, len_$0 : Integer, n_$4 : Integer :: {Seq#Index(Seq#Build(s_$2,i_$0,v_$0,len_$0),n_$4)} ( ((0 <= n_$4) && (n_$4 < len_$0)) ==> (((i_$0 == n_$4) ==> (Seq#Index(Seq#Build(s_$2,i_$0,v_$0,len_$0),n_$4) == v_$0)) && ((!(i_$0 == n_$4)) ==> (Seq#Index(Seq#Build(s_$2,i_$0,v_$0,len_$0),n_$4) == Seq#Index(s_$2,n_$4)))) ));
	assume (forall<T> s_$3 : Seq (T) , x_$0 : T :: {Seq#Contains(s_$3,x_$0)} ( Seq#Contains(s_$3,x_$0) <==> ((exists  i_$1 : Integer :: {Seq#Index(s_$3,i_$1)} ( ((0 <= i_$1) && (i_$1 < Seq#Length(s_$3))) && (Seq#Index(s_$3,i_$1) == x_$0) ))) ));
	assume (forall  x_$1 : ref :: {Seq#Contains((Seq#Empty() : Seq (ref) ),x_$1)} ( !Seq#Contains((Seq#Empty() : Seq (ref) ),x_$1) ));
	assume (forall<T> s0_$1 : Seq (T) , s1_$1 : Seq (T) , x_$2 : T :: {Seq#Contains(Seq#Append(s0_$1,s1_$1),x_$2)} ( Seq#Contains(Seq#Append(s0_$1,s1_$1),x_$2) <==> (Seq#Contains(s0_$1,x_$2) || Seq#Contains(s1_$1,x_$2)) ));
	assume (forall<T> s_$4 : Seq (T) , i_$2 : Integer, v_$1 : T, len_$1 : Integer, x_$3 : T :: {Seq#Contains(Seq#Build(s_$4,i_$2,v_$1,len_$1),x_$3)} ( Seq#Contains(Seq#Build(s_$4,i_$2,v_$1,len_$1),x_$3) <==> ((((0 <= i_$2) && (i_$2 < len_$1)) && (x_$3 == v_$1)) || ((exists  j : Integer :: {Seq#Index(s_$4,j)} ( ((((0 <= j) && (j < Seq#Length(s_$4))) && (j < len_$1)) && (!(j == i_$2))) && (Seq#Index(s_$4,j) == x_$3) )))) ));
	assume (forall<T> s_$5 : Seq (T) , n_$5 : Integer, x_$4 : T :: {Seq#Contains(Seq#Take(s_$5,n_$5),x_$4)} ( Seq#Contains(Seq#Take(s_$5,n_$5),x_$4) <==> ((exists  i_$3 : Integer :: {Seq#Index(s_$5,i_$3)} ( (((0 <= i_$3) && (i_$3 < n_$5)) && (i_$3 < Seq#Length(s_$5))) && (Seq#Index(s_$5,i_$3) == x_$4) ))) ));
	assume (forall<T> s_$6 : Seq (T) , n_$6 : Integer, x_$5 : T :: {Seq#Contains(Seq#Drop(s_$6,n_$6),x_$5)} ( Seq#Contains(Seq#Drop(s_$6,n_$6),x_$5) <==> ((exists  i_$4 : Integer :: {Seq#Index(s_$6,i_$4)} ( (((0 <= n_$6) && (n_$6 <= i_$4)) && (i_$4 < Seq#Length(s_$6))) && (Seq#Index(s_$6,i_$4) == x_$5) ))) ));
	assume (forall<T> s0_$2 : Seq (T) , s1_$2 : Seq (T)  :: {Seq#Equal(s0_$2,s1_$2)} ( Seq#Equal(s0_$2,s1_$2) <==> ((Seq#Length(s0_$2) == Seq#Length(s1_$2)) && ((forall  j_$0 : Integer :: {Seq#Index(s0_$2,j_$0)} {Seq#Index(s1_$2,j_$0)} ( ((0 <= j_$0) && (j_$0 < Seq#Length(s0_$2))) ==> (Seq#Index(s0_$2,j_$0) == Seq#Index(s1_$2,j_$0)) )))) ));
	assume (forall<T> a_$2 : Seq (T) , b_$2 : Seq (T)  :: {Seq#Equal(a_$2,b_$2)} ( Seq#Equal(a_$2,b_$2) ==> (a_$2 == b_$2) ));
	assume (forall<T> s0_$3 : Seq (T) , s1_$3 : Seq (T) , n_$7 : Integer :: {Seq#SameUntil(s0_$3,s1_$3,n_$7)} ( Seq#SameUntil(s0_$3,s1_$3,n_$7) <==> ((forall  j_$1 : Integer :: {Seq#Index(s0_$3,j_$1)} {Seq#Index(s1_$3,j_$1)} ( ((0 <= j_$1) && (j_$1 < n_$7)) ==> (Seq#Index(s0_$3,j_$1) == Seq#Index(s1_$3,j_$1)) ))) ));
	assume (forall<T> s_$7 : Seq (T) , n_$8 : Integer :: {Seq#Length(Seq#Take(s_$7,n_$8))} ( (0 <= n_$8) ==> (((n_$8 <= Seq#Length(s_$7)) ==> (Seq#Length(Seq#Take(s_$7,n_$8)) == n_$8)) && ((Seq#Length(s_$7) < n_$8) ==> (Seq#Length(Seq#Take(s_$7,n_$8)) == Seq#Length(s_$7)))) ));
	assume (forall<T> s_$8 : Seq (T) , n_$9 : Integer, j_$2 : Integer :: {Seq#Index(Seq#Take(s_$8,n_$9),j_$2)} {:weight  25}( (((0 <= j_$2) && (j_$2 < n_$9)) && (j_$2 < Seq#Length(s_$8))) ==> (Seq#Index(Seq#Take(s_$8,n_$9),j_$2) == Seq#Index(s_$8,j_$2)) ));
	assume (forall<T> s_$9 : Seq (T) , n_$10 : Integer :: {Seq#Length(Seq#Drop(s_$9,n_$10))} ( (0 <= n_$10) ==> (((n_$10 <= Seq#Length(s_$9)) ==> (Seq#Length(Seq#Drop(s_$9,n_$10)) == (Seq#Length(s_$9) - n_$10))) && ((Seq#Length(s_$9) < n_$10) ==> (Seq#Length(Seq#Drop(s_$9,n_$10)) == 0))) ));
	assume (forall<T> s_$10 : Seq (T) , n_$11 : Integer, j_$3 : Integer :: {Seq#Index(Seq#Drop(s_$10,n_$11),j_$3)} {:weight  25}( (((0 <= n_$11) && (0 <= j_$3)) && (j_$3 < (Seq#Length(s_$10) - n_$11))) ==> (Seq#Index(Seq#Drop(s_$10,n_$11),j_$3) == Seq#Index(s_$10,j_$3 + n_$11)) ));
	assume (forall<T> s_$11 : Seq (T) , t_$1 : Seq (T)  :: {Seq#Append(s_$11,t_$1)} ( (Seq#Take(Seq#Append(s_$11,t_$1),Seq#Length(s_$11)) == s_$11) && (Seq#Drop(Seq#Append(s_$11,t_$1),Seq#Length(s_$11)) == t_$1) ));
	assume (forall  min : Integer, max : Integer :: {Seq#Length(Seq#Range(min,max))} ( ((min < max) ==> (Seq#Length(Seq#Range(min,max)) == (max - min))) && ((max <= min) ==> (Seq#Length(Seq#Range(min,max)) == 0)) ));
	assume (forall  min_$0 : Integer, max_$0 : Integer, j_$4 : Integer :: {Seq#Index(Seq#Range(min_$0,max_$0),j_$4)} ( ((0 <= j_$4) && (j_$4 < (max_$0 - min_$0))) ==> (Seq#Index(Seq#Range(min_$0,max_$0),j_$4) == (min_$0 + j_$4)) ));
	assume (forall<T> x_$6 : T, y_$0 : T :: {Seq#Contains(Seq#Singleton(x_$6),y_$0)} ( Seq#Contains(Seq#Singleton(x_$6),y_$0) <==> (x_$6 == y_$0) ));
	assume NonPredicateField(AVLTree.root);
	assume NonPredicateField(AVLTree.keys);
	assume PredicateField(AVLTree.valid);
	assume NonPredicateField(AVLTreeNode.key);
	assume NonPredicateField(AVLTreeNode.height);
	assume NonPredicateField(AVLTreeNode.left);
	assume NonPredicateField(AVLTreeNode.right);
	assume NonPredicateField(AVLTreeNode.keys);
	assume NonPredicateField(AVLTreeNode.balanceFactor);
	assume PredicateField(AVLTreeNode.valid);
	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	assume IsGoodMask(Mask);
	assume IsGoodMask(SecMask);
	assume (this == null) || (dtype(this) == AVLTreeNode#t);
	assume (r#66 == null) || (dtype(r#66) == AVLTreeNode#t);
	assume true;
	assume true;
	assume true;
	assume (this#664 == null) || (dtype(this#664) == AVLTreeNode#t);
	assume true;
	assume (this#680 == null) || (dtype(this#680) == AVLTreeNode#t);
	assume (this#693 == null) || (dtype(this#693) == AVLTreeNode#t);
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_2144) && ((1000 * methodK#_2144) < Fractions(1));
	assume CurrentModule == module#default;
	assume CanAssumeFunctionDefs;
	assume !(this == null);
	assume wf(Heap,ZeroMask,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_0 == ZeroMask[this,AVLTreeNode.key := ZeroMask[this,AVLTreeNode.key][perm$R := ZeroMask[this,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.key]));
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_1 == Mask_$_0[this,AVLTreeNode.height := Mask_$_0[this,AVLTreeNode.height][perm$R := Mask_$_0[this,AVLTreeNode.height][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_1);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.height]));
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume (Heap[this,AVLTreeNode.left] == null) || (dtype(Heap[this,AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_2 == Mask_$_1[this,AVLTreeNode.left := Mask_$_1[this,AVLTreeNode.left][perm$R := Mask_$_1[this,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_2);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.left]));
	assume wf(Heap,Mask_$_2,ZeroMask);
	assume wf(Heap,Mask_$_2,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_2,ZeroMask);
	assume (Heap[this,AVLTreeNode.right] == null) || (dtype(Heap[this,AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_3 == Mask_$_2[this,AVLTreeNode.right := Mask_$_2[this,AVLTreeNode.right][perm$R := Mask_$_2[this,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_3);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.right]));
	assume wf(Heap,Mask_$_3,ZeroMask);
	assume wf(Heap,Mask_$_3,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_3,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_4 == Mask_$_3[this,AVLTreeNode.keys := Mask_$_3[this,AVLTreeNode.keys][perm$R := Mask_$_3[this,AVLTreeNode.keys][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_4);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_4,ZeroMask);
	assume wf(Heap,Mask_$_4,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_4,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_5 == Mask_$_4[this,AVLTreeNode.balanceFactor := Mask_$_4[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_4[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_5);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_5,ZeroMask);
	assume wf(Heap,Mask_$_5,ZeroMask);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_5,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_6 == Mask_$_5[Heap[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_5[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_5[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_6);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_6,ZeroMask);
	assume wf(Heap,Mask_$_6,ZeroMask);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_6,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_7 == Mask_$_6[Heap[this,AVLTreeNode.left],AVLTreeNode.height := Mask_$_6[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_6[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_7);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_7,ZeroMask);
	assume wf(Heap,Mask_$_7,ZeroMask);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_7,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_8 == Mask_$_7[Heap[this,AVLTreeNode.left],AVLTreeNode.keys := Mask_$_7[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := Mask_$_7[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_8);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_8,ZeroMask);
	assume wf(Heap,Mask_$_8,ZeroMask);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_8,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_9 == Mask_$_8[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := Mask_$_8[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := Mask_$_8[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_9);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_9,ZeroMask);
	assume wf(Heap,Mask_$_9,ZeroMask);
	assume (forall  k#96#635 : Integer :: ( ((0 <= k#96#635) && (k#96#635 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],k#96#635) < Heap[this,AVLTreeNode.key]) ));
	if ($_$_condition) { goto anon705_Then; } else { goto anon705_Else; }
anon705_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_9,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_10 == Mask_$_9[Heap[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_9[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_9[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_10);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_10,ZeroMask);
	assume wf(Heap,Mask_$_10,ZeroMask);
	assume Mask_$_11 == Mask_$_10;
	if ($_$_condition_$0) { goto anon706_Then; } else { goto anon706_Else; }
anon705_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_11 == Mask_$_9;
	if ($_$_condition_$1) { goto anon706_Then; } else { goto anon706_Else; }
anon706_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_11,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_12 == Mask_$_11[Heap[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_11[Heap[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_11[Heap[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_12);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_12,ZeroMask);
	assume wf(Heap,Mask_$_12,ZeroMask);
	assume Mask_$_13 == Mask_$_12;
	if ($_$_condition_$2) { goto anon707_Then; } else { goto anon707_Else; }
anon706_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_13 == Mask_$_11;
	if ($_$_condition_$3) { goto anon707_Then; } else { goto anon707_Else; }
anon707_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_13,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_14 == Mask_$_13[Heap[this,AVLTreeNode.right],AVLTreeNode.keys := Mask_$_13[Heap[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := Mask_$_13[Heap[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_14);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_14,ZeroMask);
	assume wf(Heap,Mask_$_14,ZeroMask);
	assume Mask_$_15 == Mask_$_14;
	if ($_$_condition_$4) { goto anon708_Then; } else { goto anon708_Else; }
anon707_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_15 == Mask_$_13;
	if ($_$_condition_$5) { goto anon708_Then; } else { goto anon708_Else; }
anon708_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_15,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_16 == Mask_$_15[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := Mask_$_15[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := Mask_$_15[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_16);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_16,ZeroMask);
	assume wf(Heap,Mask_$_16,ZeroMask);
	assume Mask_$_17 == Mask_$_16;
	if ($_$_condition_$6) { goto anon709_Then; } else { goto anon709_Else; }
anon708_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_17 == Mask_$_15;
	if ($_$_condition_$7) { goto anon709_Then; } else { goto anon709_Else; }
anon709_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume (forall  k#97#636 : Integer :: ( ((0 <= k#97#636) && (k#97#636 < Seq#Length(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[this,AVLTreeNode.key] < Seq#Index(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys],k#97#636)) ));
	goto anon10;
anon709_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	goto anon10;
anon10:
	assume predRec#_2191_$_0 == Heap[this,AVLTreeNode.left];
	assume #AVLTreeNode.valid#trigger(Heap[this,AVLTreeNode.left]);
	assume predVer#_2192_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid];
	if ($_$_condition_$8) { goto anon710_Then; } else { goto anon710_Else; }
anon710_Then:
	assume false;
	goto $exit;
anon710_Else:
	assume !false;
	assume !(predRec#_2191_$_0 == null);
	assume wf(Heap,Mask_$_17,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume SecMask_$_0 == ZeroMask[predRec#_2191_$_0,AVLTreeNode.key := ZeroMask[predRec#_2191_$_0,AVLTreeNode.key][perm$R := ZeroMask[predRec#_2191_$_0,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[predRec#_2191_$_0,AVLTreeNode.key]));
	assume wf(Heap,Mask_$_17,SecMask_$_0);
	assume wf(Heap,Mask_$_17,SecMask_$_0);
	assume !(predRec#_2191_$_0 == null);
	assume wf(Heap,Mask_$_17,SecMask_$_0);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_1 == SecMask_$_0[predRec#_2191_$_0,AVLTreeNode.height := SecMask_$_0[predRec#_2191_$_0,AVLTreeNode.height][perm$R := SecMask_$_0[predRec#_2191_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[predRec#_2191_$_0,AVLTreeNode.height]));
	assume wf(Heap,Mask_$_17,SecMask_$_1);
	assume wf(Heap,Mask_$_17,SecMask_$_1);
	assume !(predRec#_2191_$_0 == null);
	assume wf(Heap,Mask_$_17,SecMask_$_1);
	assume (Heap[predRec#_2191_$_0,AVLTreeNode.left] == null) || (dtype(Heap[predRec#_2191_$_0,AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume SecMask_$_2 == SecMask_$_1[predRec#_2191_$_0,AVLTreeNode.left := SecMask_$_1[predRec#_2191_$_0,AVLTreeNode.left][perm$R := SecMask_$_1[predRec#_2191_$_0,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[predRec#_2191_$_0,AVLTreeNode.left]));
	assume wf(Heap,Mask_$_17,SecMask_$_2);
	assume wf(Heap,Mask_$_17,SecMask_$_2);
	assume !(predRec#_2191_$_0 == null);
	assume wf(Heap,Mask_$_17,SecMask_$_2);
	assume (Heap[predRec#_2191_$_0,AVLTreeNode.right] == null) || (dtype(Heap[predRec#_2191_$_0,AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume SecMask_$_3 == SecMask_$_2[predRec#_2191_$_0,AVLTreeNode.right := SecMask_$_2[predRec#_2191_$_0,AVLTreeNode.right][perm$R := SecMask_$_2[predRec#_2191_$_0,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[predRec#_2191_$_0,AVLTreeNode.right]));
	assume wf(Heap,Mask_$_17,SecMask_$_3);
	assume wf(Heap,Mask_$_17,SecMask_$_3);
	assume !(predRec#_2191_$_0 == null);
	assume wf(Heap,Mask_$_17,SecMask_$_3);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_4 == SecMask_$_3[predRec#_2191_$_0,AVLTreeNode.keys := SecMask_$_3[predRec#_2191_$_0,AVLTreeNode.keys][perm$R := SecMask_$_3[predRec#_2191_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[predRec#_2191_$_0,AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_17,SecMask_$_4);
	assume wf(Heap,Mask_$_17,SecMask_$_4);
	assume !(predRec#_2191_$_0 == null);
	assume wf(Heap,Mask_$_17,SecMask_$_4);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_5 == SecMask_$_4[predRec#_2191_$_0,AVLTreeNode.balanceFactor := SecMask_$_4[predRec#_2191_$_0,AVLTreeNode.balanceFactor][perm$R := SecMask_$_4[predRec#_2191_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[predRec#_2191_$_0,AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_17,SecMask_$_5);
	assume wf(Heap,Mask_$_17,SecMask_$_5);
	if ($_$_condition_$9) { goto anon737_Then; } else { goto anon737_Else; }
anon737_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_17,SecMask_$_5);
	assume Fractions(100) > 0;
	assume SecMask_$_6 == SecMask_$_5[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_5[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_5[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_17,SecMask_$_6);
	assume wf(Heap,Mask_$_17,SecMask_$_6);
	assume SecMask_$_7 == SecMask_$_6;
	if ($_$_condition_$10) { goto anon738_Then; } else { goto anon738_Else; }
anon737_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_7 == SecMask_$_5;
	if ($_$_condition_$11) { goto anon738_Then; } else { goto anon738_Else; }
anon738_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_17,SecMask_$_7);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_8 == SecMask_$_7[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_7[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_7[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_17,SecMask_$_8);
	assume wf(Heap,Mask_$_17,SecMask_$_8);
	assume SecMask_$_9 == SecMask_$_8;
	if ($_$_condition_$12) { goto anon739_Then; } else { goto anon739_Else; }
anon738_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_9 == SecMask_$_7;
	if ($_$_condition_$13) { goto anon739_Then; } else { goto anon739_Else; }
anon739_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_17,SecMask_$_9);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_10 == SecMask_$_9[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_9[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_9[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_17,SecMask_$_10);
	assume wf(Heap,Mask_$_17,SecMask_$_10);
	assume SecMask_$_11 == SecMask_$_10;
	if ($_$_condition_$14) { goto anon740_Then; } else { goto anon740_Else; }
anon739_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_11 == SecMask_$_9;
	if ($_$_condition_$15) { goto anon740_Then; } else { goto anon740_Else; }
anon740_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_17,SecMask_$_11);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_12 == SecMask_$_11[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_11[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_11[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_17,SecMask_$_12);
	assume wf(Heap,Mask_$_17,SecMask_$_12);
	assume SecMask_$_13 == SecMask_$_12;
	if ($_$_condition_$16) { goto anon741_Then; } else { goto anon741_Else; }
anon740_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_13 == SecMask_$_11;
	if ($_$_condition_$17) { goto anon741_Then; } else { goto anon741_Else; }
anon741_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#641 : Integer :: ( ((0 <= lk#79#641) && (lk#79#641 < Seq#Length(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#641) < Heap[predRec#_2191_$_0,AVLTreeNode.key]) ));
	if ($_$_condition_$18) { goto anon742_Then; } else { goto anon742_Else; }
anon741_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$19) { goto anon742_Then; } else { goto anon742_Else; }
anon742_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$20) { goto anon743_Then; } else { goto anon743_Else; }
anon742_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$21) { goto anon743_Then; } else { goto anon743_Else; }
anon743_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_17,SecMask_$_13);
	assume Fractions(100) > 0;
	assume SecMask_$_14 == SecMask_$_13[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_13[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_13[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_17,SecMask_$_14);
	assume wf(Heap,Mask_$_17,SecMask_$_14);
	assume SecMask_$_15 == SecMask_$_14;
	if ($_$_condition_$22) { goto anon744_Then; } else { goto anon744_Else; }
anon743_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_15 == SecMask_$_13;
	if ($_$_condition_$23) { goto anon744_Then; } else { goto anon744_Else; }
anon744_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_17,SecMask_$_15);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_16 == SecMask_$_15[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_15[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_15[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_17,SecMask_$_16);
	assume wf(Heap,Mask_$_17,SecMask_$_16);
	assume SecMask_$_17 == SecMask_$_16;
	if ($_$_condition_$24) { goto anon745_Then; } else { goto anon745_Else; }
anon744_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_17 == SecMask_$_15;
	if ($_$_condition_$25) { goto anon745_Then; } else { goto anon745_Else; }
anon745_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_17,SecMask_$_17);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_18 == SecMask_$_17[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_17[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_17[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_17,SecMask_$_18);
	assume wf(Heap,Mask_$_17,SecMask_$_18);
	assume SecMask_$_19 == SecMask_$_18;
	if ($_$_condition_$26) { goto anon746_Then; } else { goto anon746_Else; }
anon745_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_19 == SecMask_$_17;
	if ($_$_condition_$27) { goto anon746_Then; } else { goto anon746_Else; }
anon746_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_17,SecMask_$_19);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_20 == SecMask_$_19[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_19[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_19[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_17,SecMask_$_20);
	assume wf(Heap,Mask_$_17,SecMask_$_20);
	assume SecMask_$_21 == SecMask_$_20;
	if ($_$_condition_$28) { goto anon747_Then; } else { goto anon747_Else; }
anon746_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_21 == SecMask_$_19;
	if ($_$_condition_$29) { goto anon747_Then; } else { goto anon747_Else; }
anon747_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#642 : Integer :: ( ((0 <= rk#80#642) && (rk#80#642 < Seq#Length(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[predRec#_2191_$_0,AVLTreeNode.key] < Seq#Index(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#642)) ));
	if ($_$_condition_$30) { goto anon748_Then; } else { goto anon748_Else; }
anon747_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	if ($_$_condition_$31) { goto anon748_Then; } else { goto anon748_Else; }
anon748_Then:
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon88;
anon748_Else:
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	goto anon88;
anon88:
	assume Seq#Equal(Heap[predRec#_2191_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap[predRec#_2191_$_0,AVLTreeNode.key])),ite(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap[predRec#_2191_$_0,AVLTreeNode.keys],Heap[predRec#_2191_$_0,AVLTreeNode.key]);
	assume (forall  kk#81 : Integer :: ( Seq#Contains(Heap[predRec#_2191_$_0,AVLTreeNode.keys],kk#81) <==> ((((!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81)) || ((!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81))) || (kk#81 == Heap[predRec#_2191_$_0,AVLTreeNode.key])) ));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.height] == ite(ite(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null,0,Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null,0,Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null,0,Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null,0,Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap[predRec#_2191_$_0,AVLTreeNode.balanceFactor] == (ite(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null,0,Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null,0,Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.balanceFactor] <= 1;
	assume Heap[predRec#_2191_$_0,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap[predRec#_2191_$_0,AVLTreeNode.height] > 0;
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height] - ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height])) == 2;
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (0 - 1);
	assume IsGoodMask(Mask_$_17);
	assume wf(Heap,Mask_$_17,SecMask_$_21);
	assume Heap == Heap;
	assume Mask_$_17 == Mask;
	assume SecMask_$_21 == SecMask;
	assume ZeroCredits == Credits;
	assume wf(Heap,Mask_$_17,SecMask_$_21);
	assert { :msg "  679.10: Receiver might be null." } (true && (0 <= k#98#644)) ==> (!(this == null));
	assert { :msg "  679.10: Location might not be readable." } (true && (0 <= k#98#644)) ==> CanRead(Mask_$_17,SecMask_$_21,this,AVLTreeNode.left);
	assert { :msg "  679.10: Receiver might be null." } (true && (0 <= k#98#644)) ==> (!(Heap[this,AVLTreeNode.left] == null));
	assert { :msg "  679.10: Location might not be readable." } (true && (0 <= k#98#644)) ==> CanRead(Mask_$_17,SecMask_$_21,Heap[this,AVLTreeNode.left],AVLTreeNode.keys);
	assert { :msg "  679.10: Receiver might be null." } ((true && (0 <= k#98#644)) && (k#98#644 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (!(this == null));
	assert { :msg "  679.10: Location might not be readable." } ((true && (0 <= k#98#644)) && (k#98#644 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> CanRead(Mask_$_17,SecMask_$_21,this,AVLTreeNode.left);
	assert { :msg "  679.10: Receiver might be null." } ((true && (0 <= k#98#644)) && (k#98#644 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (!(Heap[this,AVLTreeNode.left] == null));
	assert { :msg "  679.10: Location might not be readable." } ((true && (0 <= k#98#644)) && (k#98#644 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> CanRead(Mask_$_17,SecMask_$_21,Heap[this,AVLTreeNode.left],AVLTreeNode.keys);
	assert { :msg "  679.35: Sequence index might be negative." } ((true && (0 <= k#98#644)) && (k#98#644 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (0 <= k#98#644);
	assert { :msg "  679.35: Sequence index might be larger than or equal to the length of the sequence." } ((true && (0 <= k#98#644)) && (k#98#644 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (k#98#644 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assert { :msg "  679.39: Receiver might be null." } ((true && (0 <= k#98#644)) && (k#98#644 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (!(this == null));
	assert { :msg "  679.39: Location might not be readable." } ((true && (0 <= k#98#644)) && (k#98#644 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> CanRead(Mask_$_17,SecMask_$_21,this,AVLTreeNode.key);
	assert { :msg "  679.3: Assertion might not hold. The expression at 679.10 might not evaluate to true." } (forall  k#98#643 : Integer :: ( ((0 <= k#98#643) && (k#98#643 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],k#98#643) < Heap[this,AVLTreeNode.key]) ));
	assume IsGoodExhaleState(exhaleHeap#_2214_$_0,Heap,Mask_$_17,SecMask_$_21);
	assume IsGoodMask(Mask_$_17);
	assume wf(exhaleHeap#_2214_$_0,Mask_$_17,SecMask_$_21);
	assume #AVLTreeNode.valid#trigger(Heap[this,AVLTreeNode.left]);
	assume ((0 < unfoldK#_2216) && (unfoldK#_2216 < Fractions(1))) && ((1000 * unfoldK#_2216) < methodK#_2144);
	assert { :msg "  680.10: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  680.10: Location might not be readable." } true ==> CanRead(Mask_$_17,SecMask_$_21,this,AVLTreeNode.left);
	assert { :msg "  680.3: The target of the fold statement might be null." } !(Heap[this,AVLTreeNode.left] == null);
	assert { :msg "  680.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  680.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_17[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_17[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_17[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume Mask_$_18 == Mask_$_17[Heap[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_17[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_17[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$32) { goto anon749_Then; } else { goto anon749_Else; }
anon749_Then:
	assume false || ((((predVer#_2192_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap[this,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$33) { goto anon750_Then; } else { goto anon750_Else; }
anon749_Else:
	assume !(false || ((((predVer#_2192_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap[this,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_72 == SecMask_$_21;
	if ($_$_condition_$34) { goto anon776_Then; } else { goto anon776_Else; }
anon750_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#646 : Integer :: ( ((0 <= lk#79#646) && (lk#79#646 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#646) < Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	if ($_$_condition_$35) { goto anon751_Then; } else { goto anon751_Else; }
anon750_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$36) { goto anon751_Then; } else { goto anon751_Else; }
anon776_Then:
	assume !CanRead(Mask_$_18,SecMask_$_72,Heap[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume oldVers#_2236_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume Heap_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid := newVers#_2237_$_0];
	assume oldVers#_2236_$_0 < Heap_$_0[Heap_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume Heap_$_1 == Heap_$_0;
	goto anon144;
anon776_Else:
	assume CanRead(Mask_$_18,SecMask_$_72,Heap[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_1 == Heap;
	goto anon144;
anon751_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$37) { goto anon752_Then; } else { goto anon752_Else; }
anon751_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$38) { goto anon752_Then; } else { goto anon752_Else; }
anon752_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#647 : Integer :: ( ((0 <= rk#80#647) && (rk#80#647 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#647)) ));
	if ($_$_condition_$39) { goto anon753_Then; } else { goto anon753_Else; }
anon752_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	if ($_$_condition_$40) { goto anon753_Then; } else { goto anon753_Else; }
anon753_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon97;
anon753_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon97;
anon97:
	assume Seq#Equal(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key])),ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$0 : Integer :: ( Seq#Contains(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$0) <==> ((((!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$0)) || ((!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$0))) || (kk#81_$0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_22 == SecMask_$_21[Heap[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_21[Heap[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_21[Heap[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$41) { goto anon754_Then; } else { goto anon754_Else; }
anon754_Then:
	assume SecMask_$_22[Heap[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_23 == SecMask_$_22[Heap[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_22[Heap[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_24 == SecMask_$_23;
	goto anon99;
anon754_Else:
	assume 0 <= SecMask_$_22[Heap[this,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_24 == SecMask_$_22;
	goto anon99;
anon99:
	assume wf(Heap,SecMask_$_24,SecMask_$_24);
	assume wf(Heap,Mask_$_18,SecMask_$_24);
	assume SecMask_$_25 == SecMask_$_24[Heap[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_24[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_24[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$42) { goto anon755_Then; } else { goto anon755_Else; }
anon755_Then:
	assume SecMask_$_25[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_26 == SecMask_$_25[Heap[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_25[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_27 == SecMask_$_26;
	goto anon101;
anon755_Else:
	assume 0 <= SecMask_$_25[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_27 == SecMask_$_25;
	goto anon101;
anon101:
	assume wf(Heap,SecMask_$_27,SecMask_$_27);
	assume wf(Heap,Mask_$_18,SecMask_$_27);
	assume SecMask_$_28 == SecMask_$_27[Heap[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_27[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_27[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$43) { goto anon756_Then; } else { goto anon756_Else; }
anon756_Then:
	assume SecMask_$_28[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_29 == SecMask_$_28[Heap[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_28[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_30 == SecMask_$_29;
	goto anon103;
anon756_Else:
	assume 0 <= SecMask_$_28[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_30 == SecMask_$_28;
	goto anon103;
anon103:
	assume wf(Heap,SecMask_$_30,SecMask_$_30);
	assume wf(Heap,Mask_$_18,SecMask_$_30);
	assume SecMask_$_31 == SecMask_$_30[Heap[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_30[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_30[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$44) { goto anon757_Then; } else { goto anon757_Else; }
anon757_Then:
	assume SecMask_$_31[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_32 == SecMask_$_31[Heap[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_31[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_33 == SecMask_$_32;
	goto anon105;
anon757_Else:
	assume 0 <= SecMask_$_31[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_33 == SecMask_$_31;
	goto anon105;
anon105:
	assume wf(Heap,SecMask_$_33,SecMask_$_33);
	assume wf(Heap,Mask_$_18,SecMask_$_33);
	assume SecMask_$_34 == SecMask_$_33[Heap[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_33[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_33[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$45) { goto anon758_Then; } else { goto anon758_Else; }
anon758_Then:
	assume SecMask_$_34[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_35 == SecMask_$_34[Heap[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_34[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_36 == SecMask_$_35;
	goto anon107;
anon758_Else:
	assume 0 <= SecMask_$_34[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_36 == SecMask_$_34;
	goto anon107;
anon107:
	assume wf(Heap,SecMask_$_36,SecMask_$_36);
	assume wf(Heap,Mask_$_18,SecMask_$_36);
	assume SecMask_$_37 == SecMask_$_36[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_36[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_36[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$46) { goto anon759_Then; } else { goto anon759_Else; }
anon759_Then:
	assume SecMask_$_37[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_38 == SecMask_$_37[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_37[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_39 == SecMask_$_38;
	goto anon109;
anon759_Else:
	assume 0 <= SecMask_$_37[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_39 == SecMask_$_37;
	goto anon109;
anon109:
	assume wf(Heap,SecMask_$_39,SecMask_$_39);
	assume wf(Heap,Mask_$_18,SecMask_$_39);
	if ($_$_condition_$47) { goto anon760_Then; } else { goto anon760_Else; }
anon760_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_40 == SecMask_$_39[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_39[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_39[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$48) { goto anon761_Then; } else { goto anon761_Else; }
anon760_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_43 == SecMask_$_39;
	if ($_$_condition_$49) { goto anon762_Then; } else { goto anon762_Else; }
anon761_Then:
	assume SecMask_$_40[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_41 == SecMask_$_40[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_40[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_42 == SecMask_$_41;
	goto anon112;
anon761_Else:
	assume 0 <= SecMask_$_40[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_42 == SecMask_$_40;
	goto anon112;
anon762_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_44 == SecMask_$_43[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_43[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_43[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$51) { goto anon763_Then; } else { goto anon763_Else; }
anon762_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_47 == SecMask_$_43;
	if ($_$_condition_$52) { goto anon764_Then; } else { goto anon764_Else; }
anon112:
	assume wf(Heap,SecMask_$_42,SecMask_$_42);
	assume wf(Heap,Mask_$_18,SecMask_$_42);
	assume SecMask_$_43 == SecMask_$_42;
	if ($_$_condition_$50) { goto anon762_Then; } else { goto anon762_Else; }
anon763_Then:
	assume SecMask_$_44[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_45 == SecMask_$_44[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_44[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_46 == SecMask_$_45;
	goto anon116;
anon763_Else:
	assume 0 <= SecMask_$_44[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_46 == SecMask_$_44;
	goto anon116;
anon764_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_48 == SecMask_$_47[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_47[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_47[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$54) { goto anon765_Then; } else { goto anon765_Else; }
anon764_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_51 == SecMask_$_47;
	if ($_$_condition_$55) { goto anon766_Then; } else { goto anon766_Else; }
anon116:
	assume wf(Heap,SecMask_$_46,SecMask_$_46);
	assume wf(Heap,Mask_$_18,SecMask_$_46);
	assume SecMask_$_47 == SecMask_$_46;
	if ($_$_condition_$53) { goto anon764_Then; } else { goto anon764_Else; }
anon765_Then:
	assume SecMask_$_48[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_49 == SecMask_$_48[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_48[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_50 == SecMask_$_49;
	goto anon120;
anon765_Else:
	assume 0 <= SecMask_$_48[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_50 == SecMask_$_48;
	goto anon120;
anon766_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_52 == SecMask_$_51[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_51[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_51[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$57) { goto anon767_Then; } else { goto anon767_Else; }
anon766_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_55 == SecMask_$_51;
	if ($_$_condition_$58) { goto anon768_Then; } else { goto anon768_Else; }
anon120:
	assume wf(Heap,SecMask_$_50,SecMask_$_50);
	assume wf(Heap,Mask_$_18,SecMask_$_50);
	assume SecMask_$_51 == SecMask_$_50;
	if ($_$_condition_$56) { goto anon766_Then; } else { goto anon766_Else; }
anon767_Then:
	assume SecMask_$_52[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_53 == SecMask_$_52[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_52[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_54 == SecMask_$_53;
	goto anon124;
anon767_Else:
	assume 0 <= SecMask_$_52[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_54 == SecMask_$_52;
	goto anon124;
anon768_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_56 == SecMask_$_55[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_55[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_55[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$60) { goto anon769_Then; } else { goto anon769_Else; }
anon768_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_59 == SecMask_$_55;
	if ($_$_condition_$61) { goto anon770_Then; } else { goto anon770_Else; }
anon124:
	assume wf(Heap,SecMask_$_54,SecMask_$_54);
	assume wf(Heap,Mask_$_18,SecMask_$_54);
	assume SecMask_$_55 == SecMask_$_54;
	if ($_$_condition_$59) { goto anon768_Then; } else { goto anon768_Else; }
anon769_Then:
	assume SecMask_$_56[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_57 == SecMask_$_56[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_56[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_58 == SecMask_$_57;
	goto anon128;
anon769_Else:
	assume 0 <= SecMask_$_56[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_58 == SecMask_$_56;
	goto anon128;
anon770_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_60 == SecMask_$_59[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_59[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_59[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$63) { goto anon771_Then; } else { goto anon771_Else; }
anon770_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_63 == SecMask_$_59;
	if ($_$_condition_$64) { goto anon772_Then; } else { goto anon772_Else; }
anon128:
	assume wf(Heap,SecMask_$_58,SecMask_$_58);
	assume wf(Heap,Mask_$_18,SecMask_$_58);
	assume SecMask_$_59 == SecMask_$_58;
	if ($_$_condition_$62) { goto anon770_Then; } else { goto anon770_Else; }
anon771_Then:
	assume SecMask_$_60[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_61 == SecMask_$_60[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_60[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_62 == SecMask_$_61;
	goto anon132;
anon771_Else:
	assume 0 <= SecMask_$_60[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_62 == SecMask_$_60;
	goto anon132;
anon772_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_64 == SecMask_$_63[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_63[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_63[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$66) { goto anon773_Then; } else { goto anon773_Else; }
anon772_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_67 == SecMask_$_63;
	if ($_$_condition_$67) { goto anon774_Then; } else { goto anon774_Else; }
anon132:
	assume wf(Heap,SecMask_$_62,SecMask_$_62);
	assume wf(Heap,Mask_$_18,SecMask_$_62);
	assume SecMask_$_63 == SecMask_$_62;
	if ($_$_condition_$65) { goto anon772_Then; } else { goto anon772_Else; }
anon773_Then:
	assume SecMask_$_64[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_65 == SecMask_$_64[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_64[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_66 == SecMask_$_65;
	goto anon136;
anon773_Else:
	assume 0 <= SecMask_$_64[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_66 == SecMask_$_64;
	goto anon136;
anon774_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_68 == SecMask_$_67[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_67[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_67[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$69) { goto anon775_Then; } else { goto anon775_Else; }
anon774_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_71 == SecMask_$_67;
	goto anon141;
anon136:
	assume wf(Heap,SecMask_$_66,SecMask_$_66);
	assume wf(Heap,Mask_$_18,SecMask_$_66);
	assume SecMask_$_67 == SecMask_$_66;
	if ($_$_condition_$68) { goto anon774_Then; } else { goto anon774_Else; }
anon775_Then:
	assume SecMask_$_68[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_69 == SecMask_$_68[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_68[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_70 == SecMask_$_69;
	goto anon140;
anon775_Else:
	assume 0 <= SecMask_$_68[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_70 == SecMask_$_68;
	goto anon140;
anon141:
	assume wf(Heap,SecMask_$_71,SecMask_$_71);
	assume SecMask_$_72 == SecMask_$_71;
	if ($_$_condition_$70) { goto anon776_Then; } else { goto anon776_Else; }
anon140:
	assume wf(Heap,SecMask_$_70,SecMask_$_70);
	assume wf(Heap,Mask_$_18,SecMask_$_70);
	assume SecMask_$_71 == SecMask_$_70;
	goto anon141;
anon144:
	assume IsGoodMask(Mask_$_18);
	assume wf(Heap_$_1,Mask_$_18,SecMask_$_72);
	assume IsGoodMask(Mask_$_18);
	assume wf(Heap_$_1,Mask_$_18,SecMask_$_72);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_18,SecMask_$_72);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_19 == Mask_$_18[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key := Mask_$_18[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := Mask_$_18[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key]));
	assume wf(Heap_$_1,Mask_$_19,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_19,SecMask_$_72);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_19,SecMask_$_72);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_20 == Mask_$_19[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height := Mask_$_19[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_19[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_20);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_20,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_20,SecMask_$_72);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_20,SecMask_$_72);
	assume (Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null) || (dtype(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_21 == Mask_$_20[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left := Mask_$_20[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := Mask_$_20[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left]));
	assume wf(Heap_$_1,Mask_$_21,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_21,SecMask_$_72);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_21,SecMask_$_72);
	assume (Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null) || (dtype(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_22 == Mask_$_21[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right := Mask_$_21[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := Mask_$_21[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_22);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right]));
	assume wf(Heap_$_1,Mask_$_22,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_22,SecMask_$_72);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_22,SecMask_$_72);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_23 == Mask_$_22[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys := Mask_$_22[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := Mask_$_22[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_23);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_23,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_23,SecMask_$_72);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_23,SecMask_$_72);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_24 == Mask_$_23[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := Mask_$_23[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := Mask_$_23[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_24);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_24,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_24,SecMask_$_72);
	if ($_$_condition_$71) { goto anon777_Then; } else { goto anon777_Else; }
anon777_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_24,SecMask_$_72);
	assume Fractions(100) > 0;
	assume Mask_$_25 == Mask_$_24[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := Mask_$_24[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_24[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_25);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_25,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_25,SecMask_$_72);
	assume Mask_$_26 == Mask_$_25;
	if ($_$_condition_$72) { goto anon778_Then; } else { goto anon778_Else; }
anon777_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume Mask_$_26 == Mask_$_24;
	if ($_$_condition_$73) { goto anon778_Then; } else { goto anon778_Else; }
anon778_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,SecMask_$_72);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_27 == Mask_$_26[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := Mask_$_26[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_26[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_27);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_27,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_27,SecMask_$_72);
	assume Mask_$_28 == Mask_$_27;
	if ($_$_condition_$74) { goto anon779_Then; } else { goto anon779_Else; }
anon778_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume Mask_$_28 == Mask_$_26;
	if ($_$_condition_$75) { goto anon779_Then; } else { goto anon779_Else; }
anon779_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_28,SecMask_$_72);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_29 == Mask_$_28[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := Mask_$_28[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := Mask_$_28[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_29);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_29,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_29,SecMask_$_72);
	assume Mask_$_30 == Mask_$_29;
	if ($_$_condition_$76) { goto anon780_Then; } else { goto anon780_Else; }
anon779_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume Mask_$_30 == Mask_$_28;
	if ($_$_condition_$77) { goto anon780_Then; } else { goto anon780_Else; }
anon780_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_30,SecMask_$_72);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_31 == Mask_$_30[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := Mask_$_30[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := Mask_$_30[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_31);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_31,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_31,SecMask_$_72);
	assume Mask_$_32 == Mask_$_31;
	if ($_$_condition_$78) { goto anon781_Then; } else { goto anon781_Else; }
anon780_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume Mask_$_32 == Mask_$_30;
	if ($_$_condition_$79) { goto anon781_Then; } else { goto anon781_Else; }
anon781_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#650 : Integer :: ( ((0 <= lk#79#650) && (lk#79#650 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#650) < Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	if ($_$_condition_$80) { goto anon782_Then; } else { goto anon782_Else; }
anon781_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$81) { goto anon782_Then; } else { goto anon782_Else; }
anon782_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$82) { goto anon783_Then; } else { goto anon783_Else; }
anon782_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$83) { goto anon783_Then; } else { goto anon783_Else; }
anon783_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_32,SecMask_$_72);
	assume Fractions(100) > 0;
	assume Mask_$_33 == Mask_$_32[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := Mask_$_32[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_32[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_33);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_33,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_33,SecMask_$_72);
	assume Mask_$_34 == Mask_$_33;
	if ($_$_condition_$84) { goto anon784_Then; } else { goto anon784_Else; }
anon783_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume Mask_$_34 == Mask_$_32;
	if ($_$_condition_$85) { goto anon784_Then; } else { goto anon784_Else; }
anon784_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_34,SecMask_$_72);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_35 == Mask_$_34[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := Mask_$_34[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_34[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_35);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_35,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_35,SecMask_$_72);
	assume Mask_$_36 == Mask_$_35;
	if ($_$_condition_$86) { goto anon785_Then; } else { goto anon785_Else; }
anon784_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume Mask_$_36 == Mask_$_34;
	if ($_$_condition_$87) { goto anon785_Then; } else { goto anon785_Else; }
anon785_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_36,SecMask_$_72);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_37 == Mask_$_36[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := Mask_$_36[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := Mask_$_36[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_37);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_37,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_37,SecMask_$_72);
	assume Mask_$_38 == Mask_$_37;
	if ($_$_condition_$88) { goto anon786_Then; } else { goto anon786_Else; }
anon785_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume Mask_$_38 == Mask_$_36;
	if ($_$_condition_$89) { goto anon786_Then; } else { goto anon786_Else; }
anon786_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_38,SecMask_$_72);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_39 == Mask_$_38[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := Mask_$_38[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := Mask_$_38[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_39);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_39,SecMask_$_72);
	assume wf(Heap_$_1,Mask_$_39,SecMask_$_72);
	assume Mask_$_40 == Mask_$_39;
	if ($_$_condition_$90) { goto anon787_Then; } else { goto anon787_Else; }
anon786_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume Mask_$_40 == Mask_$_38;
	if ($_$_condition_$91) { goto anon787_Then; } else { goto anon787_Else; }
anon787_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#651 : Integer :: ( ((0 <= rk#80#651) && (rk#80#651 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#651)) ));
	if ($_$_condition_$92) { goto anon788_Then; } else { goto anon788_Else; }
anon787_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	if ($_$_condition_$93) { goto anon788_Then; } else { goto anon788_Else; }
anon788_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon168;
anon788_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon168;
anon168:
	assume Seq#Equal(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key])),ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$1 : Integer :: ( Seq#Contains(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$1) <==> ((((!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$1)) || ((!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$1))) || (kk#81_$1 == Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume IsGoodMask(Mask_$_40);
	assume wf(Heap_$_1,Mask_$_40,SecMask_$_72);
	assert { :msg "  681.8: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  681.8: Location might not be readable." } true ==> CanRead(Mask_$_40,SecMask_$_72,this,AVLTreeNode.left);
	assert { :msg "  681.8: Receiver might be null." } true ==> (!(Heap_$_1[this,AVLTreeNode.left] == null));
	assert { :msg "  681.8: Location might not be readable." } true ==> CanRead(Mask_$_40,SecMask_$_72,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right);
	assume r#66_$_0 == Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right];
	assume wf(Heap_$_1,Mask_$_40,SecMask_$_72);
	assert { :msg "  682.10: Receiver might be null." } (true && (0 <= k#99#653)) ==> (!(r#66_$_0 == null));
	assert { :msg "  682.10: Location might not be readable." } (true && (0 <= k#99#653)) ==> CanRead(Mask_$_40,SecMask_$_72,r#66_$_0,AVLTreeNode.keys);
	assert { :msg "  682.10: Receiver might be null." } ((true && (0 <= k#99#653)) && (k#99#653 < Seq#Length(Heap_$_1[r#66_$_0,AVLTreeNode.keys]))) ==> (!(r#66_$_0 == null));
	assert { :msg "  682.10: Location might not be readable." } ((true && (0 <= k#99#653)) && (k#99#653 < Seq#Length(Heap_$_1[r#66_$_0,AVLTreeNode.keys]))) ==> CanRead(Mask_$_40,SecMask_$_72,r#66_$_0,AVLTreeNode.keys);
	assert { :msg "  682.32: Sequence index might be negative." } ((true && (0 <= k#99#653)) && (k#99#653 < Seq#Length(Heap_$_1[r#66_$_0,AVLTreeNode.keys]))) ==> (0 <= k#99#653);
	assert { :msg "  682.32: Sequence index might be larger than or equal to the length of the sequence." } ((true && (0 <= k#99#653)) && (k#99#653 < Seq#Length(Heap_$_1[r#66_$_0,AVLTreeNode.keys]))) ==> (k#99#653 < Seq#Length(Heap_$_1[r#66_$_0,AVLTreeNode.keys]));
	assert { :msg "  682.36: Receiver might be null." } ((true && (0 <= k#99#653)) && (k#99#653 < Seq#Length(Heap_$_1[r#66_$_0,AVLTreeNode.keys]))) ==> (!(this == null));
	assert { :msg "  682.36: Location might not be readable." } ((true && (0 <= k#99#653)) && (k#99#653 < Seq#Length(Heap_$_1[r#66_$_0,AVLTreeNode.keys]))) ==> CanRead(Mask_$_40,SecMask_$_72,this,AVLTreeNode.key);
	assert { :msg "  682.3: Assertion might not hold. The expression at 682.10 might not evaluate to true." } (forall  k#99#652 : Integer :: ( ((0 <= k#99#652) && (k#99#652 < Seq#Length(Heap_$_1[r#66_$_0,AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[r#66_$_0,AVLTreeNode.keys],k#99#652) < Heap_$_1[this,AVLTreeNode.key]) ));
	assume IsGoodExhaleState(exhaleHeap#_2242_$_0,Heap_$_1,Mask_$_40,SecMask_$_72);
	assume IsGoodMask(Mask_$_40);
	assume wf(exhaleHeap#_2242_$_0,Mask_$_40,SecMask_$_72);
	assume #AVLTreeNode.valid#trigger(r#66_$_0);
	assume ((0 < unfoldK#_2244) && (unfoldK#_2244 < Fractions(1))) && ((1000 * unfoldK#_2244) < methodK#_2144);
	assert { :msg "  683.3: The target of the fold statement might be null." } !(r#66_$_0 == null);
	assert { :msg "  683.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  683.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_40[r#66_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_40[r#66_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_40[r#66_$_0,AVLTreeNode.valid][perm$N]));
	assume Mask_$_41 == Mask_$_40[r#66_$_0,AVLTreeNode.valid := Mask_$_40[r#66_$_0,AVLTreeNode.valid][perm$R := Mask_$_40[r#66_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$94) { goto anon789_Then; } else { goto anon789_Else; }
anon789_Then:
	assume false || ((((predVer#_2192_$_0 == Heap_$_1[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true);
	if ($_$_condition_$95) { goto anon790_Then; } else { goto anon790_Else; }
anon789_Else:
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_1[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true));
	assume SecMask_$_123 == SecMask_$_72;
	if ($_$_condition_$96) { goto anon816_Then; } else { goto anon816_Else; }
anon790_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#655 : Integer :: ( ((0 <= lk#79#655) && (lk#79#655 < Seq#Length(Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#655) < Heap_$_1[r#66_$_0,AVLTreeNode.key]) ));
	if ($_$_condition_$97) { goto anon791_Then; } else { goto anon791_Else; }
anon790_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$98) { goto anon791_Then; } else { goto anon791_Else; }
anon816_Then:
	assume !CanRead(Mask_$_41,SecMask_$_123,r#66_$_0,AVLTreeNode.valid);
	assume oldVers#_2264_$_0 == Heap_$_1[r#66_$_0,AVLTreeNode.valid];
	assume Heap_$_2 == Heap_$_1[r#66_$_0,AVLTreeNode.valid := newVers#_2265_$_0];
	assume oldVers#_2264_$_0 < Heap_$_2[r#66_$_0,AVLTreeNode.valid];
	assume Heap_$_3 == Heap_$_2;
	goto anon224;
anon816_Else:
	assume CanRead(Mask_$_41,SecMask_$_123,r#66_$_0,AVLTreeNode.valid);
	assume Heap_$_3 == Heap_$_1;
	goto anon224;
anon791_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$99) { goto anon792_Then; } else { goto anon792_Else; }
anon791_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$100) { goto anon792_Then; } else { goto anon792_Else; }
anon792_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#656 : Integer :: ( ((0 <= rk#80#656) && (rk#80#656 < Seq#Length(Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[r#66_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#656)) ));
	if ($_$_condition_$101) { goto anon793_Then; } else { goto anon793_Else; }
anon792_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	if ($_$_condition_$102) { goto anon793_Then; } else { goto anon793_Else; }
anon793_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon177;
anon793_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	goto anon177;
anon177:
	assume Seq#Equal(Heap_$_1[r#66_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_1[r#66_$_0,AVLTreeNode.key])),ite(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_1[r#66_$_0,AVLTreeNode.keys],Heap_$_1[r#66_$_0,AVLTreeNode.key]);
	assume (forall  kk#81_$2 : Integer :: ( Seq#Contains(Heap_$_1[r#66_$_0,AVLTreeNode.keys],kk#81_$2) <==> ((((!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$2)) || ((!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$2))) || (kk#81_$2 == Heap_$_1[r#66_$_0,AVLTreeNode.key])) ));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.height] == ite(ite(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_1[r#66_$_0,AVLTreeNode.balanceFactor] == (ite(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_1[r#66_$_0,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_1[r#66_$_0,AVLTreeNode.height] > 0;
	assume SecMask_$_73 == SecMask_$_72[r#66_$_0,AVLTreeNode.key := SecMask_$_72[r#66_$_0,AVLTreeNode.key][perm$R := SecMask_$_72[r#66_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$103) { goto anon794_Then; } else { goto anon794_Else; }
anon794_Then:
	assume SecMask_$_73[r#66_$_0,AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_74 == SecMask_$_73[r#66_$_0,AVLTreeNode.key := SecMask_$_73[r#66_$_0,AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_75 == SecMask_$_74;
	goto anon179;
anon794_Else:
	assume 0 <= SecMask_$_73[r#66_$_0,AVLTreeNode.key][perm$R];
	assume SecMask_$_75 == SecMask_$_73;
	goto anon179;
anon179:
	assume wf(Heap_$_1,SecMask_$_75,SecMask_$_75);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_75);
	assume SecMask_$_76 == SecMask_$_75[r#66_$_0,AVLTreeNode.height := SecMask_$_75[r#66_$_0,AVLTreeNode.height][perm$R := SecMask_$_75[r#66_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$104) { goto anon795_Then; } else { goto anon795_Else; }
anon795_Then:
	assume SecMask_$_76[r#66_$_0,AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_77 == SecMask_$_76[r#66_$_0,AVLTreeNode.height := SecMask_$_76[r#66_$_0,AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_78 == SecMask_$_77;
	goto anon181;
anon795_Else:
	assume 0 <= SecMask_$_76[r#66_$_0,AVLTreeNode.height][perm$R];
	assume SecMask_$_78 == SecMask_$_76;
	goto anon181;
anon181:
	assume wf(Heap_$_1,SecMask_$_78,SecMask_$_78);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_78);
	assume SecMask_$_79 == SecMask_$_78[r#66_$_0,AVLTreeNode.left := SecMask_$_78[r#66_$_0,AVLTreeNode.left][perm$R := SecMask_$_78[r#66_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$105) { goto anon796_Then; } else { goto anon796_Else; }
anon796_Then:
	assume SecMask_$_79[r#66_$_0,AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_80 == SecMask_$_79[r#66_$_0,AVLTreeNode.left := SecMask_$_79[r#66_$_0,AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_81 == SecMask_$_80;
	goto anon183;
anon796_Else:
	assume 0 <= SecMask_$_79[r#66_$_0,AVLTreeNode.left][perm$R];
	assume SecMask_$_81 == SecMask_$_79;
	goto anon183;
anon183:
	assume wf(Heap_$_1,SecMask_$_81,SecMask_$_81);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_81);
	assume SecMask_$_82 == SecMask_$_81[r#66_$_0,AVLTreeNode.right := SecMask_$_81[r#66_$_0,AVLTreeNode.right][perm$R := SecMask_$_81[r#66_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$106) { goto anon797_Then; } else { goto anon797_Else; }
anon797_Then:
	assume SecMask_$_82[r#66_$_0,AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_83 == SecMask_$_82[r#66_$_0,AVLTreeNode.right := SecMask_$_82[r#66_$_0,AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_84 == SecMask_$_83;
	goto anon185;
anon797_Else:
	assume 0 <= SecMask_$_82[r#66_$_0,AVLTreeNode.right][perm$R];
	assume SecMask_$_84 == SecMask_$_82;
	goto anon185;
anon185:
	assume wf(Heap_$_1,SecMask_$_84,SecMask_$_84);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_84);
	assume SecMask_$_85 == SecMask_$_84[r#66_$_0,AVLTreeNode.keys := SecMask_$_84[r#66_$_0,AVLTreeNode.keys][perm$R := SecMask_$_84[r#66_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$107) { goto anon798_Then; } else { goto anon798_Else; }
anon798_Then:
	assume SecMask_$_85[r#66_$_0,AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_86 == SecMask_$_85[r#66_$_0,AVLTreeNode.keys := SecMask_$_85[r#66_$_0,AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_87 == SecMask_$_86;
	goto anon187;
anon798_Else:
	assume 0 <= SecMask_$_85[r#66_$_0,AVLTreeNode.keys][perm$R];
	assume SecMask_$_87 == SecMask_$_85;
	goto anon187;
anon187:
	assume wf(Heap_$_1,SecMask_$_87,SecMask_$_87);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_87);
	assume SecMask_$_88 == SecMask_$_87[r#66_$_0,AVLTreeNode.balanceFactor := SecMask_$_87[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := SecMask_$_87[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$108) { goto anon799_Then; } else { goto anon799_Else; }
anon799_Then:
	assume SecMask_$_88[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_89 == SecMask_$_88[r#66_$_0,AVLTreeNode.balanceFactor := SecMask_$_88[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_90 == SecMask_$_89;
	goto anon189;
anon799_Else:
	assume 0 <= SecMask_$_88[r#66_$_0,AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_90 == SecMask_$_88;
	goto anon189;
anon189:
	assume wf(Heap_$_1,SecMask_$_90,SecMask_$_90);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_90);
	if ($_$_condition_$109) { goto anon800_Then; } else { goto anon800_Else; }
anon800_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_91 == SecMask_$_90[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_90[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_90[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$110) { goto anon801_Then; } else { goto anon801_Else; }
anon800_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_94 == SecMask_$_90;
	if ($_$_condition_$111) { goto anon802_Then; } else { goto anon802_Else; }
anon801_Then:
	assume SecMask_$_91[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_92 == SecMask_$_91[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_91[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_93 == SecMask_$_92;
	goto anon192;
anon801_Else:
	assume 0 <= SecMask_$_91[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_93 == SecMask_$_91;
	goto anon192;
anon802_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_95 == SecMask_$_94[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_94[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_94[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$113) { goto anon803_Then; } else { goto anon803_Else; }
anon802_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_98 == SecMask_$_94;
	if ($_$_condition_$114) { goto anon804_Then; } else { goto anon804_Else; }
anon192:
	assume wf(Heap_$_1,SecMask_$_93,SecMask_$_93);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_93);
	assume SecMask_$_94 == SecMask_$_93;
	if ($_$_condition_$112) { goto anon802_Then; } else { goto anon802_Else; }
anon803_Then:
	assume SecMask_$_95[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_96 == SecMask_$_95[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_95[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_97 == SecMask_$_96;
	goto anon196;
anon803_Else:
	assume 0 <= SecMask_$_95[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_97 == SecMask_$_95;
	goto anon196;
anon804_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_99 == SecMask_$_98[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_98[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_98[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$116) { goto anon805_Then; } else { goto anon805_Else; }
anon804_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_102 == SecMask_$_98;
	if ($_$_condition_$117) { goto anon806_Then; } else { goto anon806_Else; }
anon196:
	assume wf(Heap_$_1,SecMask_$_97,SecMask_$_97);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_97);
	assume SecMask_$_98 == SecMask_$_97;
	if ($_$_condition_$115) { goto anon804_Then; } else { goto anon804_Else; }
anon805_Then:
	assume SecMask_$_99[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_100 == SecMask_$_99[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_99[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_101 == SecMask_$_100;
	goto anon200;
anon805_Else:
	assume 0 <= SecMask_$_99[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_101 == SecMask_$_99;
	goto anon200;
anon806_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_103 == SecMask_$_102[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_102[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_102[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$119) { goto anon807_Then; } else { goto anon807_Else; }
anon806_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_106 == SecMask_$_102;
	if ($_$_condition_$120) { goto anon808_Then; } else { goto anon808_Else; }
anon200:
	assume wf(Heap_$_1,SecMask_$_101,SecMask_$_101);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_101);
	assume SecMask_$_102 == SecMask_$_101;
	if ($_$_condition_$118) { goto anon806_Then; } else { goto anon806_Else; }
anon807_Then:
	assume SecMask_$_103[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_104 == SecMask_$_103[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_103[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_105 == SecMask_$_104;
	goto anon204;
anon807_Else:
	assume 0 <= SecMask_$_103[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_105 == SecMask_$_103;
	goto anon204;
anon808_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_107 == SecMask_$_106[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_106[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_106[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$122) { goto anon809_Then; } else { goto anon809_Else; }
anon808_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_110 == SecMask_$_106;
	if ($_$_condition_$123) { goto anon810_Then; } else { goto anon810_Else; }
anon204:
	assume wf(Heap_$_1,SecMask_$_105,SecMask_$_105);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_105);
	assume SecMask_$_106 == SecMask_$_105;
	if ($_$_condition_$121) { goto anon808_Then; } else { goto anon808_Else; }
anon809_Then:
	assume SecMask_$_107[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_108 == SecMask_$_107[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_107[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_109 == SecMask_$_108;
	goto anon208;
anon809_Else:
	assume 0 <= SecMask_$_107[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_109 == SecMask_$_107;
	goto anon208;
anon810_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_111 == SecMask_$_110[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_110[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_110[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$125) { goto anon811_Then; } else { goto anon811_Else; }
anon810_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_114 == SecMask_$_110;
	if ($_$_condition_$126) { goto anon812_Then; } else { goto anon812_Else; }
anon208:
	assume wf(Heap_$_1,SecMask_$_109,SecMask_$_109);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_109);
	assume SecMask_$_110 == SecMask_$_109;
	if ($_$_condition_$124) { goto anon810_Then; } else { goto anon810_Else; }
anon811_Then:
	assume SecMask_$_111[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_112 == SecMask_$_111[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_111[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_113 == SecMask_$_112;
	goto anon212;
anon811_Else:
	assume 0 <= SecMask_$_111[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_113 == SecMask_$_111;
	goto anon212;
anon812_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_115 == SecMask_$_114[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_114[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_114[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$128) { goto anon813_Then; } else { goto anon813_Else; }
anon812_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_118 == SecMask_$_114;
	if ($_$_condition_$129) { goto anon814_Then; } else { goto anon814_Else; }
anon212:
	assume wf(Heap_$_1,SecMask_$_113,SecMask_$_113);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_113);
	assume SecMask_$_114 == SecMask_$_113;
	if ($_$_condition_$127) { goto anon812_Then; } else { goto anon812_Else; }
anon813_Then:
	assume SecMask_$_115[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_116 == SecMask_$_115[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_115[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_117 == SecMask_$_116;
	goto anon216;
anon813_Else:
	assume 0 <= SecMask_$_115[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_117 == SecMask_$_115;
	goto anon216;
anon814_Then:
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_119 == SecMask_$_118[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_118[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_118[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$131) { goto anon815_Then; } else { goto anon815_Else; }
anon814_Else:
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_122 == SecMask_$_118;
	goto anon221;
anon216:
	assume wf(Heap_$_1,SecMask_$_117,SecMask_$_117);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_117);
	assume SecMask_$_118 == SecMask_$_117;
	if ($_$_condition_$130) { goto anon814_Then; } else { goto anon814_Else; }
anon815_Then:
	assume SecMask_$_119[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_120 == SecMask_$_119[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_119[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_121 == SecMask_$_120;
	goto anon220;
anon815_Else:
	assume 0 <= SecMask_$_119[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_121 == SecMask_$_119;
	goto anon220;
anon221:
	assume wf(Heap_$_1,SecMask_$_122,SecMask_$_122);
	assume SecMask_$_123 == SecMask_$_122;
	if ($_$_condition_$132) { goto anon816_Then; } else { goto anon816_Else; }
anon220:
	assume wf(Heap_$_1,SecMask_$_121,SecMask_$_121);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_121);
	assume SecMask_$_122 == SecMask_$_121;
	goto anon221;
anon224:
	assume IsGoodMask(Mask_$_41);
	assume wf(Heap_$_3,Mask_$_41,SecMask_$_123);
	assume IsGoodMask(Mask_$_41);
	assume wf(Heap_$_3,Mask_$_41,SecMask_$_123);
	assume !(r#66_$_0 == null);
	assume wf(Heap_$_3,Mask_$_41,SecMask_$_123);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_42 == Mask_$_41[r#66_$_0,AVLTreeNode.key := Mask_$_41[r#66_$_0,AVLTreeNode.key][perm$R := Mask_$_41[r#66_$_0,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_42);
	assume IsGoodState(heapFragment(Heap_$_3[r#66_$_0,AVLTreeNode.key]));
	assume wf(Heap_$_3,Mask_$_42,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_42,SecMask_$_123);
	assume !(r#66_$_0 == null);
	assume wf(Heap_$_3,Mask_$_42,SecMask_$_123);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_43 == Mask_$_42[r#66_$_0,AVLTreeNode.height := Mask_$_42[r#66_$_0,AVLTreeNode.height][perm$R := Mask_$_42[r#66_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_43);
	assume IsGoodState(heapFragment(Heap_$_3[r#66_$_0,AVLTreeNode.height]));
	assume wf(Heap_$_3,Mask_$_43,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_43,SecMask_$_123);
	assume !(r#66_$_0 == null);
	assume wf(Heap_$_3,Mask_$_43,SecMask_$_123);
	assume (Heap_$_3[r#66_$_0,AVLTreeNode.left] == null) || (dtype(Heap_$_3[r#66_$_0,AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_44 == Mask_$_43[r#66_$_0,AVLTreeNode.left := Mask_$_43[r#66_$_0,AVLTreeNode.left][perm$R := Mask_$_43[r#66_$_0,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_44);
	assume IsGoodState(heapFragment(Heap_$_3[r#66_$_0,AVLTreeNode.left]));
	assume wf(Heap_$_3,Mask_$_44,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_44,SecMask_$_123);
	assume !(r#66_$_0 == null);
	assume wf(Heap_$_3,Mask_$_44,SecMask_$_123);
	assume (Heap_$_3[r#66_$_0,AVLTreeNode.right] == null) || (dtype(Heap_$_3[r#66_$_0,AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_45 == Mask_$_44[r#66_$_0,AVLTreeNode.right := Mask_$_44[r#66_$_0,AVLTreeNode.right][perm$R := Mask_$_44[r#66_$_0,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_45);
	assume IsGoodState(heapFragment(Heap_$_3[r#66_$_0,AVLTreeNode.right]));
	assume wf(Heap_$_3,Mask_$_45,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_45,SecMask_$_123);
	assume !(r#66_$_0 == null);
	assume wf(Heap_$_3,Mask_$_45,SecMask_$_123);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_46 == Mask_$_45[r#66_$_0,AVLTreeNode.keys := Mask_$_45[r#66_$_0,AVLTreeNode.keys][perm$R := Mask_$_45[r#66_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_46);
	assume IsGoodState(heapFragment(Heap_$_3[r#66_$_0,AVLTreeNode.keys]));
	assume wf(Heap_$_3,Mask_$_46,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_46,SecMask_$_123);
	assume !(r#66_$_0 == null);
	assume wf(Heap_$_3,Mask_$_46,SecMask_$_123);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_47 == Mask_$_46[r#66_$_0,AVLTreeNode.balanceFactor := Mask_$_46[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_46[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_47);
	assume IsGoodState(heapFragment(Heap_$_3[r#66_$_0,AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_3,Mask_$_47,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_47,SecMask_$_123);
	if ($_$_condition_$133) { goto anon817_Then; } else { goto anon817_Else; }
anon817_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume wf(Heap_$_3,Mask_$_47,SecMask_$_123);
	assume Fractions(100) > 0;
	assume Mask_$_48 == Mask_$_47[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_47[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_47[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_48);
	assume IsGoodState(heapFragment(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap_$_3,Mask_$_48,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_48,SecMask_$_123);
	assume Mask_$_49 == Mask_$_48;
	if ($_$_condition_$134) { goto anon818_Then; } else { goto anon818_Else; }
anon817_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	assume Mask_$_49 == Mask_$_47;
	if ($_$_condition_$135) { goto anon818_Then; } else { goto anon818_Else; }
anon818_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume wf(Heap_$_3,Mask_$_49,SecMask_$_123);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_50 == Mask_$_49[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := Mask_$_49[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_49[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_50);
	assume IsGoodState(heapFragment(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap_$_3,Mask_$_50,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_50,SecMask_$_123);
	assume Mask_$_51 == Mask_$_50;
	if ($_$_condition_$136) { goto anon819_Then; } else { goto anon819_Else; }
anon818_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	assume Mask_$_51 == Mask_$_49;
	if ($_$_condition_$137) { goto anon819_Then; } else { goto anon819_Else; }
anon819_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume wf(Heap_$_3,Mask_$_51,SecMask_$_123);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_52 == Mask_$_51[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := Mask_$_51[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := Mask_$_51[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_52);
	assume IsGoodState(heapFragment(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap_$_3,Mask_$_52,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_52,SecMask_$_123);
	assume Mask_$_53 == Mask_$_52;
	if ($_$_condition_$138) { goto anon820_Then; } else { goto anon820_Else; }
anon819_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	assume Mask_$_53 == Mask_$_51;
	if ($_$_condition_$139) { goto anon820_Then; } else { goto anon820_Else; }
anon820_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume wf(Heap_$_3,Mask_$_53,SecMask_$_123);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_54 == Mask_$_53[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := Mask_$_53[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := Mask_$_53[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_54);
	assume IsGoodState(heapFragment(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_3,Mask_$_54,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_54,SecMask_$_123);
	assume Mask_$_55 == Mask_$_54;
	if ($_$_condition_$140) { goto anon821_Then; } else { goto anon821_Else; }
anon820_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	assume Mask_$_55 == Mask_$_53;
	if ($_$_condition_$141) { goto anon821_Then; } else { goto anon821_Else; }
anon821_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#659 : Integer :: ( ((0 <= lk#79#659) && (lk#79#659 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#659) < Heap_$_3[r#66_$_0,AVLTreeNode.key]) ));
	if ($_$_condition_$142) { goto anon822_Then; } else { goto anon822_Else; }
anon821_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$143) { goto anon822_Then; } else { goto anon822_Else; }
anon822_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$144) { goto anon823_Then; } else { goto anon823_Else; }
anon822_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$145) { goto anon823_Then; } else { goto anon823_Else; }
anon823_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume wf(Heap_$_3,Mask_$_55,SecMask_$_123);
	assume Fractions(100) > 0;
	assume Mask_$_56 == Mask_$_55[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_55[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_55[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_56);
	assume IsGoodState(heapFragment(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap_$_3,Mask_$_56,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_56,SecMask_$_123);
	assume Mask_$_57 == Mask_$_56;
	if ($_$_condition_$146) { goto anon824_Then; } else { goto anon824_Else; }
anon823_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	assume Mask_$_57 == Mask_$_55;
	if ($_$_condition_$147) { goto anon824_Then; } else { goto anon824_Else; }
anon824_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume wf(Heap_$_3,Mask_$_57,SecMask_$_123);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_58 == Mask_$_57[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := Mask_$_57[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_57[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_58);
	assume IsGoodState(heapFragment(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap_$_3,Mask_$_58,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_58,SecMask_$_123);
	assume Mask_$_59 == Mask_$_58;
	if ($_$_condition_$148) { goto anon825_Then; } else { goto anon825_Else; }
anon824_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	assume Mask_$_59 == Mask_$_57;
	if ($_$_condition_$149) { goto anon825_Then; } else { goto anon825_Else; }
anon825_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume wf(Heap_$_3,Mask_$_59,SecMask_$_123);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_60 == Mask_$_59[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := Mask_$_59[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := Mask_$_59[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_60);
	assume IsGoodState(heapFragment(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap_$_3,Mask_$_60,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_60,SecMask_$_123);
	assume Mask_$_61 == Mask_$_60;
	if ($_$_condition_$150) { goto anon826_Then; } else { goto anon826_Else; }
anon825_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	assume Mask_$_61 == Mask_$_59;
	if ($_$_condition_$151) { goto anon826_Then; } else { goto anon826_Else; }
anon826_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume wf(Heap_$_3,Mask_$_61,SecMask_$_123);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_62 == Mask_$_61[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := Mask_$_61[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := Mask_$_61[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_62);
	assume IsGoodState(heapFragment(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_3,Mask_$_62,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_62,SecMask_$_123);
	assume Mask_$_63 == Mask_$_62;
	if ($_$_condition_$152) { goto anon827_Then; } else { goto anon827_Else; }
anon826_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	assume Mask_$_63 == Mask_$_61;
	if ($_$_condition_$153) { goto anon827_Then; } else { goto anon827_Else; }
anon827_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#660 : Integer :: ( ((0 <= rk#80#660) && (rk#80#660 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_3[r#66_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#660)) ));
	if ($_$_condition_$154) { goto anon828_Then; } else { goto anon828_Else; }
anon827_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	if ($_$_condition_$155) { goto anon828_Then; } else { goto anon828_Else; }
anon828_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon248;
anon828_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	goto anon248;
anon248:
	assume Seq#Equal(Heap_$_3[r#66_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_3[r#66_$_0,AVLTreeNode.key])),ite(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_3[r#66_$_0,AVLTreeNode.keys],Heap_$_3[r#66_$_0,AVLTreeNode.key]);
	assume (forall  kk#81_$3 : Integer :: ( Seq#Contains(Heap_$_3[r#66_$_0,AVLTreeNode.keys],kk#81_$3) <==> ((((!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$3)) || ((!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$3))) || (kk#81_$3 == Heap_$_3[r#66_$_0,AVLTreeNode.key])) ));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.height] == ite(ite(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_3[r#66_$_0,AVLTreeNode.balanceFactor] == (ite(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_3[r#66_$_0,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_3[r#66_$_0,AVLTreeNode.height] > 0;
	assume IsGoodMask(Mask_$_63);
	assume wf(Heap_$_3,Mask_$_63,SecMask_$_123);
	assume wf(Heap_$_3,Mask_$_63,SecMask_$_123);
	assert { :msg "  685.10: Receiver might be null." } true ==> (!(r#66_$_0 == null));
	assert { :msg "  685.10: Location might not be readable." } true ==> CanRead(Mask_$_63,SecMask_$_123,r#66_$_0,AVLTreeNode.right);
	if ($_$_condition_$156) { goto anon829_Then; } else { goto anon829_Else; }
anon829_Then:
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assert { :msg "  685.10: Receiver might be null." } (true && (0 <= k#100#662)) ==> (!(r#66_$_0 == null));
	assert { :msg "  685.10: Location might not be readable." } (true && (0 <= k#100#662)) ==> CanRead(Mask_$_63,SecMask_$_123,r#66_$_0,AVLTreeNode.right);
	assert { :msg "  685.10: Receiver might be null." } (true && (0 <= k#100#662)) ==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
	assert { :msg "  685.10: Location might not be readable." } (true && (0 <= k#100#662)) ==> CanRead(Mask_$_63,SecMask_$_123,Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys);
	assert { :msg "  685.10: Receiver might be null." } ((true && (0 <= k#100#662)) && (k#100#662 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (!(r#66_$_0 == null));
	assert { :msg "  685.10: Location might not be readable." } ((true && (0 <= k#100#662)) && (k#100#662 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> CanRead(Mask_$_63,SecMask_$_123,r#66_$_0,AVLTreeNode.right);
	assert { :msg "  685.10: Receiver might be null." } ((true && (0 <= k#100#662)) && (k#100#662 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
	assert { :msg "  685.10: Location might not be readable." } ((true && (0 <= k#100#662)) && (k#100#662 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> CanRead(Mask_$_63,SecMask_$_123,Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys);
	assert { :msg "  685.56: Sequence index might be negative." } ((true && (0 <= k#100#662)) && (k#100#662 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (0 <= k#100#662);
	assert { :msg "  685.56: Sequence index might be larger than or equal to the length of the sequence." } ((true && (0 <= k#100#662)) && (k#100#662 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (k#100#662 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]));
	assert { :msg "  685.60: Receiver might be null." } ((true && (0 <= k#100#662)) && (k#100#662 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (!(this == null));
	assert { :msg "  685.60: Location might not be readable." } ((true && (0 <= k#100#662)) && (k#100#662 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> CanRead(Mask_$_63,SecMask_$_123,this,AVLTreeNode.key);
	assert { :msg "  685.3: Assertion might not hold. The expression at 685.28 might not evaluate to true." } (forall  k#100#661 : Integer :: ( ((0 <= k#100#661) && (k#100#661 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],k#100#661) < Heap_$_3[this,AVLTreeNode.key]) ));
	goto anon250;
anon829_Else:
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	goto anon250;
anon250:
	assume IsGoodExhaleState(exhaleHeap#_2270_$_0,Heap_$_3,Mask_$_63,SecMask_$_123);
	assume IsGoodMask(Mask_$_63);
	assume wf(exhaleHeap#_2270_$_0,Mask_$_63,SecMask_$_123);
	assert { :msg "  687.3: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  687.3: Location might not be readable." } true ==> CanRead(Mask_$_63,SecMask_$_123,this,AVLTreeNode.left);
	assert { :msg "  687.3: Location might not be writable" } CanWrite(Mask_$_63,Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.right);
	assert { :msg "  687.17: Receiver might be null." } true ==> (!(r#66_$_0 == null));
	assert { :msg "  687.17: Location might not be readable." } true ==> CanRead(Mask_$_63,SecMask_$_123,r#66_$_0,AVLTreeNode.left);
	assume Heap_$_4 == Heap_$_3[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.right := Heap_$_3[r#66_$_0,AVLTreeNode.left]];
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_123);
	assume ((0 < methodCallK#_2276) && ((1000 * methodCallK#_2276) < Fractions(1))) && ((1000 * methodCallK#_2276) < methodK#_2144);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_123);
	assert { :msg "  688.8: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  688.8: Location might not be readable." } true ==> CanRead(Mask_$_63,SecMask_$_123,this,AVLTreeNode.left);
	assert { :msg "  688.3: The target of the method call might be null." } !(Heap_$_4[this,AVLTreeNode.left] == null);
	assume this#664_$_0 == Heap_$_4[this,AVLTreeNode.left];
	if ($_$_condition_$157) { goto anon830_Then; } else { goto anon830_Else; }
anon830_Then:
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null);
	assert { :msg "  688.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#665 : Integer :: ( ((0 <= k#92#665) && (k#92#665 < Seq#Length(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys],k#92#665) < Heap_$_4[this#664_$_0,AVLTreeNode.key]) ));
	if ($_$_condition_$158) { goto anon831_Then; } else { goto anon831_Else; }
anon830_Else:
	assume Heap_$_4[this#664_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$159) { goto anon831_Then; } else { goto anon831_Else; }
anon831_Then:
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null);
	assert { :msg "  688.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#666 : Integer :: ( ((0 <= k#93#666) && (k#93#666 < Seq#Length(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_4[this#664_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys],k#93#666)) ));
	goto anon254;
anon831_Else:
	assume Heap_$_4[this#664_$_0,AVLTreeNode.right] == null;
	goto anon254;
anon254:
	assert { :msg "  688.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  688.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  688.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  688.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_63[this#664_$_0,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_63[this#664_$_0,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_63[this#664_$_0,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_2278_$_0 == Mask_$_63[this#664_$_0,AVLTreeNode.key := Mask_$_63[this#664_$_0,AVLTreeNode.key][perm$R := Mask_$_63[this#664_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2278_$_0);
	assume wf(Heap_$_4,exhaleMask#_2278_$_0,SecMask_$_123);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_123);
	assert { :msg "  688.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  688.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_2278_$_0[this#664_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_2278_$_0[this#664_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2278_$_0[this#664_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2278_$_1 == exhaleMask#_2278_$_0[this#664_$_0,AVLTreeNode.height := exhaleMask#_2278_$_0[this#664_$_0,AVLTreeNode.height][perm$R := exhaleMask#_2278_$_0[this#664_$_0,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2278_$_1);
	assume wf(Heap_$_4,exhaleMask#_2278_$_1,SecMask_$_123);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_123);
	assert { :msg "  688.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  688.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_2278_$_1[this#664_$_0,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_2278_$_1[this#664_$_0,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_2278_$_1[this#664_$_0,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_2278_$_2 == exhaleMask#_2278_$_1[this#664_$_0,AVLTreeNode.left := exhaleMask#_2278_$_1[this#664_$_0,AVLTreeNode.left][perm$R := exhaleMask#_2278_$_1[this#664_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2278_$_2);
	assume wf(Heap_$_4,exhaleMask#_2278_$_2,SecMask_$_123);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_123);
	assert { :msg "  688.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  688.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_2278_$_2[this#664_$_0,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_2278_$_2[this#664_$_0,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_2278_$_2[this#664_$_0,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_2278_$_3 == exhaleMask#_2278_$_2[this#664_$_0,AVLTreeNode.right := exhaleMask#_2278_$_2[this#664_$_0,AVLTreeNode.right][perm$R := exhaleMask#_2278_$_2[this#664_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2278_$_3);
	assume wf(Heap_$_4,exhaleMask#_2278_$_3,SecMask_$_123);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_123);
	assert { :msg "  688.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  688.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_2278_$_3[this#664_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_2278_$_3[this#664_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2278_$_3[this#664_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2278_$_4 == exhaleMask#_2278_$_3[this#664_$_0,AVLTreeNode.keys := exhaleMask#_2278_$_3[this#664_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_2278_$_3[this#664_$_0,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2278_$_4);
	assume wf(Heap_$_4,exhaleMask#_2278_$_4,SecMask_$_123);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_123);
	assert { :msg "  688.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  688.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_2278_$_4[this#664_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_2278_$_4[this#664_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2278_$_4[this#664_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2278_$_5 == exhaleMask#_2278_$_4[this#664_$_0,AVLTreeNode.balanceFactor := exhaleMask#_2278_$_4[this#664_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2278_$_4[this#664_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2278_$_5);
	assume wf(Heap_$_4,exhaleMask#_2278_$_5,SecMask_$_123);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_123);
	if ($_$_condition_$160) { goto anon832_Then; } else { goto anon832_Else; }
anon832_Then:
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null);
	assert { :msg "  688.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  688.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2278_$_6 == exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$161) { goto anon833_Then; } else { goto anon833_Else; }
anon832_Else:
	assume Heap_$_4[this#664_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_175 == SecMask_$_123;
	assume exhaleMask#_2278_$_7 == exhaleMask#_2278_$_5;
	if ($_$_condition_$162) { goto anon861_Then; } else { goto anon861_Else; }
anon833_Then:
	assume false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$163) { goto anon834_Then; } else { goto anon834_Else; }
anon833_Else:
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_174 == SecMask_$_123;
	if ($_$_condition_$164) { goto anon860_Then; } else { goto anon860_Else; }
anon861_Then:
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null);
	assert { :msg "  688.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2278_$_8 == exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_8);
	assume wf(Heap_$_4,exhaleMask#_2278_$_8,SecMask_$_175);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_175);
	assume exhaleMask#_2278_$_9 == exhaleMask#_2278_$_8;
	if ($_$_condition_$202) { goto anon862_Then; } else { goto anon862_Else; }
anon861_Else:
	assume Heap_$_4[this#664_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2278_$_9 == exhaleMask#_2278_$_7;
	if ($_$_condition_$203) { goto anon862_Then; } else { goto anon862_Else; }
anon834_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#667 : Integer :: ( ((0 <= lk#79#667) && (lk#79#667 < Seq#Length(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#667) < Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key]) ));
	if ($_$_condition_$165) { goto anon835_Then; } else { goto anon835_Else; }
anon834_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$166) { goto anon835_Then; } else { goto anon835_Else; }
anon860_Then:
	assume !CanRead(exhaleMask#_2278_$_6,SecMask_$_174,Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_2277_$_0[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon311;
anon860_Else:
	assume CanRead(exhaleMask#_2278_$_6,SecMask_$_174,Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon311;
anon835_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$167) { goto anon836_Then; } else { goto anon836_Else; }
anon835_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$168) { goto anon836_Then; } else { goto anon836_Else; }
anon836_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#668 : Integer :: ( ((0 <= rk#80#668) && (rk#80#668 < Seq#Length(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#668)) ));
	if ($_$_condition_$169) { goto anon837_Then; } else { goto anon837_Else; }
anon836_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	if ($_$_condition_$170) { goto anon837_Then; } else { goto anon837_Else; }
anon837_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon264;
anon837_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon264;
anon264:
	assume Seq#Equal(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key])),ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys],Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$4 : Integer :: ( Seq#Contains(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$4) <==> ((((!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$4)) || ((!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$4))) || (kk#81_$4 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_124 == SecMask_$_123[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_123[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_123[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$171) { goto anon838_Then; } else { goto anon838_Else; }
anon838_Then:
	assume SecMask_$_124[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_125 == SecMask_$_124[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_124[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_126 == SecMask_$_125;
	goto anon266;
anon838_Else:
	assume 0 <= SecMask_$_124[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_126 == SecMask_$_124;
	goto anon266;
anon266:
	assume wf(Heap_$_4,SecMask_$_126,SecMask_$_126);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_126);
	assume SecMask_$_127 == SecMask_$_126[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_126[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_126[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$172) { goto anon839_Then; } else { goto anon839_Else; }
anon839_Then:
	assume SecMask_$_127[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_128 == SecMask_$_127[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_127[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_129 == SecMask_$_128;
	goto anon268;
anon839_Else:
	assume 0 <= SecMask_$_127[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_129 == SecMask_$_127;
	goto anon268;
anon268:
	assume wf(Heap_$_4,SecMask_$_129,SecMask_$_129);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_129);
	assume SecMask_$_130 == SecMask_$_129[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_129[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_129[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$173) { goto anon840_Then; } else { goto anon840_Else; }
anon840_Then:
	assume SecMask_$_130[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_131 == SecMask_$_130[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_130[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_132 == SecMask_$_131;
	goto anon270;
anon840_Else:
	assume 0 <= SecMask_$_130[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_132 == SecMask_$_130;
	goto anon270;
anon270:
	assume wf(Heap_$_4,SecMask_$_132,SecMask_$_132);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_132);
	assume SecMask_$_133 == SecMask_$_132[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_132[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_132[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$174) { goto anon841_Then; } else { goto anon841_Else; }
anon841_Then:
	assume SecMask_$_133[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_134 == SecMask_$_133[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_133[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_135 == SecMask_$_134;
	goto anon272;
anon841_Else:
	assume 0 <= SecMask_$_133[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_135 == SecMask_$_133;
	goto anon272;
anon272:
	assume wf(Heap_$_4,SecMask_$_135,SecMask_$_135);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_135);
	assume SecMask_$_136 == SecMask_$_135[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_135[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_135[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$175) { goto anon842_Then; } else { goto anon842_Else; }
anon842_Then:
	assume SecMask_$_136[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_137 == SecMask_$_136[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_136[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_138 == SecMask_$_137;
	goto anon274;
anon842_Else:
	assume 0 <= SecMask_$_136[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_138 == SecMask_$_136;
	goto anon274;
anon274:
	assume wf(Heap_$_4,SecMask_$_138,SecMask_$_138);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_138);
	assume SecMask_$_139 == SecMask_$_138[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_138[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_138[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$176) { goto anon843_Then; } else { goto anon843_Else; }
anon843_Then:
	assume SecMask_$_139[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_140 == SecMask_$_139[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_139[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_141 == SecMask_$_140;
	goto anon276;
anon843_Else:
	assume 0 <= SecMask_$_139[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_141 == SecMask_$_139;
	goto anon276;
anon276:
	assume wf(Heap_$_4,SecMask_$_141,SecMask_$_141);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_141);
	if ($_$_condition_$177) { goto anon844_Then; } else { goto anon844_Else; }
anon844_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_142 == SecMask_$_141[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_141[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_141[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$178) { goto anon845_Then; } else { goto anon845_Else; }
anon844_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_145 == SecMask_$_141;
	if ($_$_condition_$179) { goto anon846_Then; } else { goto anon846_Else; }
anon845_Then:
	assume SecMask_$_142[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_143 == SecMask_$_142[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_142[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_144 == SecMask_$_143;
	goto anon279;
anon845_Else:
	assume 0 <= SecMask_$_142[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_144 == SecMask_$_142;
	goto anon279;
anon846_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_146 == SecMask_$_145[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_145[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_145[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$181) { goto anon847_Then; } else { goto anon847_Else; }
anon846_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_149 == SecMask_$_145;
	if ($_$_condition_$182) { goto anon848_Then; } else { goto anon848_Else; }
anon279:
	assume wf(Heap_$_4,SecMask_$_144,SecMask_$_144);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_144);
	assume SecMask_$_145 == SecMask_$_144;
	if ($_$_condition_$180) { goto anon846_Then; } else { goto anon846_Else; }
anon847_Then:
	assume SecMask_$_146[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_147 == SecMask_$_146[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_146[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_148 == SecMask_$_147;
	goto anon283;
anon847_Else:
	assume 0 <= SecMask_$_146[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_148 == SecMask_$_146;
	goto anon283;
anon848_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_150 == SecMask_$_149[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_149[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_149[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$184) { goto anon849_Then; } else { goto anon849_Else; }
anon848_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_153 == SecMask_$_149;
	if ($_$_condition_$185) { goto anon850_Then; } else { goto anon850_Else; }
anon283:
	assume wf(Heap_$_4,SecMask_$_148,SecMask_$_148);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_148);
	assume SecMask_$_149 == SecMask_$_148;
	if ($_$_condition_$183) { goto anon848_Then; } else { goto anon848_Else; }
anon849_Then:
	assume SecMask_$_150[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_151 == SecMask_$_150[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_150[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_152 == SecMask_$_151;
	goto anon287;
anon849_Else:
	assume 0 <= SecMask_$_150[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_152 == SecMask_$_150;
	goto anon287;
anon850_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_154 == SecMask_$_153[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_153[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_153[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$187) { goto anon851_Then; } else { goto anon851_Else; }
anon850_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_157 == SecMask_$_153;
	if ($_$_condition_$188) { goto anon852_Then; } else { goto anon852_Else; }
anon287:
	assume wf(Heap_$_4,SecMask_$_152,SecMask_$_152);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_152);
	assume SecMask_$_153 == SecMask_$_152;
	if ($_$_condition_$186) { goto anon850_Then; } else { goto anon850_Else; }
anon851_Then:
	assume SecMask_$_154[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_155 == SecMask_$_154[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_154[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_156 == SecMask_$_155;
	goto anon291;
anon851_Else:
	assume 0 <= SecMask_$_154[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_156 == SecMask_$_154;
	goto anon291;
anon852_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_158 == SecMask_$_157[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_157[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_157[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$190) { goto anon853_Then; } else { goto anon853_Else; }
anon852_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_161 == SecMask_$_157;
	if ($_$_condition_$191) { goto anon854_Then; } else { goto anon854_Else; }
anon291:
	assume wf(Heap_$_4,SecMask_$_156,SecMask_$_156);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_156);
	assume SecMask_$_157 == SecMask_$_156;
	if ($_$_condition_$189) { goto anon852_Then; } else { goto anon852_Else; }
anon853_Then:
	assume SecMask_$_158[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_159 == SecMask_$_158[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_158[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_160 == SecMask_$_159;
	goto anon295;
anon853_Else:
	assume 0 <= SecMask_$_158[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_160 == SecMask_$_158;
	goto anon295;
anon854_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_162 == SecMask_$_161[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_161[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_161[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$193) { goto anon855_Then; } else { goto anon855_Else; }
anon854_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_165 == SecMask_$_161;
	if ($_$_condition_$194) { goto anon856_Then; } else { goto anon856_Else; }
anon295:
	assume wf(Heap_$_4,SecMask_$_160,SecMask_$_160);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_160);
	assume SecMask_$_161 == SecMask_$_160;
	if ($_$_condition_$192) { goto anon854_Then; } else { goto anon854_Else; }
anon855_Then:
	assume SecMask_$_162[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_163 == SecMask_$_162[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_162[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_164 == SecMask_$_163;
	goto anon299;
anon855_Else:
	assume 0 <= SecMask_$_162[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_164 == SecMask_$_162;
	goto anon299;
anon856_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_166 == SecMask_$_165[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_165[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_165[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$196) { goto anon857_Then; } else { goto anon857_Else; }
anon856_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_169 == SecMask_$_165;
	if ($_$_condition_$197) { goto anon858_Then; } else { goto anon858_Else; }
anon299:
	assume wf(Heap_$_4,SecMask_$_164,SecMask_$_164);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_164);
	assume SecMask_$_165 == SecMask_$_164;
	if ($_$_condition_$195) { goto anon856_Then; } else { goto anon856_Else; }
anon857_Then:
	assume SecMask_$_166[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_167 == SecMask_$_166[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_166[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_168 == SecMask_$_167;
	goto anon303;
anon857_Else:
	assume 0 <= SecMask_$_166[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_168 == SecMask_$_166;
	goto anon303;
anon858_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_170 == SecMask_$_169[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_169[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_169[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$199) { goto anon859_Then; } else { goto anon859_Else; }
anon858_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_173 == SecMask_$_169;
	goto anon308;
anon303:
	assume wf(Heap_$_4,SecMask_$_168,SecMask_$_168);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_168);
	assume SecMask_$_169 == SecMask_$_168;
	if ($_$_condition_$198) { goto anon858_Then; } else { goto anon858_Else; }
anon859_Then:
	assume SecMask_$_170[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_171 == SecMask_$_170[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_170[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_172 == SecMask_$_171;
	goto anon307;
anon859_Else:
	assume 0 <= SecMask_$_170[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_172 == SecMask_$_170;
	goto anon307;
anon308:
	assume wf(Heap_$_4,SecMask_$_173,SecMask_$_173);
	assume SecMask_$_174 == SecMask_$_173;
	if ($_$_condition_$200) { goto anon860_Then; } else { goto anon860_Else; }
anon307:
	assume wf(Heap_$_4,SecMask_$_172,SecMask_$_172);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_172);
	assume SecMask_$_173 == SecMask_$_172;
	goto anon308;
anon311:
	assume IsGoodMask(exhaleMask#_2278_$_6);
	assume wf(Heap_$_4,exhaleMask#_2278_$_6,SecMask_$_174);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_174);
	assume SecMask_$_175 == SecMask_$_174;
	assume exhaleMask#_2278_$_7 == exhaleMask#_2278_$_6;
	if ($_$_condition_$201) { goto anon861_Then; } else { goto anon861_Else; }
anon862_Then:
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null);
	assert { :msg "  688.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2278_$_10 == exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_10);
	assume wf(Heap_$_4,exhaleMask#_2278_$_10,SecMask_$_175);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_175);
	assume exhaleMask#_2278_$_11 == exhaleMask#_2278_$_10;
	if ($_$_condition_$204) { goto anon863_Then; } else { goto anon863_Else; }
anon862_Else:
	assume Heap_$_4[this#664_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2278_$_11 == exhaleMask#_2278_$_9;
	if ($_$_condition_$205) { goto anon863_Then; } else { goto anon863_Else; }
anon863_Then:
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null);
	assert { :msg "  688.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2278_$_12 == exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_12);
	assume wf(Heap_$_4,exhaleMask#_2278_$_12,SecMask_$_175);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_175);
	assume exhaleMask#_2278_$_13 == exhaleMask#_2278_$_12;
	if ($_$_condition_$206) { goto anon864_Then; } else { goto anon864_Else; }
anon863_Else:
	assume Heap_$_4[this#664_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2278_$_13 == exhaleMask#_2278_$_11;
	if ($_$_condition_$207) { goto anon864_Then; } else { goto anon864_Else; }
anon864_Then:
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null);
	assert { :msg "  688.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  688.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2278_$_14 == exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$208) { goto anon865_Then; } else { goto anon865_Else; }
anon864_Else:
	assume Heap_$_4[this#664_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2278_$_15 == exhaleMask#_2278_$_13;
	assume SecMask_$_227 == SecMask_$_175;
	if ($_$_condition_$209) { goto anon893_Then; } else { goto anon893_Else; }
anon865_Then:
	assume false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$210) { goto anon866_Then; } else { goto anon866_Else; }
anon865_Else:
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.right])) && true) && true));
	assume SecMask_$_226 == SecMask_$_175;
	if ($_$_condition_$211) { goto anon892_Then; } else { goto anon892_Else; }
anon893_Then:
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null);
	assert { :msg "  688.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2278_$_16 == exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_16);
	assume wf(Heap_$_4,exhaleMask#_2278_$_16,SecMask_$_227);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_227);
	assume exhaleMask#_2278_$_17 == exhaleMask#_2278_$_16;
	if ($_$_condition_$249) { goto anon894_Then; } else { goto anon894_Else; }
anon893_Else:
	assume Heap_$_4[this#664_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2278_$_17 == exhaleMask#_2278_$_15;
	if ($_$_condition_$250) { goto anon894_Then; } else { goto anon894_Else; }
anon866_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#672 : Integer :: ( ((0 <= lk#79#672) && (lk#79#672 < Seq#Length(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#672) < Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key]) ));
	if ($_$_condition_$212) { goto anon867_Then; } else { goto anon867_Else; }
anon866_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$213) { goto anon867_Then; } else { goto anon867_Else; }
anon892_Then:
	assume !CanRead(exhaleMask#_2278_$_14,SecMask_$_226,Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_2277_$_0[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon375;
anon892_Else:
	assume CanRead(exhaleMask#_2278_$_14,SecMask_$_226,Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon375;
anon867_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$214) { goto anon868_Then; } else { goto anon868_Else; }
anon867_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$215) { goto anon868_Then; } else { goto anon868_Else; }
anon868_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#673 : Integer :: ( ((0 <= rk#80#673) && (rk#80#673 < Seq#Length(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#673)) ));
	if ($_$_condition_$216) { goto anon869_Then; } else { goto anon869_Else; }
anon868_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	if ($_$_condition_$217) { goto anon869_Then; } else { goto anon869_Else; }
anon869_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon328;
anon869_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon328;
anon328:
	assume Seq#Equal(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key])),ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys],Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$5 : Integer :: ( Seq#Contains(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$5) <==> ((((!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$5)) || ((!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$5))) || (kk#81_$5 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume SecMask_$_176 == SecMask_$_175[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_175[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R := SecMask_$_175[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$218) { goto anon870_Then; } else { goto anon870_Else; }
anon870_Then:
	assume SecMask_$_176[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_177 == SecMask_$_176[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_176[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_178 == SecMask_$_177;
	goto anon330;
anon870_Else:
	assume 0 <= SecMask_$_176[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_178 == SecMask_$_176;
	goto anon330;
anon330:
	assume wf(Heap_$_4,SecMask_$_178,SecMask_$_178);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_178);
	assume SecMask_$_179 == SecMask_$_178[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_178[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_178[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$219) { goto anon871_Then; } else { goto anon871_Else; }
anon871_Then:
	assume SecMask_$_179[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_180 == SecMask_$_179[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_179[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_181 == SecMask_$_180;
	goto anon332;
anon871_Else:
	assume 0 <= SecMask_$_179[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_181 == SecMask_$_179;
	goto anon332;
anon332:
	assume wf(Heap_$_4,SecMask_$_181,SecMask_$_181);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_181);
	assume SecMask_$_182 == SecMask_$_181[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_181[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_181[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$220) { goto anon872_Then; } else { goto anon872_Else; }
anon872_Then:
	assume SecMask_$_182[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_183 == SecMask_$_182[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_182[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_184 == SecMask_$_183;
	goto anon334;
anon872_Else:
	assume 0 <= SecMask_$_182[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_184 == SecMask_$_182;
	goto anon334;
anon334:
	assume wf(Heap_$_4,SecMask_$_184,SecMask_$_184);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_184);
	assume SecMask_$_185 == SecMask_$_184[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_184[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_184[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$221) { goto anon873_Then; } else { goto anon873_Else; }
anon873_Then:
	assume SecMask_$_185[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_186 == SecMask_$_185[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_185[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_187 == SecMask_$_186;
	goto anon336;
anon873_Else:
	assume 0 <= SecMask_$_185[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_187 == SecMask_$_185;
	goto anon336;
anon336:
	assume wf(Heap_$_4,SecMask_$_187,SecMask_$_187);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_187);
	assume SecMask_$_188 == SecMask_$_187[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_187[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_187[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$222) { goto anon874_Then; } else { goto anon874_Else; }
anon874_Then:
	assume SecMask_$_188[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_189 == SecMask_$_188[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_188[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_190 == SecMask_$_189;
	goto anon338;
anon874_Else:
	assume 0 <= SecMask_$_188[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_190 == SecMask_$_188;
	goto anon338;
anon338:
	assume wf(Heap_$_4,SecMask_$_190,SecMask_$_190);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_190);
	assume SecMask_$_191 == SecMask_$_190[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_190[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_190[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$223) { goto anon875_Then; } else { goto anon875_Else; }
anon875_Then:
	assume SecMask_$_191[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_192 == SecMask_$_191[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_191[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_193 == SecMask_$_192;
	goto anon340;
anon875_Else:
	assume 0 <= SecMask_$_191[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_193 == SecMask_$_191;
	goto anon340;
anon340:
	assume wf(Heap_$_4,SecMask_$_193,SecMask_$_193);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_193);
	if ($_$_condition_$224) { goto anon876_Then; } else { goto anon876_Else; }
anon876_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_194 == SecMask_$_193[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_193[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_193[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$225) { goto anon877_Then; } else { goto anon877_Else; }
anon876_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_197 == SecMask_$_193;
	if ($_$_condition_$226) { goto anon878_Then; } else { goto anon878_Else; }
anon877_Then:
	assume SecMask_$_194[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_195 == SecMask_$_194[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_194[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_196 == SecMask_$_195;
	goto anon343;
anon877_Else:
	assume 0 <= SecMask_$_194[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_196 == SecMask_$_194;
	goto anon343;
anon878_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_198 == SecMask_$_197[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_197[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_197[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$228) { goto anon879_Then; } else { goto anon879_Else; }
anon878_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_201 == SecMask_$_197;
	if ($_$_condition_$229) { goto anon880_Then; } else { goto anon880_Else; }
anon343:
	assume wf(Heap_$_4,SecMask_$_196,SecMask_$_196);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_196);
	assume SecMask_$_197 == SecMask_$_196;
	if ($_$_condition_$227) { goto anon878_Then; } else { goto anon878_Else; }
anon879_Then:
	assume SecMask_$_198[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_199 == SecMask_$_198[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_198[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_200 == SecMask_$_199;
	goto anon347;
anon879_Else:
	assume 0 <= SecMask_$_198[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_200 == SecMask_$_198;
	goto anon347;
anon880_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_202 == SecMask_$_201[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_201[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_201[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$231) { goto anon881_Then; } else { goto anon881_Else; }
anon880_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_205 == SecMask_$_201;
	if ($_$_condition_$232) { goto anon882_Then; } else { goto anon882_Else; }
anon347:
	assume wf(Heap_$_4,SecMask_$_200,SecMask_$_200);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_200);
	assume SecMask_$_201 == SecMask_$_200;
	if ($_$_condition_$230) { goto anon880_Then; } else { goto anon880_Else; }
anon881_Then:
	assume SecMask_$_202[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_203 == SecMask_$_202[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_202[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_204 == SecMask_$_203;
	goto anon351;
anon881_Else:
	assume 0 <= SecMask_$_202[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_204 == SecMask_$_202;
	goto anon351;
anon882_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_206 == SecMask_$_205[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_205[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_205[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$234) { goto anon883_Then; } else { goto anon883_Else; }
anon882_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_209 == SecMask_$_205;
	if ($_$_condition_$235) { goto anon884_Then; } else { goto anon884_Else; }
anon351:
	assume wf(Heap_$_4,SecMask_$_204,SecMask_$_204);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_204);
	assume SecMask_$_205 == SecMask_$_204;
	if ($_$_condition_$233) { goto anon882_Then; } else { goto anon882_Else; }
anon883_Then:
	assume SecMask_$_206[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_207 == SecMask_$_206[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_206[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_208 == SecMask_$_207;
	goto anon355;
anon883_Else:
	assume 0 <= SecMask_$_206[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_208 == SecMask_$_206;
	goto anon355;
anon884_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_210 == SecMask_$_209[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_209[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_209[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$237) { goto anon885_Then; } else { goto anon885_Else; }
anon884_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_213 == SecMask_$_209;
	if ($_$_condition_$238) { goto anon886_Then; } else { goto anon886_Else; }
anon355:
	assume wf(Heap_$_4,SecMask_$_208,SecMask_$_208);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_208);
	assume SecMask_$_209 == SecMask_$_208;
	if ($_$_condition_$236) { goto anon884_Then; } else { goto anon884_Else; }
anon885_Then:
	assume SecMask_$_210[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_211 == SecMask_$_210[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_210[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_212 == SecMask_$_211;
	goto anon359;
anon885_Else:
	assume 0 <= SecMask_$_210[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_212 == SecMask_$_210;
	goto anon359;
anon886_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_214 == SecMask_$_213[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_213[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_213[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$240) { goto anon887_Then; } else { goto anon887_Else; }
anon886_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_217 == SecMask_$_213;
	if ($_$_condition_$241) { goto anon888_Then; } else { goto anon888_Else; }
anon359:
	assume wf(Heap_$_4,SecMask_$_212,SecMask_$_212);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_212);
	assume SecMask_$_213 == SecMask_$_212;
	if ($_$_condition_$239) { goto anon886_Then; } else { goto anon886_Else; }
anon887_Then:
	assume SecMask_$_214[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_215 == SecMask_$_214[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_214[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_216 == SecMask_$_215;
	goto anon363;
anon887_Else:
	assume 0 <= SecMask_$_214[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_216 == SecMask_$_214;
	goto anon363;
anon888_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_218 == SecMask_$_217[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_217[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_217[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$243) { goto anon889_Then; } else { goto anon889_Else; }
anon888_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_221 == SecMask_$_217;
	if ($_$_condition_$244) { goto anon890_Then; } else { goto anon890_Else; }
anon363:
	assume wf(Heap_$_4,SecMask_$_216,SecMask_$_216);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_216);
	assume SecMask_$_217 == SecMask_$_216;
	if ($_$_condition_$242) { goto anon888_Then; } else { goto anon888_Else; }
anon889_Then:
	assume SecMask_$_218[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_219 == SecMask_$_218[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_218[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_220 == SecMask_$_219;
	goto anon367;
anon889_Else:
	assume 0 <= SecMask_$_218[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_220 == SecMask_$_218;
	goto anon367;
anon890_Then:
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_222 == SecMask_$_221[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_221[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_221[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$246) { goto anon891_Then; } else { goto anon891_Else; }
anon890_Else:
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_225 == SecMask_$_221;
	goto anon372;
anon367:
	assume wf(Heap_$_4,SecMask_$_220,SecMask_$_220);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_220);
	assume SecMask_$_221 == SecMask_$_220;
	if ($_$_condition_$245) { goto anon890_Then; } else { goto anon890_Else; }
anon891_Then:
	assume SecMask_$_222[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_223 == SecMask_$_222[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_222[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_224 == SecMask_$_223;
	goto anon371;
anon891_Else:
	assume 0 <= SecMask_$_222[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_224 == SecMask_$_222;
	goto anon371;
anon372:
	assume wf(Heap_$_4,SecMask_$_225,SecMask_$_225);
	assume SecMask_$_226 == SecMask_$_225;
	if ($_$_condition_$247) { goto anon892_Then; } else { goto anon892_Else; }
anon371:
	assume wf(Heap_$_4,SecMask_$_224,SecMask_$_224);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_224);
	assume SecMask_$_225 == SecMask_$_224;
	goto anon372;
anon375:
	assume IsGoodMask(exhaleMask#_2278_$_14);
	assume wf(Heap_$_4,exhaleMask#_2278_$_14,SecMask_$_226);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_226);
	assume exhaleMask#_2278_$_15 == exhaleMask#_2278_$_14;
	assume SecMask_$_227 == SecMask_$_226;
	if ($_$_condition_$248) { goto anon893_Then; } else { goto anon893_Else; }
anon894_Then:
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null);
	assert { :msg "  688.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2278_$_18 == exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_18);
	assume wf(Heap_$_4,exhaleMask#_2278_$_18,SecMask_$_227);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_227);
	assume exhaleMask#_2278_$_19 == exhaleMask#_2278_$_18;
	if ($_$_condition_$251) { goto anon895_Then; } else { goto anon895_Else; }
anon894_Else:
	assume Heap_$_4[this#664_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2278_$_19 == exhaleMask#_2278_$_17;
	if ($_$_condition_$252) { goto anon895_Then; } else { goto anon895_Else; }
anon895_Then:
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null);
	assert { :msg "  688.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2278_$_19[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_19[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2278_$_19[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2278_$_20 == exhaleMask#_2278_$_19[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_2278_$_19[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2278_$_19[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_20);
	assume wf(Heap_$_4,exhaleMask#_2278_$_20,SecMask_$_227);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_227);
	assume exhaleMask#_2278_$_21 == exhaleMask#_2278_$_20;
	goto anon382;
anon895_Else:
	assume Heap_$_4[this#664_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2278_$_21 == exhaleMask#_2278_$_19;
	goto anon382;
anon382:
	assume IsGoodExhaleState(exhaleHeap#_2277_$_0,Heap_$_4,exhaleMask#_2278_$_21,SecMask_$_227);
	assume IsGoodMask(exhaleMask#_2278_$_21);
	assume wf(exhaleHeap#_2277_$_0,exhaleMask#_2278_$_21,SecMask_$_227);
	assume !(this#664_$_0 == null);
	assume wf(exhaleHeap#_2277_$_0,exhaleMask#_2278_$_21,SecMask_$_227);
	assume Fractions(100) > 0;
	assume Mask_$_64 == exhaleMask#_2278_$_21[this#664_$_0,AVLTreeNode.valid := exhaleMask#_2278_$_21[this#664_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_2278_$_21[this#664_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_64);
	assume IsGoodState(heapFragment(exhaleHeap#_2277_$_0[this#664_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_2277_$_0,Mask_$_64,SecMask_$_227);
	assume wf(exhaleHeap#_2277_$_0,Mask_$_64,SecMask_$_227);
	assume !(this#664_$_0 == null);
	assume wf(exhaleHeap#_2277_$_0,Mask_$_64,SecMask_$_227);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_65 == Mask_$_64[this#664_$_0,AVLTreeNode.height := Mask_$_64[this#664_$_0,AVLTreeNode.height][perm$R := Mask_$_64[this#664_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_65);
	assume IsGoodState(heapFragment(exhaleHeap#_2277_$_0[this#664_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_2277_$_0,Mask_$_65,SecMask_$_227);
	assume wf(exhaleHeap#_2277_$_0,Mask_$_65,SecMask_$_227);
	assume !(this#664_$_0 == null);
	assume wf(exhaleHeap#_2277_$_0,Mask_$_65,SecMask_$_227);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_66 == Mask_$_65[this#664_$_0,AVLTreeNode.keys := Mask_$_65[this#664_$_0,AVLTreeNode.keys][perm$R := Mask_$_65[this#664_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_66);
	assume IsGoodState(heapFragment(exhaleHeap#_2277_$_0[this#664_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_2277_$_0,Mask_$_66,SecMask_$_227);
	assume wf(exhaleHeap#_2277_$_0,Mask_$_66,SecMask_$_227);
	assume !(this#664_$_0 == null);
	assume wf(exhaleHeap#_2277_$_0,Mask_$_66,SecMask_$_227);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_67 == Mask_$_66[this#664_$_0,AVLTreeNode.balanceFactor := Mask_$_66[this#664_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_66[this#664_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_67);
	assume IsGoodState(heapFragment(exhaleHeap#_2277_$_0[this#664_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_2277_$_0,Mask_$_67,SecMask_$_227);
	assume wf(exhaleHeap#_2277_$_0,Mask_$_67,SecMask_$_227);
	assume Seq#Equal(exhaleHeap#_2277_$_0[this#664_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_4[this#664_$_0,AVLTreeNode.key])),ite(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_2277_$_0[this#664_$_0,AVLTreeNode.height] == ite(ite(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_2277_$_0[this#664_$_0,AVLTreeNode.balanceFactor] == (ite(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null,0,Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null,0,Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_67);
	assume wf(exhaleHeap#_2277_$_0,Mask_$_67,SecMask_$_227);
	assert { :msg "  689.3: Location might not be writable" } CanWrite(Mask_$_67,r#66_$_0,AVLTreeNode.left);
	assert { :msg "  689.17: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  689.17: Location might not be readable." } true ==> CanRead(Mask_$_67,SecMask_$_227,this,AVLTreeNode.left);
	assume Heap_$_5 == exhaleHeap#_2277_$_0[r#66_$_0,AVLTreeNode.left := exhaleHeap#_2277_$_0[this,AVLTreeNode.left]];
	assume wf(Heap_$_5,Mask_$_67,SecMask_$_227);
	assert { :msg "  690.3: Location might not be writable" } CanWrite(Mask_$_67,this,AVLTreeNode.left);
	assert { :msg "  690.17: Receiver might be null." } true ==> (!(r#66_$_0 == null));
	assert { :msg "  690.17: Location might not be readable." } true ==> CanRead(Mask_$_67,SecMask_$_227,r#66_$_0,AVLTreeNode.right);
	assume Heap_$_6 == Heap_$_5[this,AVLTreeNode.left := Heap_$_5[r#66_$_0,AVLTreeNode.right]];
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_227);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_227);
	assert { :msg "  692.10: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  692.10: Location might not be readable." } true ==> CanRead(Mask_$_67,SecMask_$_227,this,AVLTreeNode.left);
	if ($_$_condition_$253) { goto anon896_Then; } else { goto anon896_Else; }
anon896_Then:
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  692.10: Receiver might be null." } (true && (0 <= k#101#678)) ==> (!(this == null));
	assert { :msg "  692.10: Location might not be readable." } (true && (0 <= k#101#678)) ==> CanRead(Mask_$_67,SecMask_$_227,this,AVLTreeNode.left);
	assert { :msg "  692.10: Receiver might be null." } (true && (0 <= k#101#678)) ==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assert { :msg "  692.10: Location might not be readable." } (true && (0 <= k#101#678)) ==> CanRead(Mask_$_67,SecMask_$_227,Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys);
	assert { :msg "  692.10: Receiver might be null." } ((true && (0 <= k#101#678)) && (k#101#678 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (!(this == null));
	assert { :msg "  692.10: Location might not be readable." } ((true && (0 <= k#101#678)) && (k#101#678 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> CanRead(Mask_$_67,SecMask_$_227,this,AVLTreeNode.left);
	assert { :msg "  692.10: Receiver might be null." } ((true && (0 <= k#101#678)) && (k#101#678 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assert { :msg "  692.10: Location might not be readable." } ((true && (0 <= k#101#678)) && (k#101#678 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> CanRead(Mask_$_67,SecMask_$_227,Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys);
	assert { :msg "  692.50: Sequence index might be negative." } ((true && (0 <= k#101#678)) && (k#101#678 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (0 <= k#101#678);
	assert { :msg "  692.50: Sequence index might be larger than or equal to the length of the sequence." } ((true && (0 <= k#101#678)) && (k#101#678 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (k#101#678 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assert { :msg "  692.54: Receiver might be null." } ((true && (0 <= k#101#678)) && (k#101#678 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (!(this == null));
	assert { :msg "  692.54: Location might not be readable." } ((true && (0 <= k#101#678)) && (k#101#678 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> CanRead(Mask_$_67,SecMask_$_227,this,AVLTreeNode.key);
	assert { :msg "  692.3: Assertion might not hold. The expression at 692.25 might not evaluate to true." } (forall  k#101#677 : Integer :: ( ((0 <= k#101#677) && (k#101#677 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys],k#101#677) < Heap_$_6[this,AVLTreeNode.key]) ));
	goto anon384;
anon896_Else:
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	goto anon384;
anon384:
	assume IsGoodExhaleState(exhaleHeap#_2331_$_0,Heap_$_6,Mask_$_67,SecMask_$_227);
	assume IsGoodMask(Mask_$_67);
	assume wf(exhaleHeap#_2331_$_0,Mask_$_67,SecMask_$_227);
	assume ((0 < methodCallK#_2337) && ((1000 * methodCallK#_2337) < Fractions(1))) && ((1000 * methodCallK#_2337) < methodK#_2144);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_227);
	assert { :msg "  693.3: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$254) { goto anon897_Then; } else { goto anon897_Else; }
anon897_Then:
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  693.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#681 : Integer :: ( ((0 <= k#92#681) && (k#92#681 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#681) < Heap_$_6[this,AVLTreeNode.key]) ));
	if ($_$_condition_$255) { goto anon898_Then; } else { goto anon898_Else; }
anon897_Else:
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	if ($_$_condition_$256) { goto anon898_Then; } else { goto anon898_Else; }
anon898_Then:
	assume !(Heap_$_6[this,AVLTreeNode.right] == null);
	assert { :msg "  693.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#682 : Integer :: ( ((0 <= k#93#682) && (k#93#682 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_6[this,AVLTreeNode.key] < Seq#Index(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#682)) ));
	goto anon388;
anon898_Else:
	assume Heap_$_6[this,AVLTreeNode.right] == null;
	goto anon388;
anon388:
	assert { :msg "  693.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(Heap_$_6[this,AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_6[this,AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  693.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(Heap_$_6[this,AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_6[this,AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  693.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  693.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_67[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_67[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_67[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_2339_$_0 == Mask_$_67[this,AVLTreeNode.key := Mask_$_67[this,AVLTreeNode.key][perm$R := Mask_$_67[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2339_$_0);
	assume wf(Heap_$_6,exhaleMask#_2339_$_0,SecMask_$_227);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_227);
	assert { :msg "  693.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  693.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_2339_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_2339_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2339_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2339_$_1 == exhaleMask#_2339_$_0[this,AVLTreeNode.height := exhaleMask#_2339_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_2339_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2339_$_1);
	assume wf(Heap_$_6,exhaleMask#_2339_$_1,SecMask_$_227);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_227);
	assert { :msg "  693.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  693.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_2339_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_2339_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_2339_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_2339_$_2 == exhaleMask#_2339_$_1[this,AVLTreeNode.left := exhaleMask#_2339_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_2339_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2339_$_2);
	assume wf(Heap_$_6,exhaleMask#_2339_$_2,SecMask_$_227);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_227);
	assert { :msg "  693.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  693.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_2339_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_2339_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_2339_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_2339_$_3 == exhaleMask#_2339_$_2[this,AVLTreeNode.right := exhaleMask#_2339_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_2339_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2339_$_3);
	assume wf(Heap_$_6,exhaleMask#_2339_$_3,SecMask_$_227);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_227);
	assert { :msg "  693.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  693.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_2339_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_2339_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2339_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2339_$_4 == exhaleMask#_2339_$_3[this,AVLTreeNode.keys := exhaleMask#_2339_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_2339_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2339_$_4);
	assume wf(Heap_$_6,exhaleMask#_2339_$_4,SecMask_$_227);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_227);
	assert { :msg "  693.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  693.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_2339_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_2339_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2339_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2339_$_5 == exhaleMask#_2339_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_2339_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2339_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2339_$_5);
	assume wf(Heap_$_6,exhaleMask#_2339_$_5,SecMask_$_227);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_227);
	if ($_$_condition_$257) { goto anon899_Then; } else { goto anon899_Else; }
anon899_Then:
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  693.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  693.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2339_$_6 == exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$258) { goto anon900_Then; } else { goto anon900_Else; }
anon899_Else:
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	assume SecMask_$_279 == SecMask_$_227;
	assume exhaleMask#_2339_$_7 == exhaleMask#_2339_$_5;
	if ($_$_condition_$259) { goto anon928_Then; } else { goto anon928_Else; }
anon900_Then:
	assume false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$260) { goto anon901_Then; } else { goto anon901_Else; }
anon900_Else:
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_278 == SecMask_$_227;
	if ($_$_condition_$261) { goto anon927_Then; } else { goto anon927_Else; }
anon928_Then:
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  693.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2339_$_8 == exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_8);
	assume wf(Heap_$_6,exhaleMask#_2339_$_8,SecMask_$_279);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_279);
	assume exhaleMask#_2339_$_9 == exhaleMask#_2339_$_8;
	if ($_$_condition_$299) { goto anon929_Then; } else { goto anon929_Else; }
anon928_Else:
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	assume exhaleMask#_2339_$_9 == exhaleMask#_2339_$_7;
	if ($_$_condition_$300) { goto anon929_Then; } else { goto anon929_Else; }
anon901_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#683 : Integer :: ( ((0 <= lk#79#683) && (lk#79#683 < Seq#Length(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#683) < Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	if ($_$_condition_$262) { goto anon902_Then; } else { goto anon902_Else; }
anon901_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$263) { goto anon902_Then; } else { goto anon902_Else; }
anon927_Then:
	assume !CanRead(exhaleMask#_2339_$_6,SecMask_$_278,Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_2338_$_0[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon445;
anon927_Else:
	assume CanRead(exhaleMask#_2339_$_6,SecMask_$_278,Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon445;
anon902_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$264) { goto anon903_Then; } else { goto anon903_Else; }
anon902_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$265) { goto anon903_Then; } else { goto anon903_Else; }
anon903_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#684 : Integer :: ( ((0 <= rk#80#684) && (rk#80#684 < Seq#Length(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#684)) ));
	if ($_$_condition_$266) { goto anon904_Then; } else { goto anon904_Else; }
anon903_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	if ($_$_condition_$267) { goto anon904_Then; } else { goto anon904_Else; }
anon904_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon398;
anon904_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon398;
anon398:
	assume Seq#Equal(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key])),ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys],Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$6 : Integer :: ( Seq#Contains(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$6) <==> ((((!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$6)) || ((!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$6))) || (kk#81_$6 == Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_228 == SecMask_$_227[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_227[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_227[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$268) { goto anon905_Then; } else { goto anon905_Else; }
anon905_Then:
	assume SecMask_$_228[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_229 == SecMask_$_228[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_228[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_230 == SecMask_$_229;
	goto anon400;
anon905_Else:
	assume 0 <= SecMask_$_228[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_230 == SecMask_$_228;
	goto anon400;
anon400:
	assume wf(Heap_$_6,SecMask_$_230,SecMask_$_230);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_230);
	assume SecMask_$_231 == SecMask_$_230[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_230[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_230[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$269) { goto anon906_Then; } else { goto anon906_Else; }
anon906_Then:
	assume SecMask_$_231[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_232 == SecMask_$_231[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_231[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_233 == SecMask_$_232;
	goto anon402;
anon906_Else:
	assume 0 <= SecMask_$_231[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_233 == SecMask_$_231;
	goto anon402;
anon402:
	assume wf(Heap_$_6,SecMask_$_233,SecMask_$_233);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_233);
	assume SecMask_$_234 == SecMask_$_233[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_233[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_233[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$270) { goto anon907_Then; } else { goto anon907_Else; }
anon907_Then:
	assume SecMask_$_234[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_235 == SecMask_$_234[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_234[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_236 == SecMask_$_235;
	goto anon404;
anon907_Else:
	assume 0 <= SecMask_$_234[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_236 == SecMask_$_234;
	goto anon404;
anon404:
	assume wf(Heap_$_6,SecMask_$_236,SecMask_$_236);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_236);
	assume SecMask_$_237 == SecMask_$_236[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_236[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_236[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$271) { goto anon908_Then; } else { goto anon908_Else; }
anon908_Then:
	assume SecMask_$_237[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_238 == SecMask_$_237[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_237[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_239 == SecMask_$_238;
	goto anon406;
anon908_Else:
	assume 0 <= SecMask_$_237[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_239 == SecMask_$_237;
	goto anon406;
anon406:
	assume wf(Heap_$_6,SecMask_$_239,SecMask_$_239);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_239);
	assume SecMask_$_240 == SecMask_$_239[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_239[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_239[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$272) { goto anon909_Then; } else { goto anon909_Else; }
anon909_Then:
	assume SecMask_$_240[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_241 == SecMask_$_240[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_240[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_242 == SecMask_$_241;
	goto anon408;
anon909_Else:
	assume 0 <= SecMask_$_240[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_242 == SecMask_$_240;
	goto anon408;
anon408:
	assume wf(Heap_$_6,SecMask_$_242,SecMask_$_242);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_242);
	assume SecMask_$_243 == SecMask_$_242[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_242[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_242[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$273) { goto anon910_Then; } else { goto anon910_Else; }
anon910_Then:
	assume SecMask_$_243[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_244 == SecMask_$_243[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_243[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_245 == SecMask_$_244;
	goto anon410;
anon910_Else:
	assume 0 <= SecMask_$_243[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_245 == SecMask_$_243;
	goto anon410;
anon410:
	assume wf(Heap_$_6,SecMask_$_245,SecMask_$_245);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_245);
	if ($_$_condition_$274) { goto anon911_Then; } else { goto anon911_Else; }
anon911_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_246 == SecMask_$_245[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_245[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_245[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$275) { goto anon912_Then; } else { goto anon912_Else; }
anon911_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_249 == SecMask_$_245;
	if ($_$_condition_$276) { goto anon913_Then; } else { goto anon913_Else; }
anon912_Then:
	assume SecMask_$_246[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_247 == SecMask_$_246[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_246[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_248 == SecMask_$_247;
	goto anon413;
anon912_Else:
	assume 0 <= SecMask_$_246[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_248 == SecMask_$_246;
	goto anon413;
anon913_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_250 == SecMask_$_249[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_249[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_249[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$278) { goto anon914_Then; } else { goto anon914_Else; }
anon913_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_253 == SecMask_$_249;
	if ($_$_condition_$279) { goto anon915_Then; } else { goto anon915_Else; }
anon413:
	assume wf(Heap_$_6,SecMask_$_248,SecMask_$_248);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_248);
	assume SecMask_$_249 == SecMask_$_248;
	if ($_$_condition_$277) { goto anon913_Then; } else { goto anon913_Else; }
anon914_Then:
	assume SecMask_$_250[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_251 == SecMask_$_250[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_250[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_252 == SecMask_$_251;
	goto anon417;
anon914_Else:
	assume 0 <= SecMask_$_250[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_252 == SecMask_$_250;
	goto anon417;
anon915_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_254 == SecMask_$_253[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_253[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_253[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$281) { goto anon916_Then; } else { goto anon916_Else; }
anon915_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_257 == SecMask_$_253;
	if ($_$_condition_$282) { goto anon917_Then; } else { goto anon917_Else; }
anon417:
	assume wf(Heap_$_6,SecMask_$_252,SecMask_$_252);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_252);
	assume SecMask_$_253 == SecMask_$_252;
	if ($_$_condition_$280) { goto anon915_Then; } else { goto anon915_Else; }
anon916_Then:
	assume SecMask_$_254[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_255 == SecMask_$_254[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_254[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_256 == SecMask_$_255;
	goto anon421;
anon916_Else:
	assume 0 <= SecMask_$_254[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_256 == SecMask_$_254;
	goto anon421;
anon917_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_258 == SecMask_$_257[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_257[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_257[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$284) { goto anon918_Then; } else { goto anon918_Else; }
anon917_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_261 == SecMask_$_257;
	if ($_$_condition_$285) { goto anon919_Then; } else { goto anon919_Else; }
anon421:
	assume wf(Heap_$_6,SecMask_$_256,SecMask_$_256);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_256);
	assume SecMask_$_257 == SecMask_$_256;
	if ($_$_condition_$283) { goto anon917_Then; } else { goto anon917_Else; }
anon918_Then:
	assume SecMask_$_258[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_259 == SecMask_$_258[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_258[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_260 == SecMask_$_259;
	goto anon425;
anon918_Else:
	assume 0 <= SecMask_$_258[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_260 == SecMask_$_258;
	goto anon425;
anon919_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_262 == SecMask_$_261[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_261[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_261[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$287) { goto anon920_Then; } else { goto anon920_Else; }
anon919_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_265 == SecMask_$_261;
	if ($_$_condition_$288) { goto anon921_Then; } else { goto anon921_Else; }
anon425:
	assume wf(Heap_$_6,SecMask_$_260,SecMask_$_260);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_260);
	assume SecMask_$_261 == SecMask_$_260;
	if ($_$_condition_$286) { goto anon919_Then; } else { goto anon919_Else; }
anon920_Then:
	assume SecMask_$_262[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_263 == SecMask_$_262[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_262[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_264 == SecMask_$_263;
	goto anon429;
anon920_Else:
	assume 0 <= SecMask_$_262[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_264 == SecMask_$_262;
	goto anon429;
anon921_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_266 == SecMask_$_265[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_265[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_265[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$290) { goto anon922_Then; } else { goto anon922_Else; }
anon921_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_269 == SecMask_$_265;
	if ($_$_condition_$291) { goto anon923_Then; } else { goto anon923_Else; }
anon429:
	assume wf(Heap_$_6,SecMask_$_264,SecMask_$_264);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_264);
	assume SecMask_$_265 == SecMask_$_264;
	if ($_$_condition_$289) { goto anon921_Then; } else { goto anon921_Else; }
anon922_Then:
	assume SecMask_$_266[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_267 == SecMask_$_266[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_266[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_268 == SecMask_$_267;
	goto anon433;
anon922_Else:
	assume 0 <= SecMask_$_266[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_268 == SecMask_$_266;
	goto anon433;
anon923_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_270 == SecMask_$_269[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_269[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_269[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$293) { goto anon924_Then; } else { goto anon924_Else; }
anon923_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_273 == SecMask_$_269;
	if ($_$_condition_$294) { goto anon925_Then; } else { goto anon925_Else; }
anon433:
	assume wf(Heap_$_6,SecMask_$_268,SecMask_$_268);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_268);
	assume SecMask_$_269 == SecMask_$_268;
	if ($_$_condition_$292) { goto anon923_Then; } else { goto anon923_Else; }
anon924_Then:
	assume SecMask_$_270[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_271 == SecMask_$_270[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_270[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_272 == SecMask_$_271;
	goto anon437;
anon924_Else:
	assume 0 <= SecMask_$_270[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_272 == SecMask_$_270;
	goto anon437;
anon925_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_274 == SecMask_$_273[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_273[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_273[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$296) { goto anon926_Then; } else { goto anon926_Else; }
anon925_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_277 == SecMask_$_273;
	goto anon442;
anon437:
	assume wf(Heap_$_6,SecMask_$_272,SecMask_$_272);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_272);
	assume SecMask_$_273 == SecMask_$_272;
	if ($_$_condition_$295) { goto anon925_Then; } else { goto anon925_Else; }
anon926_Then:
	assume SecMask_$_274[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_275 == SecMask_$_274[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_274[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_276 == SecMask_$_275;
	goto anon441;
anon926_Else:
	assume 0 <= SecMask_$_274[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_276 == SecMask_$_274;
	goto anon441;
anon442:
	assume wf(Heap_$_6,SecMask_$_277,SecMask_$_277);
	assume SecMask_$_278 == SecMask_$_277;
	if ($_$_condition_$297) { goto anon927_Then; } else { goto anon927_Else; }
anon441:
	assume wf(Heap_$_6,SecMask_$_276,SecMask_$_276);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_276);
	assume SecMask_$_277 == SecMask_$_276;
	goto anon442;
anon445:
	assume IsGoodMask(exhaleMask#_2339_$_6);
	assume wf(Heap_$_6,exhaleMask#_2339_$_6,SecMask_$_278);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_278);
	assume SecMask_$_279 == SecMask_$_278;
	assume exhaleMask#_2339_$_7 == exhaleMask#_2339_$_6;
	if ($_$_condition_$298) { goto anon928_Then; } else { goto anon928_Else; }
anon929_Then:
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  693.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2339_$_10 == exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_10);
	assume wf(Heap_$_6,exhaleMask#_2339_$_10,SecMask_$_279);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_279);
	assume exhaleMask#_2339_$_11 == exhaleMask#_2339_$_10;
	if ($_$_condition_$301) { goto anon930_Then; } else { goto anon930_Else; }
anon929_Else:
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	assume exhaleMask#_2339_$_11 == exhaleMask#_2339_$_9;
	if ($_$_condition_$302) { goto anon930_Then; } else { goto anon930_Else; }
anon930_Then:
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  693.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2339_$_12 == exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_12);
	assume wf(Heap_$_6,exhaleMask#_2339_$_12,SecMask_$_279);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_279);
	assume exhaleMask#_2339_$_13 == exhaleMask#_2339_$_12;
	if ($_$_condition_$303) { goto anon931_Then; } else { goto anon931_Else; }
anon930_Else:
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	assume exhaleMask#_2339_$_13 == exhaleMask#_2339_$_11;
	if ($_$_condition_$304) { goto anon931_Then; } else { goto anon931_Else; }
anon931_Then:
	assume !(Heap_$_6[this,AVLTreeNode.right] == null);
	assert { :msg "  693.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  693.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2339_$_14 == exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$305) { goto anon932_Then; } else { goto anon932_Else; }
anon931_Else:
	assume Heap_$_6[this,AVLTreeNode.right] == null;
	assume exhaleMask#_2339_$_15 == exhaleMask#_2339_$_13;
	assume SecMask_$_331 == SecMask_$_279;
	if ($_$_condition_$306) { goto anon960_Then; } else { goto anon960_Else; }
anon932_Then:
	assume false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$307) { goto anon933_Then; } else { goto anon933_Else; }
anon932_Else:
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.right])) && true) && true));
	assume SecMask_$_330 == SecMask_$_279;
	if ($_$_condition_$308) { goto anon959_Then; } else { goto anon959_Else; }
anon960_Then:
	assume !(Heap_$_6[this,AVLTreeNode.right] == null);
	assert { :msg "  693.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2339_$_16 == exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_16);
	assume wf(Heap_$_6,exhaleMask#_2339_$_16,SecMask_$_331);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_331);
	assume exhaleMask#_2339_$_17 == exhaleMask#_2339_$_16;
	if ($_$_condition_$346) { goto anon961_Then; } else { goto anon961_Else; }
anon960_Else:
	assume Heap_$_6[this,AVLTreeNode.right] == null;
	assume exhaleMask#_2339_$_17 == exhaleMask#_2339_$_15;
	if ($_$_condition_$347) { goto anon961_Then; } else { goto anon961_Else; }
anon933_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#688 : Integer :: ( ((0 <= lk#79#688) && (lk#79#688 < Seq#Length(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#688) < Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	if ($_$_condition_$309) { goto anon934_Then; } else { goto anon934_Else; }
anon933_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$310) { goto anon934_Then; } else { goto anon934_Else; }
anon959_Then:
	assume !CanRead(exhaleMask#_2339_$_14,SecMask_$_330,Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_2338_$_0[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon509;
anon959_Else:
	assume CanRead(exhaleMask#_2339_$_14,SecMask_$_330,Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon509;
anon934_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$311) { goto anon935_Then; } else { goto anon935_Else; }
anon934_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$312) { goto anon935_Then; } else { goto anon935_Else; }
anon935_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#689 : Integer :: ( ((0 <= rk#80#689) && (rk#80#689 < Seq#Length(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#689)) ));
	if ($_$_condition_$313) { goto anon936_Then; } else { goto anon936_Else; }
anon935_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	if ($_$_condition_$314) { goto anon936_Then; } else { goto anon936_Else; }
anon936_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon462;
anon936_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon462;
anon462:
	assume Seq#Equal(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key])),ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys],Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$7 : Integer :: ( Seq#Contains(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$7) <==> ((((!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$7)) || ((!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$7))) || (kk#81_$7 == Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume SecMask_$_280 == SecMask_$_279[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_279[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := SecMask_$_279[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$315) { goto anon937_Then; } else { goto anon937_Else; }
anon937_Then:
	assume SecMask_$_280[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_281 == SecMask_$_280[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_280[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_282 == SecMask_$_281;
	goto anon464;
anon937_Else:
	assume 0 <= SecMask_$_280[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_282 == SecMask_$_280;
	goto anon464;
anon464:
	assume wf(Heap_$_6,SecMask_$_282,SecMask_$_282);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_282);
	assume SecMask_$_283 == SecMask_$_282[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_282[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_282[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$316) { goto anon938_Then; } else { goto anon938_Else; }
anon938_Then:
	assume SecMask_$_283[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_284 == SecMask_$_283[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_283[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_285 == SecMask_$_284;
	goto anon466;
anon938_Else:
	assume 0 <= SecMask_$_283[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_285 == SecMask_$_283;
	goto anon466;
anon466:
	assume wf(Heap_$_6,SecMask_$_285,SecMask_$_285);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_285);
	assume SecMask_$_286 == SecMask_$_285[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_285[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_285[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$317) { goto anon939_Then; } else { goto anon939_Else; }
anon939_Then:
	assume SecMask_$_286[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_287 == SecMask_$_286[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_286[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_288 == SecMask_$_287;
	goto anon468;
anon939_Else:
	assume 0 <= SecMask_$_286[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_288 == SecMask_$_286;
	goto anon468;
anon468:
	assume wf(Heap_$_6,SecMask_$_288,SecMask_$_288);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_288);
	assume SecMask_$_289 == SecMask_$_288[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_288[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_288[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$318) { goto anon940_Then; } else { goto anon940_Else; }
anon940_Then:
	assume SecMask_$_289[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_290 == SecMask_$_289[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_289[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_291 == SecMask_$_290;
	goto anon470;
anon940_Else:
	assume 0 <= SecMask_$_289[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_291 == SecMask_$_289;
	goto anon470;
anon470:
	assume wf(Heap_$_6,SecMask_$_291,SecMask_$_291);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_291);
	assume SecMask_$_292 == SecMask_$_291[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_291[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_291[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$319) { goto anon941_Then; } else { goto anon941_Else; }
anon941_Then:
	assume SecMask_$_292[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_293 == SecMask_$_292[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_292[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_294 == SecMask_$_293;
	goto anon472;
anon941_Else:
	assume 0 <= SecMask_$_292[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_294 == SecMask_$_292;
	goto anon472;
anon472:
	assume wf(Heap_$_6,SecMask_$_294,SecMask_$_294);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_294);
	assume SecMask_$_295 == SecMask_$_294[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_294[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_294[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$320) { goto anon942_Then; } else { goto anon942_Else; }
anon942_Then:
	assume SecMask_$_295[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_296 == SecMask_$_295[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_295[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_297 == SecMask_$_296;
	goto anon474;
anon942_Else:
	assume 0 <= SecMask_$_295[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_297 == SecMask_$_295;
	goto anon474;
anon474:
	assume wf(Heap_$_6,SecMask_$_297,SecMask_$_297);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_297);
	if ($_$_condition_$321) { goto anon943_Then; } else { goto anon943_Else; }
anon943_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_298 == SecMask_$_297[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_297[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_297[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$322) { goto anon944_Then; } else { goto anon944_Else; }
anon943_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_301 == SecMask_$_297;
	if ($_$_condition_$323) { goto anon945_Then; } else { goto anon945_Else; }
anon944_Then:
	assume SecMask_$_298[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_299 == SecMask_$_298[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_298[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_300 == SecMask_$_299;
	goto anon477;
anon944_Else:
	assume 0 <= SecMask_$_298[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_300 == SecMask_$_298;
	goto anon477;
anon945_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_302 == SecMask_$_301[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_301[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_301[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$325) { goto anon946_Then; } else { goto anon946_Else; }
anon945_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_305 == SecMask_$_301;
	if ($_$_condition_$326) { goto anon947_Then; } else { goto anon947_Else; }
anon477:
	assume wf(Heap_$_6,SecMask_$_300,SecMask_$_300);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_300);
	assume SecMask_$_301 == SecMask_$_300;
	if ($_$_condition_$324) { goto anon945_Then; } else { goto anon945_Else; }
anon946_Then:
	assume SecMask_$_302[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_303 == SecMask_$_302[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_302[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_304 == SecMask_$_303;
	goto anon481;
anon946_Else:
	assume 0 <= SecMask_$_302[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_304 == SecMask_$_302;
	goto anon481;
anon947_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_306 == SecMask_$_305[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_305[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_305[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$328) { goto anon948_Then; } else { goto anon948_Else; }
anon947_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_309 == SecMask_$_305;
	if ($_$_condition_$329) { goto anon949_Then; } else { goto anon949_Else; }
anon481:
	assume wf(Heap_$_6,SecMask_$_304,SecMask_$_304);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_304);
	assume SecMask_$_305 == SecMask_$_304;
	if ($_$_condition_$327) { goto anon947_Then; } else { goto anon947_Else; }
anon948_Then:
	assume SecMask_$_306[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_307 == SecMask_$_306[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_306[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_308 == SecMask_$_307;
	goto anon485;
anon948_Else:
	assume 0 <= SecMask_$_306[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_308 == SecMask_$_306;
	goto anon485;
anon949_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_310 == SecMask_$_309[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_309[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_309[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$331) { goto anon950_Then; } else { goto anon950_Else; }
anon949_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_313 == SecMask_$_309;
	if ($_$_condition_$332) { goto anon951_Then; } else { goto anon951_Else; }
anon485:
	assume wf(Heap_$_6,SecMask_$_308,SecMask_$_308);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_308);
	assume SecMask_$_309 == SecMask_$_308;
	if ($_$_condition_$330) { goto anon949_Then; } else { goto anon949_Else; }
anon950_Then:
	assume SecMask_$_310[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_311 == SecMask_$_310[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_310[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_312 == SecMask_$_311;
	goto anon489;
anon950_Else:
	assume 0 <= SecMask_$_310[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_312 == SecMask_$_310;
	goto anon489;
anon951_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_314 == SecMask_$_313[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_313[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_313[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$334) { goto anon952_Then; } else { goto anon952_Else; }
anon951_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_317 == SecMask_$_313;
	if ($_$_condition_$335) { goto anon953_Then; } else { goto anon953_Else; }
anon489:
	assume wf(Heap_$_6,SecMask_$_312,SecMask_$_312);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_312);
	assume SecMask_$_313 == SecMask_$_312;
	if ($_$_condition_$333) { goto anon951_Then; } else { goto anon951_Else; }
anon952_Then:
	assume SecMask_$_314[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_315 == SecMask_$_314[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_314[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_316 == SecMask_$_315;
	goto anon493;
anon952_Else:
	assume 0 <= SecMask_$_314[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_316 == SecMask_$_314;
	goto anon493;
anon953_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_318 == SecMask_$_317[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_317[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_317[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$337) { goto anon954_Then; } else { goto anon954_Else; }
anon953_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_321 == SecMask_$_317;
	if ($_$_condition_$338) { goto anon955_Then; } else { goto anon955_Else; }
anon493:
	assume wf(Heap_$_6,SecMask_$_316,SecMask_$_316);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_316);
	assume SecMask_$_317 == SecMask_$_316;
	if ($_$_condition_$336) { goto anon953_Then; } else { goto anon953_Else; }
anon954_Then:
	assume SecMask_$_318[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_319 == SecMask_$_318[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_318[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_320 == SecMask_$_319;
	goto anon497;
anon954_Else:
	assume 0 <= SecMask_$_318[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_320 == SecMask_$_318;
	goto anon497;
anon955_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_322 == SecMask_$_321[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_321[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_321[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$340) { goto anon956_Then; } else { goto anon956_Else; }
anon955_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_325 == SecMask_$_321;
	if ($_$_condition_$341) { goto anon957_Then; } else { goto anon957_Else; }
anon497:
	assume wf(Heap_$_6,SecMask_$_320,SecMask_$_320);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_320);
	assume SecMask_$_321 == SecMask_$_320;
	if ($_$_condition_$339) { goto anon955_Then; } else { goto anon955_Else; }
anon956_Then:
	assume SecMask_$_322[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_323 == SecMask_$_322[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_322[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_324 == SecMask_$_323;
	goto anon501;
anon956_Else:
	assume 0 <= SecMask_$_322[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_324 == SecMask_$_322;
	goto anon501;
anon957_Then:
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_326 == SecMask_$_325[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_325[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_325[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$343) { goto anon958_Then; } else { goto anon958_Else; }
anon957_Else:
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_329 == SecMask_$_325;
	goto anon506;
anon501:
	assume wf(Heap_$_6,SecMask_$_324,SecMask_$_324);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_324);
	assume SecMask_$_325 == SecMask_$_324;
	if ($_$_condition_$342) { goto anon957_Then; } else { goto anon957_Else; }
anon958_Then:
	assume SecMask_$_326[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_327 == SecMask_$_326[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_326[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_328 == SecMask_$_327;
	goto anon505;
anon958_Else:
	assume 0 <= SecMask_$_326[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_328 == SecMask_$_326;
	goto anon505;
anon506:
	assume wf(Heap_$_6,SecMask_$_329,SecMask_$_329);
	assume SecMask_$_330 == SecMask_$_329;
	if ($_$_condition_$344) { goto anon959_Then; } else { goto anon959_Else; }
anon505:
	assume wf(Heap_$_6,SecMask_$_328,SecMask_$_328);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_328);
	assume SecMask_$_329 == SecMask_$_328;
	goto anon506;
anon509:
	assume IsGoodMask(exhaleMask#_2339_$_14);
	assume wf(Heap_$_6,exhaleMask#_2339_$_14,SecMask_$_330);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_330);
	assume exhaleMask#_2339_$_15 == exhaleMask#_2339_$_14;
	assume SecMask_$_331 == SecMask_$_330;
	if ($_$_condition_$345) { goto anon960_Then; } else { goto anon960_Else; }
anon961_Then:
	assume !(Heap_$_6[this,AVLTreeNode.right] == null);
	assert { :msg "  693.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2339_$_18 == exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_18);
	assume wf(Heap_$_6,exhaleMask#_2339_$_18,SecMask_$_331);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_331);
	assume exhaleMask#_2339_$_19 == exhaleMask#_2339_$_18;
	if ($_$_condition_$348) { goto anon962_Then; } else { goto anon962_Else; }
anon961_Else:
	assume Heap_$_6[this,AVLTreeNode.right] == null;
	assume exhaleMask#_2339_$_19 == exhaleMask#_2339_$_17;
	if ($_$_condition_$349) { goto anon962_Then; } else { goto anon962_Else; }
anon962_Then:
	assume !(Heap_$_6[this,AVLTreeNode.right] == null);
	assert { :msg "  693.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2339_$_19[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_19[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2339_$_19[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2339_$_20 == exhaleMask#_2339_$_19[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_2339_$_19[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2339_$_19[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_20);
	assume wf(Heap_$_6,exhaleMask#_2339_$_20,SecMask_$_331);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_331);
	assume exhaleMask#_2339_$_21 == exhaleMask#_2339_$_20;
	goto anon516;
anon962_Else:
	assume Heap_$_6[this,AVLTreeNode.right] == null;
	assume exhaleMask#_2339_$_21 == exhaleMask#_2339_$_19;
	goto anon516;
anon516:
	assume IsGoodExhaleState(exhaleHeap#_2338_$_0,Heap_$_6,exhaleMask#_2339_$_21,SecMask_$_331);
	assume IsGoodMask(exhaleMask#_2339_$_21);
	assume wf(exhaleHeap#_2338_$_0,exhaleMask#_2339_$_21,SecMask_$_331);
	assume !(this == null);
	assume wf(exhaleHeap#_2338_$_0,exhaleMask#_2339_$_21,SecMask_$_331);
	assume Fractions(100) > 0;
	assume Mask_$_68 == exhaleMask#_2339_$_21[this,AVLTreeNode.valid := exhaleMask#_2339_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_2339_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_68);
	assume IsGoodState(heapFragment(exhaleHeap#_2338_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_2338_$_0,Mask_$_68,SecMask_$_331);
	assume wf(exhaleHeap#_2338_$_0,Mask_$_68,SecMask_$_331);
	assume !(this == null);
	assume wf(exhaleHeap#_2338_$_0,Mask_$_68,SecMask_$_331);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_69 == Mask_$_68[this,AVLTreeNode.height := Mask_$_68[this,AVLTreeNode.height][perm$R := Mask_$_68[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_69);
	assume IsGoodState(heapFragment(exhaleHeap#_2338_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_2338_$_0,Mask_$_69,SecMask_$_331);
	assume wf(exhaleHeap#_2338_$_0,Mask_$_69,SecMask_$_331);
	assume !(this == null);
	assume wf(exhaleHeap#_2338_$_0,Mask_$_69,SecMask_$_331);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_70 == Mask_$_69[this,AVLTreeNode.keys := Mask_$_69[this,AVLTreeNode.keys][perm$R := Mask_$_69[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_70);
	assume IsGoodState(heapFragment(exhaleHeap#_2338_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_2338_$_0,Mask_$_70,SecMask_$_331);
	assume wf(exhaleHeap#_2338_$_0,Mask_$_70,SecMask_$_331);
	assume !(this == null);
	assume wf(exhaleHeap#_2338_$_0,Mask_$_70,SecMask_$_331);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_71 == Mask_$_70[this,AVLTreeNode.balanceFactor := Mask_$_70[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_70[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_71);
	assume IsGoodState(heapFragment(exhaleHeap#_2338_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_2338_$_0,Mask_$_71,SecMask_$_331);
	assume wf(exhaleHeap#_2338_$_0,Mask_$_71,SecMask_$_331);
	assume Seq#Equal(exhaleHeap#_2338_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_6[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_6[this,AVLTreeNode.key])),ite(Heap_$_6[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_2338_$_0[this,AVLTreeNode.height] == ite(ite(Heap_$_6[this,AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_6[this,AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_6[this,AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_6[this,AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_2338_$_0[this,AVLTreeNode.balanceFactor] == (ite(Heap_$_6[this,AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_6[this,AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_71);
	assume wf(exhaleHeap#_2338_$_0,Mask_$_71,SecMask_$_331);
	assert { :msg "  694.3: Location might not be writable" } CanWrite(Mask_$_71,r#66_$_0,AVLTreeNode.right);
	assume Heap_$_7 == exhaleHeap#_2338_$_0[r#66_$_0,AVLTreeNode.right := this];
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_331);
	assume ((0 < methodCallK#_2392) && ((1000 * methodCallK#_2392) < Fractions(1))) && ((1000 * methodCallK#_2392) < methodK#_2144);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_331);
	assert { :msg "  695.3: The target of the method call might be null." } !(r#66_$_0 == null);
	if ($_$_condition_$350) { goto anon963_Then; } else { goto anon963_Else; }
anon963_Then:
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null);
	assert { :msg "  695.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#694 : Integer :: ( ((0 <= k#92#694) && (k#92#694 < Seq#Length(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],k#92#694) < Heap_$_7[r#66_$_0,AVLTreeNode.key]) ));
	if ($_$_condition_$351) { goto anon964_Then; } else { goto anon964_Else; }
anon963_Else:
	assume Heap_$_7[r#66_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$352) { goto anon964_Then; } else { goto anon964_Else; }
anon964_Then:
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null);
	assert { :msg "  695.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#695 : Integer :: ( ((0 <= k#93#695) && (k#93#695 < Seq#Length(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_7[r#66_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],k#93#695)) ));
	goto anon520;
anon964_Else:
	assume Heap_$_7[r#66_$_0,AVLTreeNode.right] == null;
	goto anon520;
anon520:
	assert { :msg "  695.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  695.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  695.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  695.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_71[r#66_$_0,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_71[r#66_$_0,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_71[r#66_$_0,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_2394_$_0 == Mask_$_71[r#66_$_0,AVLTreeNode.key := Mask_$_71[r#66_$_0,AVLTreeNode.key][perm$R := Mask_$_71[r#66_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2394_$_0);
	assume wf(Heap_$_7,exhaleMask#_2394_$_0,SecMask_$_331);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_331);
	assert { :msg "  695.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  695.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_2394_$_0[r#66_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_2394_$_0[r#66_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2394_$_0[r#66_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2394_$_1 == exhaleMask#_2394_$_0[r#66_$_0,AVLTreeNode.height := exhaleMask#_2394_$_0[r#66_$_0,AVLTreeNode.height][perm$R := exhaleMask#_2394_$_0[r#66_$_0,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2394_$_1);
	assume wf(Heap_$_7,exhaleMask#_2394_$_1,SecMask_$_331);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_331);
	assert { :msg "  695.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  695.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_2394_$_1[r#66_$_0,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_2394_$_1[r#66_$_0,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_2394_$_1[r#66_$_0,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_2394_$_2 == exhaleMask#_2394_$_1[r#66_$_0,AVLTreeNode.left := exhaleMask#_2394_$_1[r#66_$_0,AVLTreeNode.left][perm$R := exhaleMask#_2394_$_1[r#66_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2394_$_2);
	assume wf(Heap_$_7,exhaleMask#_2394_$_2,SecMask_$_331);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_331);
	assert { :msg "  695.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  695.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_2394_$_2[r#66_$_0,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_2394_$_2[r#66_$_0,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_2394_$_2[r#66_$_0,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_2394_$_3 == exhaleMask#_2394_$_2[r#66_$_0,AVLTreeNode.right := exhaleMask#_2394_$_2[r#66_$_0,AVLTreeNode.right][perm$R := exhaleMask#_2394_$_2[r#66_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2394_$_3);
	assume wf(Heap_$_7,exhaleMask#_2394_$_3,SecMask_$_331);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_331);
	assert { :msg "  695.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  695.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_2394_$_3[r#66_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_2394_$_3[r#66_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2394_$_3[r#66_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2394_$_4 == exhaleMask#_2394_$_3[r#66_$_0,AVLTreeNode.keys := exhaleMask#_2394_$_3[r#66_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_2394_$_3[r#66_$_0,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2394_$_4);
	assume wf(Heap_$_7,exhaleMask#_2394_$_4,SecMask_$_331);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_331);
	assert { :msg "  695.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  695.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_2394_$_4[r#66_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_2394_$_4[r#66_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2394_$_4[r#66_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2394_$_5 == exhaleMask#_2394_$_4[r#66_$_0,AVLTreeNode.balanceFactor := exhaleMask#_2394_$_4[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2394_$_4[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_2394_$_5);
	assume wf(Heap_$_7,exhaleMask#_2394_$_5,SecMask_$_331);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_331);
	if ($_$_condition_$353) { goto anon965_Then; } else { goto anon965_Else; }
anon965_Then:
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null);
	assert { :msg "  695.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  695.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2394_$_6 == exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$354) { goto anon966_Then; } else { goto anon966_Else; }
anon965_Else:
	assume Heap_$_7[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_383 == SecMask_$_331;
	assume exhaleMask#_2394_$_7 == exhaleMask#_2394_$_5;
	if ($_$_condition_$355) { goto anon994_Then; } else { goto anon994_Else; }
anon966_Then:
	assume false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$356) { goto anon967_Then; } else { goto anon967_Else; }
anon966_Else:
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_382 == SecMask_$_331;
	if ($_$_condition_$357) { goto anon993_Then; } else { goto anon993_Else; }
anon994_Then:
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null);
	assert { :msg "  695.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2394_$_8 == exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_8);
	assume wf(Heap_$_7,exhaleMask#_2394_$_8,SecMask_$_383);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_383);
	assume exhaleMask#_2394_$_9 == exhaleMask#_2394_$_8;
	if ($_$_condition_$395) { goto anon995_Then; } else { goto anon995_Else; }
anon994_Else:
	assume Heap_$_7[r#66_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2394_$_9 == exhaleMask#_2394_$_7;
	if ($_$_condition_$396) { goto anon995_Then; } else { goto anon995_Else; }
anon967_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#696 : Integer :: ( ((0 <= lk#79#696) && (lk#79#696 < Seq#Length(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#696) < Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key]) ));
	if ($_$_condition_$358) { goto anon968_Then; } else { goto anon968_Else; }
anon967_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$359) { goto anon968_Then; } else { goto anon968_Else; }
anon993_Then:
	assume !CanRead(exhaleMask#_2394_$_6,SecMask_$_382,Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_2393_$_0[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon577;
anon993_Else:
	assume CanRead(exhaleMask#_2394_$_6,SecMask_$_382,Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon577;
anon968_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$360) { goto anon969_Then; } else { goto anon969_Else; }
anon968_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$361) { goto anon969_Then; } else { goto anon969_Else; }
anon969_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#697 : Integer :: ( ((0 <= rk#80#697) && (rk#80#697 < Seq#Length(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#697)) ));
	if ($_$_condition_$362) { goto anon970_Then; } else { goto anon970_Else; }
anon969_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	if ($_$_condition_$363) { goto anon970_Then; } else { goto anon970_Else; }
anon970_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon530;
anon970_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon530;
anon530:
	assume Seq#Equal(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key])),ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$8 : Integer :: ( Seq#Contains(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$8) <==> ((((!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$8)) || ((!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$8))) || (kk#81_$8 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_332 == SecMask_$_331[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_331[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_331[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$364) { goto anon971_Then; } else { goto anon971_Else; }
anon971_Then:
	assume SecMask_$_332[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_333 == SecMask_$_332[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_332[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_334 == SecMask_$_333;
	goto anon532;
anon971_Else:
	assume 0 <= SecMask_$_332[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_334 == SecMask_$_332;
	goto anon532;
anon532:
	assume wf(Heap_$_7,SecMask_$_334,SecMask_$_334);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_334);
	assume SecMask_$_335 == SecMask_$_334[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_334[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_334[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$365) { goto anon972_Then; } else { goto anon972_Else; }
anon972_Then:
	assume SecMask_$_335[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_336 == SecMask_$_335[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_335[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_337 == SecMask_$_336;
	goto anon534;
anon972_Else:
	assume 0 <= SecMask_$_335[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_337 == SecMask_$_335;
	goto anon534;
anon534:
	assume wf(Heap_$_7,SecMask_$_337,SecMask_$_337);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_337);
	assume SecMask_$_338 == SecMask_$_337[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_337[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_337[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$366) { goto anon973_Then; } else { goto anon973_Else; }
anon973_Then:
	assume SecMask_$_338[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_339 == SecMask_$_338[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_338[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_340 == SecMask_$_339;
	goto anon536;
anon973_Else:
	assume 0 <= SecMask_$_338[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_340 == SecMask_$_338;
	goto anon536;
anon536:
	assume wf(Heap_$_7,SecMask_$_340,SecMask_$_340);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_340);
	assume SecMask_$_341 == SecMask_$_340[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_340[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_340[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$367) { goto anon974_Then; } else { goto anon974_Else; }
anon974_Then:
	assume SecMask_$_341[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_342 == SecMask_$_341[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_341[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_343 == SecMask_$_342;
	goto anon538;
anon974_Else:
	assume 0 <= SecMask_$_341[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_343 == SecMask_$_341;
	goto anon538;
anon538:
	assume wf(Heap_$_7,SecMask_$_343,SecMask_$_343);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_343);
	assume SecMask_$_344 == SecMask_$_343[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_343[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_343[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$368) { goto anon975_Then; } else { goto anon975_Else; }
anon975_Then:
	assume SecMask_$_344[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_345 == SecMask_$_344[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_344[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_346 == SecMask_$_345;
	goto anon540;
anon975_Else:
	assume 0 <= SecMask_$_344[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_346 == SecMask_$_344;
	goto anon540;
anon540:
	assume wf(Heap_$_7,SecMask_$_346,SecMask_$_346);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_346);
	assume SecMask_$_347 == SecMask_$_346[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_346[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_346[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$369) { goto anon976_Then; } else { goto anon976_Else; }
anon976_Then:
	assume SecMask_$_347[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_348 == SecMask_$_347[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_347[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_349 == SecMask_$_348;
	goto anon542;
anon976_Else:
	assume 0 <= SecMask_$_347[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_349 == SecMask_$_347;
	goto anon542;
anon542:
	assume wf(Heap_$_7,SecMask_$_349,SecMask_$_349);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_349);
	if ($_$_condition_$370) { goto anon977_Then; } else { goto anon977_Else; }
anon977_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_350 == SecMask_$_349[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_349[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_349[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$371) { goto anon978_Then; } else { goto anon978_Else; }
anon977_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_353 == SecMask_$_349;
	if ($_$_condition_$372) { goto anon979_Then; } else { goto anon979_Else; }
anon978_Then:
	assume SecMask_$_350[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_351 == SecMask_$_350[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_350[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_352 == SecMask_$_351;
	goto anon545;
anon978_Else:
	assume 0 <= SecMask_$_350[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_352 == SecMask_$_350;
	goto anon545;
anon979_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_354 == SecMask_$_353[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_353[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_353[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$374) { goto anon980_Then; } else { goto anon980_Else; }
anon979_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_357 == SecMask_$_353;
	if ($_$_condition_$375) { goto anon981_Then; } else { goto anon981_Else; }
anon545:
	assume wf(Heap_$_7,SecMask_$_352,SecMask_$_352);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_352);
	assume SecMask_$_353 == SecMask_$_352;
	if ($_$_condition_$373) { goto anon979_Then; } else { goto anon979_Else; }
anon980_Then:
	assume SecMask_$_354[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_355 == SecMask_$_354[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_354[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_356 == SecMask_$_355;
	goto anon549;
anon980_Else:
	assume 0 <= SecMask_$_354[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_356 == SecMask_$_354;
	goto anon549;
anon981_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_358 == SecMask_$_357[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_357[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_357[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$377) { goto anon982_Then; } else { goto anon982_Else; }
anon981_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_361 == SecMask_$_357;
	if ($_$_condition_$378) { goto anon983_Then; } else { goto anon983_Else; }
anon549:
	assume wf(Heap_$_7,SecMask_$_356,SecMask_$_356);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_356);
	assume SecMask_$_357 == SecMask_$_356;
	if ($_$_condition_$376) { goto anon981_Then; } else { goto anon981_Else; }
anon982_Then:
	assume SecMask_$_358[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_359 == SecMask_$_358[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_358[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_360 == SecMask_$_359;
	goto anon553;
anon982_Else:
	assume 0 <= SecMask_$_358[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_360 == SecMask_$_358;
	goto anon553;
anon983_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_362 == SecMask_$_361[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_361[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_361[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$380) { goto anon984_Then; } else { goto anon984_Else; }
anon983_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_365 == SecMask_$_361;
	if ($_$_condition_$381) { goto anon985_Then; } else { goto anon985_Else; }
anon553:
	assume wf(Heap_$_7,SecMask_$_360,SecMask_$_360);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_360);
	assume SecMask_$_361 == SecMask_$_360;
	if ($_$_condition_$379) { goto anon983_Then; } else { goto anon983_Else; }
anon984_Then:
	assume SecMask_$_362[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_363 == SecMask_$_362[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_362[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_364 == SecMask_$_363;
	goto anon557;
anon984_Else:
	assume 0 <= SecMask_$_362[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_364 == SecMask_$_362;
	goto anon557;
anon985_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_366 == SecMask_$_365[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_365[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_365[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$383) { goto anon986_Then; } else { goto anon986_Else; }
anon985_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_369 == SecMask_$_365;
	if ($_$_condition_$384) { goto anon987_Then; } else { goto anon987_Else; }
anon557:
	assume wf(Heap_$_7,SecMask_$_364,SecMask_$_364);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_364);
	assume SecMask_$_365 == SecMask_$_364;
	if ($_$_condition_$382) { goto anon985_Then; } else { goto anon985_Else; }
anon986_Then:
	assume SecMask_$_366[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_367 == SecMask_$_366[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_366[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_368 == SecMask_$_367;
	goto anon561;
anon986_Else:
	assume 0 <= SecMask_$_366[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_368 == SecMask_$_366;
	goto anon561;
anon987_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_370 == SecMask_$_369[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_369[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_369[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$386) { goto anon988_Then; } else { goto anon988_Else; }
anon987_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_373 == SecMask_$_369;
	if ($_$_condition_$387) { goto anon989_Then; } else { goto anon989_Else; }
anon561:
	assume wf(Heap_$_7,SecMask_$_368,SecMask_$_368);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_368);
	assume SecMask_$_369 == SecMask_$_368;
	if ($_$_condition_$385) { goto anon987_Then; } else { goto anon987_Else; }
anon988_Then:
	assume SecMask_$_370[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_371 == SecMask_$_370[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_370[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_372 == SecMask_$_371;
	goto anon565;
anon988_Else:
	assume 0 <= SecMask_$_370[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_372 == SecMask_$_370;
	goto anon565;
anon989_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_374 == SecMask_$_373[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_373[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_373[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$389) { goto anon990_Then; } else { goto anon990_Else; }
anon989_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_377 == SecMask_$_373;
	if ($_$_condition_$390) { goto anon991_Then; } else { goto anon991_Else; }
anon565:
	assume wf(Heap_$_7,SecMask_$_372,SecMask_$_372);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_372);
	assume SecMask_$_373 == SecMask_$_372;
	if ($_$_condition_$388) { goto anon989_Then; } else { goto anon989_Else; }
anon990_Then:
	assume SecMask_$_374[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_375 == SecMask_$_374[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_374[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_376 == SecMask_$_375;
	goto anon569;
anon990_Else:
	assume 0 <= SecMask_$_374[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_376 == SecMask_$_374;
	goto anon569;
anon991_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_378 == SecMask_$_377[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_377[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_377[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$392) { goto anon992_Then; } else { goto anon992_Else; }
anon991_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_381 == SecMask_$_377;
	goto anon574;
anon569:
	assume wf(Heap_$_7,SecMask_$_376,SecMask_$_376);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_376);
	assume SecMask_$_377 == SecMask_$_376;
	if ($_$_condition_$391) { goto anon991_Then; } else { goto anon991_Else; }
anon992_Then:
	assume SecMask_$_378[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_379 == SecMask_$_378[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_378[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_380 == SecMask_$_379;
	goto anon573;
anon992_Else:
	assume 0 <= SecMask_$_378[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_380 == SecMask_$_378;
	goto anon573;
anon574:
	assume wf(Heap_$_7,SecMask_$_381,SecMask_$_381);
	assume SecMask_$_382 == SecMask_$_381;
	if ($_$_condition_$393) { goto anon993_Then; } else { goto anon993_Else; }
anon573:
	assume wf(Heap_$_7,SecMask_$_380,SecMask_$_380);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_380);
	assume SecMask_$_381 == SecMask_$_380;
	goto anon574;
anon577:
	assume IsGoodMask(exhaleMask#_2394_$_6);
	assume wf(Heap_$_7,exhaleMask#_2394_$_6,SecMask_$_382);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_382);
	assume SecMask_$_383 == SecMask_$_382;
	assume exhaleMask#_2394_$_7 == exhaleMask#_2394_$_6;
	if ($_$_condition_$394) { goto anon994_Then; } else { goto anon994_Else; }
anon995_Then:
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null);
	assert { :msg "  695.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2394_$_10 == exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_10);
	assume wf(Heap_$_7,exhaleMask#_2394_$_10,SecMask_$_383);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_383);
	assume exhaleMask#_2394_$_11 == exhaleMask#_2394_$_10;
	if ($_$_condition_$397) { goto anon996_Then; } else { goto anon996_Else; }
anon995_Else:
	assume Heap_$_7[r#66_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2394_$_11 == exhaleMask#_2394_$_9;
	if ($_$_condition_$398) { goto anon996_Then; } else { goto anon996_Else; }
anon996_Then:
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null);
	assert { :msg "  695.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2394_$_12 == exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_12);
	assume wf(Heap_$_7,exhaleMask#_2394_$_12,SecMask_$_383);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_383);
	assume exhaleMask#_2394_$_13 == exhaleMask#_2394_$_12;
	if ($_$_condition_$399) { goto anon997_Then; } else { goto anon997_Else; }
anon996_Else:
	assume Heap_$_7[r#66_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2394_$_13 == exhaleMask#_2394_$_11;
	if ($_$_condition_$400) { goto anon997_Then; } else { goto anon997_Else; }
anon997_Then:
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null);
	assert { :msg "  695.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  695.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2394_$_14 == exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$401) { goto anon998_Then; } else { goto anon998_Else; }
anon997_Else:
	assume Heap_$_7[r#66_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2394_$_15 == exhaleMask#_2394_$_13;
	assume SecMask_$_435 == SecMask_$_383;
	if ($_$_condition_$402) { goto anon1026_Then; } else { goto anon1026_Else; }
anon998_Then:
	assume false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$403) { goto anon999_Then; } else { goto anon999_Else; }
anon998_Else:
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.right])) && true) && true));
	assume SecMask_$_434 == SecMask_$_383;
	if ($_$_condition_$404) { goto anon1025_Then; } else { goto anon1025_Else; }
anon1026_Then:
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null);
	assert { :msg "  695.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2394_$_16 == exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_16);
	assume wf(Heap_$_7,exhaleMask#_2394_$_16,SecMask_$_435);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_435);
	assume exhaleMask#_2394_$_17 == exhaleMask#_2394_$_16;
	if ($_$_condition_$442) { goto anon1027_Then; } else { goto anon1027_Else; }
anon1026_Else:
	assume Heap_$_7[r#66_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2394_$_17 == exhaleMask#_2394_$_15;
	if ($_$_condition_$443) { goto anon1027_Then; } else { goto anon1027_Else; }
anon999_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#701 : Integer :: ( ((0 <= lk#79#701) && (lk#79#701 < Seq#Length(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#701) < Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key]) ));
	if ($_$_condition_$405) { goto anon1000_Then; } else { goto anon1000_Else; }
anon999_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$406) { goto anon1000_Then; } else { goto anon1000_Else; }
anon1025_Then:
	assume !CanRead(exhaleMask#_2394_$_14,SecMask_$_434,Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_2393_$_0[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon641;
anon1025_Else:
	assume CanRead(exhaleMask#_2394_$_14,SecMask_$_434,Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon641;
anon1000_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$407) { goto anon1001_Then; } else { goto anon1001_Else; }
anon1000_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$408) { goto anon1001_Then; } else { goto anon1001_Else; }
anon1001_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#702 : Integer :: ( ((0 <= rk#80#702) && (rk#80#702 < Seq#Length(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#702)) ));
	if ($_$_condition_$409) { goto anon1002_Then; } else { goto anon1002_Else; }
anon1001_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	if ($_$_condition_$410) { goto anon1002_Then; } else { goto anon1002_Else; }
anon1002_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon594;
anon1002_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon594;
anon594:
	assume Seq#Equal(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key])),ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$9 : Integer :: ( Seq#Contains(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$9) <==> ((((!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$9)) || ((!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$9))) || (kk#81_$9 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume SecMask_$_384 == SecMask_$_383[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_383[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R := SecMask_$_383[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$411) { goto anon1003_Then; } else { goto anon1003_Else; }
anon1003_Then:
	assume SecMask_$_384[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_385 == SecMask_$_384[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_384[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_386 == SecMask_$_385;
	goto anon596;
anon1003_Else:
	assume 0 <= SecMask_$_384[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_386 == SecMask_$_384;
	goto anon596;
anon596:
	assume wf(Heap_$_7,SecMask_$_386,SecMask_$_386);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_386);
	assume SecMask_$_387 == SecMask_$_386[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_386[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_386[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$412) { goto anon1004_Then; } else { goto anon1004_Else; }
anon1004_Then:
	assume SecMask_$_387[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_388 == SecMask_$_387[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_387[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_389 == SecMask_$_388;
	goto anon598;
anon1004_Else:
	assume 0 <= SecMask_$_387[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_389 == SecMask_$_387;
	goto anon598;
anon598:
	assume wf(Heap_$_7,SecMask_$_389,SecMask_$_389);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_389);
	assume SecMask_$_390 == SecMask_$_389[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_389[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_389[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$413) { goto anon1005_Then; } else { goto anon1005_Else; }
anon1005_Then:
	assume SecMask_$_390[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_391 == SecMask_$_390[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_390[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_392 == SecMask_$_391;
	goto anon600;
anon1005_Else:
	assume 0 <= SecMask_$_390[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_392 == SecMask_$_390;
	goto anon600;
anon600:
	assume wf(Heap_$_7,SecMask_$_392,SecMask_$_392);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_392);
	assume SecMask_$_393 == SecMask_$_392[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_392[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_392[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$414) { goto anon1006_Then; } else { goto anon1006_Else; }
anon1006_Then:
	assume SecMask_$_393[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_394 == SecMask_$_393[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_393[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_395 == SecMask_$_394;
	goto anon602;
anon1006_Else:
	assume 0 <= SecMask_$_393[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_395 == SecMask_$_393;
	goto anon602;
anon602:
	assume wf(Heap_$_7,SecMask_$_395,SecMask_$_395);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_395);
	assume SecMask_$_396 == SecMask_$_395[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_395[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_395[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$415) { goto anon1007_Then; } else { goto anon1007_Else; }
anon1007_Then:
	assume SecMask_$_396[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_397 == SecMask_$_396[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_396[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_398 == SecMask_$_397;
	goto anon604;
anon1007_Else:
	assume 0 <= SecMask_$_396[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_398 == SecMask_$_396;
	goto anon604;
anon604:
	assume wf(Heap_$_7,SecMask_$_398,SecMask_$_398);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_398);
	assume SecMask_$_399 == SecMask_$_398[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_398[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_398[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$416) { goto anon1008_Then; } else { goto anon1008_Else; }
anon1008_Then:
	assume SecMask_$_399[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_400 == SecMask_$_399[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_399[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_401 == SecMask_$_400;
	goto anon606;
anon1008_Else:
	assume 0 <= SecMask_$_399[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_401 == SecMask_$_399;
	goto anon606;
anon606:
	assume wf(Heap_$_7,SecMask_$_401,SecMask_$_401);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_401);
	if ($_$_condition_$417) { goto anon1009_Then; } else { goto anon1009_Else; }
anon1009_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_402 == SecMask_$_401[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_401[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_401[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$418) { goto anon1010_Then; } else { goto anon1010_Else; }
anon1009_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_405 == SecMask_$_401;
	if ($_$_condition_$419) { goto anon1011_Then; } else { goto anon1011_Else; }
anon1010_Then:
	assume SecMask_$_402[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_403 == SecMask_$_402[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_402[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_404 == SecMask_$_403;
	goto anon609;
anon1010_Else:
	assume 0 <= SecMask_$_402[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_404 == SecMask_$_402;
	goto anon609;
anon1011_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_406 == SecMask_$_405[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_405[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_405[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$421) { goto anon1012_Then; } else { goto anon1012_Else; }
anon1011_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_409 == SecMask_$_405;
	if ($_$_condition_$422) { goto anon1013_Then; } else { goto anon1013_Else; }
anon609:
	assume wf(Heap_$_7,SecMask_$_404,SecMask_$_404);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_404);
	assume SecMask_$_405 == SecMask_$_404;
	if ($_$_condition_$420) { goto anon1011_Then; } else { goto anon1011_Else; }
anon1012_Then:
	assume SecMask_$_406[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_407 == SecMask_$_406[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_406[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_408 == SecMask_$_407;
	goto anon613;
anon1012_Else:
	assume 0 <= SecMask_$_406[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_408 == SecMask_$_406;
	goto anon613;
anon1013_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_410 == SecMask_$_409[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_409[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_409[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$424) { goto anon1014_Then; } else { goto anon1014_Else; }
anon1013_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_413 == SecMask_$_409;
	if ($_$_condition_$425) { goto anon1015_Then; } else { goto anon1015_Else; }
anon613:
	assume wf(Heap_$_7,SecMask_$_408,SecMask_$_408);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_408);
	assume SecMask_$_409 == SecMask_$_408;
	if ($_$_condition_$423) { goto anon1013_Then; } else { goto anon1013_Else; }
anon1014_Then:
	assume SecMask_$_410[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_411 == SecMask_$_410[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_410[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_412 == SecMask_$_411;
	goto anon617;
anon1014_Else:
	assume 0 <= SecMask_$_410[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_412 == SecMask_$_410;
	goto anon617;
anon1015_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_414 == SecMask_$_413[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_413[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_413[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$427) { goto anon1016_Then; } else { goto anon1016_Else; }
anon1015_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_417 == SecMask_$_413;
	if ($_$_condition_$428) { goto anon1017_Then; } else { goto anon1017_Else; }
anon617:
	assume wf(Heap_$_7,SecMask_$_412,SecMask_$_412);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_412);
	assume SecMask_$_413 == SecMask_$_412;
	if ($_$_condition_$426) { goto anon1015_Then; } else { goto anon1015_Else; }
anon1016_Then:
	assume SecMask_$_414[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_415 == SecMask_$_414[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_414[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_416 == SecMask_$_415;
	goto anon621;
anon1016_Else:
	assume 0 <= SecMask_$_414[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_416 == SecMask_$_414;
	goto anon621;
anon1017_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_418 == SecMask_$_417[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_417[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_417[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$430) { goto anon1018_Then; } else { goto anon1018_Else; }
anon1017_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_421 == SecMask_$_417;
	if ($_$_condition_$431) { goto anon1019_Then; } else { goto anon1019_Else; }
anon621:
	assume wf(Heap_$_7,SecMask_$_416,SecMask_$_416);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_416);
	assume SecMask_$_417 == SecMask_$_416;
	if ($_$_condition_$429) { goto anon1017_Then; } else { goto anon1017_Else; }
anon1018_Then:
	assume SecMask_$_418[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_419 == SecMask_$_418[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_418[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_420 == SecMask_$_419;
	goto anon625;
anon1018_Else:
	assume 0 <= SecMask_$_418[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_420 == SecMask_$_418;
	goto anon625;
anon1019_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_422 == SecMask_$_421[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_421[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_421[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$433) { goto anon1020_Then; } else { goto anon1020_Else; }
anon1019_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_425 == SecMask_$_421;
	if ($_$_condition_$434) { goto anon1021_Then; } else { goto anon1021_Else; }
anon625:
	assume wf(Heap_$_7,SecMask_$_420,SecMask_$_420);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_420);
	assume SecMask_$_421 == SecMask_$_420;
	if ($_$_condition_$432) { goto anon1019_Then; } else { goto anon1019_Else; }
anon1020_Then:
	assume SecMask_$_422[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_423 == SecMask_$_422[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_422[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_424 == SecMask_$_423;
	goto anon629;
anon1020_Else:
	assume 0 <= SecMask_$_422[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_424 == SecMask_$_422;
	goto anon629;
anon1021_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_426 == SecMask_$_425[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_425[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_425[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$436) { goto anon1022_Then; } else { goto anon1022_Else; }
anon1021_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_429 == SecMask_$_425;
	if ($_$_condition_$437) { goto anon1023_Then; } else { goto anon1023_Else; }
anon629:
	assume wf(Heap_$_7,SecMask_$_424,SecMask_$_424);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_424);
	assume SecMask_$_425 == SecMask_$_424;
	if ($_$_condition_$435) { goto anon1021_Then; } else { goto anon1021_Else; }
anon1022_Then:
	assume SecMask_$_426[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_427 == SecMask_$_426[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_426[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_428 == SecMask_$_427;
	goto anon633;
anon1022_Else:
	assume 0 <= SecMask_$_426[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_428 == SecMask_$_426;
	goto anon633;
anon1023_Then:
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_430 == SecMask_$_429[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_429[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_429[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$439) { goto anon1024_Then; } else { goto anon1024_Else; }
anon1023_Else:
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_433 == SecMask_$_429;
	goto anon638;
anon633:
	assume wf(Heap_$_7,SecMask_$_428,SecMask_$_428);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_428);
	assume SecMask_$_429 == SecMask_$_428;
	if ($_$_condition_$438) { goto anon1023_Then; } else { goto anon1023_Else; }
anon1024_Then:
	assume SecMask_$_430[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_431 == SecMask_$_430[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_430[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_432 == SecMask_$_431;
	goto anon637;
anon1024_Else:
	assume 0 <= SecMask_$_430[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_432 == SecMask_$_430;
	goto anon637;
anon638:
	assume wf(Heap_$_7,SecMask_$_433,SecMask_$_433);
	assume SecMask_$_434 == SecMask_$_433;
	if ($_$_condition_$440) { goto anon1025_Then; } else { goto anon1025_Else; }
anon637:
	assume wf(Heap_$_7,SecMask_$_432,SecMask_$_432);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_432);
	assume SecMask_$_433 == SecMask_$_432;
	goto anon638;
anon641:
	assume IsGoodMask(exhaleMask#_2394_$_14);
	assume wf(Heap_$_7,exhaleMask#_2394_$_14,SecMask_$_434);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_434);
	assume exhaleMask#_2394_$_15 == exhaleMask#_2394_$_14;
	assume SecMask_$_435 == SecMask_$_434;
	if ($_$_condition_$441) { goto anon1026_Then; } else { goto anon1026_Else; }
anon1027_Then:
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null);
	assert { :msg "  695.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2394_$_18 == exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_18);
	assume wf(Heap_$_7,exhaleMask#_2394_$_18,SecMask_$_435);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_435);
	assume exhaleMask#_2394_$_19 == exhaleMask#_2394_$_18;
	if ($_$_condition_$444) { goto anon1028_Then; } else { goto anon1028_Else; }
anon1027_Else:
	assume Heap_$_7[r#66_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2394_$_19 == exhaleMask#_2394_$_17;
	if ($_$_condition_$445) { goto anon1028_Then; } else { goto anon1028_Else; }
anon1028_Then:
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null);
	assert { :msg "  695.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2394_$_19[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_19[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2394_$_19[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2394_$_20 == exhaleMask#_2394_$_19[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_2394_$_19[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2394_$_19[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_20);
	assume wf(Heap_$_7,exhaleMask#_2394_$_20,SecMask_$_435);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_435);
	assume exhaleMask#_2394_$_21 == exhaleMask#_2394_$_20;
	goto anon648;
anon1028_Else:
	assume Heap_$_7[r#66_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2394_$_21 == exhaleMask#_2394_$_19;
	goto anon648;
anon648:
	assume IsGoodExhaleState(exhaleHeap#_2393_$_0,Heap_$_7,exhaleMask#_2394_$_21,SecMask_$_435);
	assume IsGoodMask(exhaleMask#_2394_$_21);
	assume wf(exhaleHeap#_2393_$_0,exhaleMask#_2394_$_21,SecMask_$_435);
	assume !(r#66_$_0 == null);
	assume wf(exhaleHeap#_2393_$_0,exhaleMask#_2394_$_21,SecMask_$_435);
	assume Fractions(100) > 0;
	assume Mask_$_72 == exhaleMask#_2394_$_21[r#66_$_0,AVLTreeNode.valid := exhaleMask#_2394_$_21[r#66_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_2394_$_21[r#66_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_72);
	assume IsGoodState(heapFragment(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_2393_$_0,Mask_$_72,SecMask_$_435);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_72,SecMask_$_435);
	assume !(r#66_$_0 == null);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_72,SecMask_$_435);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_73 == Mask_$_72[r#66_$_0,AVLTreeNode.height := Mask_$_72[r#66_$_0,AVLTreeNode.height][perm$R := Mask_$_72[r#66_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_73);
	assume IsGoodState(heapFragment(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_2393_$_0,Mask_$_73,SecMask_$_435);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_73,SecMask_$_435);
	assume !(r#66_$_0 == null);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_73,SecMask_$_435);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_74 == Mask_$_73[r#66_$_0,AVLTreeNode.keys := Mask_$_73[r#66_$_0,AVLTreeNode.keys][perm$R := Mask_$_73[r#66_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_74);
	assume IsGoodState(heapFragment(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_2393_$_0,Mask_$_74,SecMask_$_435);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_74,SecMask_$_435);
	assume !(r#66_$_0 == null);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_74,SecMask_$_435);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_75 == Mask_$_74[r#66_$_0,AVLTreeNode.balanceFactor := Mask_$_74[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_74[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_75);
	assume IsGoodState(heapFragment(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_435);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_435);
	assume Seq#Equal(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_7[r#66_$_0,AVLTreeNode.key])),ite(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.height] == ite(ite(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.balanceFactor] == (ite(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null,0,Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null,0,Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_75);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_435);
	assert { :msg "  643.2: The postcondition at 670.11 might not hold. The expression at 670.11 might not evaluate to true." } !(r#66_$_0 == null);
	assert { :msg "  643.2: The postcondition at 676.11 might not hold. The expression at 676.11 might not evaluate to true." } exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.height] == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height];
	assert { :msg "  643.2: The postcondition at 677.11 might not hold. The expression at 677.11 might not evaluate to true." } Seq#Equal(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Singleton(Heap[this,AVLTreeNode.key])),ite(Heap[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assert { :msg "  643.2: The postcondition at 671.11 might not hold. The permission at 671.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  643.2: The postcondition at 671.11 might not hold. Insufficient fraction at 671.11 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_75[r#66_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_75[r#66_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_75[r#66_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2444_$_0 == Mask_$_75[r#66_$_0,AVLTreeNode.valid := Mask_$_75[r#66_$_0,AVLTreeNode.valid][perm$R := Mask_$_75[r#66_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$446) { goto anon1029_Then; } else { goto anon1029_Else; }
anon1029_Then:
	assume false || ((((predVer#_2192_$_0 == exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true);
	if ($_$_condition_$447) { goto anon1030_Then; } else { goto anon1030_Else; }
anon1029_Else:
	assume !(false || ((((predVer#_2192_$_0 == exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true));
	assume SecMask_$_486 == SecMask_$_435;
	if ($_$_condition_$448) { goto anon1056_Then; } else { goto anon1056_Else; }
anon1030_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#706 : Integer :: ( ((0 <= lk#79#706) && (lk#79#706 < Seq#Length(exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#706) < exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.key]) ));
	if ($_$_condition_$449) { goto anon1031_Then; } else { goto anon1031_Else; }
anon1030_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$450) { goto anon1031_Then; } else { goto anon1031_Else; }
anon1056_Then:
	assume !CanRead(exhaleMask#_2444_$_0,SecMask_$_486,r#66_$_0,AVLTreeNode.valid);
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.valid] < exhaleHeap#_2443_$_0[r#66_$_0,AVLTreeNode.valid];
	goto anon704;
anon1056_Else:
	assume CanRead(exhaleMask#_2444_$_0,SecMask_$_486,r#66_$_0,AVLTreeNode.valid);
	goto anon704;
anon1031_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$451) { goto anon1032_Then; } else { goto anon1032_Else; }
anon1031_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$452) { goto anon1032_Then; } else { goto anon1032_Else; }
anon1032_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#707 : Integer :: ( ((0 <= rk#80#707) && (rk#80#707 < Seq#Length(exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.key] < Seq#Index(exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#707)) ));
	if ($_$_condition_$453) { goto anon1033_Then; } else { goto anon1033_Else; }
anon1032_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	if ($_$_condition_$454) { goto anon1033_Then; } else { goto anon1033_Else; }
anon1033_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon657;
anon1033_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	goto anon657;
anon657:
	assume Seq#Equal(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.key])),ite(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.keys],exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.key]);
	assume (forall  kk#81_$10 : Integer :: ( Seq#Contains(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.keys],kk#81_$10) <==> ((((!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$10)) || ((!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$10))) || (kk#81_$10 == exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.key])) ));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.height] == ite(ite(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.height] > 0;
	assume SecMask_$_436 == SecMask_$_435[r#66_$_0,AVLTreeNode.key := SecMask_$_435[r#66_$_0,AVLTreeNode.key][perm$R := SecMask_$_435[r#66_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$455) { goto anon1034_Then; } else { goto anon1034_Else; }
anon1034_Then:
	assume SecMask_$_436[r#66_$_0,AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_437 == SecMask_$_436[r#66_$_0,AVLTreeNode.key := SecMask_$_436[r#66_$_0,AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_438 == SecMask_$_437;
	goto anon659;
anon1034_Else:
	assume 0 <= SecMask_$_436[r#66_$_0,AVLTreeNode.key][perm$R];
	assume SecMask_$_438 == SecMask_$_436;
	goto anon659;
anon659:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_438,SecMask_$_438);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_438);
	assume SecMask_$_439 == SecMask_$_438[r#66_$_0,AVLTreeNode.height := SecMask_$_438[r#66_$_0,AVLTreeNode.height][perm$R := SecMask_$_438[r#66_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$456) { goto anon1035_Then; } else { goto anon1035_Else; }
anon1035_Then:
	assume SecMask_$_439[r#66_$_0,AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_440 == SecMask_$_439[r#66_$_0,AVLTreeNode.height := SecMask_$_439[r#66_$_0,AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_441 == SecMask_$_440;
	goto anon661;
anon1035_Else:
	assume 0 <= SecMask_$_439[r#66_$_0,AVLTreeNode.height][perm$R];
	assume SecMask_$_441 == SecMask_$_439;
	goto anon661;
anon661:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_441,SecMask_$_441);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_441);
	assume SecMask_$_442 == SecMask_$_441[r#66_$_0,AVLTreeNode.left := SecMask_$_441[r#66_$_0,AVLTreeNode.left][perm$R := SecMask_$_441[r#66_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$457) { goto anon1036_Then; } else { goto anon1036_Else; }
anon1036_Then:
	assume SecMask_$_442[r#66_$_0,AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_443 == SecMask_$_442[r#66_$_0,AVLTreeNode.left := SecMask_$_442[r#66_$_0,AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_444 == SecMask_$_443;
	goto anon663;
anon1036_Else:
	assume 0 <= SecMask_$_442[r#66_$_0,AVLTreeNode.left][perm$R];
	assume SecMask_$_444 == SecMask_$_442;
	goto anon663;
anon663:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_444,SecMask_$_444);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_444);
	assume SecMask_$_445 == SecMask_$_444[r#66_$_0,AVLTreeNode.right := SecMask_$_444[r#66_$_0,AVLTreeNode.right][perm$R := SecMask_$_444[r#66_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$458) { goto anon1037_Then; } else { goto anon1037_Else; }
anon1037_Then:
	assume SecMask_$_445[r#66_$_0,AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_446 == SecMask_$_445[r#66_$_0,AVLTreeNode.right := SecMask_$_445[r#66_$_0,AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_447 == SecMask_$_446;
	goto anon665;
anon1037_Else:
	assume 0 <= SecMask_$_445[r#66_$_0,AVLTreeNode.right][perm$R];
	assume SecMask_$_447 == SecMask_$_445;
	goto anon665;
anon665:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_447,SecMask_$_447);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_447);
	assume SecMask_$_448 == SecMask_$_447[r#66_$_0,AVLTreeNode.keys := SecMask_$_447[r#66_$_0,AVLTreeNode.keys][perm$R := SecMask_$_447[r#66_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$459) { goto anon1038_Then; } else { goto anon1038_Else; }
anon1038_Then:
	assume SecMask_$_448[r#66_$_0,AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_449 == SecMask_$_448[r#66_$_0,AVLTreeNode.keys := SecMask_$_448[r#66_$_0,AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_450 == SecMask_$_449;
	goto anon667;
anon1038_Else:
	assume 0 <= SecMask_$_448[r#66_$_0,AVLTreeNode.keys][perm$R];
	assume SecMask_$_450 == SecMask_$_448;
	goto anon667;
anon667:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_450,SecMask_$_450);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_450);
	assume SecMask_$_451 == SecMask_$_450[r#66_$_0,AVLTreeNode.balanceFactor := SecMask_$_450[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := SecMask_$_450[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$460) { goto anon1039_Then; } else { goto anon1039_Else; }
anon1039_Then:
	assume SecMask_$_451[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_452 == SecMask_$_451[r#66_$_0,AVLTreeNode.balanceFactor := SecMask_$_451[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_453 == SecMask_$_452;
	goto anon669;
anon1039_Else:
	assume 0 <= SecMask_$_451[r#66_$_0,AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_453 == SecMask_$_451;
	goto anon669;
anon669:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_453,SecMask_$_453);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_453);
	if ($_$_condition_$461) { goto anon1040_Then; } else { goto anon1040_Else; }
anon1040_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_454 == SecMask_$_453[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_453[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_453[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$462) { goto anon1041_Then; } else { goto anon1041_Else; }
anon1040_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_457 == SecMask_$_453;
	if ($_$_condition_$463) { goto anon1042_Then; } else { goto anon1042_Else; }
anon1041_Then:
	assume SecMask_$_454[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_455 == SecMask_$_454[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_454[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_456 == SecMask_$_455;
	goto anon672;
anon1041_Else:
	assume 0 <= SecMask_$_454[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_456 == SecMask_$_454;
	goto anon672;
anon1042_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_458 == SecMask_$_457[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_457[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_457[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$465) { goto anon1043_Then; } else { goto anon1043_Else; }
anon1042_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_461 == SecMask_$_457;
	if ($_$_condition_$466) { goto anon1044_Then; } else { goto anon1044_Else; }
anon672:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_456,SecMask_$_456);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_456);
	assume SecMask_$_457 == SecMask_$_456;
	if ($_$_condition_$464) { goto anon1042_Then; } else { goto anon1042_Else; }
anon1043_Then:
	assume SecMask_$_458[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_459 == SecMask_$_458[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_458[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_460 == SecMask_$_459;
	goto anon676;
anon1043_Else:
	assume 0 <= SecMask_$_458[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_460 == SecMask_$_458;
	goto anon676;
anon1044_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_462 == SecMask_$_461[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_461[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_461[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$468) { goto anon1045_Then; } else { goto anon1045_Else; }
anon1044_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_465 == SecMask_$_461;
	if ($_$_condition_$469) { goto anon1046_Then; } else { goto anon1046_Else; }
anon676:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_460,SecMask_$_460);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_460);
	assume SecMask_$_461 == SecMask_$_460;
	if ($_$_condition_$467) { goto anon1044_Then; } else { goto anon1044_Else; }
anon1045_Then:
	assume SecMask_$_462[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_463 == SecMask_$_462[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_462[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_464 == SecMask_$_463;
	goto anon680;
anon1045_Else:
	assume 0 <= SecMask_$_462[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_464 == SecMask_$_462;
	goto anon680;
anon1046_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_466 == SecMask_$_465[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_465[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_465[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$471) { goto anon1047_Then; } else { goto anon1047_Else; }
anon1046_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_469 == SecMask_$_465;
	if ($_$_condition_$472) { goto anon1048_Then; } else { goto anon1048_Else; }
anon680:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_464,SecMask_$_464);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_464);
	assume SecMask_$_465 == SecMask_$_464;
	if ($_$_condition_$470) { goto anon1046_Then; } else { goto anon1046_Else; }
anon1047_Then:
	assume SecMask_$_466[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_467 == SecMask_$_466[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_466[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_468 == SecMask_$_467;
	goto anon684;
anon1047_Else:
	assume 0 <= SecMask_$_466[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_468 == SecMask_$_466;
	goto anon684;
anon1048_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_470 == SecMask_$_469[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_469[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_469[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$474) { goto anon1049_Then; } else { goto anon1049_Else; }
anon1048_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_473 == SecMask_$_469;
	if ($_$_condition_$475) { goto anon1050_Then; } else { goto anon1050_Else; }
anon684:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_468,SecMask_$_468);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_468);
	assume SecMask_$_469 == SecMask_$_468;
	if ($_$_condition_$473) { goto anon1048_Then; } else { goto anon1048_Else; }
anon1049_Then:
	assume SecMask_$_470[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_471 == SecMask_$_470[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_470[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_472 == SecMask_$_471;
	goto anon688;
anon1049_Else:
	assume 0 <= SecMask_$_470[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_472 == SecMask_$_470;
	goto anon688;
anon1050_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_474 == SecMask_$_473[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_473[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_473[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$477) { goto anon1051_Then; } else { goto anon1051_Else; }
anon1050_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_477 == SecMask_$_473;
	if ($_$_condition_$478) { goto anon1052_Then; } else { goto anon1052_Else; }
anon688:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_472,SecMask_$_472);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_472);
	assume SecMask_$_473 == SecMask_$_472;
	if ($_$_condition_$476) { goto anon1050_Then; } else { goto anon1050_Else; }
anon1051_Then:
	assume SecMask_$_474[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_475 == SecMask_$_474[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_474[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_476 == SecMask_$_475;
	goto anon692;
anon1051_Else:
	assume 0 <= SecMask_$_474[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_476 == SecMask_$_474;
	goto anon692;
anon1052_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_478 == SecMask_$_477[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_477[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_477[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$480) { goto anon1053_Then; } else { goto anon1053_Else; }
anon1052_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_481 == SecMask_$_477;
	if ($_$_condition_$481) { goto anon1054_Then; } else { goto anon1054_Else; }
anon692:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_476,SecMask_$_476);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_476);
	assume SecMask_$_477 == SecMask_$_476;
	if ($_$_condition_$479) { goto anon1052_Then; } else { goto anon1052_Else; }
anon1053_Then:
	assume SecMask_$_478[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_479 == SecMask_$_478[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_478[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_480 == SecMask_$_479;
	goto anon696;
anon1053_Else:
	assume 0 <= SecMask_$_478[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_480 == SecMask_$_478;
	goto anon696;
anon1054_Then:
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_482 == SecMask_$_481[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_481[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_481[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$483) { goto anon1055_Then; } else { goto anon1055_Else; }
anon1054_Else:
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_485 == SecMask_$_481;
	goto anon701;
anon696:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_480,SecMask_$_480);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_480);
	assume SecMask_$_481 == SecMask_$_480;
	if ($_$_condition_$482) { goto anon1054_Then; } else { goto anon1054_Else; }
anon1055_Then:
	assume SecMask_$_482[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_483 == SecMask_$_482[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_482[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_484 == SecMask_$_483;
	goto anon700;
anon1055_Else:
	assume 0 <= SecMask_$_482[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_484 == SecMask_$_482;
	goto anon700;
anon701:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_485,SecMask_$_485);
	assume SecMask_$_486 == SecMask_$_485;
	if ($_$_condition_$484) { goto anon1056_Then; } else { goto anon1056_Else; }
anon700:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_484,SecMask_$_484);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_484);
	assume SecMask_$_485 == SecMask_$_484;
	goto anon701;
anon704:
	assume IsGoodMask(exhaleMask#_2444_$_0);
	assume wf(exhaleHeap#_2393_$_0,exhaleMask#_2444_$_0,SecMask_$_486);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_486);
	assert { :msg "  643.2: The postcondition at 672.11 might not hold. The permission at 672.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  643.2: The postcondition at 672.11 might not hold. Insufficient fraction at 672.11 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2444_$_0[r#66_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2444_$_0[r#66_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2444_$_0[r#66_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2444_$_1 == exhaleMask#_2444_$_0[r#66_$_0,AVLTreeNode.height := exhaleMask#_2444_$_0[r#66_$_0,AVLTreeNode.height][perm$R := exhaleMask#_2444_$_0[r#66_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2444_$_1);
	assume wf(exhaleHeap#_2393_$_0,exhaleMask#_2444_$_1,SecMask_$_486);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_486);
	assert { :msg "  643.2: The postcondition at 673.11 might not hold. The permission at 673.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  643.2: The postcondition at 673.11 might not hold. Insufficient fraction at 673.11 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2444_$_1[r#66_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2444_$_1[r#66_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2444_$_1[r#66_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2444_$_2 == exhaleMask#_2444_$_1[r#66_$_0,AVLTreeNode.keys := exhaleMask#_2444_$_1[r#66_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_2444_$_1[r#66_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2444_$_2);
	assume wf(exhaleHeap#_2393_$_0,exhaleMask#_2444_$_2,SecMask_$_486);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_486);
	assert { :msg "  643.2: The postcondition at 674.11 might not hold. The permission at 674.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  643.2: The postcondition at 674.11 might not hold. Insufficient fraction at 674.11 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2444_$_2[r#66_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2444_$_2[r#66_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2444_$_2[r#66_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2444_$_3 == exhaleMask#_2444_$_2[r#66_$_0,AVLTreeNode.balanceFactor := exhaleMask#_2444_$_2[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2444_$_2[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2444_$_3);
	assume wf(exhaleHeap#_2393_$_0,exhaleMask#_2444_$_3,SecMask_$_486);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_486);
	assume IsGoodExhaleState(exhaleHeap#_2443_$_0,exhaleHeap#_2393_$_0,exhaleMask#_2444_$_3,SecMask_$_486);
	assume IsGoodMask(exhaleMask#_2444_$_3);
	assume wf(exhaleHeap#_2443_$_0,exhaleMask#_2444_$_3,SecMask_$_486);
	assert { :msg "  643.2: Method might lock/unlock more than allowed." } (forall  lk#_2465 : ref :: {exhaleHeap#_2443_$_0[lk#_2465,held]} {exhaleHeap#_2443_$_0[lk#_2465,rdheld]} ( (((0 < exhaleHeap#_2443_$_0[lk#_2465,held]) <==> (0 < Heap[lk#_2465,held])) && (exhaleHeap#_2443_$_0[lk#_2465,rdheld] <==> Heap[lk#_2465,rdheld])) || false ));
	assert { :msg "  643.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
}
