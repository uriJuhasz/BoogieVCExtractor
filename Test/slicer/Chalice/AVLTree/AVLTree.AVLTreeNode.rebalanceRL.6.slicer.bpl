type Integer = int;
type Boolean = bool;
type HeapType = <a>[ref,Field (a)]a;
type MaskType = <a>[ref,Field (a)][PermissionComponent]int;
type CreditsType = [ref]int;
type ArgSeq = <T>[int]T;
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
function Fractions(int) : int;
function IsGoodState(PartialHeapType) : bool;
function heapFragment <T> (T) : PartialHeapType;
function dtype(ref) : TypeName;
function MuBelow(Mu,Mu) : bool;
function wf(HeapType,MaskType,MaskType) : bool;
function IsGoodExhaleState(HeapType,HeapType,MaskType,MaskType) : bool;
function CanRead <T> (MaskType,MaskType,ref,Field (T)) : bool;
function CanWrite <T> (MaskType,ref,Field (T)) : bool;
function IsGoodMask(MaskType) : bool;
function DecPerm <T> (MaskType,ref,Field (T),int) : MaskType;
function IncPerm <T> (MaskType,ref,Field (T),int) : MaskType;
function NonPredicateField <T> (Field (T)) : bool;
function PredicateField <T> (Field (T)) : bool;
function ite <T> (bool,T,T) : T;
function Seq#Length <T> (Seq (T)) : int;
function Seq#Empty <T> () : Seq (T);
function Seq#Singleton <T> (T) : Seq (T);
function Seq#Build <T> (Seq (T),int,T,int) : Seq (T);
function Seq#Append <T> (Seq (T),Seq (T)) : Seq (T);
function Seq#Index <T> (Seq (T),int) : T;
function Seq#Contains <T> (Seq (T),T) : bool;
function Seq#Equal <T> (Seq (T),Seq (T)) : bool;
function Seq#Take <T> (Seq (T),int) : Seq (T);
function Seq#Drop <T> (Seq (T),int) : Seq (T);
function Seq#Range(int,int) : Seq (int);
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
	var k#98#644 : int;
	var unfoldK#_2216 : int;
	var k#99#653 : int;
	var unfoldK#_2244 : int;
	var k#100#662 : int;
	var methodCallK#_2276 : int;
	var this#664 : ref;
	var k#101#678 : int;
	var methodCallK#_2337 : int;
	var this#680 : ref;
	var methodCallK#_2392 : int;
	var this#693 : ref;
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
	var $_$_condition_$2 : bool;
	var $_$_condition_$4 : bool;
	var $_$_condition_$6 : bool;
	var $_$_condition_$8 : bool;
	var $_$_condition_$9 : bool;
	var $_$_condition_$10 : bool;
	var $_$_condition_$12 : bool;
	var $_$_condition_$14 : bool;
	var $_$_condition_$16 : bool;
	var $_$_condition_$18 : bool;
	var $_$_condition_$20 : bool;
	var $_$_condition_$22 : bool;
	var $_$_condition_$24 : bool;
	var $_$_condition_$26 : bool;
	var $_$_condition_$28 : bool;
	var $_$_condition_$30 : bool;
	var $_$_condition_$32 : bool;
	var $_$_condition_$33 : bool;
	var $_$_condition_$34 : bool;
	var $_$_condition_$35 : bool;
	var $_$_condition_$37 : bool;
	var $_$_condition_$39 : bool;
	var $_$_condition_$41 : bool;
	var $_$_condition_$42 : bool;
	var $_$_condition_$43 : bool;
	var $_$_condition_$44 : bool;
	var $_$_condition_$45 : bool;
	var $_$_condition_$46 : bool;
	var $_$_condition_$47 : bool;
	var $_$_condition_$48 : bool;
	var $_$_condition_$49 : bool;
	var $_$_condition_$51 : bool;
	var $_$_condition_$52 : bool;
	var $_$_condition_$54 : bool;
	var $_$_condition_$55 : bool;
	var $_$_condition_$57 : bool;
	var $_$_condition_$58 : bool;
	var $_$_condition_$60 : bool;
	var $_$_condition_$61 : bool;
	var $_$_condition_$63 : bool;
	var $_$_condition_$64 : bool;
	var $_$_condition_$66 : bool;
	var $_$_condition_$67 : bool;
	var $_$_condition_$69 : bool;
	var $_$_condition_$71 : bool;
	var $_$_condition_$72 : bool;
	var $_$_condition_$74 : bool;
	var $_$_condition_$76 : bool;
	var $_$_condition_$78 : bool;
	var $_$_condition_$80 : bool;
	var $_$_condition_$82 : bool;
	var $_$_condition_$84 : bool;
	var $_$_condition_$86 : bool;
	var $_$_condition_$88 : bool;
	var $_$_condition_$90 : bool;
	var $_$_condition_$92 : bool;
	var $_$_condition_$94 : bool;
	var $_$_condition_$95 : bool;
	var $_$_condition_$96 : bool;
	var $_$_condition_$97 : bool;
	var $_$_condition_$99 : bool;
	var $_$_condition_$101 : bool;
	var $_$_condition_$103 : bool;
	var $_$_condition_$104 : bool;
	var $_$_condition_$105 : bool;
	var $_$_condition_$106 : bool;
	var $_$_condition_$107 : bool;
	var $_$_condition_$108 : bool;
	var $_$_condition_$109 : bool;
	var $_$_condition_$110 : bool;
	var $_$_condition_$111 : bool;
	var $_$_condition_$113 : bool;
	var $_$_condition_$114 : bool;
	var $_$_condition_$116 : bool;
	var $_$_condition_$117 : bool;
	var $_$_condition_$119 : bool;
	var $_$_condition_$120 : bool;
	var $_$_condition_$122 : bool;
	var $_$_condition_$123 : bool;
	var $_$_condition_$125 : bool;
	var $_$_condition_$126 : bool;
	var $_$_condition_$128 : bool;
	var $_$_condition_$129 : bool;
	var $_$_condition_$131 : bool;
	var $_$_condition_$133 : bool;
	var $_$_condition_$134 : bool;
	var $_$_condition_$136 : bool;
	var $_$_condition_$138 : bool;
	var $_$_condition_$140 : bool;
	var $_$_condition_$142 : bool;
	var $_$_condition_$144 : bool;
	var $_$_condition_$146 : bool;
	var $_$_condition_$148 : bool;
	var $_$_condition_$150 : bool;
	var $_$_condition_$152 : bool;
	var $_$_condition_$154 : bool;
	var $_$_condition_$156 : bool;
	var $_$_condition_$157 : bool;
	var $_$_condition_$158 : bool;
	var $_$_condition_$160 : bool;
	var $_$_condition_$161 : bool;
	var $_$_condition_$162 : bool;
	var $_$_condition_$163 : bool;
	var $_$_condition_$164 : bool;
	var $_$_condition_$165 : bool;
	var $_$_condition_$167 : bool;
	var $_$_condition_$169 : bool;
	var $_$_condition_$171 : bool;
	var $_$_condition_$172 : bool;
	var $_$_condition_$173 : bool;
	var $_$_condition_$174 : bool;
	var $_$_condition_$175 : bool;
	var $_$_condition_$176 : bool;
	var $_$_condition_$177 : bool;
	var $_$_condition_$178 : bool;
	var $_$_condition_$179 : bool;
	var $_$_condition_$181 : bool;
	var $_$_condition_$182 : bool;
	var $_$_condition_$184 : bool;
	var $_$_condition_$185 : bool;
	var $_$_condition_$187 : bool;
	var $_$_condition_$188 : bool;
	var $_$_condition_$190 : bool;
	var $_$_condition_$191 : bool;
	var $_$_condition_$193 : bool;
	var $_$_condition_$194 : bool;
	var $_$_condition_$196 : bool;
	var $_$_condition_$197 : bool;
	var $_$_condition_$199 : bool;
	var $_$_condition_$202 : bool;
	var $_$_condition_$204 : bool;
	var $_$_condition_$206 : bool;
	var $_$_condition_$208 : bool;
	var $_$_condition_$209 : bool;
	var $_$_condition_$210 : bool;
	var $_$_condition_$211 : bool;
	var $_$_condition_$212 : bool;
	var $_$_condition_$214 : bool;
	var $_$_condition_$216 : bool;
	var $_$_condition_$218 : bool;
	var $_$_condition_$219 : bool;
	var $_$_condition_$220 : bool;
	var $_$_condition_$221 : bool;
	var $_$_condition_$222 : bool;
	var $_$_condition_$223 : bool;
	var $_$_condition_$224 : bool;
	var $_$_condition_$225 : bool;
	var $_$_condition_$226 : bool;
	var $_$_condition_$228 : bool;
	var $_$_condition_$229 : bool;
	var $_$_condition_$231 : bool;
	var $_$_condition_$232 : bool;
	var $_$_condition_$234 : bool;
	var $_$_condition_$235 : bool;
	var $_$_condition_$237 : bool;
	var $_$_condition_$238 : bool;
	var $_$_condition_$240 : bool;
	var $_$_condition_$241 : bool;
	var $_$_condition_$243 : bool;
	var $_$_condition_$244 : bool;
	var $_$_condition_$246 : bool;
	var $_$_condition_$249 : bool;
	var $_$_condition_$251 : bool;
	var $_$_condition_$253 : bool;
	var $_$_condition_$254 : bool;
	var $_$_condition_$255 : bool;
	var $_$_condition_$257 : bool;
	var $_$_condition_$258 : bool;
	var $_$_condition_$259 : bool;
	var $_$_condition_$260 : bool;
	var $_$_condition_$261 : bool;
	var $_$_condition_$262 : bool;
	var $_$_condition_$264 : bool;
	var $_$_condition_$266 : bool;
	var $_$_condition_$268 : bool;
	var $_$_condition_$269 : bool;
	var $_$_condition_$270 : bool;
	var $_$_condition_$271 : bool;
	var $_$_condition_$272 : bool;
	var $_$_condition_$273 : bool;
	var $_$_condition_$274 : bool;
	var $_$_condition_$275 : bool;
	var $_$_condition_$276 : bool;
	var $_$_condition_$278 : bool;
	var $_$_condition_$279 : bool;
	var $_$_condition_$281 : bool;
	var $_$_condition_$282 : bool;
	var $_$_condition_$284 : bool;
	var $_$_condition_$285 : bool;
	var $_$_condition_$287 : bool;
	var $_$_condition_$288 : bool;
	var $_$_condition_$290 : bool;
	var $_$_condition_$291 : bool;
	var $_$_condition_$293 : bool;
	var $_$_condition_$294 : bool;
	var $_$_condition_$296 : bool;
	var $_$_condition_$299 : bool;
	var $_$_condition_$301 : bool;
	var $_$_condition_$303 : bool;
	var $_$_condition_$305 : bool;
	var $_$_condition_$306 : bool;
	var $_$_condition_$307 : bool;
	var $_$_condition_$308 : bool;
	var $_$_condition_$309 : bool;
	var $_$_condition_$311 : bool;
	var $_$_condition_$313 : bool;
	var $_$_condition_$315 : bool;
	var $_$_condition_$316 : bool;
	var $_$_condition_$317 : bool;
	var $_$_condition_$318 : bool;
	var $_$_condition_$319 : bool;
	var $_$_condition_$320 : bool;
	var $_$_condition_$321 : bool;
	var $_$_condition_$322 : bool;
	var $_$_condition_$323 : bool;
	var $_$_condition_$325 : bool;
	var $_$_condition_$326 : bool;
	var $_$_condition_$328 : bool;
	var $_$_condition_$329 : bool;
	var $_$_condition_$331 : bool;
	var $_$_condition_$332 : bool;
	var $_$_condition_$334 : bool;
	var $_$_condition_$335 : bool;
	var $_$_condition_$337 : bool;
	var $_$_condition_$338 : bool;
	var $_$_condition_$340 : bool;
	var $_$_condition_$341 : bool;
	var $_$_condition_$343 : bool;
	var $_$_condition_$346 : bool;
	var $_$_condition_$348 : bool;
	var $_$_condition_$350 : bool;
	var $_$_condition_$351 : bool;
	var $_$_condition_$353 : bool;
	var $_$_condition_$354 : bool;
	var $_$_condition_$355 : bool;
	var $_$_condition_$356 : bool;
	var $_$_condition_$357 : bool;
	var $_$_condition_$358 : bool;
	var $_$_condition_$360 : bool;
	var $_$_condition_$362 : bool;
	var $_$_condition_$364 : bool;
	var $_$_condition_$365 : bool;
	var $_$_condition_$366 : bool;
	var $_$_condition_$367 : bool;
	var $_$_condition_$368 : bool;
	var $_$_condition_$369 : bool;
	var $_$_condition_$370 : bool;
	var $_$_condition_$371 : bool;
	var $_$_condition_$372 : bool;
	var $_$_condition_$374 : bool;
	var $_$_condition_$375 : bool;
	var $_$_condition_$377 : bool;
	var $_$_condition_$378 : bool;
	var $_$_condition_$380 : bool;
	var $_$_condition_$381 : bool;
	var $_$_condition_$383 : bool;
	var $_$_condition_$384 : bool;
	var $_$_condition_$386 : bool;
	var $_$_condition_$387 : bool;
	var $_$_condition_$389 : bool;
	var $_$_condition_$390 : bool;
	var $_$_condition_$392 : bool;
	var $_$_condition_$395 : bool;
	var $_$_condition_$397 : bool;
	var $_$_condition_$399 : bool;
	var $_$_condition_$401 : bool;
	var $_$_condition_$402 : bool;
	var $_$_condition_$403 : bool;
	var $_$_condition_$404 : bool;
	var $_$_condition_$405 : bool;
	var $_$_condition_$407 : bool;
	var $_$_condition_$409 : bool;
	var $_$_condition_$411 : bool;
	var $_$_condition_$412 : bool;
	var $_$_condition_$413 : bool;
	var $_$_condition_$414 : bool;
	var $_$_condition_$415 : bool;
	var $_$_condition_$416 : bool;
	var $_$_condition_$417 : bool;
	var $_$_condition_$418 : bool;
	var $_$_condition_$419 : bool;
	var $_$_condition_$421 : bool;
	var $_$_condition_$422 : bool;
	var $_$_condition_$424 : bool;
	var $_$_condition_$425 : bool;
	var $_$_condition_$427 : bool;
	var $_$_condition_$428 : bool;
	var $_$_condition_$430 : bool;
	var $_$_condition_$431 : bool;
	var $_$_condition_$433 : bool;
	var $_$_condition_$434 : bool;
	var $_$_condition_$436 : bool;
	var $_$_condition_$437 : bool;
	var $_$_condition_$439 : bool;
	var $_$_condition_$442 : bool;
	var $_$_condition_$444 : bool;
	var $_$_condition_$446 : bool;
	var $_$_condition_$447 : bool;
	var $_$_condition_$448 : bool;
	var $_$_condition_$449 : bool;
	var $_$_condition_$451 : bool;
	var $_$_condition_$453 : bool;
	var $_$_condition_$455 : bool;
	var $_$_condition_$456 : bool;
	var $_$_condition_$457 : bool;
	var $_$_condition_$458 : bool;
	var $_$_condition_$459 : bool;
	var $_$_condition_$460 : bool;
	var $_$_condition_$461 : bool;
	var $_$_condition_$462 : bool;
	var $_$_condition_$463 : bool;
	var $_$_condition_$465 : bool;
	var $_$_condition_$466 : bool;
	var $_$_condition_$468 : bool;
	var $_$_condition_$469 : bool;
	var $_$_condition_$471 : bool;
	var $_$_condition_$472 : bool;
	var $_$_condition_$474 : bool;
	var $_$_condition_$475 : bool;
	var $_$_condition_$477 : bool;
	var $_$_condition_$478 : bool;
	var $_$_condition_$480 : bool;
	var $_$_condition_$481 : bool;
	var $_$_condition_$483 : bool;
$start:
	assume Permission$denominator > 0;
	assume (Permission$Zero[perm$R] == 0) && (Permission$Zero[perm$N] == 0);
	assume (Permission$Full[perm$R] == Permission$FullFraction) && (Permission$Full[perm$N] == 0);
	assume (((((forall  o_$25 : ref, f_$16 : Field (Boolean) , pc_$0 : PermissionComponent :: ( ZeroMask[o_$25,f_$16][pc_$0] == 0 ))) && ((forall  o_$26 : ref, f_$17 : Field (Integer) , pc_$1 : PermissionComponent :: ( ZeroMask[o_$26,f_$17][pc_$1] == 0 )))) && ((forall  o_$27 : ref, f_$18 : Field (ref) , pc_$2 : PermissionComponent :: ( ZeroMask[o_$27,f_$18][pc_$2] == 0 )))) && ((forall  o_$28 : ref, f_$19 : Field (Mu) , pc_$3 : PermissionComponent :: ( ZeroMask[o_$28,f_$19][pc_$3] == 0 )))) && ((forall  o_$29 : ref, f_$20 : Field (Seq (Integer) ) , pc_$4 : PermissionComponent :: ( ZeroMask[o_$29,f_$20][pc_$4] == 0 )));
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
	assume IsGoodState(emptyPartialHeap);
	assume NonPredicateField(mu);
	assume (forall  m : Mu, n_$0 : Mu :: {MuBelow(m,n_$0),MuBelow(n_$0,m)} ( !(MuBelow(m,n_$0) && MuBelow(n_$0,m)) ));
	assume (forall  m_$0 : Mu, n_$1 : Mu, o_$0 : Mu :: {MuBelow(m_$0,n_$1),MuBelow(n_$1,o_$0)} ( (MuBelow(m_$0,n_$1) && MuBelow(n_$1,o_$0)) ==> MuBelow(m_$0,o_$0) ));
	assume (forall  m_$1 : Mu, n_$2 : Mu :: ( MuBelow(m_$1,n_$2) ==> (!(n_$2 == $LockBottom)) ));
	assume NonPredicateField(held);
	assume NonPredicateField(rdheld);
	assume (forall  eh : HeapType, h_$0 : HeapType, m_$3 : MaskType, sm_$0 : MaskType :: {IsGoodExhaleState(eh,h_$0,m_$3,sm_$0)} ( IsGoodExhaleState(eh,h_$0,m_$3,sm_$0) <==> (((((((((((((forall  o_$6_$0 : ref, f_$1_$0 : Field (Boolean)  :: {eh[o_$6_$0,f_$1_$0]} ( CanRead(m_$3,sm_$0,o_$6_$0,f_$1_$0) ==> (eh[o_$6_$0,f_$1_$0] == h_$0[o_$6_$0,f_$1_$0]) ))) && ((forall  o_$6_$1 : ref, f_$1_$1 : Field (Integer)  :: {eh[o_$6_$1,f_$1_$1]} ( CanRead(m_$3,sm_$0,o_$6_$1,f_$1_$1) ==> (eh[o_$6_$1,f_$1_$1] == h_$0[o_$6_$1,f_$1_$1]) )))) && ((forall  o_$6_$2 : ref, f_$1_$2 : Field (ref)  :: {eh[o_$6_$2,f_$1_$2]} ( CanRead(m_$3,sm_$0,o_$6_$2,f_$1_$2) ==> (eh[o_$6_$2,f_$1_$2] == h_$0[o_$6_$2,f_$1_$2]) )))) && ((forall  o_$6_$3 : ref, f_$1_$3 : Field (Mu)  :: {eh[o_$6_$3,f_$1_$3]} ( CanRead(m_$3,sm_$0,o_$6_$3,f_$1_$3) ==> (eh[o_$6_$3,f_$1_$3] == h_$0[o_$6_$3,f_$1_$3]) )))) && ((forall  o_$6_$4 : ref, f_$1_$4 : Field (Seq (Integer) )  :: {eh[o_$6_$4,f_$1_$4]} ( CanRead(m_$3,sm_$0,o_$6_$4,f_$1_$4) ==> (eh[o_$6_$4,f_$1_$4] == h_$0[o_$6_$4,f_$1_$4]) )))) && ((forall  o_$7 : ref :: {eh[o_$7,held]} ( (0 < eh[o_$7,held]) <==> (0 < h_$0[o_$7,held]) )))) && ((forall  o_$8 : ref :: {eh[o_$8,rdheld]} ( eh[o_$8,rdheld] <==> h_$0[o_$8,rdheld] )))) && ((forall  o_$9 : ref :: {h_$0[o_$9,held]} ( (0 < h_$0[o_$9,held]) ==> (eh[o_$9,mu] == h_$0[o_$9,mu]) )))) && ((forall  o_$10 : ref :: {h_$0[o_$10,rdheld]} ( h_$0[o_$10,rdheld] ==> (eh[o_$10,mu] == h_$0[o_$10,mu]) )))) && ((forall  o_$11 : ref :: {h_$0[o_$11,forkK]} {eh[o_$11,forkK]} ( h_$0[o_$11,forkK] == eh[o_$11,forkK] )))) && ((forall  o_$12 : ref :: {h_$0[o_$12,held]} {eh[o_$12,held]} ( h_$0[o_$12,held] == eh[o_$12,held] )))) && ((forall  o_$13 : ref, f_$2 : Field (Integer)  :: {eh[o_$13,f_$2],PredicateField(f_$2)} ( PredicateField(f_$2) ==> (h_$0[o_$13,f_$2] <= eh[o_$13,f_$2]) )))) ));
	assume (((((forall  m_$4_$0 : MaskType, sm_$1_$0 : MaskType, obj_$2 : ref, f_$3_$0 : Field (Boolean)  :: {CanRead(m_$4_$0,sm_$1_$0,obj_$2,f_$3_$0)} ( CanRead(m_$4_$0,sm_$1_$0,obj_$2,f_$3_$0) <==> ((((0 < m_$4_$0[obj_$2,f_$3_$0][perm$R]) || (0 < m_$4_$0[obj_$2,f_$3_$0][perm$N])) || (0 < sm_$1_$0[obj_$2,f_$3_$0][perm$R])) || (0 < sm_$1_$0[obj_$2,f_$3_$0][perm$N])) ))) && ((forall  m_$4_$1 : MaskType, sm_$1_$1 : MaskType, obj_$3 : ref, f_$3_$1 : Field (Integer)  :: {CanRead(m_$4_$1,sm_$1_$1,obj_$3,f_$3_$1)} ( CanRead(m_$4_$1,sm_$1_$1,obj_$3,f_$3_$1) <==> ((((0 < m_$4_$1[obj_$3,f_$3_$1][perm$R]) || (0 < m_$4_$1[obj_$3,f_$3_$1][perm$N])) || (0 < sm_$1_$1[obj_$3,f_$3_$1][perm$R])) || (0 < sm_$1_$1[obj_$3,f_$3_$1][perm$N])) )))) && ((forall  m_$4_$2 : MaskType, sm_$1_$2 : MaskType, obj_$4 : ref, f_$3_$2 : Field (ref)  :: {CanRead(m_$4_$2,sm_$1_$2,obj_$4,f_$3_$2)} ( CanRead(m_$4_$2,sm_$1_$2,obj_$4,f_$3_$2) <==> ((((0 < m_$4_$2[obj_$4,f_$3_$2][perm$R]) || (0 < m_$4_$2[obj_$4,f_$3_$2][perm$N])) || (0 < sm_$1_$2[obj_$4,f_$3_$2][perm$R])) || (0 < sm_$1_$2[obj_$4,f_$3_$2][perm$N])) )))) && ((forall  m_$4_$3 : MaskType, sm_$1_$3 : MaskType, obj_$5 : ref, f_$3_$3 : Field (Mu)  :: {CanRead(m_$4_$3,sm_$1_$3,obj_$5,f_$3_$3)} ( CanRead(m_$4_$3,sm_$1_$3,obj_$5,f_$3_$3) <==> ((((0 < m_$4_$3[obj_$5,f_$3_$3][perm$R]) || (0 < m_$4_$3[obj_$5,f_$3_$3][perm$N])) || (0 < sm_$1_$3[obj_$5,f_$3_$3][perm$R])) || (0 < sm_$1_$3[obj_$5,f_$3_$3][perm$N])) )))) && ((forall  m_$4_$4 : MaskType, sm_$1_$4 : MaskType, obj_$6 : ref, f_$3_$4 : Field (Seq (Integer) )  :: {CanRead(m_$4_$4,sm_$1_$4,obj_$6,f_$3_$4)} ( CanRead(m_$4_$4,sm_$1_$4,obj_$6,f_$3_$4) <==> ((((0 < m_$4_$4[obj_$6,f_$3_$4][perm$R]) || (0 < m_$4_$4[obj_$6,f_$3_$4][perm$N])) || (0 < sm_$1_$4[obj_$6,f_$3_$4][perm$R])) || (0 < sm_$1_$4[obj_$6,f_$3_$4][perm$N])) )));
	assume (((((forall  m_$6_$0 : MaskType, obj_$1_$0 : ref, f_$5_$0 : Field (Boolean)  :: {CanWrite(m_$6_$0,obj_$1_$0,f_$5_$0)} ( CanWrite(m_$6_$0,obj_$1_$0,f_$5_$0) <==> ((m_$6_$0[obj_$1_$0,f_$5_$0][perm$R] == Permission$FullFraction) && (m_$6_$0[obj_$1_$0,f_$5_$0][perm$N] == 0)) ))) && ((forall  m_$6_$1 : MaskType, obj_$1_$1 : ref, f_$5_$1 : Field (Integer)  :: {CanWrite(m_$6_$1,obj_$1_$1,f_$5_$1)} ( CanWrite(m_$6_$1,obj_$1_$1,f_$5_$1) <==> ((m_$6_$1[obj_$1_$1,f_$5_$1][perm$R] == Permission$FullFraction) && (m_$6_$1[obj_$1_$1,f_$5_$1][perm$N] == 0)) )))) && ((forall  m_$6_$2 : MaskType, obj_$1_$2 : ref, f_$5_$2 : Field (ref)  :: {CanWrite(m_$6_$2,obj_$1_$2,f_$5_$2)} ( CanWrite(m_$6_$2,obj_$1_$2,f_$5_$2) <==> ((m_$6_$2[obj_$1_$2,f_$5_$2][perm$R] == Permission$FullFraction) && (m_$6_$2[obj_$1_$2,f_$5_$2][perm$N] == 0)) )))) && ((forall  m_$6_$3 : MaskType, obj_$1_$3 : ref, f_$5_$3 : Field (Mu)  :: {CanWrite(m_$6_$3,obj_$1_$3,f_$5_$3)} ( CanWrite(m_$6_$3,obj_$1_$3,f_$5_$3) <==> ((m_$6_$3[obj_$1_$3,f_$5_$3][perm$R] == Permission$FullFraction) && (m_$6_$3[obj_$1_$3,f_$5_$3][perm$N] == 0)) )))) && ((forall  m_$6_$4 : MaskType, obj_$1_$4 : ref, f_$5_$4 : Field (Seq (Integer) )  :: {CanWrite(m_$6_$4,obj_$1_$4,f_$5_$4)} ( CanWrite(m_$6_$4,obj_$1_$4,f_$5_$4) <==> ((m_$6_$4[obj_$1_$4,f_$5_$4][perm$R] == Permission$FullFraction) && (m_$6_$4[obj_$1_$4,f_$5_$4][perm$N] == 0)) )));
	assume (forall  m_$7 : MaskType :: {IsGoodMask(m_$7)} ( IsGoodMask(m_$7) <==> ((((((forall  o_$14_$0 : ref, f_$6_$0 : Field (Boolean)  :: ( ((0 <= m_$7[o_$14_$0,f_$6_$0][perm$R]) && (NonPredicateField(f_$6_$0) ==> ((m_$7[o_$14_$0,f_$6_$0][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14_$0,f_$6_$0][perm$N]) ==> (m_$7[o_$14_$0,f_$6_$0][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14_$0,f_$6_$0][perm$N] < 0) ==> (0 < m_$7[o_$14_$0,f_$6_$0][perm$R])) ))) && ((forall  o_$14_$1 : ref, f_$6_$1 : Field (Integer)  :: ( ((0 <= m_$7[o_$14_$1,f_$6_$1][perm$R]) && (NonPredicateField(f_$6_$1) ==> ((m_$7[o_$14_$1,f_$6_$1][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14_$1,f_$6_$1][perm$N]) ==> (m_$7[o_$14_$1,f_$6_$1][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14_$1,f_$6_$1][perm$N] < 0) ==> (0 < m_$7[o_$14_$1,f_$6_$1][perm$R])) )))) && ((forall  o_$14_$2 : ref, f_$6_$2 : Field (ref)  :: ( ((0 <= m_$7[o_$14_$2,f_$6_$2][perm$R]) && (NonPredicateField(f_$6_$2) ==> ((m_$7[o_$14_$2,f_$6_$2][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14_$2,f_$6_$2][perm$N]) ==> (m_$7[o_$14_$2,f_$6_$2][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14_$2,f_$6_$2][perm$N] < 0) ==> (0 < m_$7[o_$14_$2,f_$6_$2][perm$R])) )))) && ((forall  o_$14_$3 : ref, f_$6_$3 : Field (Mu)  :: ( ((0 <= m_$7[o_$14_$3,f_$6_$3][perm$R]) && (NonPredicateField(f_$6_$3) ==> ((m_$7[o_$14_$3,f_$6_$3][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14_$3,f_$6_$3][perm$N]) ==> (m_$7[o_$14_$3,f_$6_$3][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14_$3,f_$6_$3][perm$N] < 0) ==> (0 < m_$7[o_$14_$3,f_$6_$3][perm$R])) )))) && ((forall  o_$14_$4 : ref, f_$6_$4 : Field (Seq (Integer) )  :: ( ((0 <= m_$7[o_$14_$4,f_$6_$4][perm$R]) && (NonPredicateField(f_$6_$4) ==> ((m_$7[o_$14_$4,f_$6_$4][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14_$4,f_$6_$4][perm$N]) ==> (m_$7[o_$14_$4,f_$6_$4][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14_$4,f_$6_$4][perm$N] < 0) ==> (0 < m_$7[o_$14_$4,f_$6_$4][perm$R])) )))) ));
	assume (forall  h_$1 : HeapType, m_$8 : MaskType, sm_$2 : MaskType, o_$15 : ref, q : ref :: {wf(h_$1,m_$8,sm_$2),h_$1[o_$15,mu],h_$1[q,mu]} ( (((wf(h_$1,m_$8,sm_$2) && (!(o_$15 == q))) && ((0 < h_$1[o_$15,held]) || h_$1[o_$15,rdheld])) && ((0 < h_$1[q,held]) || h_$1[q,rdheld])) ==> (!(h_$1[o_$15,mu] == h_$1[q,mu])) ));
	assume (((((((((((((((((((((((((forall  m_$9_$0 : MaskType, o_$16_$0 : ref, f_$7_$0 : Field (Boolean) , howMuch_$3 : Integer, q_$0_$0 : ref, g_$4 : Field (Boolean)  :: {DecPerm(m_$9_$0,o_$16_$0,f_$7_$0,howMuch_$3)[q_$0_$0,g_$4][perm$R]} ( DecPerm(m_$9_$0,o_$16_$0,f_$7_$0,howMuch_$3)[q_$0_$0,g_$4][perm$R] == ite((o_$16_$0 == q_$0_$0) && (f_$7_$0 == g_$4),m_$9_$0[q_$0_$0,g_$4][perm$R] - howMuch_$3,m_$9_$0[q_$0_$0,g_$4][perm$R]) ))) && ((forall  m_$9_$1 : MaskType, o_$16_$1 : ref, f_$7_$1 : Field (Integer) , howMuch_$4 : Integer, q_$0_$1 : ref, g_$5 : Field (Boolean)  :: {DecPerm(m_$9_$1,o_$16_$1,f_$7_$1,howMuch_$4)[q_$0_$1,g_$5][perm$R]} ( DecPerm(m_$9_$1,o_$16_$1,f_$7_$1,howMuch_$4)[q_$0_$1,g_$5][perm$R] == ite((o_$16_$1 == q_$0_$1) && false,m_$9_$1[q_$0_$1,g_$5][perm$R] - howMuch_$4,m_$9_$1[q_$0_$1,g_$5][perm$R]) )))) && ((forall  m_$9_$2 : MaskType, o_$16_$2 : ref, f_$7_$2 : Field (ref) , howMuch_$5 : Integer, q_$0_$2 : ref, g_$6 : Field (Boolean)  :: {DecPerm(m_$9_$2,o_$16_$2,f_$7_$2,howMuch_$5)[q_$0_$2,g_$6][perm$R]} ( DecPerm(m_$9_$2,o_$16_$2,f_$7_$2,howMuch_$5)[q_$0_$2,g_$6][perm$R] == ite((o_$16_$2 == q_$0_$2) && false,m_$9_$2[q_$0_$2,g_$6][perm$R] - howMuch_$5,m_$9_$2[q_$0_$2,g_$6][perm$R]) )))) && ((forall  m_$9_$3 : MaskType, o_$16_$3 : ref, f_$7_$3 : Field (Mu) , howMuch_$6 : Integer, q_$0_$3 : ref, g_$7 : Field (Boolean)  :: {DecPerm(m_$9_$3,o_$16_$3,f_$7_$3,howMuch_$6)[q_$0_$3,g_$7][perm$R]} ( DecPerm(m_$9_$3,o_$16_$3,f_$7_$3,howMuch_$6)[q_$0_$3,g_$7][perm$R] == ite((o_$16_$3 == q_$0_$3) && false,m_$9_$3[q_$0_$3,g_$7][perm$R] - howMuch_$6,m_$9_$3[q_$0_$3,g_$7][perm$R]) )))) && ((forall  m_$9_$4 : MaskType, o_$16_$4 : ref, f_$7_$4 : Field (Seq (Integer) ) , howMuch_$7 : Integer, q_$0_$4 : ref, g_$8 : Field (Boolean)  :: {DecPerm(m_$9_$4,o_$16_$4,f_$7_$4,howMuch_$7)[q_$0_$4,g_$8][perm$R]} ( DecPerm(m_$9_$4,o_$16_$4,f_$7_$4,howMuch_$7)[q_$0_$4,g_$8][perm$R] == ite((o_$16_$4 == q_$0_$4) && false,m_$9_$4[q_$0_$4,g_$8][perm$R] - howMuch_$7,m_$9_$4[q_$0_$4,g_$8][perm$R]) )))) && ((forall  m_$9_$5 : MaskType, o_$16_$5 : ref, f_$7_$5 : Field (Boolean) , howMuch_$8 : Integer, q_$0_$5 : ref, g_$9 : Field (Integer)  :: {DecPerm(m_$9_$5,o_$16_$5,f_$7_$5,howMuch_$8)[q_$0_$5,g_$9][perm$R]} ( DecPerm(m_$9_$5,o_$16_$5,f_$7_$5,howMuch_$8)[q_$0_$5,g_$9][perm$R] == ite((o_$16_$5 == q_$0_$5) && false,m_$9_$5[q_$0_$5,g_$9][perm$R] - howMuch_$8,m_$9_$5[q_$0_$5,g_$9][perm$R]) )))) && ((forall  m_$9_$6 : MaskType, o_$16_$6 : ref, f_$7_$6 : Field (Integer) , howMuch_$9 : Integer, q_$0_$6 : ref, g_$10 : Field (Integer)  :: {DecPerm(m_$9_$6,o_$16_$6,f_$7_$6,howMuch_$9)[q_$0_$6,g_$10][perm$R]} ( DecPerm(m_$9_$6,o_$16_$6,f_$7_$6,howMuch_$9)[q_$0_$6,g_$10][perm$R] == ite((o_$16_$6 == q_$0_$6) && (f_$7_$6 == g_$10),m_$9_$6[q_$0_$6,g_$10][perm$R] - howMuch_$9,m_$9_$6[q_$0_$6,g_$10][perm$R]) )))) && ((forall  m_$9_$7 : MaskType, o_$16_$7 : ref, f_$7_$7 : Field (ref) , howMuch_$10 : Integer, q_$0_$7 : ref, g_$11 : Field (Integer)  :: {DecPerm(m_$9_$7,o_$16_$7,f_$7_$7,howMuch_$10)[q_$0_$7,g_$11][perm$R]} ( DecPerm(m_$9_$7,o_$16_$7,f_$7_$7,howMuch_$10)[q_$0_$7,g_$11][perm$R] == ite((o_$16_$7 == q_$0_$7) && false,m_$9_$7[q_$0_$7,g_$11][perm$R] - howMuch_$10,m_$9_$7[q_$0_$7,g_$11][perm$R]) )))) && ((forall  m_$9_$8 : MaskType, o_$16_$8 : ref, f_$7_$8 : Field (Mu) , howMuch_$11 : Integer, q_$0_$8 : ref, g_$12 : Field (Integer)  :: {DecPerm(m_$9_$8,o_$16_$8,f_$7_$8,howMuch_$11)[q_$0_$8,g_$12][perm$R]} ( DecPerm(m_$9_$8,o_$16_$8,f_$7_$8,howMuch_$11)[q_$0_$8,g_$12][perm$R] == ite((o_$16_$8 == q_$0_$8) && false,m_$9_$8[q_$0_$8,g_$12][perm$R] - howMuch_$11,m_$9_$8[q_$0_$8,g_$12][perm$R]) )))) && ((forall  m_$9_$9 : MaskType, o_$16_$9 : ref, f_$7_$9 : Field (Seq (Integer) ) , howMuch_$12 : Integer, q_$0_$9 : ref, g_$13 : Field (Integer)  :: {DecPerm(m_$9_$9,o_$16_$9,f_$7_$9,howMuch_$12)[q_$0_$9,g_$13][perm$R]} ( DecPerm(m_$9_$9,o_$16_$9,f_$7_$9,howMuch_$12)[q_$0_$9,g_$13][perm$R] == ite((o_$16_$9 == q_$0_$9) && false,m_$9_$9[q_$0_$9,g_$13][perm$R] - howMuch_$12,m_$9_$9[q_$0_$9,g_$13][perm$R]) )))) && ((forall  m_$9_$10 : MaskType, o_$16_$10 : ref, f_$7_$10 : Field (Boolean) , howMuch_$13 : Integer, q_$0_$10 : ref, g_$14 : Field (ref)  :: {DecPerm(m_$9_$10,o_$16_$10,f_$7_$10,howMuch_$13)[q_$0_$10,g_$14][perm$R]} ( DecPerm(m_$9_$10,o_$16_$10,f_$7_$10,howMuch_$13)[q_$0_$10,g_$14][perm$R] == ite((o_$16_$10 == q_$0_$10) && false,m_$9_$10[q_$0_$10,g_$14][perm$R] - howMuch_$13,m_$9_$10[q_$0_$10,g_$14][perm$R]) )))) && ((forall  m_$9_$11 : MaskType, o_$16_$11 : ref, f_$7_$11 : Field (Integer) , howMuch_$14 : Integer, q_$0_$11 : ref, g_$15 : Field (ref)  :: {DecPerm(m_$9_$11,o_$16_$11,f_$7_$11,howMuch_$14)[q_$0_$11,g_$15][perm$R]} ( DecPerm(m_$9_$11,o_$16_$11,f_$7_$11,howMuch_$14)[q_$0_$11,g_$15][perm$R] == ite((o_$16_$11 == q_$0_$11) && false,m_$9_$11[q_$0_$11,g_$15][perm$R] - howMuch_$14,m_$9_$11[q_$0_$11,g_$15][perm$R]) )))) && ((forall  m_$9_$12 : MaskType, o_$16_$12 : ref, f_$7_$12 : Field (ref) , howMuch_$15 : Integer, q_$0_$12 : ref, g_$16 : Field (ref)  :: {DecPerm(m_$9_$12,o_$16_$12,f_$7_$12,howMuch_$15)[q_$0_$12,g_$16][perm$R]} ( DecPerm(m_$9_$12,o_$16_$12,f_$7_$12,howMuch_$15)[q_$0_$12,g_$16][perm$R] == ite((o_$16_$12 == q_$0_$12) && (f_$7_$12 == g_$16),m_$9_$12[q_$0_$12,g_$16][perm$R] - howMuch_$15,m_$9_$12[q_$0_$12,g_$16][perm$R]) )))) && ((forall  m_$9_$13 : MaskType, o_$16_$13 : ref, f_$7_$13 : Field (Mu) , howMuch_$16 : Integer, q_$0_$13 : ref, g_$17 : Field (ref)  :: {DecPerm(m_$9_$13,o_$16_$13,f_$7_$13,howMuch_$16)[q_$0_$13,g_$17][perm$R]} ( DecPerm(m_$9_$13,o_$16_$13,f_$7_$13,howMuch_$16)[q_$0_$13,g_$17][perm$R] == ite((o_$16_$13 == q_$0_$13) && false,m_$9_$13[q_$0_$13,g_$17][perm$R] - howMuch_$16,m_$9_$13[q_$0_$13,g_$17][perm$R]) )))) && ((forall  m_$9_$14 : MaskType, o_$16_$14 : ref, f_$7_$14 : Field (Seq (Integer) ) , howMuch_$17 : Integer, q_$0_$14 : ref, g_$18 : Field (ref)  :: {DecPerm(m_$9_$14,o_$16_$14,f_$7_$14,howMuch_$17)[q_$0_$14,g_$18][perm$R]} ( DecPerm(m_$9_$14,o_$16_$14,f_$7_$14,howMuch_$17)[q_$0_$14,g_$18][perm$R] == ite((o_$16_$14 == q_$0_$14) && false,m_$9_$14[q_$0_$14,g_$18][perm$R] - howMuch_$17,m_$9_$14[q_$0_$14,g_$18][perm$R]) )))) && ((forall  m_$9_$15 : MaskType, o_$16_$15 : ref, f_$7_$15 : Field (Boolean) , howMuch_$18 : Integer, q_$0_$15 : ref, g_$19 : Field (Mu)  :: {DecPerm(m_$9_$15,o_$16_$15,f_$7_$15,howMuch_$18)[q_$0_$15,g_$19][perm$R]} ( DecPerm(m_$9_$15,o_$16_$15,f_$7_$15,howMuch_$18)[q_$0_$15,g_$19][perm$R] == ite((o_$16_$15 == q_$0_$15) && false,m_$9_$15[q_$0_$15,g_$19][perm$R] - howMuch_$18,m_$9_$15[q_$0_$15,g_$19][perm$R]) )))) && ((forall  m_$9_$16 : MaskType, o_$16_$16 : ref, f_$7_$16 : Field (Integer) , howMuch_$19 : Integer, q_$0_$16 : ref, g_$20 : Field (Mu)  :: {DecPerm(m_$9_$16,o_$16_$16,f_$7_$16,howMuch_$19)[q_$0_$16,g_$20][perm$R]} ( DecPerm(m_$9_$16,o_$16_$16,f_$7_$16,howMuch_$19)[q_$0_$16,g_$20][perm$R] == ite((o_$16_$16 == q_$0_$16) && false,m_$9_$16[q_$0_$16,g_$20][perm$R] - howMuch_$19,m_$9_$16[q_$0_$16,g_$20][perm$R]) )))) && ((forall  m_$9_$17 : MaskType, o_$16_$17 : ref, f_$7_$17 : Field (ref) , howMuch_$20 : Integer, q_$0_$17 : ref, g_$21 : Field (Mu)  :: {DecPerm(m_$9_$17,o_$16_$17,f_$7_$17,howMuch_$20)[q_$0_$17,g_$21][perm$R]} ( DecPerm(m_$9_$17,o_$16_$17,f_$7_$17,howMuch_$20)[q_$0_$17,g_$21][perm$R] == ite((o_$16_$17 == q_$0_$17) && false,m_$9_$17[q_$0_$17,g_$21][perm$R] - howMuch_$20,m_$9_$17[q_$0_$17,g_$21][perm$R]) )))) && ((forall  m_$9_$18 : MaskType, o_$16_$18 : ref, f_$7_$18 : Field (Mu) , howMuch_$21 : Integer, q_$0_$18 : ref, g_$22 : Field (Mu)  :: {DecPerm(m_$9_$18,o_$16_$18,f_$7_$18,howMuch_$21)[q_$0_$18,g_$22][perm$R]} ( DecPerm(m_$9_$18,o_$16_$18,f_$7_$18,howMuch_$21)[q_$0_$18,g_$22][perm$R] == ite((o_$16_$18 == q_$0_$18) && (f_$7_$18 == g_$22),m_$9_$18[q_$0_$18,g_$22][perm$R] - howMuch_$21,m_$9_$18[q_$0_$18,g_$22][perm$R]) )))) && ((forall  m_$9_$19 : MaskType, o_$16_$19 : ref, f_$7_$19 : Field (Seq (Integer) ) , howMuch_$22 : Integer, q_$0_$19 : ref, g_$23 : Field (Mu)  :: {DecPerm(m_$9_$19,o_$16_$19,f_$7_$19,howMuch_$22)[q_$0_$19,g_$23][perm$R]} ( DecPerm(m_$9_$19,o_$16_$19,f_$7_$19,howMuch_$22)[q_$0_$19,g_$23][perm$R] == ite((o_$16_$19 == q_$0_$19) && false,m_$9_$19[q_$0_$19,g_$23][perm$R] - howMuch_$22,m_$9_$19[q_$0_$19,g_$23][perm$R]) )))) && ((forall  m_$9_$20 : MaskType, o_$16_$20 : ref, f_$7_$20 : Field (Boolean) , howMuch_$23 : Integer, q_$0_$20 : ref, g_$24 : Field (Seq (Integer) )  :: {DecPerm(m_$9_$20,o_$16_$20,f_$7_$20,howMuch_$23)[q_$0_$20,g_$24][perm$R]} ( DecPerm(m_$9_$20,o_$16_$20,f_$7_$20,howMuch_$23)[q_$0_$20,g_$24][perm$R] == ite((o_$16_$20 == q_$0_$20) && false,m_$9_$20[q_$0_$20,g_$24][perm$R] - howMuch_$23,m_$9_$20[q_$0_$20,g_$24][perm$R]) )))) && ((forall  m_$9_$21 : MaskType, o_$16_$21 : ref, f_$7_$21 : Field (Integer) , howMuch_$24 : Integer, q_$0_$21 : ref, g_$25 : Field (Seq (Integer) )  :: {DecPerm(m_$9_$21,o_$16_$21,f_$7_$21,howMuch_$24)[q_$0_$21,g_$25][perm$R]} ( DecPerm(m_$9_$21,o_$16_$21,f_$7_$21,howMuch_$24)[q_$0_$21,g_$25][perm$R] == ite((o_$16_$21 == q_$0_$21) && false,m_$9_$21[q_$0_$21,g_$25][perm$R] - howMuch_$24,m_$9_$21[q_$0_$21,g_$25][perm$R]) )))) && ((forall  m_$9_$22 : MaskType, o_$16_$22 : ref, f_$7_$22 : Field (ref) , howMuch_$25 : Integer, q_$0_$22 : ref, g_$26 : Field (Seq (Integer) )  :: {DecPerm(m_$9_$22,o_$16_$22,f_$7_$22,howMuch_$25)[q_$0_$22,g_$26][perm$R]} ( DecPerm(m_$9_$22,o_$16_$22,f_$7_$22,howMuch_$25)[q_$0_$22,g_$26][perm$R] == ite((o_$16_$22 == q_$0_$22) && false,m_$9_$22[q_$0_$22,g_$26][perm$R] - howMuch_$25,m_$9_$22[q_$0_$22,g_$26][perm$R]) )))) && ((forall  m_$9_$23 : MaskType, o_$16_$23 : ref, f_$7_$23 : Field (Mu) , howMuch_$26 : Integer, q_$0_$23 : ref, g_$27 : Field (Seq (Integer) )  :: {DecPerm(m_$9_$23,o_$16_$23,f_$7_$23,howMuch_$26)[q_$0_$23,g_$27][perm$R]} ( DecPerm(m_$9_$23,o_$16_$23,f_$7_$23,howMuch_$26)[q_$0_$23,g_$27][perm$R] == ite((o_$16_$23 == q_$0_$23) && false,m_$9_$23[q_$0_$23,g_$27][perm$R] - howMuch_$26,m_$9_$23[q_$0_$23,g_$27][perm$R]) )))) && ((forall  m_$9_$24 : MaskType, o_$16_$24 : ref, f_$7_$24 : Field (Seq (Integer) ) , howMuch_$27 : Integer, q_$0_$24 : ref, g_$28 : Field (Seq (Integer) )  :: {DecPerm(m_$9_$24,o_$16_$24,f_$7_$24,howMuch_$27)[q_$0_$24,g_$28][perm$R]} ( DecPerm(m_$9_$24,o_$16_$24,f_$7_$24,howMuch_$27)[q_$0_$24,g_$28][perm$R] == ite((o_$16_$24 == q_$0_$24) && (f_$7_$24 == g_$28),m_$9_$24[q_$0_$24,g_$28][perm$R] - howMuch_$27,m_$9_$24[q_$0_$24,g_$28][perm$R]) )));
	assume (((((((((((((((((((((((((forall  m_$11_$0 : MaskType, o_$18_$0 : ref, f_$9_$0 : Field (Boolean) , howMuch_$1_$0 : Integer, q_$2_$0 : ref, g_$1_$0 : Field (Boolean)  :: {IncPerm(m_$11_$0,o_$18_$0,f_$9_$0,howMuch_$1_$0)[q_$2_$0,g_$1_$0][perm$R]} ( IncPerm(m_$11_$0,o_$18_$0,f_$9_$0,howMuch_$1_$0)[q_$2_$0,g_$1_$0][perm$R] == ite((o_$18_$0 == q_$2_$0) && (f_$9_$0 == g_$1_$0),m_$11_$0[q_$2_$0,g_$1_$0][perm$R] + howMuch_$1_$0,m_$11_$0[q_$2_$0,g_$1_$0][perm$R]) ))) && ((forall  m_$11_$1 : MaskType, o_$18_$1 : ref, f_$9_$1 : Field (Integer) , howMuch_$1_$1 : Integer, q_$2_$1 : ref, g_$1_$1 : Field (Boolean)  :: {IncPerm(m_$11_$1,o_$18_$1,f_$9_$1,howMuch_$1_$1)[q_$2_$1,g_$1_$1][perm$R]} ( IncPerm(m_$11_$1,o_$18_$1,f_$9_$1,howMuch_$1_$1)[q_$2_$1,g_$1_$1][perm$R] == ite((o_$18_$1 == q_$2_$1) && false,m_$11_$1[q_$2_$1,g_$1_$1][perm$R] + howMuch_$1_$1,m_$11_$1[q_$2_$1,g_$1_$1][perm$R]) )))) && ((forall  m_$11_$2 : MaskType, o_$18_$2 : ref, f_$9_$2 : Field (ref) , howMuch_$1_$2 : Integer, q_$2_$2 : ref, g_$1_$2 : Field (Boolean)  :: {IncPerm(m_$11_$2,o_$18_$2,f_$9_$2,howMuch_$1_$2)[q_$2_$2,g_$1_$2][perm$R]} ( IncPerm(m_$11_$2,o_$18_$2,f_$9_$2,howMuch_$1_$2)[q_$2_$2,g_$1_$2][perm$R] == ite((o_$18_$2 == q_$2_$2) && false,m_$11_$2[q_$2_$2,g_$1_$2][perm$R] + howMuch_$1_$2,m_$11_$2[q_$2_$2,g_$1_$2][perm$R]) )))) && ((forall  m_$11_$3 : MaskType, o_$18_$3 : ref, f_$9_$3 : Field (Mu) , howMuch_$1_$3 : Integer, q_$2_$3 : ref, g_$1_$3 : Field (Boolean)  :: {IncPerm(m_$11_$3,o_$18_$3,f_$9_$3,howMuch_$1_$3)[q_$2_$3,g_$1_$3][perm$R]} ( IncPerm(m_$11_$3,o_$18_$3,f_$9_$3,howMuch_$1_$3)[q_$2_$3,g_$1_$3][perm$R] == ite((o_$18_$3 == q_$2_$3) && false,m_$11_$3[q_$2_$3,g_$1_$3][perm$R] + howMuch_$1_$3,m_$11_$3[q_$2_$3,g_$1_$3][perm$R]) )))) && ((forall  m_$11_$4 : MaskType, o_$18_$4 : ref, f_$9_$4 : Field (Seq (Integer) ) , howMuch_$1_$4 : Integer, q_$2_$4 : ref, g_$1_$4 : Field (Boolean)  :: {IncPerm(m_$11_$4,o_$18_$4,f_$9_$4,howMuch_$1_$4)[q_$2_$4,g_$1_$4][perm$R]} ( IncPerm(m_$11_$4,o_$18_$4,f_$9_$4,howMuch_$1_$4)[q_$2_$4,g_$1_$4][perm$R] == ite((o_$18_$4 == q_$2_$4) && false,m_$11_$4[q_$2_$4,g_$1_$4][perm$R] + howMuch_$1_$4,m_$11_$4[q_$2_$4,g_$1_$4][perm$R]) )))) && ((forall  m_$11_$5 : MaskType, o_$18_$5 : ref, f_$9_$5 : Field (Boolean) , howMuch_$1_$5 : Integer, q_$2_$5 : ref, g_$1_$5 : Field (Integer)  :: {IncPerm(m_$11_$5,o_$18_$5,f_$9_$5,howMuch_$1_$5)[q_$2_$5,g_$1_$5][perm$R]} ( IncPerm(m_$11_$5,o_$18_$5,f_$9_$5,howMuch_$1_$5)[q_$2_$5,g_$1_$5][perm$R] == ite((o_$18_$5 == q_$2_$5) && false,m_$11_$5[q_$2_$5,g_$1_$5][perm$R] + howMuch_$1_$5,m_$11_$5[q_$2_$5,g_$1_$5][perm$R]) )))) && ((forall  m_$11_$6 : MaskType, o_$18_$6 : ref, f_$9_$6 : Field (Integer) , howMuch_$1_$6 : Integer, q_$2_$6 : ref, g_$1_$6 : Field (Integer)  :: {IncPerm(m_$11_$6,o_$18_$6,f_$9_$6,howMuch_$1_$6)[q_$2_$6,g_$1_$6][perm$R]} ( IncPerm(m_$11_$6,o_$18_$6,f_$9_$6,howMuch_$1_$6)[q_$2_$6,g_$1_$6][perm$R] == ite((o_$18_$6 == q_$2_$6) && (f_$9_$6 == g_$1_$6),m_$11_$6[q_$2_$6,g_$1_$6][perm$R] + howMuch_$1_$6,m_$11_$6[q_$2_$6,g_$1_$6][perm$R]) )))) && ((forall  m_$11_$7 : MaskType, o_$18_$7 : ref, f_$9_$7 : Field (ref) , howMuch_$1_$7 : Integer, q_$2_$7 : ref, g_$1_$7 : Field (Integer)  :: {IncPerm(m_$11_$7,o_$18_$7,f_$9_$7,howMuch_$1_$7)[q_$2_$7,g_$1_$7][perm$R]} ( IncPerm(m_$11_$7,o_$18_$7,f_$9_$7,howMuch_$1_$7)[q_$2_$7,g_$1_$7][perm$R] == ite((o_$18_$7 == q_$2_$7) && false,m_$11_$7[q_$2_$7,g_$1_$7][perm$R] + howMuch_$1_$7,m_$11_$7[q_$2_$7,g_$1_$7][perm$R]) )))) && ((forall  m_$11_$8 : MaskType, o_$18_$8 : ref, f_$9_$8 : Field (Mu) , howMuch_$1_$8 : Integer, q_$2_$8 : ref, g_$1_$8 : Field (Integer)  :: {IncPerm(m_$11_$8,o_$18_$8,f_$9_$8,howMuch_$1_$8)[q_$2_$8,g_$1_$8][perm$R]} ( IncPerm(m_$11_$8,o_$18_$8,f_$9_$8,howMuch_$1_$8)[q_$2_$8,g_$1_$8][perm$R] == ite((o_$18_$8 == q_$2_$8) && false,m_$11_$8[q_$2_$8,g_$1_$8][perm$R] + howMuch_$1_$8,m_$11_$8[q_$2_$8,g_$1_$8][perm$R]) )))) && ((forall  m_$11_$9 : MaskType, o_$18_$9 : ref, f_$9_$9 : Field (Seq (Integer) ) , howMuch_$1_$9 : Integer, q_$2_$9 : ref, g_$1_$9 : Field (Integer)  :: {IncPerm(m_$11_$9,o_$18_$9,f_$9_$9,howMuch_$1_$9)[q_$2_$9,g_$1_$9][perm$R]} ( IncPerm(m_$11_$9,o_$18_$9,f_$9_$9,howMuch_$1_$9)[q_$2_$9,g_$1_$9][perm$R] == ite((o_$18_$9 == q_$2_$9) && false,m_$11_$9[q_$2_$9,g_$1_$9][perm$R] + howMuch_$1_$9,m_$11_$9[q_$2_$9,g_$1_$9][perm$R]) )))) && ((forall  m_$11_$10 : MaskType, o_$18_$10 : ref, f_$9_$10 : Field (Boolean) , howMuch_$1_$10 : Integer, q_$2_$10 : ref, g_$1_$10 : Field (ref)  :: {IncPerm(m_$11_$10,o_$18_$10,f_$9_$10,howMuch_$1_$10)[q_$2_$10,g_$1_$10][perm$R]} ( IncPerm(m_$11_$10,o_$18_$10,f_$9_$10,howMuch_$1_$10)[q_$2_$10,g_$1_$10][perm$R] == ite((o_$18_$10 == q_$2_$10) && false,m_$11_$10[q_$2_$10,g_$1_$10][perm$R] + howMuch_$1_$10,m_$11_$10[q_$2_$10,g_$1_$10][perm$R]) )))) && ((forall  m_$11_$11 : MaskType, o_$18_$11 : ref, f_$9_$11 : Field (Integer) , howMuch_$1_$11 : Integer, q_$2_$11 : ref, g_$1_$11 : Field (ref)  :: {IncPerm(m_$11_$11,o_$18_$11,f_$9_$11,howMuch_$1_$11)[q_$2_$11,g_$1_$11][perm$R]} ( IncPerm(m_$11_$11,o_$18_$11,f_$9_$11,howMuch_$1_$11)[q_$2_$11,g_$1_$11][perm$R] == ite((o_$18_$11 == q_$2_$11) && false,m_$11_$11[q_$2_$11,g_$1_$11][perm$R] + howMuch_$1_$11,m_$11_$11[q_$2_$11,g_$1_$11][perm$R]) )))) && ((forall  m_$11_$12 : MaskType, o_$18_$12 : ref, f_$9_$12 : Field (ref) , howMuch_$1_$12 : Integer, q_$2_$12 : ref, g_$1_$12 : Field (ref)  :: {IncPerm(m_$11_$12,o_$18_$12,f_$9_$12,howMuch_$1_$12)[q_$2_$12,g_$1_$12][perm$R]} ( IncPerm(m_$11_$12,o_$18_$12,f_$9_$12,howMuch_$1_$12)[q_$2_$12,g_$1_$12][perm$R] == ite((o_$18_$12 == q_$2_$12) && (f_$9_$12 == g_$1_$12),m_$11_$12[q_$2_$12,g_$1_$12][perm$R] + howMuch_$1_$12,m_$11_$12[q_$2_$12,g_$1_$12][perm$R]) )))) && ((forall  m_$11_$13 : MaskType, o_$18_$13 : ref, f_$9_$13 : Field (Mu) , howMuch_$1_$13 : Integer, q_$2_$13 : ref, g_$1_$13 : Field (ref)  :: {IncPerm(m_$11_$13,o_$18_$13,f_$9_$13,howMuch_$1_$13)[q_$2_$13,g_$1_$13][perm$R]} ( IncPerm(m_$11_$13,o_$18_$13,f_$9_$13,howMuch_$1_$13)[q_$2_$13,g_$1_$13][perm$R] == ite((o_$18_$13 == q_$2_$13) && false,m_$11_$13[q_$2_$13,g_$1_$13][perm$R] + howMuch_$1_$13,m_$11_$13[q_$2_$13,g_$1_$13][perm$R]) )))) && ((forall  m_$11_$14 : MaskType, o_$18_$14 : ref, f_$9_$14 : Field (Seq (Integer) ) , howMuch_$1_$14 : Integer, q_$2_$14 : ref, g_$1_$14 : Field (ref)  :: {IncPerm(m_$11_$14,o_$18_$14,f_$9_$14,howMuch_$1_$14)[q_$2_$14,g_$1_$14][perm$R]} ( IncPerm(m_$11_$14,o_$18_$14,f_$9_$14,howMuch_$1_$14)[q_$2_$14,g_$1_$14][perm$R] == ite((o_$18_$14 == q_$2_$14) && false,m_$11_$14[q_$2_$14,g_$1_$14][perm$R] + howMuch_$1_$14,m_$11_$14[q_$2_$14,g_$1_$14][perm$R]) )))) && ((forall  m_$11_$15 : MaskType, o_$18_$15 : ref, f_$9_$15 : Field (Boolean) , howMuch_$1_$15 : Integer, q_$2_$15 : ref, g_$1_$15 : Field (Mu)  :: {IncPerm(m_$11_$15,o_$18_$15,f_$9_$15,howMuch_$1_$15)[q_$2_$15,g_$1_$15][perm$R]} ( IncPerm(m_$11_$15,o_$18_$15,f_$9_$15,howMuch_$1_$15)[q_$2_$15,g_$1_$15][perm$R] == ite((o_$18_$15 == q_$2_$15) && false,m_$11_$15[q_$2_$15,g_$1_$15][perm$R] + howMuch_$1_$15,m_$11_$15[q_$2_$15,g_$1_$15][perm$R]) )))) && ((forall  m_$11_$16 : MaskType, o_$18_$16 : ref, f_$9_$16 : Field (Integer) , howMuch_$1_$16 : Integer, q_$2_$16 : ref, g_$1_$16 : Field (Mu)  :: {IncPerm(m_$11_$16,o_$18_$16,f_$9_$16,howMuch_$1_$16)[q_$2_$16,g_$1_$16][perm$R]} ( IncPerm(m_$11_$16,o_$18_$16,f_$9_$16,howMuch_$1_$16)[q_$2_$16,g_$1_$16][perm$R] == ite((o_$18_$16 == q_$2_$16) && false,m_$11_$16[q_$2_$16,g_$1_$16][perm$R] + howMuch_$1_$16,m_$11_$16[q_$2_$16,g_$1_$16][perm$R]) )))) && ((forall  m_$11_$17 : MaskType, o_$18_$17 : ref, f_$9_$17 : Field (ref) , howMuch_$1_$17 : Integer, q_$2_$17 : ref, g_$1_$17 : Field (Mu)  :: {IncPerm(m_$11_$17,o_$18_$17,f_$9_$17,howMuch_$1_$17)[q_$2_$17,g_$1_$17][perm$R]} ( IncPerm(m_$11_$17,o_$18_$17,f_$9_$17,howMuch_$1_$17)[q_$2_$17,g_$1_$17][perm$R] == ite((o_$18_$17 == q_$2_$17) && false,m_$11_$17[q_$2_$17,g_$1_$17][perm$R] + howMuch_$1_$17,m_$11_$17[q_$2_$17,g_$1_$17][perm$R]) )))) && ((forall  m_$11_$18 : MaskType, o_$18_$18 : ref, f_$9_$18 : Field (Mu) , howMuch_$1_$18 : Integer, q_$2_$18 : ref, g_$1_$18 : Field (Mu)  :: {IncPerm(m_$11_$18,o_$18_$18,f_$9_$18,howMuch_$1_$18)[q_$2_$18,g_$1_$18][perm$R]} ( IncPerm(m_$11_$18,o_$18_$18,f_$9_$18,howMuch_$1_$18)[q_$2_$18,g_$1_$18][perm$R] == ite((o_$18_$18 == q_$2_$18) && (f_$9_$18 == g_$1_$18),m_$11_$18[q_$2_$18,g_$1_$18][perm$R] + howMuch_$1_$18,m_$11_$18[q_$2_$18,g_$1_$18][perm$R]) )))) && ((forall  m_$11_$19 : MaskType, o_$18_$19 : ref, f_$9_$19 : Field (Seq (Integer) ) , howMuch_$1_$19 : Integer, q_$2_$19 : ref, g_$1_$19 : Field (Mu)  :: {IncPerm(m_$11_$19,o_$18_$19,f_$9_$19,howMuch_$1_$19)[q_$2_$19,g_$1_$19][perm$R]} ( IncPerm(m_$11_$19,o_$18_$19,f_$9_$19,howMuch_$1_$19)[q_$2_$19,g_$1_$19][perm$R] == ite((o_$18_$19 == q_$2_$19) && false,m_$11_$19[q_$2_$19,g_$1_$19][perm$R] + howMuch_$1_$19,m_$11_$19[q_$2_$19,g_$1_$19][perm$R]) )))) && ((forall  m_$11_$20 : MaskType, o_$18_$20 : ref, f_$9_$20 : Field (Boolean) , howMuch_$1_$20 : Integer, q_$2_$20 : ref, g_$1_$20 : Field (Seq (Integer) )  :: {IncPerm(m_$11_$20,o_$18_$20,f_$9_$20,howMuch_$1_$20)[q_$2_$20,g_$1_$20][perm$R]} ( IncPerm(m_$11_$20,o_$18_$20,f_$9_$20,howMuch_$1_$20)[q_$2_$20,g_$1_$20][perm$R] == ite((o_$18_$20 == q_$2_$20) && false,m_$11_$20[q_$2_$20,g_$1_$20][perm$R] + howMuch_$1_$20,m_$11_$20[q_$2_$20,g_$1_$20][perm$R]) )))) && ((forall  m_$11_$21 : MaskType, o_$18_$21 : ref, f_$9_$21 : Field (Integer) , howMuch_$1_$21 : Integer, q_$2_$21 : ref, g_$1_$21 : Field (Seq (Integer) )  :: {IncPerm(m_$11_$21,o_$18_$21,f_$9_$21,howMuch_$1_$21)[q_$2_$21,g_$1_$21][perm$R]} ( IncPerm(m_$11_$21,o_$18_$21,f_$9_$21,howMuch_$1_$21)[q_$2_$21,g_$1_$21][perm$R] == ite((o_$18_$21 == q_$2_$21) && false,m_$11_$21[q_$2_$21,g_$1_$21][perm$R] + howMuch_$1_$21,m_$11_$21[q_$2_$21,g_$1_$21][perm$R]) )))) && ((forall  m_$11_$22 : MaskType, o_$18_$22 : ref, f_$9_$22 : Field (ref) , howMuch_$1_$22 : Integer, q_$2_$22 : ref, g_$1_$22 : Field (Seq (Integer) )  :: {IncPerm(m_$11_$22,o_$18_$22,f_$9_$22,howMuch_$1_$22)[q_$2_$22,g_$1_$22][perm$R]} ( IncPerm(m_$11_$22,o_$18_$22,f_$9_$22,howMuch_$1_$22)[q_$2_$22,g_$1_$22][perm$R] == ite((o_$18_$22 == q_$2_$22) && false,m_$11_$22[q_$2_$22,g_$1_$22][perm$R] + howMuch_$1_$22,m_$11_$22[q_$2_$22,g_$1_$22][perm$R]) )))) && ((forall  m_$11_$23 : MaskType, o_$18_$23 : ref, f_$9_$23 : Field (Mu) , howMuch_$1_$23 : Integer, q_$2_$23 : ref, g_$1_$23 : Field (Seq (Integer) )  :: {IncPerm(m_$11_$23,o_$18_$23,f_$9_$23,howMuch_$1_$23)[q_$2_$23,g_$1_$23][perm$R]} ( IncPerm(m_$11_$23,o_$18_$23,f_$9_$23,howMuch_$1_$23)[q_$2_$23,g_$1_$23][perm$R] == ite((o_$18_$23 == q_$2_$23) && false,m_$11_$23[q_$2_$23,g_$1_$23][perm$R] + howMuch_$1_$23,m_$11_$23[q_$2_$23,g_$1_$23][perm$R]) )))) && ((forall  m_$11_$24 : MaskType, o_$18_$24 : ref, f_$9_$24 : Field (Seq (Integer) ) , howMuch_$1_$24 : Integer, q_$2_$24 : ref, g_$1_$24 : Field (Seq (Integer) )  :: {IncPerm(m_$11_$24,o_$18_$24,f_$9_$24,howMuch_$1_$24)[q_$2_$24,g_$1_$24][perm$R]} ( IncPerm(m_$11_$24,o_$18_$24,f_$9_$24,howMuch_$1_$24)[q_$2_$24,g_$1_$24][perm$R] == ite((o_$18_$24 == q_$2_$24) && (f_$9_$24 == g_$1_$24),m_$11_$24[q_$2_$24,g_$1_$24][perm$R] + howMuch_$1_$24,m_$11_$24[q_$2_$24,g_$1_$24][perm$R]) )));
	assume (forall  o_$22 : ref :: ( ZeroCredits[o_$22] == 0 ));
	assume (((((forall  f_$13_$0 : Field (Boolean)  :: ( NonPredicateField(f_$13_$0) ==> (!PredicateField(f_$13_$0)) ))) && ((forall  f_$13_$1 : Field (Integer)  :: ( NonPredicateField(f_$13_$1) ==> (!PredicateField(f_$13_$1)) )))) && ((forall  f_$13_$2 : Field (ref)  :: ( NonPredicateField(f_$13_$2) ==> (!PredicateField(f_$13_$2)) )))) && ((forall  f_$13_$3 : Field (Mu)  :: ( NonPredicateField(f_$13_$3) ==> (!PredicateField(f_$13_$3)) )))) && ((forall  f_$13_$4 : Field (Seq (Integer) )  :: ( NonPredicateField(f_$13_$4) ==> (!PredicateField(f_$13_$4)) )));
	assume (((((forall  f_$14_$0 : Field (Boolean)  :: ( PredicateField(f_$14_$0) ==> (!NonPredicateField(f_$14_$0)) ))) && ((forall  f_$14_$1 : Field (Integer)  :: ( PredicateField(f_$14_$1) ==> (!NonPredicateField(f_$14_$1)) )))) && ((forall  f_$14_$2 : Field (ref)  :: ( PredicateField(f_$14_$2) ==> (!NonPredicateField(f_$14_$2)) )))) && ((forall  f_$14_$3 : Field (Mu)  :: ( PredicateField(f_$14_$3) ==> (!NonPredicateField(f_$14_$3)) )))) && ((forall  f_$14_$4 : Field (Seq (Integer) )  :: ( PredicateField(f_$14_$4) ==> (!NonPredicateField(f_$14_$4)) )));
	assume (((((((((((((((((((forall  con_$1 : Boolean, a_$0_$0 : Boolean, b_$0_$0 : Boolean :: {ite(con_$1,a_$0_$0,b_$0_$0)} ( con_$1 ==> (ite(con_$1,a_$0_$0,b_$0_$0) == a_$0_$0) ))) && ((forall  con_$2 : Boolean, a_$0_$1 : Integer, b_$0_$1 : Integer :: {ite(con_$2,a_$0_$1,b_$0_$1)} ( con_$2 ==> (ite(con_$2,a_$0_$1,b_$0_$1) == a_$0_$1) )))) && ((forall  con_$3 : Boolean, a_$0_$2 : [PermissionComponent]Integer, b_$0_$2 : [PermissionComponent]Integer :: {ite(con_$3,a_$0_$2,b_$0_$2)} ( con_$3 ==> (ite(con_$3,a_$0_$2,b_$0_$2) == a_$0_$2) )))) && ((forall  con_$4 : Boolean, a_$0_$3 : PermissionComponent, b_$0_$3 : PermissionComponent :: {ite(con_$4,a_$0_$3,b_$0_$3)} ( con_$4 ==> (ite(con_$4,a_$0_$3,b_$0_$3) == a_$0_$3) )))) && ((forall  con_$5 : Boolean, a_$0_$4 : MaskType, b_$0_$4 : MaskType :: {ite(con_$5,a_$0_$4,b_$0_$4)} ( con_$5 ==> (ite(con_$5,a_$0_$4,b_$0_$4) == a_$0_$4) )))) && ((forall  con_$6 : Boolean, a_$0_$5 : ref, b_$0_$5 : ref :: {ite(con_$6,a_$0_$5,b_$0_$5)} ( con_$6 ==> (ite(con_$6,a_$0_$5,b_$0_$5) == a_$0_$5) )))) && ((forall  con_$7 : Boolean, a_$0_$6 : Field (Integer) , b_$0_$6 : Field (Integer)  :: {ite(con_$7,a_$0_$6,b_$0_$6)} ( con_$7 ==> (ite(con_$7,a_$0_$6,b_$0_$6) == a_$0_$6) )))) && ((forall  con_$8 : Boolean, a_$0_$7 : PartialHeapType, b_$0_$7 : PartialHeapType :: {ite(con_$8,a_$0_$7,b_$0_$7)} ( con_$8 ==> (ite(con_$8,a_$0_$7,b_$0_$7) == a_$0_$7) )))) && ((forall  con_$9 : Boolean, a_$0_$8 : Field (Mu) , b_$0_$8 : Field (Mu)  :: {ite(con_$9,a_$0_$8,b_$0_$8)} ( con_$9 ==> (ite(con_$9,a_$0_$8,b_$0_$8) == a_$0_$8) )))) && ((forall  con_$10 : Boolean, a_$0_$9 : Mu, b_$0_$9 : Mu :: {ite(con_$10,a_$0_$9,b_$0_$9)} ( con_$10 ==> (ite(con_$10,a_$0_$9,b_$0_$9) == a_$0_$9) )))) && ((forall  con_$11 : Boolean, a_$0_$10 : Field (Boolean) , b_$0_$10 : Field (Boolean)  :: {ite(con_$11,a_$0_$10,b_$0_$10)} ( con_$11 ==> (ite(con_$11,a_$0_$10,b_$0_$10) == a_$0_$10) )))) && ((forall  con_$12 : Boolean, a_$0_$11 : HeapType, b_$0_$11 : HeapType :: {ite(con_$12,a_$0_$11,b_$0_$11)} ( con_$12 ==> (ite(con_$12,a_$0_$11,b_$0_$11) == a_$0_$11) )))) && ((forall  con_$13 : Boolean, a_$0_$12 : CreditsType, b_$0_$12 : CreditsType :: {ite(con_$13,a_$0_$12,b_$0_$12)} ( con_$13 ==> (ite(con_$13,a_$0_$12,b_$0_$12) == a_$0_$12) )))) && ((forall  con_$14 : Boolean, a_$0_$13 : Seq (ref) , b_$0_$13 : Seq (ref)  :: {ite(con_$14,a_$0_$13,b_$0_$13)} ( con_$14 ==> (ite(con_$14,a_$0_$13,b_$0_$13) == a_$0_$13) )))) && ((forall  con_$15 : Boolean, a_$0_$14 : Seq (Integer) , b_$0_$14 : Seq (Integer)  :: {ite(con_$15,a_$0_$14,b_$0_$14)} ( con_$15 ==> (ite(con_$15,a_$0_$14,b_$0_$14) == a_$0_$14) )))) && ((forall  con_$16 : Boolean, a_$0_$15 : Field (ref) , b_$0_$15 : Field (ref)  :: {ite(con_$16,a_$0_$15,b_$0_$15)} ( con_$16 ==> (ite(con_$16,a_$0_$15,b_$0_$15) == a_$0_$15) )))) && ((forall  con_$17 : Boolean, a_$0_$16 : Field (Seq (Integer) ) , b_$0_$16 : Field (Seq (Integer) )  :: {ite(con_$17,a_$0_$16,b_$0_$16)} ( con_$17 ==> (ite(con_$17,a_$0_$16,b_$0_$16) == a_$0_$16) )))) && ((forall  con_$18 : Boolean, a_$0_$17 : TypeName, b_$0_$17 : TypeName :: {ite(con_$18,a_$0_$17,b_$0_$17)} ( con_$18 ==> (ite(con_$18,a_$0_$17,b_$0_$17) == a_$0_$17) )))) && ((forall  con_$19 : Boolean, a_$0_$18 : ModuleName, b_$0_$18 : ModuleName :: {ite(con_$19,a_$0_$18,b_$0_$18)} ( con_$19 ==> (ite(con_$19,a_$0_$18,b_$0_$18) == a_$0_$18) )));
	assume (((((((((((((((((((forall  con_$0_$0 : Boolean, a_$1_$0 : Boolean, b_$1_$0 : Boolean :: {ite(con_$0_$0,a_$1_$0,b_$1_$0)} ( (!con_$0_$0) ==> (ite(con_$0_$0,a_$1_$0,b_$1_$0) == b_$1_$0) ))) && ((forall  con_$0_$1 : Boolean, a_$1_$1 : Integer, b_$1_$1 : Integer :: {ite(con_$0_$1,a_$1_$1,b_$1_$1)} ( (!con_$0_$1) ==> (ite(con_$0_$1,a_$1_$1,b_$1_$1) == b_$1_$1) )))) && ((forall  con_$0_$2 : Boolean, a_$1_$2 : [PermissionComponent]Integer, b_$1_$2 : [PermissionComponent]Integer :: {ite(con_$0_$2,a_$1_$2,b_$1_$2)} ( (!con_$0_$2) ==> (ite(con_$0_$2,a_$1_$2,b_$1_$2) == b_$1_$2) )))) && ((forall  con_$0_$3 : Boolean, a_$1_$3 : PermissionComponent, b_$1_$3 : PermissionComponent :: {ite(con_$0_$3,a_$1_$3,b_$1_$3)} ( (!con_$0_$3) ==> (ite(con_$0_$3,a_$1_$3,b_$1_$3) == b_$1_$3) )))) && ((forall  con_$0_$4 : Boolean, a_$1_$4 : MaskType, b_$1_$4 : MaskType :: {ite(con_$0_$4,a_$1_$4,b_$1_$4)} ( (!con_$0_$4) ==> (ite(con_$0_$4,a_$1_$4,b_$1_$4) == b_$1_$4) )))) && ((forall  con_$0_$5 : Boolean, a_$1_$5 : ref, b_$1_$5 : ref :: {ite(con_$0_$5,a_$1_$5,b_$1_$5)} ( (!con_$0_$5) ==> (ite(con_$0_$5,a_$1_$5,b_$1_$5) == b_$1_$5) )))) && ((forall  con_$0_$6 : Boolean, a_$1_$6 : Field (Integer) , b_$1_$6 : Field (Integer)  :: {ite(con_$0_$6,a_$1_$6,b_$1_$6)} ( (!con_$0_$6) ==> (ite(con_$0_$6,a_$1_$6,b_$1_$6) == b_$1_$6) )))) && ((forall  con_$0_$7 : Boolean, a_$1_$7 : PartialHeapType, b_$1_$7 : PartialHeapType :: {ite(con_$0_$7,a_$1_$7,b_$1_$7)} ( (!con_$0_$7) ==> (ite(con_$0_$7,a_$1_$7,b_$1_$7) == b_$1_$7) )))) && ((forall  con_$0_$8 : Boolean, a_$1_$8 : Field (Mu) , b_$1_$8 : Field (Mu)  :: {ite(con_$0_$8,a_$1_$8,b_$1_$8)} ( (!con_$0_$8) ==> (ite(con_$0_$8,a_$1_$8,b_$1_$8) == b_$1_$8) )))) && ((forall  con_$0_$9 : Boolean, a_$1_$9 : Mu, b_$1_$9 : Mu :: {ite(con_$0_$9,a_$1_$9,b_$1_$9)} ( (!con_$0_$9) ==> (ite(con_$0_$9,a_$1_$9,b_$1_$9) == b_$1_$9) )))) && ((forall  con_$0_$10 : Boolean, a_$1_$10 : Field (Boolean) , b_$1_$10 : Field (Boolean)  :: {ite(con_$0_$10,a_$1_$10,b_$1_$10)} ( (!con_$0_$10) ==> (ite(con_$0_$10,a_$1_$10,b_$1_$10) == b_$1_$10) )))) && ((forall  con_$0_$11 : Boolean, a_$1_$11 : HeapType, b_$1_$11 : HeapType :: {ite(con_$0_$11,a_$1_$11,b_$1_$11)} ( (!con_$0_$11) ==> (ite(con_$0_$11,a_$1_$11,b_$1_$11) == b_$1_$11) )))) && ((forall  con_$0_$12 : Boolean, a_$1_$12 : CreditsType, b_$1_$12 : CreditsType :: {ite(con_$0_$12,a_$1_$12,b_$1_$12)} ( (!con_$0_$12) ==> (ite(con_$0_$12,a_$1_$12,b_$1_$12) == b_$1_$12) )))) && ((forall  con_$0_$13 : Boolean, a_$1_$13 : Seq (ref) , b_$1_$13 : Seq (ref)  :: {ite(con_$0_$13,a_$1_$13,b_$1_$13)} ( (!con_$0_$13) ==> (ite(con_$0_$13,a_$1_$13,b_$1_$13) == b_$1_$13) )))) && ((forall  con_$0_$14 : Boolean, a_$1_$14 : Seq (Integer) , b_$1_$14 : Seq (Integer)  :: {ite(con_$0_$14,a_$1_$14,b_$1_$14)} ( (!con_$0_$14) ==> (ite(con_$0_$14,a_$1_$14,b_$1_$14) == b_$1_$14) )))) && ((forall  con_$0_$15 : Boolean, a_$1_$15 : Field (ref) , b_$1_$15 : Field (ref)  :: {ite(con_$0_$15,a_$1_$15,b_$1_$15)} ( (!con_$0_$15) ==> (ite(con_$0_$15,a_$1_$15,b_$1_$15) == b_$1_$15) )))) && ((forall  con_$0_$16 : Boolean, a_$1_$16 : Field (Seq (Integer) ) , b_$1_$16 : Field (Seq (Integer) )  :: {ite(con_$0_$16,a_$1_$16,b_$1_$16)} ( (!con_$0_$16) ==> (ite(con_$0_$16,a_$1_$16,b_$1_$16) == b_$1_$16) )))) && ((forall  con_$0_$17 : Boolean, a_$1_$17 : TypeName, b_$1_$17 : TypeName :: {ite(con_$0_$17,a_$1_$17,b_$1_$17)} ( (!con_$0_$17) ==> (ite(con_$0_$17,a_$1_$17,b_$1_$17) == b_$1_$17) )))) && ((forall  con_$0_$18 : Boolean, a_$1_$18 : ModuleName, b_$1_$18 : ModuleName :: {ite(con_$0_$18,a_$1_$18,b_$1_$18)} ( (!con_$0_$18) ==> (ite(con_$0_$18,a_$1_$18,b_$1_$18) == b_$1_$18) )));
	assume ((forall  s_$12 : Seq (Integer)  :: {Seq#Length(s_$12)} ( 0 <= Seq#Length(s_$12) ))) && ((forall  s_$13 : Seq (ref)  :: {Seq#Length(s_$13)} ( 0 <= Seq#Length(s_$13) )));
	assume (Seq#Length((Seq#Empty() : Seq (Integer) )) == 0) && (Seq#Length((Seq#Empty() : Seq (ref) )) == 0);
	assume ((forall  s_$0_$0 : Seq (Integer)  :: {Seq#Length(s_$0_$0)} ( (Seq#Length(s_$0_$0) == 0) ==> (s_$0_$0 == (Seq#Empty() : Seq (Integer) )) ))) && ((forall  s_$0_$1 : Seq (ref)  :: {Seq#Length(s_$0_$1)} ( (Seq#Length(s_$0_$1) == 0) ==> (s_$0_$1 == (Seq#Empty() : Seq (ref) )) )));
	assume ((forall  t_$2 : Integer :: {Seq#Length(Seq#Singleton(t_$2))} ( Seq#Length(Seq#Singleton(t_$2)) == 1 ))) && ((forall  t_$3 : ref :: {Seq#Length(Seq#Singleton(t_$3))} ( Seq#Length(Seq#Singleton(t_$3)) == 1 )));
	assume ((forall  s_$1_$0 : Seq (Integer) , i_$5 : Integer, v_$2 : Integer, len_$2 : Integer :: {Seq#Length(Seq#Build(s_$1_$0,i_$5,v_$2,len_$2))} ( (0 <= len_$2) ==> (Seq#Length(Seq#Build(s_$1_$0,i_$5,v_$2,len_$2)) == len_$2) ))) && ((forall  s_$1_$1 : Seq (ref) , i_$6 : Integer, v_$3 : ref, len_$3 : Integer :: {Seq#Length(Seq#Build(s_$1_$1,i_$6,v_$3,len_$3))} ( (0 <= len_$3) ==> (Seq#Length(Seq#Build(s_$1_$1,i_$6,v_$3,len_$3)) == len_$3) )));
	assume ((forall  s0_$4 : Seq (Integer) , s1_$4 : Seq (Integer)  :: {Seq#Length(Seq#Append(s0_$4,s1_$4))} ( Seq#Length(Seq#Append(s0_$4,s1_$4)) == (Seq#Length(s0_$4) + Seq#Length(s1_$4)) ))) && ((forall  s0_$5 : Seq (ref) , s1_$5 : Seq (ref)  :: {Seq#Length(Seq#Append(s0_$5,s1_$5))} ( Seq#Length(Seq#Append(s0_$5,s1_$5)) == (Seq#Length(s0_$5) + Seq#Length(s1_$5)) )));
	assume ((forall  t_$0_$0 : Integer :: {Seq#Index(Seq#Singleton(t_$0_$0),0)} ( Seq#Index(Seq#Singleton(t_$0_$0),0) == t_$0_$0 ))) && ((forall  t_$0_$1 : ref :: {Seq#Index(Seq#Singleton(t_$0_$1),0)} ( Seq#Index(Seq#Singleton(t_$0_$1),0) == t_$0_$1 )));
	assume ((forall  s0_$0_$0 : Seq (Integer) , s1_$0_$0 : Seq (Integer) , n_$3_$0 : Integer :: {Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$3_$0)} ( ((n_$3_$0 < Seq#Length(s0_$0_$0)) ==> (Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$3_$0) == Seq#Index(s0_$0_$0,n_$3_$0))) && ((Seq#Length(s0_$0_$0) <= n_$3_$0) ==> (Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$3_$0) == Seq#Index(s1_$0_$0,n_$3_$0 - Seq#Length(s0_$0_$0)))) ))) && ((forall  s0_$0_$1 : Seq (ref) , s1_$0_$1 : Seq (ref) , n_$3_$1 : Integer :: {Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$3_$1)} ( ((n_$3_$1 < Seq#Length(s0_$0_$1)) ==> (Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$3_$1) == Seq#Index(s0_$0_$1,n_$3_$1))) && ((Seq#Length(s0_$0_$1) <= n_$3_$1) ==> (Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$3_$1) == Seq#Index(s1_$0_$1,n_$3_$1 - Seq#Length(s0_$0_$1)))) )));
	assume ((forall  s_$2_$0 : Seq (Integer) , i_$0_$0 : Integer, v_$0_$0 : Integer, len_$0_$0 : Integer, n_$4_$0 : Integer :: {Seq#Index(Seq#Build(s_$2_$0,i_$0_$0,v_$0_$0,len_$0_$0),n_$4_$0)} ( ((0 <= n_$4_$0) && (n_$4_$0 < len_$0_$0)) ==> (((i_$0_$0 == n_$4_$0) ==> (Seq#Index(Seq#Build(s_$2_$0,i_$0_$0,v_$0_$0,len_$0_$0),n_$4_$0) == v_$0_$0)) && ((!(i_$0_$0 == n_$4_$0)) ==> (Seq#Index(Seq#Build(s_$2_$0,i_$0_$0,v_$0_$0,len_$0_$0),n_$4_$0) == Seq#Index(s_$2_$0,n_$4_$0)))) ))) && ((forall  s_$2_$1 : Seq (ref) , i_$0_$1 : Integer, v_$0_$1 : ref, len_$0_$1 : Integer, n_$4_$1 : Integer :: {Seq#Index(Seq#Build(s_$2_$1,i_$0_$1,v_$0_$1,len_$0_$1),n_$4_$1)} ( ((0 <= n_$4_$1) && (n_$4_$1 < len_$0_$1)) ==> (((i_$0_$1 == n_$4_$1) ==> (Seq#Index(Seq#Build(s_$2_$1,i_$0_$1,v_$0_$1,len_$0_$1),n_$4_$1) == v_$0_$1)) && ((!(i_$0_$1 == n_$4_$1)) ==> (Seq#Index(Seq#Build(s_$2_$1,i_$0_$1,v_$0_$1,len_$0_$1),n_$4_$1) == Seq#Index(s_$2_$1,n_$4_$1)))) )));
	assume ((forall  s_$3_$0 : Seq (Integer) , x_$0_$0 : Integer :: {Seq#Contains(s_$3_$0,x_$0_$0)} ( Seq#Contains(s_$3_$0,x_$0_$0) <==> ((exists  i_$1_$1 : Integer :: {Seq#Index(s_$3_$0,i_$1_$1)} ( ((0 <= i_$1_$1) && (i_$1_$1 < Seq#Length(s_$3_$0))) && (Seq#Index(s_$3_$0,i_$1_$1) == x_$0_$0) ))) ))) && ((forall  s_$3_$1 : Seq (ref) , x_$0_$1 : ref :: {Seq#Contains(s_$3_$1,x_$0_$1)} ( Seq#Contains(s_$3_$1,x_$0_$1) <==> ((exists  i_$1_$3 : Integer :: {Seq#Index(s_$3_$1,i_$1_$3)} ( ((0 <= i_$1_$3) && (i_$1_$3 < Seq#Length(s_$3_$1))) && (Seq#Index(s_$3_$1,i_$1_$3) == x_$0_$1) ))) )));
	assume (forall  x_$1 : ref :: {Seq#Contains((Seq#Empty() : Seq (ref) ),x_$1)} ( !Seq#Contains((Seq#Empty() : Seq (ref) ),x_$1) ));
	assume ((forall  s0_$1_$0 : Seq (Integer) , s1_$1_$0 : Seq (Integer) , x_$2_$0 : Integer :: {Seq#Contains(Seq#Append(s0_$1_$0,s1_$1_$0),x_$2_$0)} ( Seq#Contains(Seq#Append(s0_$1_$0,s1_$1_$0),x_$2_$0) <==> (Seq#Contains(s0_$1_$0,x_$2_$0) || Seq#Contains(s1_$1_$0,x_$2_$0)) ))) && ((forall  s0_$1_$1 : Seq (ref) , s1_$1_$1 : Seq (ref) , x_$2_$1 : ref :: {Seq#Contains(Seq#Append(s0_$1_$1,s1_$1_$1),x_$2_$1)} ( Seq#Contains(Seq#Append(s0_$1_$1,s1_$1_$1),x_$2_$1) <==> (Seq#Contains(s0_$1_$1,x_$2_$1) || Seq#Contains(s1_$1_$1,x_$2_$1)) )));
	assume ((forall  s_$4_$0 : Seq (Integer) , i_$2_$0 : Integer, v_$1_$0 : Integer, len_$1_$0 : Integer, x_$3_$0 : Integer :: {Seq#Contains(Seq#Build(s_$4_$0,i_$2_$0,v_$1_$0,len_$1_$0),x_$3_$0)} ( Seq#Contains(Seq#Build(s_$4_$0,i_$2_$0,v_$1_$0,len_$1_$0),x_$3_$0) <==> ((((0 <= i_$2_$0) && (i_$2_$0 < len_$1_$0)) && (x_$3_$0 == v_$1_$0)) || ((exists  j_$6 : Integer :: {Seq#Index(s_$4_$0,j_$6)} ( ((((0 <= j_$6) && (j_$6 < Seq#Length(s_$4_$0))) && (j_$6 < len_$1_$0)) && (!(j_$6 == i_$2_$0))) && (Seq#Index(s_$4_$0,j_$6) == x_$3_$0) )))) ))) && ((forall  s_$4_$1 : Seq (ref) , i_$2_$1 : Integer, v_$1_$1 : ref, len_$1_$1 : Integer, x_$3_$1 : ref :: {Seq#Contains(Seq#Build(s_$4_$1,i_$2_$1,v_$1_$1,len_$1_$1),x_$3_$1)} ( Seq#Contains(Seq#Build(s_$4_$1,i_$2_$1,v_$1_$1,len_$1_$1),x_$3_$1) <==> ((((0 <= i_$2_$1) && (i_$2_$1 < len_$1_$1)) && (x_$3_$1 == v_$1_$1)) || ((exists  j_$8 : Integer :: {Seq#Index(s_$4_$1,j_$8)} ( ((((0 <= j_$8) && (j_$8 < Seq#Length(s_$4_$1))) && (j_$8 < len_$1_$1)) && (!(j_$8 == i_$2_$1))) && (Seq#Index(s_$4_$1,j_$8) == x_$3_$1) )))) )));
	assume ((forall  s_$5_$0 : Seq (Integer) , n_$5_$0 : Integer, x_$4_$0 : Integer :: {Seq#Contains(Seq#Take(s_$5_$0,n_$5_$0),x_$4_$0)} ( Seq#Contains(Seq#Take(s_$5_$0,n_$5_$0),x_$4_$0) <==> ((exists  i_$3_$1 : Integer :: {Seq#Index(s_$5_$0,i_$3_$1)} ( (((0 <= i_$3_$1) && (i_$3_$1 < n_$5_$0)) && (i_$3_$1 < Seq#Length(s_$5_$0))) && (Seq#Index(s_$5_$0,i_$3_$1) == x_$4_$0) ))) ))) && ((forall  s_$5_$1 : Seq (ref) , n_$5_$1 : Integer, x_$4_$1 : ref :: {Seq#Contains(Seq#Take(s_$5_$1,n_$5_$1),x_$4_$1)} ( Seq#Contains(Seq#Take(s_$5_$1,n_$5_$1),x_$4_$1) <==> ((exists  i_$3_$3 : Integer :: {Seq#Index(s_$5_$1,i_$3_$3)} ( (((0 <= i_$3_$3) && (i_$3_$3 < n_$5_$1)) && (i_$3_$3 < Seq#Length(s_$5_$1))) && (Seq#Index(s_$5_$1,i_$3_$3) == x_$4_$1) ))) )));
	assume ((forall  s_$6_$0 : Seq (Integer) , n_$6_$0 : Integer, x_$5_$0 : Integer :: {Seq#Contains(Seq#Drop(s_$6_$0,n_$6_$0),x_$5_$0)} ( Seq#Contains(Seq#Drop(s_$6_$0,n_$6_$0),x_$5_$0) <==> ((exists  i_$4_$1 : Integer :: {Seq#Index(s_$6_$0,i_$4_$1)} ( (((0 <= n_$6_$0) && (n_$6_$0 <= i_$4_$1)) && (i_$4_$1 < Seq#Length(s_$6_$0))) && (Seq#Index(s_$6_$0,i_$4_$1) == x_$5_$0) ))) ))) && ((forall  s_$6_$1 : Seq (ref) , n_$6_$1 : Integer, x_$5_$1 : ref :: {Seq#Contains(Seq#Drop(s_$6_$1,n_$6_$1),x_$5_$1)} ( Seq#Contains(Seq#Drop(s_$6_$1,n_$6_$1),x_$5_$1) <==> ((exists  i_$4_$3 : Integer :: {Seq#Index(s_$6_$1,i_$4_$3)} ( (((0 <= n_$6_$1) && (n_$6_$1 <= i_$4_$3)) && (i_$4_$3 < Seq#Length(s_$6_$1))) && (Seq#Index(s_$6_$1,i_$4_$3) == x_$5_$1) ))) )));
	assume ((forall  s0_$2_$0 : Seq (Integer) , s1_$2_$0 : Seq (Integer)  :: {Seq#Equal(s0_$2_$0,s1_$2_$0)} ( Seq#Equal(s0_$2_$0,s1_$2_$0) <==> ((Seq#Length(s0_$2_$0) == Seq#Length(s1_$2_$0)) && ((forall  j_$0_$1 : Integer :: {Seq#Index(s0_$2_$0,j_$0_$1)} {Seq#Index(s1_$2_$0,j_$0_$1)} ( ((0 <= j_$0_$1) && (j_$0_$1 < Seq#Length(s0_$2_$0))) ==> (Seq#Index(s0_$2_$0,j_$0_$1) == Seq#Index(s1_$2_$0,j_$0_$1)) )))) ))) && ((forall  s0_$2_$1 : Seq (ref) , s1_$2_$1 : Seq (ref)  :: {Seq#Equal(s0_$2_$1,s1_$2_$1)} ( Seq#Equal(s0_$2_$1,s1_$2_$1) <==> ((Seq#Length(s0_$2_$1) == Seq#Length(s1_$2_$1)) && ((forall  j_$0_$3 : Integer :: {Seq#Index(s0_$2_$1,j_$0_$3)} {Seq#Index(s1_$2_$1,j_$0_$3)} ( ((0 <= j_$0_$3) && (j_$0_$3 < Seq#Length(s0_$2_$1))) ==> (Seq#Index(s0_$2_$1,j_$0_$3) == Seq#Index(s1_$2_$1,j_$0_$3)) )))) )));
	assume ((forall  a_$2_$0 : Seq (Integer) , b_$2_$0 : Seq (Integer)  :: {Seq#Equal(a_$2_$0,b_$2_$0)} ( Seq#Equal(a_$2_$0,b_$2_$0) ==> (a_$2_$0 == b_$2_$0) ))) && ((forall  a_$2_$1 : Seq (ref) , b_$2_$1 : Seq (ref)  :: {Seq#Equal(a_$2_$1,b_$2_$1)} ( Seq#Equal(a_$2_$1,b_$2_$1) ==> (a_$2_$1 == b_$2_$1) )));
	assume ((forall  s_$7_$0 : Seq (Integer) , n_$8_$0 : Integer :: {Seq#Length(Seq#Take(s_$7_$0,n_$8_$0))} ( (0 <= n_$8_$0) ==> (((n_$8_$0 <= Seq#Length(s_$7_$0)) ==> (Seq#Length(Seq#Take(s_$7_$0,n_$8_$0)) == n_$8_$0)) && ((Seq#Length(s_$7_$0) < n_$8_$0) ==> (Seq#Length(Seq#Take(s_$7_$0,n_$8_$0)) == Seq#Length(s_$7_$0)))) ))) && ((forall  s_$7_$1 : Seq (ref) , n_$8_$1 : Integer :: {Seq#Length(Seq#Take(s_$7_$1,n_$8_$1))} ( (0 <= n_$8_$1) ==> (((n_$8_$1 <= Seq#Length(s_$7_$1)) ==> (Seq#Length(Seq#Take(s_$7_$1,n_$8_$1)) == n_$8_$1)) && ((Seq#Length(s_$7_$1) < n_$8_$1) ==> (Seq#Length(Seq#Take(s_$7_$1,n_$8_$1)) == Seq#Length(s_$7_$1)))) )));
	assume ((forall  s_$8_$0 : Seq (Integer) , n_$9_$0 : Integer, j_$2_$0 : Integer :: {Seq#Index(Seq#Take(s_$8_$0,n_$9_$0),j_$2_$0)} {:weight  25}( (((0 <= j_$2_$0) && (j_$2_$0 < n_$9_$0)) && (j_$2_$0 < Seq#Length(s_$8_$0))) ==> (Seq#Index(Seq#Take(s_$8_$0,n_$9_$0),j_$2_$0) == Seq#Index(s_$8_$0,j_$2_$0)) ))) && ((forall  s_$8_$1 : Seq (ref) , n_$9_$1 : Integer, j_$2_$1 : Integer :: {Seq#Index(Seq#Take(s_$8_$1,n_$9_$1),j_$2_$1)} {:weight  25}( (((0 <= j_$2_$1) && (j_$2_$1 < n_$9_$1)) && (j_$2_$1 < Seq#Length(s_$8_$1))) ==> (Seq#Index(Seq#Take(s_$8_$1,n_$9_$1),j_$2_$1) == Seq#Index(s_$8_$1,j_$2_$1)) )));
	assume ((forall  s_$9_$0 : Seq (Integer) , n_$10_$0 : Integer :: {Seq#Length(Seq#Drop(s_$9_$0,n_$10_$0))} ( (0 <= n_$10_$0) ==> (((n_$10_$0 <= Seq#Length(s_$9_$0)) ==> (Seq#Length(Seq#Drop(s_$9_$0,n_$10_$0)) == (Seq#Length(s_$9_$0) - n_$10_$0))) && ((Seq#Length(s_$9_$0) < n_$10_$0) ==> (Seq#Length(Seq#Drop(s_$9_$0,n_$10_$0)) == 0))) ))) && ((forall  s_$9_$1 : Seq (ref) , n_$10_$1 : Integer :: {Seq#Length(Seq#Drop(s_$9_$1,n_$10_$1))} ( (0 <= n_$10_$1) ==> (((n_$10_$1 <= Seq#Length(s_$9_$1)) ==> (Seq#Length(Seq#Drop(s_$9_$1,n_$10_$1)) == (Seq#Length(s_$9_$1) - n_$10_$1))) && ((Seq#Length(s_$9_$1) < n_$10_$1) ==> (Seq#Length(Seq#Drop(s_$9_$1,n_$10_$1)) == 0))) )));
	assume ((forall  s_$10_$0 : Seq (Integer) , n_$11_$0 : Integer, j_$3_$0 : Integer :: {Seq#Index(Seq#Drop(s_$10_$0,n_$11_$0),j_$3_$0)} {:weight  25}( (((0 <= n_$11_$0) && (0 <= j_$3_$0)) && (j_$3_$0 < (Seq#Length(s_$10_$0) - n_$11_$0))) ==> (Seq#Index(Seq#Drop(s_$10_$0,n_$11_$0),j_$3_$0) == Seq#Index(s_$10_$0,j_$3_$0 + n_$11_$0)) ))) && ((forall  s_$10_$1 : Seq (ref) , n_$11_$1 : Integer, j_$3_$1 : Integer :: {Seq#Index(Seq#Drop(s_$10_$1,n_$11_$1),j_$3_$1)} {:weight  25}( (((0 <= n_$11_$1) && (0 <= j_$3_$1)) && (j_$3_$1 < (Seq#Length(s_$10_$1) - n_$11_$1))) ==> (Seq#Index(Seq#Drop(s_$10_$1,n_$11_$1),j_$3_$1) == Seq#Index(s_$10_$1,j_$3_$1 + n_$11_$1)) )));
	assume ((forall  s_$11_$0 : Seq (Integer) , t_$1_$0 : Seq (Integer)  :: {Seq#Append(s_$11_$0,t_$1_$0)} ( (Seq#Take(Seq#Append(s_$11_$0,t_$1_$0),Seq#Length(s_$11_$0)) == s_$11_$0) && (Seq#Drop(Seq#Append(s_$11_$0,t_$1_$0),Seq#Length(s_$11_$0)) == t_$1_$0) ))) && ((forall  s_$11_$1 : Seq (ref) , t_$1_$1 : Seq (ref)  :: {Seq#Append(s_$11_$1,t_$1_$1)} ( (Seq#Take(Seq#Append(s_$11_$1,t_$1_$1),Seq#Length(s_$11_$1)) == s_$11_$1) && (Seq#Drop(Seq#Append(s_$11_$1,t_$1_$1),Seq#Length(s_$11_$1)) == t_$1_$1) )));
	assume (forall  min : Integer, max : Integer :: {Seq#Length(Seq#Range(min,max))} ( ((min < max) ==> (Seq#Length(Seq#Range(min,max)) == (max - min))) && ((max <= min) ==> (Seq#Length(Seq#Range(min,max)) == 0)) ));
	assume (forall  min_$0 : Integer, max_$0 : Integer, j_$4 : Integer :: {Seq#Index(Seq#Range(min_$0,max_$0),j_$4)} ( ((0 <= j_$4) && (j_$4 < (max_$0 - min_$0))) ==> (Seq#Index(Seq#Range(min_$0,max_$0),j_$4) == (min_$0 + j_$4)) ));
	assume ((forall  x_$6_$0 : Integer, y_$0_$0 : Integer :: {Seq#Contains(Seq#Singleton(x_$6_$0),y_$0_$0)} ( Seq#Contains(Seq#Singleton(x_$6_$0),y_$0_$0) <==> (x_$6_$0 == y_$0_$0) ))) && ((forall  x_$6_$1 : ref, y_$0_$1 : ref :: {Seq#Contains(Seq#Singleton(x_$6_$1),y_$0_$1)} ( Seq#Contains(Seq#Singleton(x_$6_$1),y_$0_$1) <==> (x_$6_$1 == y_$0_$1) )));
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
	assume $_$_condition;
	assume $_$_condition <==> (!(Heap[this,AVLTreeNode.right] == null));
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
	goto $branchMerge_0;
anon705_Else:
	assume !$_$_condition;
	assume $_$_condition <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_11 == Mask_$_9;
	goto $branchMerge_0;
anon706_Then:
	assume $_$_condition_$0;
	assume $_$_condition_$0 <==> (!(Heap[this,AVLTreeNode.right] == null));
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
	goto $branchMerge_1;
anon706_Else:
	assume !$_$_condition_$0;
	assume $_$_condition_$0 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_13 == Mask_$_11;
	goto $branchMerge_1;
anon707_Then:
	assume $_$_condition_$2;
	assume $_$_condition_$2 <==> (!(Heap[this,AVLTreeNode.right] == null));
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
	goto $branchMerge_2;
anon707_Else:
	assume !$_$_condition_$2;
	assume $_$_condition_$2 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_15 == Mask_$_13;
	goto $branchMerge_2;
anon708_Then:
	assume $_$_condition_$4;
	assume $_$_condition_$4 <==> (!(Heap[this,AVLTreeNode.right] == null));
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
	goto $branchMerge_3;
anon708_Else:
	assume !$_$_condition_$4;
	assume $_$_condition_$4 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_17 == Mask_$_15;
	goto $branchMerge_3;
anon709_Then:
	assume $_$_condition_$6;
	assume $_$_condition_$6 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume (forall  k#97#636 : Integer :: ( ((0 <= k#97#636) && (k#97#636 < Seq#Length(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[this,AVLTreeNode.key] < Seq#Index(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys],k#97#636)) ));
	goto anon10;
anon709_Else:
	assume !$_$_condition_$6;
	assume $_$_condition_$6 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	goto anon10;
anon10:
	assume predRec#_2191_$_0 == Heap[this,AVLTreeNode.left];
	assume #AVLTreeNode.valid#trigger(Heap[this,AVLTreeNode.left]);
	assume predVer#_2192_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid];
	if ($_$_condition_$8) { goto anon710_Then; } else { goto anon710_Else; }
anon710_Then:
	assume $_$_condition_$8;
	assume $_$_condition_$8 <==> false;
	assume false;
	goto $exit;
anon710_Else:
	assume !$_$_condition_$8;
	assume $_$_condition_$8 <==> false;
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
	assume $_$_condition_$9;
	assume $_$_condition_$9 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
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
	goto $branchMerge_4;
anon737_Else:
	assume !$_$_condition_$9;
	assume $_$_condition_$9 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_7 == SecMask_$_5;
	goto $branchMerge_4;
anon738_Then:
	assume $_$_condition_$10;
	assume $_$_condition_$10 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
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
	goto $branchMerge_5;
anon738_Else:
	assume !$_$_condition_$10;
	assume $_$_condition_$10 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_9 == SecMask_$_7;
	goto $branchMerge_5;
anon739_Then:
	assume $_$_condition_$12;
	assume $_$_condition_$12 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
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
	goto $branchMerge_6;
anon739_Else:
	assume !$_$_condition_$12;
	assume $_$_condition_$12 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_11 == SecMask_$_9;
	goto $branchMerge_6;
anon740_Then:
	assume $_$_condition_$14;
	assume $_$_condition_$14 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
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
	goto $branchMerge_7;
anon740_Else:
	assume !$_$_condition_$14;
	assume $_$_condition_$14 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_13 == SecMask_$_11;
	goto $branchMerge_7;
anon741_Then:
	assume $_$_condition_$16;
	assume $_$_condition_$16 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#641 : Integer :: ( ((0 <= lk#79#641) && (lk#79#641 < Seq#Length(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#641) < Heap[predRec#_2191_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_8;
anon741_Else:
	assume !$_$_condition_$16;
	assume $_$_condition_$16 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_8;
anon742_Then:
	assume $_$_condition_$18;
	assume $_$_condition_$18 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null);
	assume Heap[Heap[predRec#_2191_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_9;
anon742_Else:
	assume !$_$_condition_$18;
	assume $_$_condition_$18 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.left] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_9;
anon743_Then:
	assume $_$_condition_$20;
	assume $_$_condition_$20 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
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
	goto $branchMerge_10;
anon743_Else:
	assume !$_$_condition_$20;
	assume $_$_condition_$20 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_15 == SecMask_$_13;
	goto $branchMerge_10;
anon744_Then:
	assume $_$_condition_$22;
	assume $_$_condition_$22 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
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
	goto $branchMerge_11;
anon744_Else:
	assume !$_$_condition_$22;
	assume $_$_condition_$22 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_17 == SecMask_$_15;
	goto $branchMerge_11;
anon745_Then:
	assume $_$_condition_$24;
	assume $_$_condition_$24 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
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
	goto $branchMerge_12;
anon745_Else:
	assume !$_$_condition_$24;
	assume $_$_condition_$24 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_19 == SecMask_$_17;
	goto $branchMerge_12;
anon746_Then:
	assume $_$_condition_$26;
	assume $_$_condition_$26 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
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
	goto $branchMerge_13;
anon746_Else:
	assume !$_$_condition_$26;
	assume $_$_condition_$26 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_21 == SecMask_$_19;
	goto $branchMerge_13;
anon747_Then:
	assume $_$_condition_$28;
	assume $_$_condition_$28 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#642 : Integer :: ( ((0 <= rk#80#642) && (rk#80#642 < Seq#Length(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[predRec#_2191_$_0,AVLTreeNode.key] < Seq#Index(Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#642)) ));
	goto $branchMerge_14;
anon747_Else:
	assume !$_$_condition_$28;
	assume $_$_condition_$28 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
	assume Heap[predRec#_2191_$_0,AVLTreeNode.right] == null;
	goto $branchMerge_14;
anon748_Then:
	assume $_$_condition_$30;
	assume $_$_condition_$30 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
	assume !(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null);
	assume Heap[Heap[predRec#_2191_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon88;
anon748_Else:
	assume !$_$_condition_$30;
	assume $_$_condition_$30 <==> (!(Heap[predRec#_2191_$_0,AVLTreeNode.right] == null));
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
	assume $_$_condition_$32;
	assume $_$_condition_$32 <==> (false || ((((predVer#_2192_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap[this,AVLTreeNode.left])) && true) && true));
	assume false || ((((predVer#_2192_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap[this,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$33) { goto anon750_Then; } else { goto anon750_Else; }
anon749_Else:
	assume !$_$_condition_$32;
	assume $_$_condition_$32 <==> (false || ((((predVer#_2192_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap[this,AVLTreeNode.left])) && true) && true));
	assume !(false || ((((predVer#_2192_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap[this,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_72 == SecMask_$_21;
	goto $branchMerge_15;
anon750_Then:
	assume $_$_condition_$33;
	assume $_$_condition_$33 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#646 : Integer :: ( ((0 <= lk#79#646) && (lk#79#646 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#646) < Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_16;
anon750_Else:
	assume !$_$_condition_$33;
	assume $_$_condition_$33 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_16;
anon776_Then:
	assume $_$_condition_$34;
	assume $_$_condition_$34 <==> (!CanRead(Mask_$_18,SecMask_$_72,Heap[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(Mask_$_18,SecMask_$_72,Heap[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume oldVers#_2236_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume Heap_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid := newVers#_2237_$_0];
	assume oldVers#_2236_$_0 < Heap_$_0[Heap_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume Heap_$_1 == Heap_$_0;
	goto anon144;
anon776_Else:
	assume !$_$_condition_$34;
	assume $_$_condition_$34 <==> (!CanRead(Mask_$_18,SecMask_$_72,Heap[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume CanRead(Mask_$_18,SecMask_$_72,Heap[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_1 == Heap;
	goto anon144;
anon751_Then:
	assume $_$_condition_$35;
	assume $_$_condition_$35 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_17;
anon751_Else:
	assume !$_$_condition_$35;
	assume $_$_condition_$35 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_17;
anon752_Then:
	assume $_$_condition_$37;
	assume $_$_condition_$37 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#647 : Integer :: ( ((0 <= rk#80#647) && (rk#80#647 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#647)) ));
	goto $branchMerge_18;
anon752_Else:
	assume !$_$_condition_$37;
	assume $_$_condition_$37 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_18;
anon753_Then:
	assume $_$_condition_$39;
	assume $_$_condition_$39 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon97;
anon753_Else:
	assume !$_$_condition_$39;
	assume $_$_condition_$39 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	assume $_$_condition_$41;
	assume SecMask_$_22[Heap[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_23 == SecMask_$_22[Heap[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_22[Heap[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_24 == SecMask_$_23;
	goto anon99;
anon754_Else:
	assume !$_$_condition_$41;
	assume 0 <= SecMask_$_22[Heap[this,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_24 == SecMask_$_22;
	goto anon99;
anon99:
	assume wf(Heap,SecMask_$_24,SecMask_$_24);
	assume wf(Heap,Mask_$_18,SecMask_$_24);
	assume SecMask_$_25 == SecMask_$_24[Heap[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_24[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_24[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$42) { goto anon755_Then; } else { goto anon755_Else; }
anon755_Then:
	assume $_$_condition_$42;
	assume SecMask_$_25[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_26 == SecMask_$_25[Heap[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_25[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_27 == SecMask_$_26;
	goto anon101;
anon755_Else:
	assume !$_$_condition_$42;
	assume 0 <= SecMask_$_25[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_27 == SecMask_$_25;
	goto anon101;
anon101:
	assume wf(Heap,SecMask_$_27,SecMask_$_27);
	assume wf(Heap,Mask_$_18,SecMask_$_27);
	assume SecMask_$_28 == SecMask_$_27[Heap[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_27[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_27[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$43) { goto anon756_Then; } else { goto anon756_Else; }
anon756_Then:
	assume $_$_condition_$43;
	assume SecMask_$_28[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_29 == SecMask_$_28[Heap[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_28[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_30 == SecMask_$_29;
	goto anon103;
anon756_Else:
	assume !$_$_condition_$43;
	assume 0 <= SecMask_$_28[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_30 == SecMask_$_28;
	goto anon103;
anon103:
	assume wf(Heap,SecMask_$_30,SecMask_$_30);
	assume wf(Heap,Mask_$_18,SecMask_$_30);
	assume SecMask_$_31 == SecMask_$_30[Heap[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_30[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_30[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$44) { goto anon757_Then; } else { goto anon757_Else; }
anon757_Then:
	assume $_$_condition_$44;
	assume SecMask_$_31[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_32 == SecMask_$_31[Heap[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_31[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_33 == SecMask_$_32;
	goto anon105;
anon757_Else:
	assume !$_$_condition_$44;
	assume 0 <= SecMask_$_31[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_33 == SecMask_$_31;
	goto anon105;
anon105:
	assume wf(Heap,SecMask_$_33,SecMask_$_33);
	assume wf(Heap,Mask_$_18,SecMask_$_33);
	assume SecMask_$_34 == SecMask_$_33[Heap[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_33[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_33[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$45) { goto anon758_Then; } else { goto anon758_Else; }
anon758_Then:
	assume $_$_condition_$45;
	assume SecMask_$_34[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_35 == SecMask_$_34[Heap[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_34[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_36 == SecMask_$_35;
	goto anon107;
anon758_Else:
	assume !$_$_condition_$45;
	assume 0 <= SecMask_$_34[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_36 == SecMask_$_34;
	goto anon107;
anon107:
	assume wf(Heap,SecMask_$_36,SecMask_$_36);
	assume wf(Heap,Mask_$_18,SecMask_$_36);
	assume SecMask_$_37 == SecMask_$_36[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_36[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_36[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$46) { goto anon759_Then; } else { goto anon759_Else; }
anon759_Then:
	assume $_$_condition_$46;
	assume SecMask_$_37[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_38 == SecMask_$_37[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_37[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_39 == SecMask_$_38;
	goto anon109;
anon759_Else:
	assume !$_$_condition_$46;
	assume 0 <= SecMask_$_37[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_39 == SecMask_$_37;
	goto anon109;
anon109:
	assume wf(Heap,SecMask_$_39,SecMask_$_39);
	assume wf(Heap,Mask_$_18,SecMask_$_39);
	if ($_$_condition_$47) { goto anon760_Then; } else { goto anon760_Else; }
anon760_Then:
	assume $_$_condition_$47;
	assume $_$_condition_$47 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_40 == SecMask_$_39[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_39[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_39[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$48) { goto anon761_Then; } else { goto anon761_Else; }
anon760_Else:
	assume !$_$_condition_$47;
	assume $_$_condition_$47 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_43 == SecMask_$_39;
	goto $branchMerge_19;
anon761_Then:
	assume $_$_condition_$48;
	assume SecMask_$_40[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_41 == SecMask_$_40[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_40[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_42 == SecMask_$_41;
	goto anon112;
anon761_Else:
	assume !$_$_condition_$48;
	assume 0 <= SecMask_$_40[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_42 == SecMask_$_40;
	goto anon112;
anon762_Then:
	assume $_$_condition_$49;
	assume $_$_condition_$49 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_44 == SecMask_$_43[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_43[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_43[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$51) { goto anon763_Then; } else { goto anon763_Else; }
anon762_Else:
	assume !$_$_condition_$49;
	assume $_$_condition_$49 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_47 == SecMask_$_43;
	goto $branchMerge_20;
anon112:
	assume wf(Heap,SecMask_$_42,SecMask_$_42);
	assume wf(Heap,Mask_$_18,SecMask_$_42);
	assume SecMask_$_43 == SecMask_$_42;
	goto $branchMerge_19;
anon763_Then:
	assume $_$_condition_$51;
	assume SecMask_$_44[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_45 == SecMask_$_44[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_44[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_46 == SecMask_$_45;
	goto anon116;
anon763_Else:
	assume !$_$_condition_$51;
	assume 0 <= SecMask_$_44[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_46 == SecMask_$_44;
	goto anon116;
anon764_Then:
	assume $_$_condition_$52;
	assume $_$_condition_$52 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_48 == SecMask_$_47[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_47[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_47[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$54) { goto anon765_Then; } else { goto anon765_Else; }
anon764_Else:
	assume !$_$_condition_$52;
	assume $_$_condition_$52 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_51 == SecMask_$_47;
	goto $branchMerge_21;
anon116:
	assume wf(Heap,SecMask_$_46,SecMask_$_46);
	assume wf(Heap,Mask_$_18,SecMask_$_46);
	assume SecMask_$_47 == SecMask_$_46;
	goto $branchMerge_20;
anon765_Then:
	assume $_$_condition_$54;
	assume SecMask_$_48[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_49 == SecMask_$_48[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_48[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_50 == SecMask_$_49;
	goto anon120;
anon765_Else:
	assume !$_$_condition_$54;
	assume 0 <= SecMask_$_48[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_50 == SecMask_$_48;
	goto anon120;
anon766_Then:
	assume $_$_condition_$55;
	assume $_$_condition_$55 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_52 == SecMask_$_51[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_51[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_51[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$57) { goto anon767_Then; } else { goto anon767_Else; }
anon766_Else:
	assume !$_$_condition_$55;
	assume $_$_condition_$55 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_55 == SecMask_$_51;
	goto $branchMerge_22;
anon120:
	assume wf(Heap,SecMask_$_50,SecMask_$_50);
	assume wf(Heap,Mask_$_18,SecMask_$_50);
	assume SecMask_$_51 == SecMask_$_50;
	goto $branchMerge_21;
anon767_Then:
	assume $_$_condition_$57;
	assume SecMask_$_52[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_53 == SecMask_$_52[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_52[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_54 == SecMask_$_53;
	goto anon124;
anon767_Else:
	assume !$_$_condition_$57;
	assume 0 <= SecMask_$_52[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_54 == SecMask_$_52;
	goto anon124;
anon768_Then:
	assume $_$_condition_$58;
	assume $_$_condition_$58 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_56 == SecMask_$_55[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_55[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_55[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$60) { goto anon769_Then; } else { goto anon769_Else; }
anon768_Else:
	assume !$_$_condition_$58;
	assume $_$_condition_$58 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_59 == SecMask_$_55;
	goto $branchMerge_23;
anon124:
	assume wf(Heap,SecMask_$_54,SecMask_$_54);
	assume wf(Heap,Mask_$_18,SecMask_$_54);
	assume SecMask_$_55 == SecMask_$_54;
	goto $branchMerge_22;
anon769_Then:
	assume $_$_condition_$60;
	assume SecMask_$_56[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_57 == SecMask_$_56[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_56[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_58 == SecMask_$_57;
	goto anon128;
anon769_Else:
	assume !$_$_condition_$60;
	assume 0 <= SecMask_$_56[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_58 == SecMask_$_56;
	goto anon128;
anon770_Then:
	assume $_$_condition_$61;
	assume $_$_condition_$61 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_60 == SecMask_$_59[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_59[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_59[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$63) { goto anon771_Then; } else { goto anon771_Else; }
anon770_Else:
	assume !$_$_condition_$61;
	assume $_$_condition_$61 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_63 == SecMask_$_59;
	goto $branchMerge_24;
anon128:
	assume wf(Heap,SecMask_$_58,SecMask_$_58);
	assume wf(Heap,Mask_$_18,SecMask_$_58);
	assume SecMask_$_59 == SecMask_$_58;
	goto $branchMerge_23;
anon771_Then:
	assume $_$_condition_$63;
	assume SecMask_$_60[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_61 == SecMask_$_60[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_60[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_62 == SecMask_$_61;
	goto anon132;
anon771_Else:
	assume !$_$_condition_$63;
	assume 0 <= SecMask_$_60[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_62 == SecMask_$_60;
	goto anon132;
anon772_Then:
	assume $_$_condition_$64;
	assume $_$_condition_$64 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_64 == SecMask_$_63[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_63[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_63[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$66) { goto anon773_Then; } else { goto anon773_Else; }
anon772_Else:
	assume !$_$_condition_$64;
	assume $_$_condition_$64 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_67 == SecMask_$_63;
	goto $branchMerge_25;
anon132:
	assume wf(Heap,SecMask_$_62,SecMask_$_62);
	assume wf(Heap,Mask_$_18,SecMask_$_62);
	assume SecMask_$_63 == SecMask_$_62;
	goto $branchMerge_24;
anon773_Then:
	assume $_$_condition_$66;
	assume SecMask_$_64[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_65 == SecMask_$_64[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_64[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_66 == SecMask_$_65;
	goto anon136;
anon773_Else:
	assume !$_$_condition_$66;
	assume 0 <= SecMask_$_64[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_66 == SecMask_$_64;
	goto anon136;
anon774_Then:
	assume $_$_condition_$67;
	assume $_$_condition_$67 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_68 == SecMask_$_67[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_67[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_67[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$69) { goto anon775_Then; } else { goto anon775_Else; }
anon774_Else:
	assume !$_$_condition_$67;
	assume $_$_condition_$67 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_71 == SecMask_$_67;
	goto anon141;
anon136:
	assume wf(Heap,SecMask_$_66,SecMask_$_66);
	assume wf(Heap,Mask_$_18,SecMask_$_66);
	assume SecMask_$_67 == SecMask_$_66;
	goto $branchMerge_25;
anon775_Then:
	assume $_$_condition_$69;
	assume SecMask_$_68[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_69 == SecMask_$_68[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_68[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_70 == SecMask_$_69;
	goto anon140;
anon775_Else:
	assume !$_$_condition_$69;
	assume 0 <= SecMask_$_68[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_70 == SecMask_$_68;
	goto anon140;
anon141:
	assume wf(Heap,SecMask_$_71,SecMask_$_71);
	assume SecMask_$_72 == SecMask_$_71;
	goto $branchMerge_15;
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
	assume $_$_condition_$71;
	assume $_$_condition_$71 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_26;
anon777_Else:
	assume !$_$_condition_$71;
	assume $_$_condition_$71 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume Mask_$_26 == Mask_$_24;
	goto $branchMerge_26;
anon778_Then:
	assume $_$_condition_$72;
	assume $_$_condition_$72 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_27;
anon778_Else:
	assume !$_$_condition_$72;
	assume $_$_condition_$72 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume Mask_$_28 == Mask_$_26;
	goto $branchMerge_27;
anon779_Then:
	assume $_$_condition_$74;
	assume $_$_condition_$74 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_28;
anon779_Else:
	assume !$_$_condition_$74;
	assume $_$_condition_$74 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume Mask_$_30 == Mask_$_28;
	goto $branchMerge_28;
anon780_Then:
	assume $_$_condition_$76;
	assume $_$_condition_$76 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_29;
anon780_Else:
	assume !$_$_condition_$76;
	assume $_$_condition_$76 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume Mask_$_32 == Mask_$_30;
	goto $branchMerge_29;
anon781_Then:
	assume $_$_condition_$78;
	assume $_$_condition_$78 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#650 : Integer :: ( ((0 <= lk#79#650) && (lk#79#650 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#650) < Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_30;
anon781_Else:
	assume !$_$_condition_$78;
	assume $_$_condition_$78 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_30;
anon782_Then:
	assume $_$_condition_$80;
	assume $_$_condition_$80 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_31;
anon782_Else:
	assume !$_$_condition_$80;
	assume $_$_condition_$80 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_31;
anon783_Then:
	assume $_$_condition_$82;
	assume $_$_condition_$82 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_32;
anon783_Else:
	assume !$_$_condition_$82;
	assume $_$_condition_$82 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume Mask_$_34 == Mask_$_32;
	goto $branchMerge_32;
anon784_Then:
	assume $_$_condition_$84;
	assume $_$_condition_$84 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_33;
anon784_Else:
	assume !$_$_condition_$84;
	assume $_$_condition_$84 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume Mask_$_36 == Mask_$_34;
	goto $branchMerge_33;
anon785_Then:
	assume $_$_condition_$86;
	assume $_$_condition_$86 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_34;
anon785_Else:
	assume !$_$_condition_$86;
	assume $_$_condition_$86 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume Mask_$_38 == Mask_$_36;
	goto $branchMerge_34;
anon786_Then:
	assume $_$_condition_$88;
	assume $_$_condition_$88 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_35;
anon786_Else:
	assume !$_$_condition_$88;
	assume $_$_condition_$88 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume Mask_$_40 == Mask_$_38;
	goto $branchMerge_35;
anon787_Then:
	assume $_$_condition_$90;
	assume $_$_condition_$90 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#651 : Integer :: ( ((0 <= rk#80#651) && (rk#80#651 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#651)) ));
	goto $branchMerge_36;
anon787_Else:
	assume !$_$_condition_$90;
	assume $_$_condition_$90 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_36;
anon788_Then:
	assume $_$_condition_$92;
	assume $_$_condition_$92 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon168;
anon788_Else:
	assume !$_$_condition_$92;
	assume $_$_condition_$92 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	assume $_$_condition_$94;
	assume $_$_condition_$94 <==> (false || ((((predVer#_2192_$_0 == Heap_$_1[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true));
	assume false || ((((predVer#_2192_$_0 == Heap_$_1[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true);
	if ($_$_condition_$95) { goto anon790_Then; } else { goto anon790_Else; }
anon789_Else:
	assume !$_$_condition_$94;
	assume $_$_condition_$94 <==> (false || ((((predVer#_2192_$_0 == Heap_$_1[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true));
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_1[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true));
	assume SecMask_$_123 == SecMask_$_72;
	goto $branchMerge_37;
anon790_Then:
	assume $_$_condition_$95;
	assume $_$_condition_$95 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#655 : Integer :: ( ((0 <= lk#79#655) && (lk#79#655 < Seq#Length(Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#655) < Heap_$_1[r#66_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_38;
anon790_Else:
	assume !$_$_condition_$95;
	assume $_$_condition_$95 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_38;
anon816_Then:
	assume $_$_condition_$96;
	assume $_$_condition_$96 <==> (!CanRead(Mask_$_41,SecMask_$_123,r#66_$_0,AVLTreeNode.valid));
	assume !CanRead(Mask_$_41,SecMask_$_123,r#66_$_0,AVLTreeNode.valid);
	assume oldVers#_2264_$_0 == Heap_$_1[r#66_$_0,AVLTreeNode.valid];
	assume Heap_$_2 == Heap_$_1[r#66_$_0,AVLTreeNode.valid := newVers#_2265_$_0];
	assume oldVers#_2264_$_0 < Heap_$_2[r#66_$_0,AVLTreeNode.valid];
	assume Heap_$_3 == Heap_$_2;
	goto anon224;
anon816_Else:
	assume !$_$_condition_$96;
	assume $_$_condition_$96 <==> (!CanRead(Mask_$_41,SecMask_$_123,r#66_$_0,AVLTreeNode.valid));
	assume CanRead(Mask_$_41,SecMask_$_123,r#66_$_0,AVLTreeNode.valid);
	assume Heap_$_3 == Heap_$_1;
	goto anon224;
anon791_Then:
	assume $_$_condition_$97;
	assume $_$_condition_$97 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_39;
anon791_Else:
	assume !$_$_condition_$97;
	assume $_$_condition_$97 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_39;
anon792_Then:
	assume $_$_condition_$99;
	assume $_$_condition_$99 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#656 : Integer :: ( ((0 <= rk#80#656) && (rk#80#656 < Seq#Length(Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[r#66_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#656)) ));
	goto $branchMerge_40;
anon792_Else:
	assume !$_$_condition_$99;
	assume $_$_condition_$99 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	goto $branchMerge_40;
anon793_Then:
	assume $_$_condition_$101;
	assume $_$_condition_$101 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon177;
anon793_Else:
	assume !$_$_condition_$101;
	assume $_$_condition_$101 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
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
	assume $_$_condition_$103;
	assume SecMask_$_73[r#66_$_0,AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_74 == SecMask_$_73[r#66_$_0,AVLTreeNode.key := SecMask_$_73[r#66_$_0,AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_75 == SecMask_$_74;
	goto anon179;
anon794_Else:
	assume !$_$_condition_$103;
	assume 0 <= SecMask_$_73[r#66_$_0,AVLTreeNode.key][perm$R];
	assume SecMask_$_75 == SecMask_$_73;
	goto anon179;
anon179:
	assume wf(Heap_$_1,SecMask_$_75,SecMask_$_75);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_75);
	assume SecMask_$_76 == SecMask_$_75[r#66_$_0,AVLTreeNode.height := SecMask_$_75[r#66_$_0,AVLTreeNode.height][perm$R := SecMask_$_75[r#66_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$104) { goto anon795_Then; } else { goto anon795_Else; }
anon795_Then:
	assume $_$_condition_$104;
	assume SecMask_$_76[r#66_$_0,AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_77 == SecMask_$_76[r#66_$_0,AVLTreeNode.height := SecMask_$_76[r#66_$_0,AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_78 == SecMask_$_77;
	goto anon181;
anon795_Else:
	assume !$_$_condition_$104;
	assume 0 <= SecMask_$_76[r#66_$_0,AVLTreeNode.height][perm$R];
	assume SecMask_$_78 == SecMask_$_76;
	goto anon181;
anon181:
	assume wf(Heap_$_1,SecMask_$_78,SecMask_$_78);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_78);
	assume SecMask_$_79 == SecMask_$_78[r#66_$_0,AVLTreeNode.left := SecMask_$_78[r#66_$_0,AVLTreeNode.left][perm$R := SecMask_$_78[r#66_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$105) { goto anon796_Then; } else { goto anon796_Else; }
anon796_Then:
	assume $_$_condition_$105;
	assume SecMask_$_79[r#66_$_0,AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_80 == SecMask_$_79[r#66_$_0,AVLTreeNode.left := SecMask_$_79[r#66_$_0,AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_81 == SecMask_$_80;
	goto anon183;
anon796_Else:
	assume !$_$_condition_$105;
	assume 0 <= SecMask_$_79[r#66_$_0,AVLTreeNode.left][perm$R];
	assume SecMask_$_81 == SecMask_$_79;
	goto anon183;
anon183:
	assume wf(Heap_$_1,SecMask_$_81,SecMask_$_81);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_81);
	assume SecMask_$_82 == SecMask_$_81[r#66_$_0,AVLTreeNode.right := SecMask_$_81[r#66_$_0,AVLTreeNode.right][perm$R := SecMask_$_81[r#66_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$106) { goto anon797_Then; } else { goto anon797_Else; }
anon797_Then:
	assume $_$_condition_$106;
	assume SecMask_$_82[r#66_$_0,AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_83 == SecMask_$_82[r#66_$_0,AVLTreeNode.right := SecMask_$_82[r#66_$_0,AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_84 == SecMask_$_83;
	goto anon185;
anon797_Else:
	assume !$_$_condition_$106;
	assume 0 <= SecMask_$_82[r#66_$_0,AVLTreeNode.right][perm$R];
	assume SecMask_$_84 == SecMask_$_82;
	goto anon185;
anon185:
	assume wf(Heap_$_1,SecMask_$_84,SecMask_$_84);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_84);
	assume SecMask_$_85 == SecMask_$_84[r#66_$_0,AVLTreeNode.keys := SecMask_$_84[r#66_$_0,AVLTreeNode.keys][perm$R := SecMask_$_84[r#66_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$107) { goto anon798_Then; } else { goto anon798_Else; }
anon798_Then:
	assume $_$_condition_$107;
	assume SecMask_$_85[r#66_$_0,AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_86 == SecMask_$_85[r#66_$_0,AVLTreeNode.keys := SecMask_$_85[r#66_$_0,AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_87 == SecMask_$_86;
	goto anon187;
anon798_Else:
	assume !$_$_condition_$107;
	assume 0 <= SecMask_$_85[r#66_$_0,AVLTreeNode.keys][perm$R];
	assume SecMask_$_87 == SecMask_$_85;
	goto anon187;
anon187:
	assume wf(Heap_$_1,SecMask_$_87,SecMask_$_87);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_87);
	assume SecMask_$_88 == SecMask_$_87[r#66_$_0,AVLTreeNode.balanceFactor := SecMask_$_87[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := SecMask_$_87[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$108) { goto anon799_Then; } else { goto anon799_Else; }
anon799_Then:
	assume $_$_condition_$108;
	assume SecMask_$_88[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_89 == SecMask_$_88[r#66_$_0,AVLTreeNode.balanceFactor := SecMask_$_88[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_90 == SecMask_$_89;
	goto anon189;
anon799_Else:
	assume !$_$_condition_$108;
	assume 0 <= SecMask_$_88[r#66_$_0,AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_90 == SecMask_$_88;
	goto anon189;
anon189:
	assume wf(Heap_$_1,SecMask_$_90,SecMask_$_90);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_90);
	if ($_$_condition_$109) { goto anon800_Then; } else { goto anon800_Else; }
anon800_Then:
	assume $_$_condition_$109;
	assume $_$_condition_$109 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_91 == SecMask_$_90[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_90[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_90[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$110) { goto anon801_Then; } else { goto anon801_Else; }
anon800_Else:
	assume !$_$_condition_$109;
	assume $_$_condition_$109 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_94 == SecMask_$_90;
	goto $branchMerge_41;
anon801_Then:
	assume $_$_condition_$110;
	assume SecMask_$_91[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_92 == SecMask_$_91[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_91[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_93 == SecMask_$_92;
	goto anon192;
anon801_Else:
	assume !$_$_condition_$110;
	assume 0 <= SecMask_$_91[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_93 == SecMask_$_91;
	goto anon192;
anon802_Then:
	assume $_$_condition_$111;
	assume $_$_condition_$111 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_95 == SecMask_$_94[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_94[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_94[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$113) { goto anon803_Then; } else { goto anon803_Else; }
anon802_Else:
	assume !$_$_condition_$111;
	assume $_$_condition_$111 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_98 == SecMask_$_94;
	goto $branchMerge_42;
anon192:
	assume wf(Heap_$_1,SecMask_$_93,SecMask_$_93);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_93);
	assume SecMask_$_94 == SecMask_$_93;
	goto $branchMerge_41;
anon803_Then:
	assume $_$_condition_$113;
	assume SecMask_$_95[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_96 == SecMask_$_95[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_95[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_97 == SecMask_$_96;
	goto anon196;
anon803_Else:
	assume !$_$_condition_$113;
	assume 0 <= SecMask_$_95[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_97 == SecMask_$_95;
	goto anon196;
anon804_Then:
	assume $_$_condition_$114;
	assume $_$_condition_$114 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_99 == SecMask_$_98[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_98[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_98[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$116) { goto anon805_Then; } else { goto anon805_Else; }
anon804_Else:
	assume !$_$_condition_$114;
	assume $_$_condition_$114 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_102 == SecMask_$_98;
	goto $branchMerge_43;
anon196:
	assume wf(Heap_$_1,SecMask_$_97,SecMask_$_97);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_97);
	assume SecMask_$_98 == SecMask_$_97;
	goto $branchMerge_42;
anon805_Then:
	assume $_$_condition_$116;
	assume SecMask_$_99[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_100 == SecMask_$_99[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_99[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_101 == SecMask_$_100;
	goto anon200;
anon805_Else:
	assume !$_$_condition_$116;
	assume 0 <= SecMask_$_99[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_101 == SecMask_$_99;
	goto anon200;
anon806_Then:
	assume $_$_condition_$117;
	assume $_$_condition_$117 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_103 == SecMask_$_102[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_102[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_102[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$119) { goto anon807_Then; } else { goto anon807_Else; }
anon806_Else:
	assume !$_$_condition_$117;
	assume $_$_condition_$117 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_106 == SecMask_$_102;
	goto $branchMerge_44;
anon200:
	assume wf(Heap_$_1,SecMask_$_101,SecMask_$_101);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_101);
	assume SecMask_$_102 == SecMask_$_101;
	goto $branchMerge_43;
anon807_Then:
	assume $_$_condition_$119;
	assume SecMask_$_103[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_104 == SecMask_$_103[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_103[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_105 == SecMask_$_104;
	goto anon204;
anon807_Else:
	assume !$_$_condition_$119;
	assume 0 <= SecMask_$_103[Heap_$_1[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_105 == SecMask_$_103;
	goto anon204;
anon808_Then:
	assume $_$_condition_$120;
	assume $_$_condition_$120 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_107 == SecMask_$_106[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_106[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_106[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$122) { goto anon809_Then; } else { goto anon809_Else; }
anon808_Else:
	assume !$_$_condition_$120;
	assume $_$_condition_$120 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_110 == SecMask_$_106;
	goto $branchMerge_45;
anon204:
	assume wf(Heap_$_1,SecMask_$_105,SecMask_$_105);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_105);
	assume SecMask_$_106 == SecMask_$_105;
	goto $branchMerge_44;
anon809_Then:
	assume $_$_condition_$122;
	assume SecMask_$_107[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_108 == SecMask_$_107[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_107[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_109 == SecMask_$_108;
	goto anon208;
anon809_Else:
	assume !$_$_condition_$122;
	assume 0 <= SecMask_$_107[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_109 == SecMask_$_107;
	goto anon208;
anon810_Then:
	assume $_$_condition_$123;
	assume $_$_condition_$123 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_111 == SecMask_$_110[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_110[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_110[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$125) { goto anon811_Then; } else { goto anon811_Else; }
anon810_Else:
	assume !$_$_condition_$123;
	assume $_$_condition_$123 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_114 == SecMask_$_110;
	goto $branchMerge_46;
anon208:
	assume wf(Heap_$_1,SecMask_$_109,SecMask_$_109);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_109);
	assume SecMask_$_110 == SecMask_$_109;
	goto $branchMerge_45;
anon811_Then:
	assume $_$_condition_$125;
	assume SecMask_$_111[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_112 == SecMask_$_111[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_111[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_113 == SecMask_$_112;
	goto anon212;
anon811_Else:
	assume !$_$_condition_$125;
	assume 0 <= SecMask_$_111[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_113 == SecMask_$_111;
	goto anon212;
anon812_Then:
	assume $_$_condition_$126;
	assume $_$_condition_$126 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_115 == SecMask_$_114[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_114[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_114[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$128) { goto anon813_Then; } else { goto anon813_Else; }
anon812_Else:
	assume !$_$_condition_$126;
	assume $_$_condition_$126 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_118 == SecMask_$_114;
	goto $branchMerge_47;
anon212:
	assume wf(Heap_$_1,SecMask_$_113,SecMask_$_113);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_113);
	assume SecMask_$_114 == SecMask_$_113;
	goto $branchMerge_46;
anon813_Then:
	assume $_$_condition_$128;
	assume SecMask_$_115[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_116 == SecMask_$_115[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_115[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_117 == SecMask_$_116;
	goto anon216;
anon813_Else:
	assume !$_$_condition_$128;
	assume 0 <= SecMask_$_115[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_117 == SecMask_$_115;
	goto anon216;
anon814_Then:
	assume $_$_condition_$129;
	assume $_$_condition_$129 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_119 == SecMask_$_118[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_118[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_118[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$131) { goto anon815_Then; } else { goto anon815_Else; }
anon814_Else:
	assume !$_$_condition_$129;
	assume $_$_condition_$129 <==> (!(Heap_$_1[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_1[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_122 == SecMask_$_118;
	goto anon221;
anon216:
	assume wf(Heap_$_1,SecMask_$_117,SecMask_$_117);
	assume wf(Heap_$_1,Mask_$_41,SecMask_$_117);
	assume SecMask_$_118 == SecMask_$_117;
	goto $branchMerge_47;
anon815_Then:
	assume $_$_condition_$131;
	assume SecMask_$_119[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_120 == SecMask_$_119[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_119[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_121 == SecMask_$_120;
	goto anon220;
anon815_Else:
	assume !$_$_condition_$131;
	assume 0 <= SecMask_$_119[Heap_$_1[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_121 == SecMask_$_119;
	goto anon220;
anon221:
	assume wf(Heap_$_1,SecMask_$_122,SecMask_$_122);
	assume SecMask_$_123 == SecMask_$_122;
	goto $branchMerge_37;
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
	assume $_$_condition_$133;
	assume $_$_condition_$133 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
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
	goto $branchMerge_48;
anon817_Else:
	assume !$_$_condition_$133;
	assume $_$_condition_$133 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	assume Mask_$_49 == Mask_$_47;
	goto $branchMerge_48;
anon818_Then:
	assume $_$_condition_$134;
	assume $_$_condition_$134 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
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
	goto $branchMerge_49;
anon818_Else:
	assume !$_$_condition_$134;
	assume $_$_condition_$134 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	assume Mask_$_51 == Mask_$_49;
	goto $branchMerge_49;
anon819_Then:
	assume $_$_condition_$136;
	assume $_$_condition_$136 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
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
	goto $branchMerge_50;
anon819_Else:
	assume !$_$_condition_$136;
	assume $_$_condition_$136 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	assume Mask_$_53 == Mask_$_51;
	goto $branchMerge_50;
anon820_Then:
	assume $_$_condition_$138;
	assume $_$_condition_$138 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
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
	goto $branchMerge_51;
anon820_Else:
	assume !$_$_condition_$138;
	assume $_$_condition_$138 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	assume Mask_$_55 == Mask_$_53;
	goto $branchMerge_51;
anon821_Then:
	assume $_$_condition_$140;
	assume $_$_condition_$140 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#659 : Integer :: ( ((0 <= lk#79#659) && (lk#79#659 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#659) < Heap_$_3[r#66_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_52;
anon821_Else:
	assume !$_$_condition_$140;
	assume $_$_condition_$140 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_52;
anon822_Then:
	assume $_$_condition_$142;
	assume $_$_condition_$142 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null);
	assume Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_53;
anon822_Else:
	assume !$_$_condition_$142;
	assume $_$_condition_$142 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_53;
anon823_Then:
	assume $_$_condition_$144;
	assume $_$_condition_$144 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
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
	goto $branchMerge_54;
anon823_Else:
	assume !$_$_condition_$144;
	assume $_$_condition_$144 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	assume Mask_$_57 == Mask_$_55;
	goto $branchMerge_54;
anon824_Then:
	assume $_$_condition_$146;
	assume $_$_condition_$146 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
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
	goto $branchMerge_55;
anon824_Else:
	assume !$_$_condition_$146;
	assume $_$_condition_$146 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	assume Mask_$_59 == Mask_$_57;
	goto $branchMerge_55;
anon825_Then:
	assume $_$_condition_$148;
	assume $_$_condition_$148 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
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
	goto $branchMerge_56;
anon825_Else:
	assume !$_$_condition_$148;
	assume $_$_condition_$148 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	assume Mask_$_61 == Mask_$_59;
	goto $branchMerge_56;
anon826_Then:
	assume $_$_condition_$150;
	assume $_$_condition_$150 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
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
	goto $branchMerge_57;
anon826_Else:
	assume !$_$_condition_$150;
	assume $_$_condition_$150 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	assume Mask_$_63 == Mask_$_61;
	goto $branchMerge_57;
anon827_Then:
	assume $_$_condition_$152;
	assume $_$_condition_$152 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#660 : Integer :: ( ((0 <= rk#80#660) && (rk#80#660 < Seq#Length(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_3[r#66_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#660)) ));
	goto $branchMerge_58;
anon827_Else:
	assume !$_$_condition_$152;
	assume $_$_condition_$152 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_3[r#66_$_0,AVLTreeNode.right] == null;
	goto $branchMerge_58;
anon828_Then:
	assume $_$_condition_$154;
	assume $_$_condition_$154 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null);
	assume Heap_$_3[Heap_$_3[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon248;
anon828_Else:
	assume !$_$_condition_$154;
	assume $_$_condition_$154 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
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
	assume $_$_condition_$156;
	assume $_$_condition_$156 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
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
	assume !$_$_condition_$156;
	assume $_$_condition_$156 <==> (!(Heap_$_3[r#66_$_0,AVLTreeNode.right] == null));
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
	assume $_$_condition_$157;
	assume $_$_condition_$157 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null);
	assert { :msg "  688.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#665 : Integer :: ( ((0 <= k#92#665) && (k#92#665 < Seq#Length(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys],k#92#665) < Heap_$_4[this#664_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_59;
anon830_Else:
	assume !$_$_condition_$157;
	assume $_$_condition_$157 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null));
	assume Heap_$_4[this#664_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_59;
anon831_Then:
	assume $_$_condition_$158;
	assume $_$_condition_$158 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null);
	assert { :msg "  688.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#666 : Integer :: ( ((0 <= k#93#666) && (k#93#666 < Seq#Length(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_4[this#664_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys],k#93#666)) ));
	goto anon254;
anon831_Else:
	assume !$_$_condition_$158;
	assume $_$_condition_$158 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null));
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
	assume $_$_condition_$160;
	assume $_$_condition_$160 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null);
	assert { :msg "  688.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  688.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2278_$_6 == exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_2278_$_5[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$161) { goto anon833_Then; } else { goto anon833_Else; }
anon832_Else:
	assume !$_$_condition_$160;
	assume $_$_condition_$160 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null));
	assume Heap_$_4[this#664_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_175 == SecMask_$_123;
	assume exhaleMask#_2278_$_7 == exhaleMask#_2278_$_5;
	goto $branchMerge_60;
anon833_Then:
	assume $_$_condition_$161;
	assume $_$_condition_$161 <==> (false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.left])) && true) && true));
	assume false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$163) { goto anon834_Then; } else { goto anon834_Else; }
anon833_Else:
	assume !$_$_condition_$161;
	assume $_$_condition_$161 <==> (false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.left])) && true) && true));
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_174 == SecMask_$_123;
	goto $branchMerge_61;
anon861_Then:
	assume $_$_condition_$162;
	assume $_$_condition_$162 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null);
	assert { :msg "  688.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2278_$_8 == exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_2278_$_7[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_8);
	assume wf(Heap_$_4,exhaleMask#_2278_$_8,SecMask_$_175);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_175);
	assume exhaleMask#_2278_$_9 == exhaleMask#_2278_$_8;
	goto $branchMerge_62;
anon861_Else:
	assume !$_$_condition_$162;
	assume $_$_condition_$162 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null));
	assume Heap_$_4[this#664_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2278_$_9 == exhaleMask#_2278_$_7;
	goto $branchMerge_62;
anon834_Then:
	assume $_$_condition_$163;
	assume $_$_condition_$163 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#667 : Integer :: ( ((0 <= lk#79#667) && (lk#79#667 < Seq#Length(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#667) < Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_63;
anon834_Else:
	assume !$_$_condition_$163;
	assume $_$_condition_$163 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_63;
anon860_Then:
	assume $_$_condition_$164;
	assume $_$_condition_$164 <==> (!CanRead(exhaleMask#_2278_$_6,SecMask_$_174,Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_2278_$_6,SecMask_$_174,Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_2277_$_0[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon311;
anon860_Else:
	assume !$_$_condition_$164;
	assume $_$_condition_$164 <==> (!CanRead(exhaleMask#_2278_$_6,SecMask_$_174,Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_2278_$_6,SecMask_$_174,Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon311;
anon835_Then:
	assume $_$_condition_$165;
	assume $_$_condition_$165 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_64;
anon835_Else:
	assume !$_$_condition_$165;
	assume $_$_condition_$165 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_64;
anon836_Then:
	assume $_$_condition_$167;
	assume $_$_condition_$167 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#668 : Integer :: ( ((0 <= rk#80#668) && (rk#80#668 < Seq#Length(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#668)) ));
	goto $branchMerge_65;
anon836_Else:
	assume !$_$_condition_$167;
	assume $_$_condition_$167 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_65;
anon837_Then:
	assume $_$_condition_$169;
	assume $_$_condition_$169 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon264;
anon837_Else:
	assume !$_$_condition_$169;
	assume $_$_condition_$169 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	assume $_$_condition_$171;
	assume SecMask_$_124[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_125 == SecMask_$_124[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_124[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_126 == SecMask_$_125;
	goto anon266;
anon838_Else:
	assume !$_$_condition_$171;
	assume 0 <= SecMask_$_124[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_126 == SecMask_$_124;
	goto anon266;
anon266:
	assume wf(Heap_$_4,SecMask_$_126,SecMask_$_126);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_126);
	assume SecMask_$_127 == SecMask_$_126[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_126[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_126[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$172) { goto anon839_Then; } else { goto anon839_Else; }
anon839_Then:
	assume $_$_condition_$172;
	assume SecMask_$_127[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_128 == SecMask_$_127[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_127[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_129 == SecMask_$_128;
	goto anon268;
anon839_Else:
	assume !$_$_condition_$172;
	assume 0 <= SecMask_$_127[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_129 == SecMask_$_127;
	goto anon268;
anon268:
	assume wf(Heap_$_4,SecMask_$_129,SecMask_$_129);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_129);
	assume SecMask_$_130 == SecMask_$_129[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_129[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_129[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$173) { goto anon840_Then; } else { goto anon840_Else; }
anon840_Then:
	assume $_$_condition_$173;
	assume SecMask_$_130[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_131 == SecMask_$_130[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_130[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_132 == SecMask_$_131;
	goto anon270;
anon840_Else:
	assume !$_$_condition_$173;
	assume 0 <= SecMask_$_130[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_132 == SecMask_$_130;
	goto anon270;
anon270:
	assume wf(Heap_$_4,SecMask_$_132,SecMask_$_132);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_132);
	assume SecMask_$_133 == SecMask_$_132[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_132[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_132[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$174) { goto anon841_Then; } else { goto anon841_Else; }
anon841_Then:
	assume $_$_condition_$174;
	assume SecMask_$_133[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_134 == SecMask_$_133[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_133[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_135 == SecMask_$_134;
	goto anon272;
anon841_Else:
	assume !$_$_condition_$174;
	assume 0 <= SecMask_$_133[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_135 == SecMask_$_133;
	goto anon272;
anon272:
	assume wf(Heap_$_4,SecMask_$_135,SecMask_$_135);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_135);
	assume SecMask_$_136 == SecMask_$_135[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_135[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_135[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$175) { goto anon842_Then; } else { goto anon842_Else; }
anon842_Then:
	assume $_$_condition_$175;
	assume SecMask_$_136[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_137 == SecMask_$_136[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_136[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_138 == SecMask_$_137;
	goto anon274;
anon842_Else:
	assume !$_$_condition_$175;
	assume 0 <= SecMask_$_136[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_138 == SecMask_$_136;
	goto anon274;
anon274:
	assume wf(Heap_$_4,SecMask_$_138,SecMask_$_138);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_138);
	assume SecMask_$_139 == SecMask_$_138[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_138[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_138[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$176) { goto anon843_Then; } else { goto anon843_Else; }
anon843_Then:
	assume $_$_condition_$176;
	assume SecMask_$_139[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_140 == SecMask_$_139[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_139[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_141 == SecMask_$_140;
	goto anon276;
anon843_Else:
	assume !$_$_condition_$176;
	assume 0 <= SecMask_$_139[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_141 == SecMask_$_139;
	goto anon276;
anon276:
	assume wf(Heap_$_4,SecMask_$_141,SecMask_$_141);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_141);
	if ($_$_condition_$177) { goto anon844_Then; } else { goto anon844_Else; }
anon844_Then:
	assume $_$_condition_$177;
	assume $_$_condition_$177 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_142 == SecMask_$_141[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_141[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_141[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$178) { goto anon845_Then; } else { goto anon845_Else; }
anon844_Else:
	assume !$_$_condition_$177;
	assume $_$_condition_$177 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_145 == SecMask_$_141;
	goto $branchMerge_66;
anon845_Then:
	assume $_$_condition_$178;
	assume SecMask_$_142[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_143 == SecMask_$_142[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_142[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_144 == SecMask_$_143;
	goto anon279;
anon845_Else:
	assume !$_$_condition_$178;
	assume 0 <= SecMask_$_142[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_144 == SecMask_$_142;
	goto anon279;
anon846_Then:
	assume $_$_condition_$179;
	assume $_$_condition_$179 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_146 == SecMask_$_145[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_145[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_145[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$181) { goto anon847_Then; } else { goto anon847_Else; }
anon846_Else:
	assume !$_$_condition_$179;
	assume $_$_condition_$179 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_149 == SecMask_$_145;
	goto $branchMerge_67;
anon279:
	assume wf(Heap_$_4,SecMask_$_144,SecMask_$_144);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_144);
	assume SecMask_$_145 == SecMask_$_144;
	goto $branchMerge_66;
anon847_Then:
	assume $_$_condition_$181;
	assume SecMask_$_146[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_147 == SecMask_$_146[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_146[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_148 == SecMask_$_147;
	goto anon283;
anon847_Else:
	assume !$_$_condition_$181;
	assume 0 <= SecMask_$_146[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_148 == SecMask_$_146;
	goto anon283;
anon848_Then:
	assume $_$_condition_$182;
	assume $_$_condition_$182 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_150 == SecMask_$_149[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_149[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_149[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$184) { goto anon849_Then; } else { goto anon849_Else; }
anon848_Else:
	assume !$_$_condition_$182;
	assume $_$_condition_$182 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_153 == SecMask_$_149;
	goto $branchMerge_68;
anon283:
	assume wf(Heap_$_4,SecMask_$_148,SecMask_$_148);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_148);
	assume SecMask_$_149 == SecMask_$_148;
	goto $branchMerge_67;
anon849_Then:
	assume $_$_condition_$184;
	assume SecMask_$_150[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_151 == SecMask_$_150[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_150[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_152 == SecMask_$_151;
	goto anon287;
anon849_Else:
	assume !$_$_condition_$184;
	assume 0 <= SecMask_$_150[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_152 == SecMask_$_150;
	goto anon287;
anon850_Then:
	assume $_$_condition_$185;
	assume $_$_condition_$185 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_154 == SecMask_$_153[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_153[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_153[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$187) { goto anon851_Then; } else { goto anon851_Else; }
anon850_Else:
	assume !$_$_condition_$185;
	assume $_$_condition_$185 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_157 == SecMask_$_153;
	goto $branchMerge_69;
anon287:
	assume wf(Heap_$_4,SecMask_$_152,SecMask_$_152);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_152);
	assume SecMask_$_153 == SecMask_$_152;
	goto $branchMerge_68;
anon851_Then:
	assume $_$_condition_$187;
	assume SecMask_$_154[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_155 == SecMask_$_154[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_154[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_156 == SecMask_$_155;
	goto anon291;
anon851_Else:
	assume !$_$_condition_$187;
	assume 0 <= SecMask_$_154[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_156 == SecMask_$_154;
	goto anon291;
anon852_Then:
	assume $_$_condition_$188;
	assume $_$_condition_$188 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_158 == SecMask_$_157[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_157[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_157[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$190) { goto anon853_Then; } else { goto anon853_Else; }
anon852_Else:
	assume !$_$_condition_$188;
	assume $_$_condition_$188 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_161 == SecMask_$_157;
	goto $branchMerge_70;
anon291:
	assume wf(Heap_$_4,SecMask_$_156,SecMask_$_156);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_156);
	assume SecMask_$_157 == SecMask_$_156;
	goto $branchMerge_69;
anon853_Then:
	assume $_$_condition_$190;
	assume SecMask_$_158[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_159 == SecMask_$_158[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_158[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_160 == SecMask_$_159;
	goto anon295;
anon853_Else:
	assume !$_$_condition_$190;
	assume 0 <= SecMask_$_158[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_160 == SecMask_$_158;
	goto anon295;
anon854_Then:
	assume $_$_condition_$191;
	assume $_$_condition_$191 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_162 == SecMask_$_161[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_161[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_161[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$193) { goto anon855_Then; } else { goto anon855_Else; }
anon854_Else:
	assume !$_$_condition_$191;
	assume $_$_condition_$191 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_165 == SecMask_$_161;
	goto $branchMerge_71;
anon295:
	assume wf(Heap_$_4,SecMask_$_160,SecMask_$_160);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_160);
	assume SecMask_$_161 == SecMask_$_160;
	goto $branchMerge_70;
anon855_Then:
	assume $_$_condition_$193;
	assume SecMask_$_162[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_163 == SecMask_$_162[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_162[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_164 == SecMask_$_163;
	goto anon299;
anon855_Else:
	assume !$_$_condition_$193;
	assume 0 <= SecMask_$_162[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_164 == SecMask_$_162;
	goto anon299;
anon856_Then:
	assume $_$_condition_$194;
	assume $_$_condition_$194 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_166 == SecMask_$_165[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_165[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_165[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$196) { goto anon857_Then; } else { goto anon857_Else; }
anon856_Else:
	assume !$_$_condition_$194;
	assume $_$_condition_$194 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_169 == SecMask_$_165;
	goto $branchMerge_72;
anon299:
	assume wf(Heap_$_4,SecMask_$_164,SecMask_$_164);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_164);
	assume SecMask_$_165 == SecMask_$_164;
	goto $branchMerge_71;
anon857_Then:
	assume $_$_condition_$196;
	assume SecMask_$_166[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_167 == SecMask_$_166[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_166[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_168 == SecMask_$_167;
	goto anon303;
anon857_Else:
	assume !$_$_condition_$196;
	assume 0 <= SecMask_$_166[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_168 == SecMask_$_166;
	goto anon303;
anon858_Then:
	assume $_$_condition_$197;
	assume $_$_condition_$197 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_170 == SecMask_$_169[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_169[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_169[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$199) { goto anon859_Then; } else { goto anon859_Else; }
anon858_Else:
	assume !$_$_condition_$197;
	assume $_$_condition_$197 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_173 == SecMask_$_169;
	goto anon308;
anon303:
	assume wf(Heap_$_4,SecMask_$_168,SecMask_$_168);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_168);
	assume SecMask_$_169 == SecMask_$_168;
	goto $branchMerge_72;
anon859_Then:
	assume $_$_condition_$199;
	assume SecMask_$_170[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_171 == SecMask_$_170[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_170[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_172 == SecMask_$_171;
	goto anon307;
anon859_Else:
	assume !$_$_condition_$199;
	assume 0 <= SecMask_$_170[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_172 == SecMask_$_170;
	goto anon307;
anon308:
	assume wf(Heap_$_4,SecMask_$_173,SecMask_$_173);
	assume SecMask_$_174 == SecMask_$_173;
	goto $branchMerge_61;
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
	goto $branchMerge_60;
anon862_Then:
	assume $_$_condition_$202;
	assume $_$_condition_$202 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null);
	assert { :msg "  688.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2278_$_10 == exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_2278_$_9[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_10);
	assume wf(Heap_$_4,exhaleMask#_2278_$_10,SecMask_$_175);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_175);
	assume exhaleMask#_2278_$_11 == exhaleMask#_2278_$_10;
	goto $branchMerge_73;
anon862_Else:
	assume !$_$_condition_$202;
	assume $_$_condition_$202 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null));
	assume Heap_$_4[this#664_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2278_$_11 == exhaleMask#_2278_$_9;
	goto $branchMerge_73;
anon863_Then:
	assume $_$_condition_$204;
	assume $_$_condition_$204 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null);
	assert { :msg "  688.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2278_$_12 == exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2278_$_11[Heap_$_4[this#664_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_12);
	assume wf(Heap_$_4,exhaleMask#_2278_$_12,SecMask_$_175);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_175);
	assume exhaleMask#_2278_$_13 == exhaleMask#_2278_$_12;
	goto $branchMerge_74;
anon863_Else:
	assume !$_$_condition_$204;
	assume $_$_condition_$204 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.left] == null));
	assume Heap_$_4[this#664_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2278_$_13 == exhaleMask#_2278_$_11;
	goto $branchMerge_74;
anon864_Then:
	assume $_$_condition_$206;
	assume $_$_condition_$206 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null);
	assert { :msg "  688.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  688.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2278_$_14 == exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_2278_$_13[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$208) { goto anon865_Then; } else { goto anon865_Else; }
anon864_Else:
	assume !$_$_condition_$206;
	assume $_$_condition_$206 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null));
	assume Heap_$_4[this#664_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2278_$_15 == exhaleMask#_2278_$_13;
	assume SecMask_$_227 == SecMask_$_175;
	goto $branchMerge_75;
anon865_Then:
	assume $_$_condition_$208;
	assume $_$_condition_$208 <==> (false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.right])) && true) && true));
	assume false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$210) { goto anon866_Then; } else { goto anon866_Else; }
anon865_Else:
	assume !$_$_condition_$208;
	assume $_$_condition_$208 <==> (false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.right])) && true) && true));
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_4[this#664_$_0,AVLTreeNode.right])) && true) && true));
	assume SecMask_$_226 == SecMask_$_175;
	goto $branchMerge_76;
anon893_Then:
	assume $_$_condition_$209;
	assume $_$_condition_$209 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null);
	assert { :msg "  688.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2278_$_16 == exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_2278_$_15[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_16);
	assume wf(Heap_$_4,exhaleMask#_2278_$_16,SecMask_$_227);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_227);
	assume exhaleMask#_2278_$_17 == exhaleMask#_2278_$_16;
	goto $branchMerge_77;
anon893_Else:
	assume !$_$_condition_$209;
	assume $_$_condition_$209 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null));
	assume Heap_$_4[this#664_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2278_$_17 == exhaleMask#_2278_$_15;
	goto $branchMerge_77;
anon866_Then:
	assume $_$_condition_$210;
	assume $_$_condition_$210 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#672 : Integer :: ( ((0 <= lk#79#672) && (lk#79#672 < Seq#Length(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#672) < Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_78;
anon866_Else:
	assume !$_$_condition_$210;
	assume $_$_condition_$210 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_78;
anon892_Then:
	assume $_$_condition_$211;
	assume $_$_condition_$211 <==> (!CanRead(exhaleMask#_2278_$_14,SecMask_$_226,Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_2278_$_14,SecMask_$_226,Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_2277_$_0[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon375;
anon892_Else:
	assume !$_$_condition_$211;
	assume $_$_condition_$211 <==> (!CanRead(exhaleMask#_2278_$_14,SecMask_$_226,Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_2278_$_14,SecMask_$_226,Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon375;
anon867_Then:
	assume $_$_condition_$212;
	assume $_$_condition_$212 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_79;
anon867_Else:
	assume !$_$_condition_$212;
	assume $_$_condition_$212 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_79;
anon868_Then:
	assume $_$_condition_$214;
	assume $_$_condition_$214 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#673 : Integer :: ( ((0 <= rk#80#673) && (rk#80#673 < Seq#Length(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#673)) ));
	goto $branchMerge_80;
anon868_Else:
	assume !$_$_condition_$214;
	assume $_$_condition_$214 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_80;
anon869_Then:
	assume $_$_condition_$216;
	assume $_$_condition_$216 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap_$_4[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon328;
anon869_Else:
	assume !$_$_condition_$216;
	assume $_$_condition_$216 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	assume $_$_condition_$218;
	assume SecMask_$_176[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_177 == SecMask_$_176[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_176[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_178 == SecMask_$_177;
	goto anon330;
anon870_Else:
	assume !$_$_condition_$218;
	assume 0 <= SecMask_$_176[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_178 == SecMask_$_176;
	goto anon330;
anon330:
	assume wf(Heap_$_4,SecMask_$_178,SecMask_$_178);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_178);
	assume SecMask_$_179 == SecMask_$_178[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_178[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_178[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$219) { goto anon871_Then; } else { goto anon871_Else; }
anon871_Then:
	assume $_$_condition_$219;
	assume SecMask_$_179[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_180 == SecMask_$_179[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_179[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_181 == SecMask_$_180;
	goto anon332;
anon871_Else:
	assume !$_$_condition_$219;
	assume 0 <= SecMask_$_179[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_181 == SecMask_$_179;
	goto anon332;
anon332:
	assume wf(Heap_$_4,SecMask_$_181,SecMask_$_181);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_181);
	assume SecMask_$_182 == SecMask_$_181[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_181[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_181[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$220) { goto anon872_Then; } else { goto anon872_Else; }
anon872_Then:
	assume $_$_condition_$220;
	assume SecMask_$_182[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_183 == SecMask_$_182[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_182[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_184 == SecMask_$_183;
	goto anon334;
anon872_Else:
	assume !$_$_condition_$220;
	assume 0 <= SecMask_$_182[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_184 == SecMask_$_182;
	goto anon334;
anon334:
	assume wf(Heap_$_4,SecMask_$_184,SecMask_$_184);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_184);
	assume SecMask_$_185 == SecMask_$_184[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_184[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_184[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$221) { goto anon873_Then; } else { goto anon873_Else; }
anon873_Then:
	assume $_$_condition_$221;
	assume SecMask_$_185[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_186 == SecMask_$_185[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_185[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_187 == SecMask_$_186;
	goto anon336;
anon873_Else:
	assume !$_$_condition_$221;
	assume 0 <= SecMask_$_185[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_187 == SecMask_$_185;
	goto anon336;
anon336:
	assume wf(Heap_$_4,SecMask_$_187,SecMask_$_187);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_187);
	assume SecMask_$_188 == SecMask_$_187[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_187[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_187[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$222) { goto anon874_Then; } else { goto anon874_Else; }
anon874_Then:
	assume $_$_condition_$222;
	assume SecMask_$_188[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_189 == SecMask_$_188[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_188[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_190 == SecMask_$_189;
	goto anon338;
anon874_Else:
	assume !$_$_condition_$222;
	assume 0 <= SecMask_$_188[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_190 == SecMask_$_188;
	goto anon338;
anon338:
	assume wf(Heap_$_4,SecMask_$_190,SecMask_$_190);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_190);
	assume SecMask_$_191 == SecMask_$_190[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_190[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_190[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$223) { goto anon875_Then; } else { goto anon875_Else; }
anon875_Then:
	assume $_$_condition_$223;
	assume SecMask_$_191[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_192 == SecMask_$_191[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_191[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_193 == SecMask_$_192;
	goto anon340;
anon875_Else:
	assume !$_$_condition_$223;
	assume 0 <= SecMask_$_191[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_193 == SecMask_$_191;
	goto anon340;
anon340:
	assume wf(Heap_$_4,SecMask_$_193,SecMask_$_193);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_193);
	if ($_$_condition_$224) { goto anon876_Then; } else { goto anon876_Else; }
anon876_Then:
	assume $_$_condition_$224;
	assume $_$_condition_$224 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_194 == SecMask_$_193[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_193[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_193[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$225) { goto anon877_Then; } else { goto anon877_Else; }
anon876_Else:
	assume !$_$_condition_$224;
	assume $_$_condition_$224 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_197 == SecMask_$_193;
	goto $branchMerge_81;
anon877_Then:
	assume $_$_condition_$225;
	assume SecMask_$_194[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_195 == SecMask_$_194[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_194[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_196 == SecMask_$_195;
	goto anon343;
anon877_Else:
	assume !$_$_condition_$225;
	assume 0 <= SecMask_$_194[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_196 == SecMask_$_194;
	goto anon343;
anon878_Then:
	assume $_$_condition_$226;
	assume $_$_condition_$226 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_198 == SecMask_$_197[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_197[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_197[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$228) { goto anon879_Then; } else { goto anon879_Else; }
anon878_Else:
	assume !$_$_condition_$226;
	assume $_$_condition_$226 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_201 == SecMask_$_197;
	goto $branchMerge_82;
anon343:
	assume wf(Heap_$_4,SecMask_$_196,SecMask_$_196);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_196);
	assume SecMask_$_197 == SecMask_$_196;
	goto $branchMerge_81;
anon879_Then:
	assume $_$_condition_$228;
	assume SecMask_$_198[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_199 == SecMask_$_198[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_198[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_200 == SecMask_$_199;
	goto anon347;
anon879_Else:
	assume !$_$_condition_$228;
	assume 0 <= SecMask_$_198[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_200 == SecMask_$_198;
	goto anon347;
anon880_Then:
	assume $_$_condition_$229;
	assume $_$_condition_$229 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_202 == SecMask_$_201[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_201[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_201[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$231) { goto anon881_Then; } else { goto anon881_Else; }
anon880_Else:
	assume !$_$_condition_$229;
	assume $_$_condition_$229 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_205 == SecMask_$_201;
	goto $branchMerge_83;
anon347:
	assume wf(Heap_$_4,SecMask_$_200,SecMask_$_200);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_200);
	assume SecMask_$_201 == SecMask_$_200;
	goto $branchMerge_82;
anon881_Then:
	assume $_$_condition_$231;
	assume SecMask_$_202[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_203 == SecMask_$_202[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_202[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_204 == SecMask_$_203;
	goto anon351;
anon881_Else:
	assume !$_$_condition_$231;
	assume 0 <= SecMask_$_202[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_204 == SecMask_$_202;
	goto anon351;
anon882_Then:
	assume $_$_condition_$232;
	assume $_$_condition_$232 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_206 == SecMask_$_205[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_205[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_205[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$234) { goto anon883_Then; } else { goto anon883_Else; }
anon882_Else:
	assume !$_$_condition_$232;
	assume $_$_condition_$232 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_209 == SecMask_$_205;
	goto $branchMerge_84;
anon351:
	assume wf(Heap_$_4,SecMask_$_204,SecMask_$_204);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_204);
	assume SecMask_$_205 == SecMask_$_204;
	goto $branchMerge_83;
anon883_Then:
	assume $_$_condition_$234;
	assume SecMask_$_206[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_207 == SecMask_$_206[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_206[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_208 == SecMask_$_207;
	goto anon355;
anon883_Else:
	assume !$_$_condition_$234;
	assume 0 <= SecMask_$_206[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_208 == SecMask_$_206;
	goto anon355;
anon884_Then:
	assume $_$_condition_$235;
	assume $_$_condition_$235 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_210 == SecMask_$_209[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_209[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_209[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$237) { goto anon885_Then; } else { goto anon885_Else; }
anon884_Else:
	assume !$_$_condition_$235;
	assume $_$_condition_$235 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_213 == SecMask_$_209;
	goto $branchMerge_85;
anon355:
	assume wf(Heap_$_4,SecMask_$_208,SecMask_$_208);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_208);
	assume SecMask_$_209 == SecMask_$_208;
	goto $branchMerge_84;
anon885_Then:
	assume $_$_condition_$237;
	assume SecMask_$_210[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_211 == SecMask_$_210[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_210[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_212 == SecMask_$_211;
	goto anon359;
anon885_Else:
	assume !$_$_condition_$237;
	assume 0 <= SecMask_$_210[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_212 == SecMask_$_210;
	goto anon359;
anon886_Then:
	assume $_$_condition_$238;
	assume $_$_condition_$238 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_214 == SecMask_$_213[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_213[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_213[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$240) { goto anon887_Then; } else { goto anon887_Else; }
anon886_Else:
	assume !$_$_condition_$238;
	assume $_$_condition_$238 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_217 == SecMask_$_213;
	goto $branchMerge_86;
anon359:
	assume wf(Heap_$_4,SecMask_$_212,SecMask_$_212);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_212);
	assume SecMask_$_213 == SecMask_$_212;
	goto $branchMerge_85;
anon887_Then:
	assume $_$_condition_$240;
	assume SecMask_$_214[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_215 == SecMask_$_214[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_214[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_216 == SecMask_$_215;
	goto anon363;
anon887_Else:
	assume !$_$_condition_$240;
	assume 0 <= SecMask_$_214[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_216 == SecMask_$_214;
	goto anon363;
anon888_Then:
	assume $_$_condition_$241;
	assume $_$_condition_$241 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_218 == SecMask_$_217[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_217[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_217[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$243) { goto anon889_Then; } else { goto anon889_Else; }
anon888_Else:
	assume !$_$_condition_$241;
	assume $_$_condition_$241 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_221 == SecMask_$_217;
	goto $branchMerge_87;
anon363:
	assume wf(Heap_$_4,SecMask_$_216,SecMask_$_216);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_216);
	assume SecMask_$_217 == SecMask_$_216;
	goto $branchMerge_86;
anon889_Then:
	assume $_$_condition_$243;
	assume SecMask_$_218[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_219 == SecMask_$_218[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_218[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_220 == SecMask_$_219;
	goto anon367;
anon889_Else:
	assume !$_$_condition_$243;
	assume 0 <= SecMask_$_218[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_220 == SecMask_$_218;
	goto anon367;
anon890_Then:
	assume $_$_condition_$244;
	assume $_$_condition_$244 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_222 == SecMask_$_221[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_221[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_221[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$246) { goto anon891_Then; } else { goto anon891_Else; }
anon890_Else:
	assume !$_$_condition_$244;
	assume $_$_condition_$244 <==> (!(Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_225 == SecMask_$_221;
	goto anon372;
anon367:
	assume wf(Heap_$_4,SecMask_$_220,SecMask_$_220);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_220);
	assume SecMask_$_221 == SecMask_$_220;
	goto $branchMerge_87;
anon891_Then:
	assume $_$_condition_$246;
	assume SecMask_$_222[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_223 == SecMask_$_222[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_222[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_224 == SecMask_$_223;
	goto anon371;
anon891_Else:
	assume !$_$_condition_$246;
	assume 0 <= SecMask_$_222[Heap_$_4[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_224 == SecMask_$_222;
	goto anon371;
anon372:
	assume wf(Heap_$_4,SecMask_$_225,SecMask_$_225);
	assume SecMask_$_226 == SecMask_$_225;
	goto $branchMerge_76;
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
	goto $branchMerge_75;
anon894_Then:
	assume $_$_condition_$249;
	assume $_$_condition_$249 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null);
	assert { :msg "  688.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  688.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2278_$_18 == exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_2278_$_17[Heap_$_4[this#664_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2278_$_18);
	assume wf(Heap_$_4,exhaleMask#_2278_$_18,SecMask_$_227);
	assume wf(Heap_$_4,Mask_$_63,SecMask_$_227);
	assume exhaleMask#_2278_$_19 == exhaleMask#_2278_$_18;
	goto $branchMerge_88;
anon894_Else:
	assume !$_$_condition_$249;
	assume $_$_condition_$249 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null));
	assume Heap_$_4[this#664_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2278_$_19 == exhaleMask#_2278_$_17;
	goto $branchMerge_88;
anon895_Then:
	assume $_$_condition_$251;
	assume $_$_condition_$251 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null));
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
	assume !$_$_condition_$251;
	assume $_$_condition_$251 <==> (!(Heap_$_4[this#664_$_0,AVLTreeNode.right] == null));
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
	assume $_$_condition_$253;
	assume $_$_condition_$253 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
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
	assume !$_$_condition_$253;
	assume $_$_condition_$253 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
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
	assume $_$_condition_$254;
	assume $_$_condition_$254 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  693.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#681 : Integer :: ( ((0 <= k#92#681) && (k#92#681 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#681) < Heap_$_6[this,AVLTreeNode.key]) ));
	goto $branchMerge_89;
anon897_Else:
	assume !$_$_condition_$254;
	assume $_$_condition_$254 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	goto $branchMerge_89;
anon898_Then:
	assume $_$_condition_$255;
	assume $_$_condition_$255 <==> (!(Heap_$_6[this,AVLTreeNode.right] == null));
	assume !(Heap_$_6[this,AVLTreeNode.right] == null);
	assert { :msg "  693.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#682 : Integer :: ( ((0 <= k#93#682) && (k#93#682 < Seq#Length(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_6[this,AVLTreeNode.key] < Seq#Index(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#682)) ));
	goto anon388;
anon898_Else:
	assume !$_$_condition_$255;
	assume $_$_condition_$255 <==> (!(Heap_$_6[this,AVLTreeNode.right] == null));
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
	assume $_$_condition_$257;
	assume $_$_condition_$257 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  693.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  693.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2339_$_6 == exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_2339_$_5[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$258) { goto anon900_Then; } else { goto anon900_Else; }
anon899_Else:
	assume !$_$_condition_$257;
	assume $_$_condition_$257 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	assume SecMask_$_279 == SecMask_$_227;
	assume exhaleMask#_2339_$_7 == exhaleMask#_2339_$_5;
	goto $branchMerge_90;
anon900_Then:
	assume $_$_condition_$258;
	assume $_$_condition_$258 <==> (false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.left])) && true) && true));
	assume false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$260) { goto anon901_Then; } else { goto anon901_Else; }
anon900_Else:
	assume !$_$_condition_$258;
	assume $_$_condition_$258 <==> (false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.left])) && true) && true));
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_278 == SecMask_$_227;
	goto $branchMerge_91;
anon928_Then:
	assume $_$_condition_$259;
	assume $_$_condition_$259 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  693.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2339_$_8 == exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_2339_$_7[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_8);
	assume wf(Heap_$_6,exhaleMask#_2339_$_8,SecMask_$_279);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_279);
	assume exhaleMask#_2339_$_9 == exhaleMask#_2339_$_8;
	goto $branchMerge_92;
anon928_Else:
	assume !$_$_condition_$259;
	assume $_$_condition_$259 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	assume exhaleMask#_2339_$_9 == exhaleMask#_2339_$_7;
	goto $branchMerge_92;
anon901_Then:
	assume $_$_condition_$260;
	assume $_$_condition_$260 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#683 : Integer :: ( ((0 <= lk#79#683) && (lk#79#683 < Seq#Length(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#683) < Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_93;
anon901_Else:
	assume !$_$_condition_$260;
	assume $_$_condition_$260 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_93;
anon927_Then:
	assume $_$_condition_$261;
	assume $_$_condition_$261 <==> (!CanRead(exhaleMask#_2339_$_6,SecMask_$_278,Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_2339_$_6,SecMask_$_278,Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_2338_$_0[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon445;
anon927_Else:
	assume !$_$_condition_$261;
	assume $_$_condition_$261 <==> (!CanRead(exhaleMask#_2339_$_6,SecMask_$_278,Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_2339_$_6,SecMask_$_278,Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon445;
anon902_Then:
	assume $_$_condition_$262;
	assume $_$_condition_$262 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_94;
anon902_Else:
	assume !$_$_condition_$262;
	assume $_$_condition_$262 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_94;
anon903_Then:
	assume $_$_condition_$264;
	assume $_$_condition_$264 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#684 : Integer :: ( ((0 <= rk#80#684) && (rk#80#684 < Seq#Length(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#684)) ));
	goto $branchMerge_95;
anon903_Else:
	assume !$_$_condition_$264;
	assume $_$_condition_$264 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_95;
anon904_Then:
	assume $_$_condition_$266;
	assume $_$_condition_$266 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon398;
anon904_Else:
	assume !$_$_condition_$266;
	assume $_$_condition_$266 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	assume $_$_condition_$268;
	assume SecMask_$_228[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_229 == SecMask_$_228[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_228[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_230 == SecMask_$_229;
	goto anon400;
anon905_Else:
	assume !$_$_condition_$268;
	assume 0 <= SecMask_$_228[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_230 == SecMask_$_228;
	goto anon400;
anon400:
	assume wf(Heap_$_6,SecMask_$_230,SecMask_$_230);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_230);
	assume SecMask_$_231 == SecMask_$_230[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_230[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_230[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$269) { goto anon906_Then; } else { goto anon906_Else; }
anon906_Then:
	assume $_$_condition_$269;
	assume SecMask_$_231[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_232 == SecMask_$_231[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_231[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_233 == SecMask_$_232;
	goto anon402;
anon906_Else:
	assume !$_$_condition_$269;
	assume 0 <= SecMask_$_231[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_233 == SecMask_$_231;
	goto anon402;
anon402:
	assume wf(Heap_$_6,SecMask_$_233,SecMask_$_233);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_233);
	assume SecMask_$_234 == SecMask_$_233[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_233[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_233[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$270) { goto anon907_Then; } else { goto anon907_Else; }
anon907_Then:
	assume $_$_condition_$270;
	assume SecMask_$_234[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_235 == SecMask_$_234[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_234[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_236 == SecMask_$_235;
	goto anon404;
anon907_Else:
	assume !$_$_condition_$270;
	assume 0 <= SecMask_$_234[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_236 == SecMask_$_234;
	goto anon404;
anon404:
	assume wf(Heap_$_6,SecMask_$_236,SecMask_$_236);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_236);
	assume SecMask_$_237 == SecMask_$_236[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_236[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_236[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$271) { goto anon908_Then; } else { goto anon908_Else; }
anon908_Then:
	assume $_$_condition_$271;
	assume SecMask_$_237[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_238 == SecMask_$_237[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_237[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_239 == SecMask_$_238;
	goto anon406;
anon908_Else:
	assume !$_$_condition_$271;
	assume 0 <= SecMask_$_237[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_239 == SecMask_$_237;
	goto anon406;
anon406:
	assume wf(Heap_$_6,SecMask_$_239,SecMask_$_239);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_239);
	assume SecMask_$_240 == SecMask_$_239[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_239[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_239[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$272) { goto anon909_Then; } else { goto anon909_Else; }
anon909_Then:
	assume $_$_condition_$272;
	assume SecMask_$_240[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_241 == SecMask_$_240[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_240[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_242 == SecMask_$_241;
	goto anon408;
anon909_Else:
	assume !$_$_condition_$272;
	assume 0 <= SecMask_$_240[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_242 == SecMask_$_240;
	goto anon408;
anon408:
	assume wf(Heap_$_6,SecMask_$_242,SecMask_$_242);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_242);
	assume SecMask_$_243 == SecMask_$_242[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_242[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_242[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$273) { goto anon910_Then; } else { goto anon910_Else; }
anon910_Then:
	assume $_$_condition_$273;
	assume SecMask_$_243[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_244 == SecMask_$_243[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_243[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_245 == SecMask_$_244;
	goto anon410;
anon910_Else:
	assume !$_$_condition_$273;
	assume 0 <= SecMask_$_243[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_245 == SecMask_$_243;
	goto anon410;
anon410:
	assume wf(Heap_$_6,SecMask_$_245,SecMask_$_245);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_245);
	if ($_$_condition_$274) { goto anon911_Then; } else { goto anon911_Else; }
anon911_Then:
	assume $_$_condition_$274;
	assume $_$_condition_$274 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_246 == SecMask_$_245[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_245[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_245[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$275) { goto anon912_Then; } else { goto anon912_Else; }
anon911_Else:
	assume !$_$_condition_$274;
	assume $_$_condition_$274 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_249 == SecMask_$_245;
	goto $branchMerge_96;
anon912_Then:
	assume $_$_condition_$275;
	assume SecMask_$_246[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_247 == SecMask_$_246[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_246[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_248 == SecMask_$_247;
	goto anon413;
anon912_Else:
	assume !$_$_condition_$275;
	assume 0 <= SecMask_$_246[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_248 == SecMask_$_246;
	goto anon413;
anon913_Then:
	assume $_$_condition_$276;
	assume $_$_condition_$276 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_250 == SecMask_$_249[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_249[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_249[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$278) { goto anon914_Then; } else { goto anon914_Else; }
anon913_Else:
	assume !$_$_condition_$276;
	assume $_$_condition_$276 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_253 == SecMask_$_249;
	goto $branchMerge_97;
anon413:
	assume wf(Heap_$_6,SecMask_$_248,SecMask_$_248);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_248);
	assume SecMask_$_249 == SecMask_$_248;
	goto $branchMerge_96;
anon914_Then:
	assume $_$_condition_$278;
	assume SecMask_$_250[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_251 == SecMask_$_250[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_250[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_252 == SecMask_$_251;
	goto anon417;
anon914_Else:
	assume !$_$_condition_$278;
	assume 0 <= SecMask_$_250[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_252 == SecMask_$_250;
	goto anon417;
anon915_Then:
	assume $_$_condition_$279;
	assume $_$_condition_$279 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_254 == SecMask_$_253[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_253[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_253[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$281) { goto anon916_Then; } else { goto anon916_Else; }
anon915_Else:
	assume !$_$_condition_$279;
	assume $_$_condition_$279 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_257 == SecMask_$_253;
	goto $branchMerge_98;
anon417:
	assume wf(Heap_$_6,SecMask_$_252,SecMask_$_252);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_252);
	assume SecMask_$_253 == SecMask_$_252;
	goto $branchMerge_97;
anon916_Then:
	assume $_$_condition_$281;
	assume SecMask_$_254[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_255 == SecMask_$_254[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_254[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_256 == SecMask_$_255;
	goto anon421;
anon916_Else:
	assume !$_$_condition_$281;
	assume 0 <= SecMask_$_254[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_256 == SecMask_$_254;
	goto anon421;
anon917_Then:
	assume $_$_condition_$282;
	assume $_$_condition_$282 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_258 == SecMask_$_257[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_257[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_257[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$284) { goto anon918_Then; } else { goto anon918_Else; }
anon917_Else:
	assume !$_$_condition_$282;
	assume $_$_condition_$282 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_261 == SecMask_$_257;
	goto $branchMerge_99;
anon421:
	assume wf(Heap_$_6,SecMask_$_256,SecMask_$_256);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_256);
	assume SecMask_$_257 == SecMask_$_256;
	goto $branchMerge_98;
anon918_Then:
	assume $_$_condition_$284;
	assume SecMask_$_258[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_259 == SecMask_$_258[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_258[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_260 == SecMask_$_259;
	goto anon425;
anon918_Else:
	assume !$_$_condition_$284;
	assume 0 <= SecMask_$_258[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_260 == SecMask_$_258;
	goto anon425;
anon919_Then:
	assume $_$_condition_$285;
	assume $_$_condition_$285 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_262 == SecMask_$_261[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_261[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_261[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$287) { goto anon920_Then; } else { goto anon920_Else; }
anon919_Else:
	assume !$_$_condition_$285;
	assume $_$_condition_$285 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_265 == SecMask_$_261;
	goto $branchMerge_100;
anon425:
	assume wf(Heap_$_6,SecMask_$_260,SecMask_$_260);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_260);
	assume SecMask_$_261 == SecMask_$_260;
	goto $branchMerge_99;
anon920_Then:
	assume $_$_condition_$287;
	assume SecMask_$_262[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_263 == SecMask_$_262[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_262[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_264 == SecMask_$_263;
	goto anon429;
anon920_Else:
	assume !$_$_condition_$287;
	assume 0 <= SecMask_$_262[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_264 == SecMask_$_262;
	goto anon429;
anon921_Then:
	assume $_$_condition_$288;
	assume $_$_condition_$288 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_266 == SecMask_$_265[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_265[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_265[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$290) { goto anon922_Then; } else { goto anon922_Else; }
anon921_Else:
	assume !$_$_condition_$288;
	assume $_$_condition_$288 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_269 == SecMask_$_265;
	goto $branchMerge_101;
anon429:
	assume wf(Heap_$_6,SecMask_$_264,SecMask_$_264);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_264);
	assume SecMask_$_265 == SecMask_$_264;
	goto $branchMerge_100;
anon922_Then:
	assume $_$_condition_$290;
	assume SecMask_$_266[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_267 == SecMask_$_266[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_266[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_268 == SecMask_$_267;
	goto anon433;
anon922_Else:
	assume !$_$_condition_$290;
	assume 0 <= SecMask_$_266[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_268 == SecMask_$_266;
	goto anon433;
anon923_Then:
	assume $_$_condition_$291;
	assume $_$_condition_$291 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_270 == SecMask_$_269[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_269[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_269[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$293) { goto anon924_Then; } else { goto anon924_Else; }
anon923_Else:
	assume !$_$_condition_$291;
	assume $_$_condition_$291 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_273 == SecMask_$_269;
	goto $branchMerge_102;
anon433:
	assume wf(Heap_$_6,SecMask_$_268,SecMask_$_268);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_268);
	assume SecMask_$_269 == SecMask_$_268;
	goto $branchMerge_101;
anon924_Then:
	assume $_$_condition_$293;
	assume SecMask_$_270[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_271 == SecMask_$_270[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_270[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_272 == SecMask_$_271;
	goto anon437;
anon924_Else:
	assume !$_$_condition_$293;
	assume 0 <= SecMask_$_270[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_272 == SecMask_$_270;
	goto anon437;
anon925_Then:
	assume $_$_condition_$294;
	assume $_$_condition_$294 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_274 == SecMask_$_273[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_273[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_273[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$296) { goto anon926_Then; } else { goto anon926_Else; }
anon925_Else:
	assume !$_$_condition_$294;
	assume $_$_condition_$294 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_277 == SecMask_$_273;
	goto anon442;
anon437:
	assume wf(Heap_$_6,SecMask_$_272,SecMask_$_272);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_272);
	assume SecMask_$_273 == SecMask_$_272;
	goto $branchMerge_102;
anon926_Then:
	assume $_$_condition_$296;
	assume SecMask_$_274[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_275 == SecMask_$_274[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_274[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_276 == SecMask_$_275;
	goto anon441;
anon926_Else:
	assume !$_$_condition_$296;
	assume 0 <= SecMask_$_274[Heap_$_6[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_276 == SecMask_$_274;
	goto anon441;
anon442:
	assume wf(Heap_$_6,SecMask_$_277,SecMask_$_277);
	assume SecMask_$_278 == SecMask_$_277;
	goto $branchMerge_91;
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
	goto $branchMerge_90;
anon929_Then:
	assume $_$_condition_$299;
	assume $_$_condition_$299 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  693.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2339_$_10 == exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_2339_$_9[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_10);
	assume wf(Heap_$_6,exhaleMask#_2339_$_10,SecMask_$_279);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_279);
	assume exhaleMask#_2339_$_11 == exhaleMask#_2339_$_10;
	goto $branchMerge_103;
anon929_Else:
	assume !$_$_condition_$299;
	assume $_$_condition_$299 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	assume exhaleMask#_2339_$_11 == exhaleMask#_2339_$_9;
	goto $branchMerge_103;
anon930_Then:
	assume $_$_condition_$301;
	assume $_$_condition_$301 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assume !(Heap_$_6[this,AVLTreeNode.left] == null);
	assert { :msg "  693.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2339_$_12 == exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2339_$_11[Heap_$_6[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_12);
	assume wf(Heap_$_6,exhaleMask#_2339_$_12,SecMask_$_279);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_279);
	assume exhaleMask#_2339_$_13 == exhaleMask#_2339_$_12;
	goto $branchMerge_104;
anon930_Else:
	assume !$_$_condition_$301;
	assume $_$_condition_$301 <==> (!(Heap_$_6[this,AVLTreeNode.left] == null));
	assume Heap_$_6[this,AVLTreeNode.left] == null;
	assume exhaleMask#_2339_$_13 == exhaleMask#_2339_$_11;
	goto $branchMerge_104;
anon931_Then:
	assume $_$_condition_$303;
	assume $_$_condition_$303 <==> (!(Heap_$_6[this,AVLTreeNode.right] == null));
	assume !(Heap_$_6[this,AVLTreeNode.right] == null);
	assert { :msg "  693.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  693.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2339_$_14 == exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_2339_$_13[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$305) { goto anon932_Then; } else { goto anon932_Else; }
anon931_Else:
	assume !$_$_condition_$303;
	assume $_$_condition_$303 <==> (!(Heap_$_6[this,AVLTreeNode.right] == null));
	assume Heap_$_6[this,AVLTreeNode.right] == null;
	assume exhaleMask#_2339_$_15 == exhaleMask#_2339_$_13;
	assume SecMask_$_331 == SecMask_$_279;
	goto $branchMerge_105;
anon932_Then:
	assume $_$_condition_$305;
	assume $_$_condition_$305 <==> (false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.right])) && true) && true));
	assume false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$307) { goto anon933_Then; } else { goto anon933_Else; }
anon932_Else:
	assume !$_$_condition_$305;
	assume $_$_condition_$305 <==> (false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.right])) && true) && true));
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_6[this,AVLTreeNode.right])) && true) && true));
	assume SecMask_$_330 == SecMask_$_279;
	goto $branchMerge_106;
anon960_Then:
	assume $_$_condition_$306;
	assume $_$_condition_$306 <==> (!(Heap_$_6[this,AVLTreeNode.right] == null));
	assume !(Heap_$_6[this,AVLTreeNode.right] == null);
	assert { :msg "  693.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2339_$_16 == exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_2339_$_15[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_16);
	assume wf(Heap_$_6,exhaleMask#_2339_$_16,SecMask_$_331);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_331);
	assume exhaleMask#_2339_$_17 == exhaleMask#_2339_$_16;
	goto $branchMerge_107;
anon960_Else:
	assume !$_$_condition_$306;
	assume $_$_condition_$306 <==> (!(Heap_$_6[this,AVLTreeNode.right] == null));
	assume Heap_$_6[this,AVLTreeNode.right] == null;
	assume exhaleMask#_2339_$_17 == exhaleMask#_2339_$_15;
	goto $branchMerge_107;
anon933_Then:
	assume $_$_condition_$307;
	assume $_$_condition_$307 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#688 : Integer :: ( ((0 <= lk#79#688) && (lk#79#688 < Seq#Length(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#688) < Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_108;
anon933_Else:
	assume !$_$_condition_$307;
	assume $_$_condition_$307 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_108;
anon959_Then:
	assume $_$_condition_$308;
	assume $_$_condition_$308 <==> (!CanRead(exhaleMask#_2339_$_14,SecMask_$_330,Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_2339_$_14,SecMask_$_330,Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_2338_$_0[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon509;
anon959_Else:
	assume !$_$_condition_$308;
	assume $_$_condition_$308 <==> (!CanRead(exhaleMask#_2339_$_14,SecMask_$_330,Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_2339_$_14,SecMask_$_330,Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon509;
anon934_Then:
	assume $_$_condition_$309;
	assume $_$_condition_$309 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_109;
anon934_Else:
	assume !$_$_condition_$309;
	assume $_$_condition_$309 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_109;
anon935_Then:
	assume $_$_condition_$311;
	assume $_$_condition_$311 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#689 : Integer :: ( ((0 <= rk#80#689) && (rk#80#689 < Seq#Length(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#689)) ));
	goto $branchMerge_110;
anon935_Else:
	assume !$_$_condition_$311;
	assume $_$_condition_$311 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_110;
anon936_Then:
	assume $_$_condition_$313;
	assume $_$_condition_$313 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap_$_6[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon462;
anon936_Else:
	assume !$_$_condition_$313;
	assume $_$_condition_$313 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	assume $_$_condition_$315;
	assume SecMask_$_280[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_281 == SecMask_$_280[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_280[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_282 == SecMask_$_281;
	goto anon464;
anon937_Else:
	assume !$_$_condition_$315;
	assume 0 <= SecMask_$_280[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_282 == SecMask_$_280;
	goto anon464;
anon464:
	assume wf(Heap_$_6,SecMask_$_282,SecMask_$_282);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_282);
	assume SecMask_$_283 == SecMask_$_282[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_282[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_282[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$316) { goto anon938_Then; } else { goto anon938_Else; }
anon938_Then:
	assume $_$_condition_$316;
	assume SecMask_$_283[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_284 == SecMask_$_283[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_283[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_285 == SecMask_$_284;
	goto anon466;
anon938_Else:
	assume !$_$_condition_$316;
	assume 0 <= SecMask_$_283[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_285 == SecMask_$_283;
	goto anon466;
anon466:
	assume wf(Heap_$_6,SecMask_$_285,SecMask_$_285);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_285);
	assume SecMask_$_286 == SecMask_$_285[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_285[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_285[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$317) { goto anon939_Then; } else { goto anon939_Else; }
anon939_Then:
	assume $_$_condition_$317;
	assume SecMask_$_286[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_287 == SecMask_$_286[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_286[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_288 == SecMask_$_287;
	goto anon468;
anon939_Else:
	assume !$_$_condition_$317;
	assume 0 <= SecMask_$_286[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_288 == SecMask_$_286;
	goto anon468;
anon468:
	assume wf(Heap_$_6,SecMask_$_288,SecMask_$_288);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_288);
	assume SecMask_$_289 == SecMask_$_288[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_288[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_288[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$318) { goto anon940_Then; } else { goto anon940_Else; }
anon940_Then:
	assume $_$_condition_$318;
	assume SecMask_$_289[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_290 == SecMask_$_289[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_289[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_291 == SecMask_$_290;
	goto anon470;
anon940_Else:
	assume !$_$_condition_$318;
	assume 0 <= SecMask_$_289[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_291 == SecMask_$_289;
	goto anon470;
anon470:
	assume wf(Heap_$_6,SecMask_$_291,SecMask_$_291);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_291);
	assume SecMask_$_292 == SecMask_$_291[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_291[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_291[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$319) { goto anon941_Then; } else { goto anon941_Else; }
anon941_Then:
	assume $_$_condition_$319;
	assume SecMask_$_292[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_293 == SecMask_$_292[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_292[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_294 == SecMask_$_293;
	goto anon472;
anon941_Else:
	assume !$_$_condition_$319;
	assume 0 <= SecMask_$_292[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_294 == SecMask_$_292;
	goto anon472;
anon472:
	assume wf(Heap_$_6,SecMask_$_294,SecMask_$_294);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_294);
	assume SecMask_$_295 == SecMask_$_294[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_294[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_294[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$320) { goto anon942_Then; } else { goto anon942_Else; }
anon942_Then:
	assume $_$_condition_$320;
	assume SecMask_$_295[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_296 == SecMask_$_295[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_295[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_297 == SecMask_$_296;
	goto anon474;
anon942_Else:
	assume !$_$_condition_$320;
	assume 0 <= SecMask_$_295[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_297 == SecMask_$_295;
	goto anon474;
anon474:
	assume wf(Heap_$_6,SecMask_$_297,SecMask_$_297);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_297);
	if ($_$_condition_$321) { goto anon943_Then; } else { goto anon943_Else; }
anon943_Then:
	assume $_$_condition_$321;
	assume $_$_condition_$321 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_298 == SecMask_$_297[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_297[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_297[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$322) { goto anon944_Then; } else { goto anon944_Else; }
anon943_Else:
	assume !$_$_condition_$321;
	assume $_$_condition_$321 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_301 == SecMask_$_297;
	goto $branchMerge_111;
anon944_Then:
	assume $_$_condition_$322;
	assume SecMask_$_298[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_299 == SecMask_$_298[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_298[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_300 == SecMask_$_299;
	goto anon477;
anon944_Else:
	assume !$_$_condition_$322;
	assume 0 <= SecMask_$_298[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_300 == SecMask_$_298;
	goto anon477;
anon945_Then:
	assume $_$_condition_$323;
	assume $_$_condition_$323 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_302 == SecMask_$_301[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_301[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_301[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$325) { goto anon946_Then; } else { goto anon946_Else; }
anon945_Else:
	assume !$_$_condition_$323;
	assume $_$_condition_$323 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_305 == SecMask_$_301;
	goto $branchMerge_112;
anon477:
	assume wf(Heap_$_6,SecMask_$_300,SecMask_$_300);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_300);
	assume SecMask_$_301 == SecMask_$_300;
	goto $branchMerge_111;
anon946_Then:
	assume $_$_condition_$325;
	assume SecMask_$_302[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_303 == SecMask_$_302[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_302[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_304 == SecMask_$_303;
	goto anon481;
anon946_Else:
	assume !$_$_condition_$325;
	assume 0 <= SecMask_$_302[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_304 == SecMask_$_302;
	goto anon481;
anon947_Then:
	assume $_$_condition_$326;
	assume $_$_condition_$326 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_306 == SecMask_$_305[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_305[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_305[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$328) { goto anon948_Then; } else { goto anon948_Else; }
anon947_Else:
	assume !$_$_condition_$326;
	assume $_$_condition_$326 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_309 == SecMask_$_305;
	goto $branchMerge_113;
anon481:
	assume wf(Heap_$_6,SecMask_$_304,SecMask_$_304);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_304);
	assume SecMask_$_305 == SecMask_$_304;
	goto $branchMerge_112;
anon948_Then:
	assume $_$_condition_$328;
	assume SecMask_$_306[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_307 == SecMask_$_306[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_306[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_308 == SecMask_$_307;
	goto anon485;
anon948_Else:
	assume !$_$_condition_$328;
	assume 0 <= SecMask_$_306[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_308 == SecMask_$_306;
	goto anon485;
anon949_Then:
	assume $_$_condition_$329;
	assume $_$_condition_$329 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_310 == SecMask_$_309[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_309[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_309[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$331) { goto anon950_Then; } else { goto anon950_Else; }
anon949_Else:
	assume !$_$_condition_$329;
	assume $_$_condition_$329 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_313 == SecMask_$_309;
	goto $branchMerge_114;
anon485:
	assume wf(Heap_$_6,SecMask_$_308,SecMask_$_308);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_308);
	assume SecMask_$_309 == SecMask_$_308;
	goto $branchMerge_113;
anon950_Then:
	assume $_$_condition_$331;
	assume SecMask_$_310[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_311 == SecMask_$_310[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_310[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_312 == SecMask_$_311;
	goto anon489;
anon950_Else:
	assume !$_$_condition_$331;
	assume 0 <= SecMask_$_310[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_312 == SecMask_$_310;
	goto anon489;
anon951_Then:
	assume $_$_condition_$332;
	assume $_$_condition_$332 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_314 == SecMask_$_313[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_313[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_313[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$334) { goto anon952_Then; } else { goto anon952_Else; }
anon951_Else:
	assume !$_$_condition_$332;
	assume $_$_condition_$332 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_317 == SecMask_$_313;
	goto $branchMerge_115;
anon489:
	assume wf(Heap_$_6,SecMask_$_312,SecMask_$_312);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_312);
	assume SecMask_$_313 == SecMask_$_312;
	goto $branchMerge_114;
anon952_Then:
	assume $_$_condition_$334;
	assume SecMask_$_314[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_315 == SecMask_$_314[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_314[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_316 == SecMask_$_315;
	goto anon493;
anon952_Else:
	assume !$_$_condition_$334;
	assume 0 <= SecMask_$_314[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_316 == SecMask_$_314;
	goto anon493;
anon953_Then:
	assume $_$_condition_$335;
	assume $_$_condition_$335 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_318 == SecMask_$_317[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_317[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_317[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$337) { goto anon954_Then; } else { goto anon954_Else; }
anon953_Else:
	assume !$_$_condition_$335;
	assume $_$_condition_$335 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_321 == SecMask_$_317;
	goto $branchMerge_116;
anon493:
	assume wf(Heap_$_6,SecMask_$_316,SecMask_$_316);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_316);
	assume SecMask_$_317 == SecMask_$_316;
	goto $branchMerge_115;
anon954_Then:
	assume $_$_condition_$337;
	assume SecMask_$_318[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_319 == SecMask_$_318[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_318[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_320 == SecMask_$_319;
	goto anon497;
anon954_Else:
	assume !$_$_condition_$337;
	assume 0 <= SecMask_$_318[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_320 == SecMask_$_318;
	goto anon497;
anon955_Then:
	assume $_$_condition_$338;
	assume $_$_condition_$338 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_322 == SecMask_$_321[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_321[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_321[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$340) { goto anon956_Then; } else { goto anon956_Else; }
anon955_Else:
	assume !$_$_condition_$338;
	assume $_$_condition_$338 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_325 == SecMask_$_321;
	goto $branchMerge_117;
anon497:
	assume wf(Heap_$_6,SecMask_$_320,SecMask_$_320);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_320);
	assume SecMask_$_321 == SecMask_$_320;
	goto $branchMerge_116;
anon956_Then:
	assume $_$_condition_$340;
	assume SecMask_$_322[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_323 == SecMask_$_322[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_322[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_324 == SecMask_$_323;
	goto anon501;
anon956_Else:
	assume !$_$_condition_$340;
	assume 0 <= SecMask_$_322[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_324 == SecMask_$_322;
	goto anon501;
anon957_Then:
	assume $_$_condition_$341;
	assume $_$_condition_$341 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_326 == SecMask_$_325[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_325[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_325[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$343) { goto anon958_Then; } else { goto anon958_Else; }
anon957_Else:
	assume !$_$_condition_$341;
	assume $_$_condition_$341 <==> (!(Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_329 == SecMask_$_325;
	goto anon506;
anon501:
	assume wf(Heap_$_6,SecMask_$_324,SecMask_$_324);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_324);
	assume SecMask_$_325 == SecMask_$_324;
	goto $branchMerge_117;
anon958_Then:
	assume $_$_condition_$343;
	assume SecMask_$_326[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_327 == SecMask_$_326[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_326[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_328 == SecMask_$_327;
	goto anon505;
anon958_Else:
	assume !$_$_condition_$343;
	assume 0 <= SecMask_$_326[Heap_$_6[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_328 == SecMask_$_326;
	goto anon505;
anon506:
	assume wf(Heap_$_6,SecMask_$_329,SecMask_$_329);
	assume SecMask_$_330 == SecMask_$_329;
	goto $branchMerge_106;
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
	goto $branchMerge_105;
anon961_Then:
	assume $_$_condition_$346;
	assume $_$_condition_$346 <==> (!(Heap_$_6[this,AVLTreeNode.right] == null));
	assume !(Heap_$_6[this,AVLTreeNode.right] == null);
	assert { :msg "  693.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  693.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2339_$_18 == exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_2339_$_17[Heap_$_6[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2339_$_18);
	assume wf(Heap_$_6,exhaleMask#_2339_$_18,SecMask_$_331);
	assume wf(Heap_$_6,Mask_$_67,SecMask_$_331);
	assume exhaleMask#_2339_$_19 == exhaleMask#_2339_$_18;
	goto $branchMerge_118;
anon961_Else:
	assume !$_$_condition_$346;
	assume $_$_condition_$346 <==> (!(Heap_$_6[this,AVLTreeNode.right] == null));
	assume Heap_$_6[this,AVLTreeNode.right] == null;
	assume exhaleMask#_2339_$_19 == exhaleMask#_2339_$_17;
	goto $branchMerge_118;
anon962_Then:
	assume $_$_condition_$348;
	assume $_$_condition_$348 <==> (!(Heap_$_6[this,AVLTreeNode.right] == null));
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
	assume !$_$_condition_$348;
	assume $_$_condition_$348 <==> (!(Heap_$_6[this,AVLTreeNode.right] == null));
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
	assume $_$_condition_$350;
	assume $_$_condition_$350 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null);
	assert { :msg "  695.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#694 : Integer :: ( ((0 <= k#92#694) && (k#92#694 < Seq#Length(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],k#92#694) < Heap_$_7[r#66_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_119;
anon963_Else:
	assume !$_$_condition_$350;
	assume $_$_condition_$350 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_7[r#66_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_119;
anon964_Then:
	assume $_$_condition_$351;
	assume $_$_condition_$351 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null);
	assert { :msg "  695.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#695 : Integer :: ( ((0 <= k#93#695) && (k#93#695 < Seq#Length(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_7[r#66_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],k#93#695)) ));
	goto anon520;
anon964_Else:
	assume !$_$_condition_$351;
	assume $_$_condition_$351 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null));
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
	assume $_$_condition_$353;
	assume $_$_condition_$353 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null);
	assert { :msg "  695.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  695.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2394_$_6 == exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_2394_$_5[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$354) { goto anon966_Then; } else { goto anon966_Else; }
anon965_Else:
	assume !$_$_condition_$353;
	assume $_$_condition_$353 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_7[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_383 == SecMask_$_331;
	assume exhaleMask#_2394_$_7 == exhaleMask#_2394_$_5;
	goto $branchMerge_120;
anon966_Then:
	assume $_$_condition_$354;
	assume $_$_condition_$354 <==> (false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.left])) && true) && true));
	assume false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$356) { goto anon967_Then; } else { goto anon967_Else; }
anon966_Else:
	assume !$_$_condition_$354;
	assume $_$_condition_$354 <==> (false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.left])) && true) && true));
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_382 == SecMask_$_331;
	goto $branchMerge_121;
anon994_Then:
	assume $_$_condition_$355;
	assume $_$_condition_$355 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null);
	assert { :msg "  695.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2394_$_8 == exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_2394_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_8);
	assume wf(Heap_$_7,exhaleMask#_2394_$_8,SecMask_$_383);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_383);
	assume exhaleMask#_2394_$_9 == exhaleMask#_2394_$_8;
	goto $branchMerge_122;
anon994_Else:
	assume !$_$_condition_$355;
	assume $_$_condition_$355 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_7[r#66_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2394_$_9 == exhaleMask#_2394_$_7;
	goto $branchMerge_122;
anon967_Then:
	assume $_$_condition_$356;
	assume $_$_condition_$356 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#696 : Integer :: ( ((0 <= lk#79#696) && (lk#79#696 < Seq#Length(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#696) < Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_123;
anon967_Else:
	assume !$_$_condition_$356;
	assume $_$_condition_$356 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_123;
anon993_Then:
	assume $_$_condition_$357;
	assume $_$_condition_$357 <==> (!CanRead(exhaleMask#_2394_$_6,SecMask_$_382,Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_2394_$_6,SecMask_$_382,Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_2393_$_0[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon577;
anon993_Else:
	assume !$_$_condition_$357;
	assume $_$_condition_$357 <==> (!CanRead(exhaleMask#_2394_$_6,SecMask_$_382,Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_2394_$_6,SecMask_$_382,Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon577;
anon968_Then:
	assume $_$_condition_$358;
	assume $_$_condition_$358 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_124;
anon968_Else:
	assume !$_$_condition_$358;
	assume $_$_condition_$358 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_124;
anon969_Then:
	assume $_$_condition_$360;
	assume $_$_condition_$360 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#697 : Integer :: ( ((0 <= rk#80#697) && (rk#80#697 < Seq#Length(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#697)) ));
	goto $branchMerge_125;
anon969_Else:
	assume !$_$_condition_$360;
	assume $_$_condition_$360 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_125;
anon970_Then:
	assume $_$_condition_$362;
	assume $_$_condition_$362 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon530;
anon970_Else:
	assume !$_$_condition_$362;
	assume $_$_condition_$362 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	assume $_$_condition_$364;
	assume SecMask_$_332[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_333 == SecMask_$_332[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_332[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_334 == SecMask_$_333;
	goto anon532;
anon971_Else:
	assume !$_$_condition_$364;
	assume 0 <= SecMask_$_332[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_334 == SecMask_$_332;
	goto anon532;
anon532:
	assume wf(Heap_$_7,SecMask_$_334,SecMask_$_334);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_334);
	assume SecMask_$_335 == SecMask_$_334[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_334[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_334[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$365) { goto anon972_Then; } else { goto anon972_Else; }
anon972_Then:
	assume $_$_condition_$365;
	assume SecMask_$_335[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_336 == SecMask_$_335[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_335[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_337 == SecMask_$_336;
	goto anon534;
anon972_Else:
	assume !$_$_condition_$365;
	assume 0 <= SecMask_$_335[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_337 == SecMask_$_335;
	goto anon534;
anon534:
	assume wf(Heap_$_7,SecMask_$_337,SecMask_$_337);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_337);
	assume SecMask_$_338 == SecMask_$_337[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_337[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_337[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$366) { goto anon973_Then; } else { goto anon973_Else; }
anon973_Then:
	assume $_$_condition_$366;
	assume SecMask_$_338[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_339 == SecMask_$_338[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_338[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_340 == SecMask_$_339;
	goto anon536;
anon973_Else:
	assume !$_$_condition_$366;
	assume 0 <= SecMask_$_338[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_340 == SecMask_$_338;
	goto anon536;
anon536:
	assume wf(Heap_$_7,SecMask_$_340,SecMask_$_340);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_340);
	assume SecMask_$_341 == SecMask_$_340[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_340[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_340[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$367) { goto anon974_Then; } else { goto anon974_Else; }
anon974_Then:
	assume $_$_condition_$367;
	assume SecMask_$_341[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_342 == SecMask_$_341[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_341[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_343 == SecMask_$_342;
	goto anon538;
anon974_Else:
	assume !$_$_condition_$367;
	assume 0 <= SecMask_$_341[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_343 == SecMask_$_341;
	goto anon538;
anon538:
	assume wf(Heap_$_7,SecMask_$_343,SecMask_$_343);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_343);
	assume SecMask_$_344 == SecMask_$_343[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_343[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_343[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$368) { goto anon975_Then; } else { goto anon975_Else; }
anon975_Then:
	assume $_$_condition_$368;
	assume SecMask_$_344[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_345 == SecMask_$_344[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_344[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_346 == SecMask_$_345;
	goto anon540;
anon975_Else:
	assume !$_$_condition_$368;
	assume 0 <= SecMask_$_344[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_346 == SecMask_$_344;
	goto anon540;
anon540:
	assume wf(Heap_$_7,SecMask_$_346,SecMask_$_346);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_346);
	assume SecMask_$_347 == SecMask_$_346[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_346[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_346[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$369) { goto anon976_Then; } else { goto anon976_Else; }
anon976_Then:
	assume $_$_condition_$369;
	assume SecMask_$_347[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_348 == SecMask_$_347[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_347[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_349 == SecMask_$_348;
	goto anon542;
anon976_Else:
	assume !$_$_condition_$369;
	assume 0 <= SecMask_$_347[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_349 == SecMask_$_347;
	goto anon542;
anon542:
	assume wf(Heap_$_7,SecMask_$_349,SecMask_$_349);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_349);
	if ($_$_condition_$370) { goto anon977_Then; } else { goto anon977_Else; }
anon977_Then:
	assume $_$_condition_$370;
	assume $_$_condition_$370 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_350 == SecMask_$_349[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_349[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_349[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$371) { goto anon978_Then; } else { goto anon978_Else; }
anon977_Else:
	assume !$_$_condition_$370;
	assume $_$_condition_$370 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_353 == SecMask_$_349;
	goto $branchMerge_126;
anon978_Then:
	assume $_$_condition_$371;
	assume SecMask_$_350[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_351 == SecMask_$_350[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_350[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_352 == SecMask_$_351;
	goto anon545;
anon978_Else:
	assume !$_$_condition_$371;
	assume 0 <= SecMask_$_350[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_352 == SecMask_$_350;
	goto anon545;
anon979_Then:
	assume $_$_condition_$372;
	assume $_$_condition_$372 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_354 == SecMask_$_353[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_353[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_353[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$374) { goto anon980_Then; } else { goto anon980_Else; }
anon979_Else:
	assume !$_$_condition_$372;
	assume $_$_condition_$372 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_357 == SecMask_$_353;
	goto $branchMerge_127;
anon545:
	assume wf(Heap_$_7,SecMask_$_352,SecMask_$_352);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_352);
	assume SecMask_$_353 == SecMask_$_352;
	goto $branchMerge_126;
anon980_Then:
	assume $_$_condition_$374;
	assume SecMask_$_354[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_355 == SecMask_$_354[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_354[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_356 == SecMask_$_355;
	goto anon549;
anon980_Else:
	assume !$_$_condition_$374;
	assume 0 <= SecMask_$_354[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_356 == SecMask_$_354;
	goto anon549;
anon981_Then:
	assume $_$_condition_$375;
	assume $_$_condition_$375 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_358 == SecMask_$_357[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_357[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_357[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$377) { goto anon982_Then; } else { goto anon982_Else; }
anon981_Else:
	assume !$_$_condition_$375;
	assume $_$_condition_$375 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_361 == SecMask_$_357;
	goto $branchMerge_128;
anon549:
	assume wf(Heap_$_7,SecMask_$_356,SecMask_$_356);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_356);
	assume SecMask_$_357 == SecMask_$_356;
	goto $branchMerge_127;
anon982_Then:
	assume $_$_condition_$377;
	assume SecMask_$_358[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_359 == SecMask_$_358[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_358[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_360 == SecMask_$_359;
	goto anon553;
anon982_Else:
	assume !$_$_condition_$377;
	assume 0 <= SecMask_$_358[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_360 == SecMask_$_358;
	goto anon553;
anon983_Then:
	assume $_$_condition_$378;
	assume $_$_condition_$378 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_362 == SecMask_$_361[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_361[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_361[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$380) { goto anon984_Then; } else { goto anon984_Else; }
anon983_Else:
	assume !$_$_condition_$378;
	assume $_$_condition_$378 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_365 == SecMask_$_361;
	goto $branchMerge_129;
anon553:
	assume wf(Heap_$_7,SecMask_$_360,SecMask_$_360);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_360);
	assume SecMask_$_361 == SecMask_$_360;
	goto $branchMerge_128;
anon984_Then:
	assume $_$_condition_$380;
	assume SecMask_$_362[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_363 == SecMask_$_362[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_362[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_364 == SecMask_$_363;
	goto anon557;
anon984_Else:
	assume !$_$_condition_$380;
	assume 0 <= SecMask_$_362[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_364 == SecMask_$_362;
	goto anon557;
anon985_Then:
	assume $_$_condition_$381;
	assume $_$_condition_$381 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_366 == SecMask_$_365[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_365[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_365[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$383) { goto anon986_Then; } else { goto anon986_Else; }
anon985_Else:
	assume !$_$_condition_$381;
	assume $_$_condition_$381 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_369 == SecMask_$_365;
	goto $branchMerge_130;
anon557:
	assume wf(Heap_$_7,SecMask_$_364,SecMask_$_364);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_364);
	assume SecMask_$_365 == SecMask_$_364;
	goto $branchMerge_129;
anon986_Then:
	assume $_$_condition_$383;
	assume SecMask_$_366[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_367 == SecMask_$_366[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_366[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_368 == SecMask_$_367;
	goto anon561;
anon986_Else:
	assume !$_$_condition_$383;
	assume 0 <= SecMask_$_366[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_368 == SecMask_$_366;
	goto anon561;
anon987_Then:
	assume $_$_condition_$384;
	assume $_$_condition_$384 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_370 == SecMask_$_369[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_369[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_369[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$386) { goto anon988_Then; } else { goto anon988_Else; }
anon987_Else:
	assume !$_$_condition_$384;
	assume $_$_condition_$384 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_373 == SecMask_$_369;
	goto $branchMerge_131;
anon561:
	assume wf(Heap_$_7,SecMask_$_368,SecMask_$_368);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_368);
	assume SecMask_$_369 == SecMask_$_368;
	goto $branchMerge_130;
anon988_Then:
	assume $_$_condition_$386;
	assume SecMask_$_370[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_371 == SecMask_$_370[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_370[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_372 == SecMask_$_371;
	goto anon565;
anon988_Else:
	assume !$_$_condition_$386;
	assume 0 <= SecMask_$_370[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_372 == SecMask_$_370;
	goto anon565;
anon989_Then:
	assume $_$_condition_$387;
	assume $_$_condition_$387 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_374 == SecMask_$_373[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_373[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_373[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$389) { goto anon990_Then; } else { goto anon990_Else; }
anon989_Else:
	assume !$_$_condition_$387;
	assume $_$_condition_$387 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_377 == SecMask_$_373;
	goto $branchMerge_132;
anon565:
	assume wf(Heap_$_7,SecMask_$_372,SecMask_$_372);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_372);
	assume SecMask_$_373 == SecMask_$_372;
	goto $branchMerge_131;
anon990_Then:
	assume $_$_condition_$389;
	assume SecMask_$_374[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_375 == SecMask_$_374[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_374[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_376 == SecMask_$_375;
	goto anon569;
anon990_Else:
	assume !$_$_condition_$389;
	assume 0 <= SecMask_$_374[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_376 == SecMask_$_374;
	goto anon569;
anon991_Then:
	assume $_$_condition_$390;
	assume $_$_condition_$390 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_378 == SecMask_$_377[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_377[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_377[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$392) { goto anon992_Then; } else { goto anon992_Else; }
anon991_Else:
	assume !$_$_condition_$390;
	assume $_$_condition_$390 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_381 == SecMask_$_377;
	goto anon574;
anon569:
	assume wf(Heap_$_7,SecMask_$_376,SecMask_$_376);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_376);
	assume SecMask_$_377 == SecMask_$_376;
	goto $branchMerge_132;
anon992_Then:
	assume $_$_condition_$392;
	assume SecMask_$_378[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_379 == SecMask_$_378[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_378[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_380 == SecMask_$_379;
	goto anon573;
anon992_Else:
	assume !$_$_condition_$392;
	assume 0 <= SecMask_$_378[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_380 == SecMask_$_378;
	goto anon573;
anon574:
	assume wf(Heap_$_7,SecMask_$_381,SecMask_$_381);
	assume SecMask_$_382 == SecMask_$_381;
	goto $branchMerge_121;
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
	goto $branchMerge_120;
anon995_Then:
	assume $_$_condition_$395;
	assume $_$_condition_$395 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null);
	assert { :msg "  695.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2394_$_10 == exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_2394_$_9[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_10);
	assume wf(Heap_$_7,exhaleMask#_2394_$_10,SecMask_$_383);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_383);
	assume exhaleMask#_2394_$_11 == exhaleMask#_2394_$_10;
	goto $branchMerge_133;
anon995_Else:
	assume !$_$_condition_$395;
	assume $_$_condition_$395 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_7[r#66_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2394_$_11 == exhaleMask#_2394_$_9;
	goto $branchMerge_133;
anon996_Then:
	assume $_$_condition_$397;
	assume $_$_condition_$397 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null);
	assert { :msg "  695.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2394_$_12 == exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2394_$_11[Heap_$_7[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_12);
	assume wf(Heap_$_7,exhaleMask#_2394_$_12,SecMask_$_383);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_383);
	assume exhaleMask#_2394_$_13 == exhaleMask#_2394_$_12;
	goto $branchMerge_134;
anon996_Else:
	assume !$_$_condition_$397;
	assume $_$_condition_$397 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.left] == null));
	assume Heap_$_7[r#66_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_2394_$_13 == exhaleMask#_2394_$_11;
	goto $branchMerge_134;
anon997_Then:
	assume $_$_condition_$399;
	assume $_$_condition_$399 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null);
	assert { :msg "  695.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  695.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2394_$_14 == exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_2394_$_13[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$401) { goto anon998_Then; } else { goto anon998_Else; }
anon997_Else:
	assume !$_$_condition_$399;
	assume $_$_condition_$399 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_7[r#66_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2394_$_15 == exhaleMask#_2394_$_13;
	assume SecMask_$_435 == SecMask_$_383;
	goto $branchMerge_135;
anon998_Then:
	assume $_$_condition_$401;
	assume $_$_condition_$401 <==> (false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.right])) && true) && true));
	assume false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$403) { goto anon999_Then; } else { goto anon999_Else; }
anon998_Else:
	assume !$_$_condition_$401;
	assume $_$_condition_$401 <==> (false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.right])) && true) && true));
	assume !(false || ((((predVer#_2192_$_0 == Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (predRec#_2191_$_0 == Heap_$_7[r#66_$_0,AVLTreeNode.right])) && true) && true));
	assume SecMask_$_434 == SecMask_$_383;
	goto $branchMerge_136;
anon1026_Then:
	assume $_$_condition_$402;
	assume $_$_condition_$402 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null);
	assert { :msg "  695.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2394_$_16 == exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_2394_$_15[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_16);
	assume wf(Heap_$_7,exhaleMask#_2394_$_16,SecMask_$_435);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_435);
	assume exhaleMask#_2394_$_17 == exhaleMask#_2394_$_16;
	goto $branchMerge_137;
anon1026_Else:
	assume !$_$_condition_$402;
	assume $_$_condition_$402 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_7[r#66_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2394_$_17 == exhaleMask#_2394_$_15;
	goto $branchMerge_137;
anon999_Then:
	assume $_$_condition_$403;
	assume $_$_condition_$403 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#701 : Integer :: ( ((0 <= lk#79#701) && (lk#79#701 < Seq#Length(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#701) < Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_138;
anon999_Else:
	assume !$_$_condition_$403;
	assume $_$_condition_$403 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_138;
anon1025_Then:
	assume $_$_condition_$404;
	assume $_$_condition_$404 <==> (!CanRead(exhaleMask#_2394_$_14,SecMask_$_434,Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_2394_$_14,SecMask_$_434,Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_2393_$_0[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon641;
anon1025_Else:
	assume !$_$_condition_$404;
	assume $_$_condition_$404 <==> (!CanRead(exhaleMask#_2394_$_14,SecMask_$_434,Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_2394_$_14,SecMask_$_434,Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon641;
anon1000_Then:
	assume $_$_condition_$405;
	assume $_$_condition_$405 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_139;
anon1000_Else:
	assume !$_$_condition_$405;
	assume $_$_condition_$405 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_139;
anon1001_Then:
	assume $_$_condition_$407;
	assume $_$_condition_$407 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#702 : Integer :: ( ((0 <= rk#80#702) && (rk#80#702 < Seq#Length(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#702)) ));
	goto $branchMerge_140;
anon1001_Else:
	assume !$_$_condition_$407;
	assume $_$_condition_$407 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_140;
anon1002_Then:
	assume $_$_condition_$409;
	assume $_$_condition_$409 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap_$_7[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon594;
anon1002_Else:
	assume !$_$_condition_$409;
	assume $_$_condition_$409 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	assume $_$_condition_$411;
	assume SecMask_$_384[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_385 == SecMask_$_384[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_384[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_386 == SecMask_$_385;
	goto anon596;
anon1003_Else:
	assume !$_$_condition_$411;
	assume 0 <= SecMask_$_384[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_386 == SecMask_$_384;
	goto anon596;
anon596:
	assume wf(Heap_$_7,SecMask_$_386,SecMask_$_386);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_386);
	assume SecMask_$_387 == SecMask_$_386[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_386[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_386[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$412) { goto anon1004_Then; } else { goto anon1004_Else; }
anon1004_Then:
	assume $_$_condition_$412;
	assume SecMask_$_387[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_388 == SecMask_$_387[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_387[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_389 == SecMask_$_388;
	goto anon598;
anon1004_Else:
	assume !$_$_condition_$412;
	assume 0 <= SecMask_$_387[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_389 == SecMask_$_387;
	goto anon598;
anon598:
	assume wf(Heap_$_7,SecMask_$_389,SecMask_$_389);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_389);
	assume SecMask_$_390 == SecMask_$_389[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_389[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_389[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$413) { goto anon1005_Then; } else { goto anon1005_Else; }
anon1005_Then:
	assume $_$_condition_$413;
	assume SecMask_$_390[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_391 == SecMask_$_390[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_390[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_392 == SecMask_$_391;
	goto anon600;
anon1005_Else:
	assume !$_$_condition_$413;
	assume 0 <= SecMask_$_390[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_392 == SecMask_$_390;
	goto anon600;
anon600:
	assume wf(Heap_$_7,SecMask_$_392,SecMask_$_392);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_392);
	assume SecMask_$_393 == SecMask_$_392[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_392[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_392[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$414) { goto anon1006_Then; } else { goto anon1006_Else; }
anon1006_Then:
	assume $_$_condition_$414;
	assume SecMask_$_393[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_394 == SecMask_$_393[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_393[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_395 == SecMask_$_394;
	goto anon602;
anon1006_Else:
	assume !$_$_condition_$414;
	assume 0 <= SecMask_$_393[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_395 == SecMask_$_393;
	goto anon602;
anon602:
	assume wf(Heap_$_7,SecMask_$_395,SecMask_$_395);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_395);
	assume SecMask_$_396 == SecMask_$_395[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_395[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_395[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$415) { goto anon1007_Then; } else { goto anon1007_Else; }
anon1007_Then:
	assume $_$_condition_$415;
	assume SecMask_$_396[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_397 == SecMask_$_396[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_396[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_398 == SecMask_$_397;
	goto anon604;
anon1007_Else:
	assume !$_$_condition_$415;
	assume 0 <= SecMask_$_396[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_398 == SecMask_$_396;
	goto anon604;
anon604:
	assume wf(Heap_$_7,SecMask_$_398,SecMask_$_398);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_398);
	assume SecMask_$_399 == SecMask_$_398[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_398[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_398[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$416) { goto anon1008_Then; } else { goto anon1008_Else; }
anon1008_Then:
	assume $_$_condition_$416;
	assume SecMask_$_399[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_400 == SecMask_$_399[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_399[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_401 == SecMask_$_400;
	goto anon606;
anon1008_Else:
	assume !$_$_condition_$416;
	assume 0 <= SecMask_$_399[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_401 == SecMask_$_399;
	goto anon606;
anon606:
	assume wf(Heap_$_7,SecMask_$_401,SecMask_$_401);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_401);
	if ($_$_condition_$417) { goto anon1009_Then; } else { goto anon1009_Else; }
anon1009_Then:
	assume $_$_condition_$417;
	assume $_$_condition_$417 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_402 == SecMask_$_401[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_401[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_401[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$418) { goto anon1010_Then; } else { goto anon1010_Else; }
anon1009_Else:
	assume !$_$_condition_$417;
	assume $_$_condition_$417 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_405 == SecMask_$_401;
	goto $branchMerge_141;
anon1010_Then:
	assume $_$_condition_$418;
	assume SecMask_$_402[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_403 == SecMask_$_402[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_402[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_404 == SecMask_$_403;
	goto anon609;
anon1010_Else:
	assume !$_$_condition_$418;
	assume 0 <= SecMask_$_402[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_404 == SecMask_$_402;
	goto anon609;
anon1011_Then:
	assume $_$_condition_$419;
	assume $_$_condition_$419 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_406 == SecMask_$_405[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_405[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_405[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$421) { goto anon1012_Then; } else { goto anon1012_Else; }
anon1011_Else:
	assume !$_$_condition_$419;
	assume $_$_condition_$419 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_409 == SecMask_$_405;
	goto $branchMerge_142;
anon609:
	assume wf(Heap_$_7,SecMask_$_404,SecMask_$_404);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_404);
	assume SecMask_$_405 == SecMask_$_404;
	goto $branchMerge_141;
anon1012_Then:
	assume $_$_condition_$421;
	assume SecMask_$_406[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_407 == SecMask_$_406[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_406[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_408 == SecMask_$_407;
	goto anon613;
anon1012_Else:
	assume !$_$_condition_$421;
	assume 0 <= SecMask_$_406[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_408 == SecMask_$_406;
	goto anon613;
anon1013_Then:
	assume $_$_condition_$422;
	assume $_$_condition_$422 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_410 == SecMask_$_409[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_409[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_409[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$424) { goto anon1014_Then; } else { goto anon1014_Else; }
anon1013_Else:
	assume !$_$_condition_$422;
	assume $_$_condition_$422 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_413 == SecMask_$_409;
	goto $branchMerge_143;
anon613:
	assume wf(Heap_$_7,SecMask_$_408,SecMask_$_408);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_408);
	assume SecMask_$_409 == SecMask_$_408;
	goto $branchMerge_142;
anon1014_Then:
	assume $_$_condition_$424;
	assume SecMask_$_410[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_411 == SecMask_$_410[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_410[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_412 == SecMask_$_411;
	goto anon617;
anon1014_Else:
	assume !$_$_condition_$424;
	assume 0 <= SecMask_$_410[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_412 == SecMask_$_410;
	goto anon617;
anon1015_Then:
	assume $_$_condition_$425;
	assume $_$_condition_$425 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_414 == SecMask_$_413[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_413[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_413[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$427) { goto anon1016_Then; } else { goto anon1016_Else; }
anon1015_Else:
	assume !$_$_condition_$425;
	assume $_$_condition_$425 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_417 == SecMask_$_413;
	goto $branchMerge_144;
anon617:
	assume wf(Heap_$_7,SecMask_$_412,SecMask_$_412);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_412);
	assume SecMask_$_413 == SecMask_$_412;
	goto $branchMerge_143;
anon1016_Then:
	assume $_$_condition_$427;
	assume SecMask_$_414[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_415 == SecMask_$_414[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_414[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_416 == SecMask_$_415;
	goto anon621;
anon1016_Else:
	assume !$_$_condition_$427;
	assume 0 <= SecMask_$_414[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_416 == SecMask_$_414;
	goto anon621;
anon1017_Then:
	assume $_$_condition_$428;
	assume $_$_condition_$428 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_418 == SecMask_$_417[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_417[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_417[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$430) { goto anon1018_Then; } else { goto anon1018_Else; }
anon1017_Else:
	assume !$_$_condition_$428;
	assume $_$_condition_$428 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_421 == SecMask_$_417;
	goto $branchMerge_145;
anon621:
	assume wf(Heap_$_7,SecMask_$_416,SecMask_$_416);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_416);
	assume SecMask_$_417 == SecMask_$_416;
	goto $branchMerge_144;
anon1018_Then:
	assume $_$_condition_$430;
	assume SecMask_$_418[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_419 == SecMask_$_418[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_418[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_420 == SecMask_$_419;
	goto anon625;
anon1018_Else:
	assume !$_$_condition_$430;
	assume 0 <= SecMask_$_418[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_420 == SecMask_$_418;
	goto anon625;
anon1019_Then:
	assume $_$_condition_$431;
	assume $_$_condition_$431 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_422 == SecMask_$_421[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_421[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_421[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$433) { goto anon1020_Then; } else { goto anon1020_Else; }
anon1019_Else:
	assume !$_$_condition_$431;
	assume $_$_condition_$431 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_425 == SecMask_$_421;
	goto $branchMerge_146;
anon625:
	assume wf(Heap_$_7,SecMask_$_420,SecMask_$_420);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_420);
	assume SecMask_$_421 == SecMask_$_420;
	goto $branchMerge_145;
anon1020_Then:
	assume $_$_condition_$433;
	assume SecMask_$_422[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_423 == SecMask_$_422[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_422[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_424 == SecMask_$_423;
	goto anon629;
anon1020_Else:
	assume !$_$_condition_$433;
	assume 0 <= SecMask_$_422[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_424 == SecMask_$_422;
	goto anon629;
anon1021_Then:
	assume $_$_condition_$434;
	assume $_$_condition_$434 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_426 == SecMask_$_425[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_425[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_425[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$436) { goto anon1022_Then; } else { goto anon1022_Else; }
anon1021_Else:
	assume !$_$_condition_$434;
	assume $_$_condition_$434 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_429 == SecMask_$_425;
	goto $branchMerge_147;
anon629:
	assume wf(Heap_$_7,SecMask_$_424,SecMask_$_424);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_424);
	assume SecMask_$_425 == SecMask_$_424;
	goto $branchMerge_146;
anon1022_Then:
	assume $_$_condition_$436;
	assume SecMask_$_426[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_427 == SecMask_$_426[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_426[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_428 == SecMask_$_427;
	goto anon633;
anon1022_Else:
	assume !$_$_condition_$436;
	assume 0 <= SecMask_$_426[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_428 == SecMask_$_426;
	goto anon633;
anon1023_Then:
	assume $_$_condition_$437;
	assume $_$_condition_$437 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_430 == SecMask_$_429[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_429[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_429[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$439) { goto anon1024_Then; } else { goto anon1024_Else; }
anon1023_Else:
	assume !$_$_condition_$437;
	assume $_$_condition_$437 <==> (!(Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_433 == SecMask_$_429;
	goto anon638;
anon633:
	assume wf(Heap_$_7,SecMask_$_428,SecMask_$_428);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_428);
	assume SecMask_$_429 == SecMask_$_428;
	goto $branchMerge_147;
anon1024_Then:
	assume $_$_condition_$439;
	assume SecMask_$_430[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_431 == SecMask_$_430[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_430[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_432 == SecMask_$_431;
	goto anon637;
anon1024_Else:
	assume !$_$_condition_$439;
	assume 0 <= SecMask_$_430[Heap_$_7[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_432 == SecMask_$_430;
	goto anon637;
anon638:
	assume wf(Heap_$_7,SecMask_$_433,SecMask_$_433);
	assume SecMask_$_434 == SecMask_$_433;
	goto $branchMerge_136;
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
	goto $branchMerge_135;
anon1027_Then:
	assume $_$_condition_$442;
	assume $_$_condition_$442 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null);
	assert { :msg "  695.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  695.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2394_$_18 == exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_2394_$_17[Heap_$_7[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2394_$_18);
	assume wf(Heap_$_7,exhaleMask#_2394_$_18,SecMask_$_435);
	assume wf(Heap_$_7,Mask_$_71,SecMask_$_435);
	assume exhaleMask#_2394_$_19 == exhaleMask#_2394_$_18;
	goto $branchMerge_148;
anon1027_Else:
	assume !$_$_condition_$442;
	assume $_$_condition_$442 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null));
	assume Heap_$_7[r#66_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_2394_$_19 == exhaleMask#_2394_$_17;
	goto $branchMerge_148;
anon1028_Then:
	assume $_$_condition_$444;
	assume $_$_condition_$444 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null));
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
	assume !$_$_condition_$444;
	assume $_$_condition_$444 <==> (!(Heap_$_7[r#66_$_0,AVLTreeNode.right] == null));
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
	assume $_$_condition_$446;
	assume $_$_condition_$446 <==> (false || ((((predVer#_2192_$_0 == exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true));
	assume false || ((((predVer#_2192_$_0 == exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true);
	if ($_$_condition_$447) { goto anon1030_Then; } else { goto anon1030_Else; }
anon1029_Else:
	assume !$_$_condition_$446;
	assume $_$_condition_$446 <==> (false || ((((predVer#_2192_$_0 == exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true));
	assume !(false || ((((predVer#_2192_$_0 == exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.valid]) && (predRec#_2191_$_0 == r#66_$_0)) && true) && true));
	assume SecMask_$_486 == SecMask_$_435;
	goto $branchMerge_149;
anon1030_Then:
	assume $_$_condition_$447;
	assume $_$_condition_$447 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#706 : Integer :: ( ((0 <= lk#79#706) && (lk#79#706 < Seq#Length(exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#706) < exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_150;
anon1030_Else:
	assume !$_$_condition_$447;
	assume $_$_condition_$447 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_150;
anon1056_Then:
	assume $_$_condition_$448;
	assume $_$_condition_$448 <==> (!CanRead(exhaleMask#_2444_$_0,SecMask_$_486,r#66_$_0,AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_2444_$_0,SecMask_$_486,r#66_$_0,AVLTreeNode.valid);
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.valid] < exhaleHeap#_2443_$_0[r#66_$_0,AVLTreeNode.valid];
	goto anon704;
anon1056_Else:
	assume !$_$_condition_$448;
	assume $_$_condition_$448 <==> (!CanRead(exhaleMask#_2444_$_0,SecMask_$_486,r#66_$_0,AVLTreeNode.valid));
	assume CanRead(exhaleMask#_2444_$_0,SecMask_$_486,r#66_$_0,AVLTreeNode.valid);
	goto anon704;
anon1031_Then:
	assume $_$_condition_$449;
	assume $_$_condition_$449 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_151;
anon1031_Else:
	assume !$_$_condition_$449;
	assume $_$_condition_$449 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_151;
anon1032_Then:
	assume $_$_condition_$451;
	assume $_$_condition_$451 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#707 : Integer :: ( ((0 <= rk#80#707) && (rk#80#707 < Seq#Length(exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.key] < Seq#Index(exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#707)) ));
	goto $branchMerge_152;
anon1032_Else:
	assume !$_$_condition_$451;
	assume $_$_condition_$451 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	goto $branchMerge_152;
anon1033_Then:
	assume $_$_condition_$453;
	assume $_$_condition_$453 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume exhaleHeap#_2393_$_0[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon657;
anon1033_Else:
	assume !$_$_condition_$453;
	assume $_$_condition_$453 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
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
	assume $_$_condition_$455;
	assume SecMask_$_436[r#66_$_0,AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_437 == SecMask_$_436[r#66_$_0,AVLTreeNode.key := SecMask_$_436[r#66_$_0,AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_438 == SecMask_$_437;
	goto anon659;
anon1034_Else:
	assume !$_$_condition_$455;
	assume 0 <= SecMask_$_436[r#66_$_0,AVLTreeNode.key][perm$R];
	assume SecMask_$_438 == SecMask_$_436;
	goto anon659;
anon659:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_438,SecMask_$_438);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_438);
	assume SecMask_$_439 == SecMask_$_438[r#66_$_0,AVLTreeNode.height := SecMask_$_438[r#66_$_0,AVLTreeNode.height][perm$R := SecMask_$_438[r#66_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$456) { goto anon1035_Then; } else { goto anon1035_Else; }
anon1035_Then:
	assume $_$_condition_$456;
	assume SecMask_$_439[r#66_$_0,AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_440 == SecMask_$_439[r#66_$_0,AVLTreeNode.height := SecMask_$_439[r#66_$_0,AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_441 == SecMask_$_440;
	goto anon661;
anon1035_Else:
	assume !$_$_condition_$456;
	assume 0 <= SecMask_$_439[r#66_$_0,AVLTreeNode.height][perm$R];
	assume SecMask_$_441 == SecMask_$_439;
	goto anon661;
anon661:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_441,SecMask_$_441);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_441);
	assume SecMask_$_442 == SecMask_$_441[r#66_$_0,AVLTreeNode.left := SecMask_$_441[r#66_$_0,AVLTreeNode.left][perm$R := SecMask_$_441[r#66_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$457) { goto anon1036_Then; } else { goto anon1036_Else; }
anon1036_Then:
	assume $_$_condition_$457;
	assume SecMask_$_442[r#66_$_0,AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_443 == SecMask_$_442[r#66_$_0,AVLTreeNode.left := SecMask_$_442[r#66_$_0,AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_444 == SecMask_$_443;
	goto anon663;
anon1036_Else:
	assume !$_$_condition_$457;
	assume 0 <= SecMask_$_442[r#66_$_0,AVLTreeNode.left][perm$R];
	assume SecMask_$_444 == SecMask_$_442;
	goto anon663;
anon663:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_444,SecMask_$_444);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_444);
	assume SecMask_$_445 == SecMask_$_444[r#66_$_0,AVLTreeNode.right := SecMask_$_444[r#66_$_0,AVLTreeNode.right][perm$R := SecMask_$_444[r#66_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$458) { goto anon1037_Then; } else { goto anon1037_Else; }
anon1037_Then:
	assume $_$_condition_$458;
	assume SecMask_$_445[r#66_$_0,AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_446 == SecMask_$_445[r#66_$_0,AVLTreeNode.right := SecMask_$_445[r#66_$_0,AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_447 == SecMask_$_446;
	goto anon665;
anon1037_Else:
	assume !$_$_condition_$458;
	assume 0 <= SecMask_$_445[r#66_$_0,AVLTreeNode.right][perm$R];
	assume SecMask_$_447 == SecMask_$_445;
	goto anon665;
anon665:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_447,SecMask_$_447);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_447);
	assume SecMask_$_448 == SecMask_$_447[r#66_$_0,AVLTreeNode.keys := SecMask_$_447[r#66_$_0,AVLTreeNode.keys][perm$R := SecMask_$_447[r#66_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$459) { goto anon1038_Then; } else { goto anon1038_Else; }
anon1038_Then:
	assume $_$_condition_$459;
	assume SecMask_$_448[r#66_$_0,AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_449 == SecMask_$_448[r#66_$_0,AVLTreeNode.keys := SecMask_$_448[r#66_$_0,AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_450 == SecMask_$_449;
	goto anon667;
anon1038_Else:
	assume !$_$_condition_$459;
	assume 0 <= SecMask_$_448[r#66_$_0,AVLTreeNode.keys][perm$R];
	assume SecMask_$_450 == SecMask_$_448;
	goto anon667;
anon667:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_450,SecMask_$_450);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_450);
	assume SecMask_$_451 == SecMask_$_450[r#66_$_0,AVLTreeNode.balanceFactor := SecMask_$_450[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := SecMask_$_450[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$460) { goto anon1039_Then; } else { goto anon1039_Else; }
anon1039_Then:
	assume $_$_condition_$460;
	assume SecMask_$_451[r#66_$_0,AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_452 == SecMask_$_451[r#66_$_0,AVLTreeNode.balanceFactor := SecMask_$_451[r#66_$_0,AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_453 == SecMask_$_452;
	goto anon669;
anon1039_Else:
	assume !$_$_condition_$460;
	assume 0 <= SecMask_$_451[r#66_$_0,AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_453 == SecMask_$_451;
	goto anon669;
anon669:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_453,SecMask_$_453);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_453);
	if ($_$_condition_$461) { goto anon1040_Then; } else { goto anon1040_Else; }
anon1040_Then:
	assume $_$_condition_$461;
	assume $_$_condition_$461 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_454 == SecMask_$_453[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_453[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_453[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$462) { goto anon1041_Then; } else { goto anon1041_Else; }
anon1040_Else:
	assume !$_$_condition_$461;
	assume $_$_condition_$461 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_457 == SecMask_$_453;
	goto $branchMerge_153;
anon1041_Then:
	assume $_$_condition_$462;
	assume SecMask_$_454[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_455 == SecMask_$_454[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_454[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_456 == SecMask_$_455;
	goto anon672;
anon1041_Else:
	assume !$_$_condition_$462;
	assume 0 <= SecMask_$_454[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_456 == SecMask_$_454;
	goto anon672;
anon1042_Then:
	assume $_$_condition_$463;
	assume $_$_condition_$463 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_458 == SecMask_$_457[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_457[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_457[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$465) { goto anon1043_Then; } else { goto anon1043_Else; }
anon1042_Else:
	assume !$_$_condition_$463;
	assume $_$_condition_$463 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_461 == SecMask_$_457;
	goto $branchMerge_154;
anon672:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_456,SecMask_$_456);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_456);
	assume SecMask_$_457 == SecMask_$_456;
	goto $branchMerge_153;
anon1043_Then:
	assume $_$_condition_$465;
	assume SecMask_$_458[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_459 == SecMask_$_458[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_458[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_460 == SecMask_$_459;
	goto anon676;
anon1043_Else:
	assume !$_$_condition_$465;
	assume 0 <= SecMask_$_458[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_460 == SecMask_$_458;
	goto anon676;
anon1044_Then:
	assume $_$_condition_$466;
	assume $_$_condition_$466 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_462 == SecMask_$_461[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_461[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_461[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$468) { goto anon1045_Then; } else { goto anon1045_Else; }
anon1044_Else:
	assume !$_$_condition_$466;
	assume $_$_condition_$466 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_465 == SecMask_$_461;
	goto $branchMerge_155;
anon676:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_460,SecMask_$_460);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_460);
	assume SecMask_$_461 == SecMask_$_460;
	goto $branchMerge_154;
anon1045_Then:
	assume $_$_condition_$468;
	assume SecMask_$_462[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_463 == SecMask_$_462[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_462[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_464 == SecMask_$_463;
	goto anon680;
anon1045_Else:
	assume !$_$_condition_$468;
	assume 0 <= SecMask_$_462[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_464 == SecMask_$_462;
	goto anon680;
anon1046_Then:
	assume $_$_condition_$469;
	assume $_$_condition_$469 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_466 == SecMask_$_465[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_465[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_465[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$471) { goto anon1047_Then; } else { goto anon1047_Else; }
anon1046_Else:
	assume !$_$_condition_$469;
	assume $_$_condition_$469 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_469 == SecMask_$_465;
	goto $branchMerge_156;
anon680:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_464,SecMask_$_464);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_464);
	assume SecMask_$_465 == SecMask_$_464;
	goto $branchMerge_155;
anon1047_Then:
	assume $_$_condition_$471;
	assume SecMask_$_466[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_467 == SecMask_$_466[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_466[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_468 == SecMask_$_467;
	goto anon684;
anon1047_Else:
	assume !$_$_condition_$471;
	assume 0 <= SecMask_$_466[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_468 == SecMask_$_466;
	goto anon684;
anon1048_Then:
	assume $_$_condition_$472;
	assume $_$_condition_$472 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_470 == SecMask_$_469[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_469[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_469[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$474) { goto anon1049_Then; } else { goto anon1049_Else; }
anon1048_Else:
	assume !$_$_condition_$472;
	assume $_$_condition_$472 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_473 == SecMask_$_469;
	goto $branchMerge_157;
anon684:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_468,SecMask_$_468);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_468);
	assume SecMask_$_469 == SecMask_$_468;
	goto $branchMerge_156;
anon1049_Then:
	assume $_$_condition_$474;
	assume SecMask_$_470[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_471 == SecMask_$_470[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_470[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_472 == SecMask_$_471;
	goto anon688;
anon1049_Else:
	assume !$_$_condition_$474;
	assume 0 <= SecMask_$_470[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_472 == SecMask_$_470;
	goto anon688;
anon1050_Then:
	assume $_$_condition_$475;
	assume $_$_condition_$475 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_474 == SecMask_$_473[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_473[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_473[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$477) { goto anon1051_Then; } else { goto anon1051_Else; }
anon1050_Else:
	assume !$_$_condition_$475;
	assume $_$_condition_$475 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_477 == SecMask_$_473;
	goto $branchMerge_158;
anon688:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_472,SecMask_$_472);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_472);
	assume SecMask_$_473 == SecMask_$_472;
	goto $branchMerge_157;
anon1051_Then:
	assume $_$_condition_$477;
	assume SecMask_$_474[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_475 == SecMask_$_474[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_474[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_476 == SecMask_$_475;
	goto anon692;
anon1051_Else:
	assume !$_$_condition_$477;
	assume 0 <= SecMask_$_474[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_476 == SecMask_$_474;
	goto anon692;
anon1052_Then:
	assume $_$_condition_$478;
	assume $_$_condition_$478 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_478 == SecMask_$_477[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_477[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_477[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$480) { goto anon1053_Then; } else { goto anon1053_Else; }
anon1052_Else:
	assume !$_$_condition_$478;
	assume $_$_condition_$478 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_481 == SecMask_$_477;
	goto $branchMerge_159;
anon692:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_476,SecMask_$_476);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_476);
	assume SecMask_$_477 == SecMask_$_476;
	goto $branchMerge_158;
anon1053_Then:
	assume $_$_condition_$480;
	assume SecMask_$_478[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_479 == SecMask_$_478[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_478[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_480 == SecMask_$_479;
	goto anon696;
anon1053_Else:
	assume !$_$_condition_$480;
	assume 0 <= SecMask_$_478[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_480 == SecMask_$_478;
	goto anon696;
anon1054_Then:
	assume $_$_condition_$481;
	assume $_$_condition_$481 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_482 == SecMask_$_481[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_481[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_481[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$483) { goto anon1055_Then; } else { goto anon1055_Else; }
anon1054_Else:
	assume !$_$_condition_$481;
	assume $_$_condition_$481 <==> (!(exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_485 == SecMask_$_481;
	goto anon701;
anon696:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_480,SecMask_$_480);
	assume wf(exhaleHeap#_2393_$_0,Mask_$_75,SecMask_$_480);
	assume SecMask_$_481 == SecMask_$_480;
	goto $branchMerge_159;
anon1055_Then:
	assume $_$_condition_$483;
	assume SecMask_$_482[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_483 == SecMask_$_482[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_482[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_484 == SecMask_$_483;
	goto anon700;
anon1055_Else:
	assume !$_$_condition_$483;
	assume 0 <= SecMask_$_482[exhaleHeap#_2393_$_0[r#66_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_484 == SecMask_$_482;
	goto anon700;
anon701:
	assume wf(exhaleHeap#_2393_$_0,SecMask_$_485,SecMask_$_485);
	assume SecMask_$_486 == SecMask_$_485;
	goto $branchMerge_149;
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
$branchMerge_0:
	if ($_$_condition_$0) { goto anon706_Then; } else { goto anon706_Else; }
$branchMerge_1:
	if ($_$_condition_$2) { goto anon707_Then; } else { goto anon707_Else; }
$branchMerge_2:
	if ($_$_condition_$4) { goto anon708_Then; } else { goto anon708_Else; }
$branchMerge_3:
	if ($_$_condition_$6) { goto anon709_Then; } else { goto anon709_Else; }
$branchMerge_4:
	if ($_$_condition_$10) { goto anon738_Then; } else { goto anon738_Else; }
$branchMerge_5:
	if ($_$_condition_$12) { goto anon739_Then; } else { goto anon739_Else; }
$branchMerge_6:
	if ($_$_condition_$14) { goto anon740_Then; } else { goto anon740_Else; }
$branchMerge_7:
	if ($_$_condition_$16) { goto anon741_Then; } else { goto anon741_Else; }
$branchMerge_8:
	if ($_$_condition_$18) { goto anon742_Then; } else { goto anon742_Else; }
$branchMerge_9:
	if ($_$_condition_$20) { goto anon743_Then; } else { goto anon743_Else; }
$branchMerge_10:
	if ($_$_condition_$22) { goto anon744_Then; } else { goto anon744_Else; }
$branchMerge_11:
	if ($_$_condition_$24) { goto anon745_Then; } else { goto anon745_Else; }
$branchMerge_12:
	if ($_$_condition_$26) { goto anon746_Then; } else { goto anon746_Else; }
$branchMerge_13:
	if ($_$_condition_$28) { goto anon747_Then; } else { goto anon747_Else; }
$branchMerge_14:
	if ($_$_condition_$30) { goto anon748_Then; } else { goto anon748_Else; }
$branchMerge_15:
	if ($_$_condition_$34) { goto anon776_Then; } else { goto anon776_Else; }
$branchMerge_16:
	if ($_$_condition_$35) { goto anon751_Then; } else { goto anon751_Else; }
$branchMerge_17:
	if ($_$_condition_$37) { goto anon752_Then; } else { goto anon752_Else; }
$branchMerge_18:
	if ($_$_condition_$39) { goto anon753_Then; } else { goto anon753_Else; }
$branchMerge_19:
	if ($_$_condition_$49) { goto anon762_Then; } else { goto anon762_Else; }
$branchMerge_20:
	if ($_$_condition_$52) { goto anon764_Then; } else { goto anon764_Else; }
$branchMerge_21:
	if ($_$_condition_$55) { goto anon766_Then; } else { goto anon766_Else; }
$branchMerge_22:
	if ($_$_condition_$58) { goto anon768_Then; } else { goto anon768_Else; }
$branchMerge_23:
	if ($_$_condition_$61) { goto anon770_Then; } else { goto anon770_Else; }
$branchMerge_24:
	if ($_$_condition_$64) { goto anon772_Then; } else { goto anon772_Else; }
$branchMerge_25:
	if ($_$_condition_$67) { goto anon774_Then; } else { goto anon774_Else; }
$branchMerge_26:
	if ($_$_condition_$72) { goto anon778_Then; } else { goto anon778_Else; }
$branchMerge_27:
	if ($_$_condition_$74) { goto anon779_Then; } else { goto anon779_Else; }
$branchMerge_28:
	if ($_$_condition_$76) { goto anon780_Then; } else { goto anon780_Else; }
$branchMerge_29:
	if ($_$_condition_$78) { goto anon781_Then; } else { goto anon781_Else; }
$branchMerge_30:
	if ($_$_condition_$80) { goto anon782_Then; } else { goto anon782_Else; }
$branchMerge_31:
	if ($_$_condition_$82) { goto anon783_Then; } else { goto anon783_Else; }
$branchMerge_32:
	if ($_$_condition_$84) { goto anon784_Then; } else { goto anon784_Else; }
$branchMerge_33:
	if ($_$_condition_$86) { goto anon785_Then; } else { goto anon785_Else; }
$branchMerge_34:
	if ($_$_condition_$88) { goto anon786_Then; } else { goto anon786_Else; }
$branchMerge_35:
	if ($_$_condition_$90) { goto anon787_Then; } else { goto anon787_Else; }
$branchMerge_36:
	if ($_$_condition_$92) { goto anon788_Then; } else { goto anon788_Else; }
$branchMerge_37:
	if ($_$_condition_$96) { goto anon816_Then; } else { goto anon816_Else; }
$branchMerge_38:
	if ($_$_condition_$97) { goto anon791_Then; } else { goto anon791_Else; }
$branchMerge_39:
	if ($_$_condition_$99) { goto anon792_Then; } else { goto anon792_Else; }
$branchMerge_40:
	if ($_$_condition_$101) { goto anon793_Then; } else { goto anon793_Else; }
$branchMerge_41:
	if ($_$_condition_$111) { goto anon802_Then; } else { goto anon802_Else; }
$branchMerge_42:
	if ($_$_condition_$114) { goto anon804_Then; } else { goto anon804_Else; }
$branchMerge_43:
	if ($_$_condition_$117) { goto anon806_Then; } else { goto anon806_Else; }
$branchMerge_44:
	if ($_$_condition_$120) { goto anon808_Then; } else { goto anon808_Else; }
$branchMerge_45:
	if ($_$_condition_$123) { goto anon810_Then; } else { goto anon810_Else; }
$branchMerge_46:
	if ($_$_condition_$126) { goto anon812_Then; } else { goto anon812_Else; }
$branchMerge_47:
	if ($_$_condition_$129) { goto anon814_Then; } else { goto anon814_Else; }
$branchMerge_48:
	if ($_$_condition_$134) { goto anon818_Then; } else { goto anon818_Else; }
$branchMerge_49:
	if ($_$_condition_$136) { goto anon819_Then; } else { goto anon819_Else; }
$branchMerge_50:
	if ($_$_condition_$138) { goto anon820_Then; } else { goto anon820_Else; }
$branchMerge_51:
	if ($_$_condition_$140) { goto anon821_Then; } else { goto anon821_Else; }
$branchMerge_52:
	if ($_$_condition_$142) { goto anon822_Then; } else { goto anon822_Else; }
$branchMerge_53:
	if ($_$_condition_$144) { goto anon823_Then; } else { goto anon823_Else; }
$branchMerge_54:
	if ($_$_condition_$146) { goto anon824_Then; } else { goto anon824_Else; }
$branchMerge_55:
	if ($_$_condition_$148) { goto anon825_Then; } else { goto anon825_Else; }
$branchMerge_56:
	if ($_$_condition_$150) { goto anon826_Then; } else { goto anon826_Else; }
$branchMerge_57:
	if ($_$_condition_$152) { goto anon827_Then; } else { goto anon827_Else; }
$branchMerge_58:
	if ($_$_condition_$154) { goto anon828_Then; } else { goto anon828_Else; }
$branchMerge_59:
	if ($_$_condition_$158) { goto anon831_Then; } else { goto anon831_Else; }
$branchMerge_60:
	if ($_$_condition_$162) { goto anon861_Then; } else { goto anon861_Else; }
$branchMerge_61:
	if ($_$_condition_$164) { goto anon860_Then; } else { goto anon860_Else; }
$branchMerge_62:
	if ($_$_condition_$202) { goto anon862_Then; } else { goto anon862_Else; }
$branchMerge_63:
	if ($_$_condition_$165) { goto anon835_Then; } else { goto anon835_Else; }
$branchMerge_64:
	if ($_$_condition_$167) { goto anon836_Then; } else { goto anon836_Else; }
$branchMerge_65:
	if ($_$_condition_$169) { goto anon837_Then; } else { goto anon837_Else; }
$branchMerge_66:
	if ($_$_condition_$179) { goto anon846_Then; } else { goto anon846_Else; }
$branchMerge_67:
	if ($_$_condition_$182) { goto anon848_Then; } else { goto anon848_Else; }
$branchMerge_68:
	if ($_$_condition_$185) { goto anon850_Then; } else { goto anon850_Else; }
$branchMerge_69:
	if ($_$_condition_$188) { goto anon852_Then; } else { goto anon852_Else; }
$branchMerge_70:
	if ($_$_condition_$191) { goto anon854_Then; } else { goto anon854_Else; }
$branchMerge_71:
	if ($_$_condition_$194) { goto anon856_Then; } else { goto anon856_Else; }
$branchMerge_72:
	if ($_$_condition_$197) { goto anon858_Then; } else { goto anon858_Else; }
$branchMerge_73:
	if ($_$_condition_$204) { goto anon863_Then; } else { goto anon863_Else; }
$branchMerge_74:
	if ($_$_condition_$206) { goto anon864_Then; } else { goto anon864_Else; }
$branchMerge_75:
	if ($_$_condition_$209) { goto anon893_Then; } else { goto anon893_Else; }
$branchMerge_76:
	if ($_$_condition_$211) { goto anon892_Then; } else { goto anon892_Else; }
$branchMerge_77:
	if ($_$_condition_$249) { goto anon894_Then; } else { goto anon894_Else; }
$branchMerge_78:
	if ($_$_condition_$212) { goto anon867_Then; } else { goto anon867_Else; }
$branchMerge_79:
	if ($_$_condition_$214) { goto anon868_Then; } else { goto anon868_Else; }
$branchMerge_80:
	if ($_$_condition_$216) { goto anon869_Then; } else { goto anon869_Else; }
$branchMerge_81:
	if ($_$_condition_$226) { goto anon878_Then; } else { goto anon878_Else; }
$branchMerge_82:
	if ($_$_condition_$229) { goto anon880_Then; } else { goto anon880_Else; }
$branchMerge_83:
	if ($_$_condition_$232) { goto anon882_Then; } else { goto anon882_Else; }
$branchMerge_84:
	if ($_$_condition_$235) { goto anon884_Then; } else { goto anon884_Else; }
$branchMerge_85:
	if ($_$_condition_$238) { goto anon886_Then; } else { goto anon886_Else; }
$branchMerge_86:
	if ($_$_condition_$241) { goto anon888_Then; } else { goto anon888_Else; }
$branchMerge_87:
	if ($_$_condition_$244) { goto anon890_Then; } else { goto anon890_Else; }
$branchMerge_88:
	if ($_$_condition_$251) { goto anon895_Then; } else { goto anon895_Else; }
$branchMerge_89:
	if ($_$_condition_$255) { goto anon898_Then; } else { goto anon898_Else; }
$branchMerge_90:
	if ($_$_condition_$259) { goto anon928_Then; } else { goto anon928_Else; }
$branchMerge_91:
	if ($_$_condition_$261) { goto anon927_Then; } else { goto anon927_Else; }
$branchMerge_92:
	if ($_$_condition_$299) { goto anon929_Then; } else { goto anon929_Else; }
$branchMerge_93:
	if ($_$_condition_$262) { goto anon902_Then; } else { goto anon902_Else; }
$branchMerge_94:
	if ($_$_condition_$264) { goto anon903_Then; } else { goto anon903_Else; }
$branchMerge_95:
	if ($_$_condition_$266) { goto anon904_Then; } else { goto anon904_Else; }
$branchMerge_96:
	if ($_$_condition_$276) { goto anon913_Then; } else { goto anon913_Else; }
$branchMerge_97:
	if ($_$_condition_$279) { goto anon915_Then; } else { goto anon915_Else; }
$branchMerge_98:
	if ($_$_condition_$282) { goto anon917_Then; } else { goto anon917_Else; }
$branchMerge_99:
	if ($_$_condition_$285) { goto anon919_Then; } else { goto anon919_Else; }
$branchMerge_100:
	if ($_$_condition_$288) { goto anon921_Then; } else { goto anon921_Else; }
$branchMerge_101:
	if ($_$_condition_$291) { goto anon923_Then; } else { goto anon923_Else; }
$branchMerge_102:
	if ($_$_condition_$294) { goto anon925_Then; } else { goto anon925_Else; }
$branchMerge_103:
	if ($_$_condition_$301) { goto anon930_Then; } else { goto anon930_Else; }
$branchMerge_104:
	if ($_$_condition_$303) { goto anon931_Then; } else { goto anon931_Else; }
$branchMerge_105:
	if ($_$_condition_$306) { goto anon960_Then; } else { goto anon960_Else; }
$branchMerge_106:
	if ($_$_condition_$308) { goto anon959_Then; } else { goto anon959_Else; }
$branchMerge_107:
	if ($_$_condition_$346) { goto anon961_Then; } else { goto anon961_Else; }
$branchMerge_108:
	if ($_$_condition_$309) { goto anon934_Then; } else { goto anon934_Else; }
$branchMerge_109:
	if ($_$_condition_$311) { goto anon935_Then; } else { goto anon935_Else; }
$branchMerge_110:
	if ($_$_condition_$313) { goto anon936_Then; } else { goto anon936_Else; }
$branchMerge_111:
	if ($_$_condition_$323) { goto anon945_Then; } else { goto anon945_Else; }
$branchMerge_112:
	if ($_$_condition_$326) { goto anon947_Then; } else { goto anon947_Else; }
$branchMerge_113:
	if ($_$_condition_$329) { goto anon949_Then; } else { goto anon949_Else; }
$branchMerge_114:
	if ($_$_condition_$332) { goto anon951_Then; } else { goto anon951_Else; }
$branchMerge_115:
	if ($_$_condition_$335) { goto anon953_Then; } else { goto anon953_Else; }
$branchMerge_116:
	if ($_$_condition_$338) { goto anon955_Then; } else { goto anon955_Else; }
$branchMerge_117:
	if ($_$_condition_$341) { goto anon957_Then; } else { goto anon957_Else; }
$branchMerge_118:
	if ($_$_condition_$348) { goto anon962_Then; } else { goto anon962_Else; }
$branchMerge_119:
	if ($_$_condition_$351) { goto anon964_Then; } else { goto anon964_Else; }
$branchMerge_120:
	if ($_$_condition_$355) { goto anon994_Then; } else { goto anon994_Else; }
$branchMerge_121:
	if ($_$_condition_$357) { goto anon993_Then; } else { goto anon993_Else; }
$branchMerge_122:
	if ($_$_condition_$395) { goto anon995_Then; } else { goto anon995_Else; }
$branchMerge_123:
	if ($_$_condition_$358) { goto anon968_Then; } else { goto anon968_Else; }
$branchMerge_124:
	if ($_$_condition_$360) { goto anon969_Then; } else { goto anon969_Else; }
$branchMerge_125:
	if ($_$_condition_$362) { goto anon970_Then; } else { goto anon970_Else; }
$branchMerge_126:
	if ($_$_condition_$372) { goto anon979_Then; } else { goto anon979_Else; }
$branchMerge_127:
	if ($_$_condition_$375) { goto anon981_Then; } else { goto anon981_Else; }
$branchMerge_128:
	if ($_$_condition_$378) { goto anon983_Then; } else { goto anon983_Else; }
$branchMerge_129:
	if ($_$_condition_$381) { goto anon985_Then; } else { goto anon985_Else; }
$branchMerge_130:
	if ($_$_condition_$384) { goto anon987_Then; } else { goto anon987_Else; }
$branchMerge_131:
	if ($_$_condition_$387) { goto anon989_Then; } else { goto anon989_Else; }
$branchMerge_132:
	if ($_$_condition_$390) { goto anon991_Then; } else { goto anon991_Else; }
$branchMerge_133:
	if ($_$_condition_$397) { goto anon996_Then; } else { goto anon996_Else; }
$branchMerge_134:
	if ($_$_condition_$399) { goto anon997_Then; } else { goto anon997_Else; }
$branchMerge_135:
	if ($_$_condition_$402) { goto anon1026_Then; } else { goto anon1026_Else; }
$branchMerge_136:
	if ($_$_condition_$404) { goto anon1025_Then; } else { goto anon1025_Else; }
$branchMerge_137:
	if ($_$_condition_$442) { goto anon1027_Then; } else { goto anon1027_Else; }
$branchMerge_138:
	if ($_$_condition_$405) { goto anon1000_Then; } else { goto anon1000_Else; }
$branchMerge_139:
	if ($_$_condition_$407) { goto anon1001_Then; } else { goto anon1001_Else; }
$branchMerge_140:
	if ($_$_condition_$409) { goto anon1002_Then; } else { goto anon1002_Else; }
$branchMerge_141:
	if ($_$_condition_$419) { goto anon1011_Then; } else { goto anon1011_Else; }
$branchMerge_142:
	if ($_$_condition_$422) { goto anon1013_Then; } else { goto anon1013_Else; }
$branchMerge_143:
	if ($_$_condition_$425) { goto anon1015_Then; } else { goto anon1015_Else; }
$branchMerge_144:
	if ($_$_condition_$428) { goto anon1017_Then; } else { goto anon1017_Else; }
$branchMerge_145:
	if ($_$_condition_$431) { goto anon1019_Then; } else { goto anon1019_Else; }
$branchMerge_146:
	if ($_$_condition_$434) { goto anon1021_Then; } else { goto anon1021_Else; }
$branchMerge_147:
	if ($_$_condition_$437) { goto anon1023_Then; } else { goto anon1023_Else; }
$branchMerge_148:
	if ($_$_condition_$444) { goto anon1028_Then; } else { goto anon1028_Else; }
$branchMerge_149:
	if ($_$_condition_$448) { goto anon1056_Then; } else { goto anon1056_Else; }
$branchMerge_150:
	if ($_$_condition_$449) { goto anon1031_Then; } else { goto anon1031_Else; }
$branchMerge_151:
	if ($_$_condition_$451) { goto anon1032_Then; } else { goto anon1032_Else; }
$branchMerge_152:
	if ($_$_condition_$453) { goto anon1033_Then; } else { goto anon1033_Else; }
$branchMerge_153:
	if ($_$_condition_$463) { goto anon1042_Then; } else { goto anon1042_Else; }
$branchMerge_154:
	if ($_$_condition_$466) { goto anon1044_Then; } else { goto anon1044_Else; }
$branchMerge_155:
	if ($_$_condition_$469) { goto anon1046_Then; } else { goto anon1046_Else; }
$branchMerge_156:
	if ($_$_condition_$472) { goto anon1048_Then; } else { goto anon1048_Else; }
$branchMerge_157:
	if ($_$_condition_$475) { goto anon1050_Then; } else { goto anon1050_Else; }
$branchMerge_158:
	if ($_$_condition_$478) { goto anon1052_Then; } else { goto anon1052_Else; }
$branchMerge_159:
	if ($_$_condition_$481) { goto anon1054_Then; } else { goto anon1054_Else; }
}
