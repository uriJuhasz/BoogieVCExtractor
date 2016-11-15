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
procedure AVLTreeNode.rebalanceLeft (this : ref) returns (r#63 : ref)
{
	var methodK#_1751 : int;
	var methodCallK#_1756 : int;
	var this#521 : ref;
	var unfoldingK#_1813 : int;
	var methodCallK#_1855 : int;
	var this#547 : ref;
	var r#548 : ref;
	var methodCallK#_1974 : int;
	var this#577 : ref;
	var r#578 : ref;
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
	var this#521_$_0 : ref;
	var exhaleHeap#_1757_$_0 : HeapType;
	var exhaleMask#_1758_$_0 : MaskType;
	var exhaleMask#_1758_$_1 : MaskType;
	var bf#522_$_0 : int;
	var Mask_$_18 : MaskType;
	var Mask_$_19 : MaskType;
	var predVer#_1764_$_0 : int;
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
	var predVer#_1783_$_0 : int;
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
	var cond#_1801_$_0 : bool;
	var exhaleHeap#_1806_$_0 : HeapType;
	var unfoldingMask#_1809_$_0 : MaskType;
	var exhaleHeap#_1975_$_0 : HeapType;
	var exhaleMask#_1976_$_0 : MaskType;
	var exhaleMask#_1976_$_1 : MaskType;
	var exhaleMask#_1976_$_2 : MaskType;
	var exhaleMask#_1976_$_3 : MaskType;
	var exhaleMask#_1976_$_4 : MaskType;
	var exhaleMask#_1976_$_5 : MaskType;
	var exhaleMask#_1976_$_6 : MaskType;
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
	var SecMask_$_227 : MaskType;
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
	var exhaleMask#_1976_$_7 : MaskType;
	var exhaleMask#_1976_$_8 : MaskType;
	var exhaleMask#_1976_$_9 : MaskType;
	var exhaleMask#_1976_$_10 : MaskType;
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
	var SecMask_$_331 : MaskType;
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
	var exhaleMask#_1976_$_11 : MaskType;
	var exhaleMask#_1976_$_12 : MaskType;
	var exhaleMask#_1976_$_13 : MaskType;
	var exhaleMask#_1976_$_14 : MaskType;
	var exhaleMask#_1976_$_15 : MaskType;
	var exhaleMask#_1976_$_16 : MaskType;
	var exhaleMask#_1976_$_17 : MaskType;
	var r#578_$_0 : ref;
	var Mask_$_20 : MaskType;
	var Mask_$_21 : MaskType;
	var Mask_$_22 : MaskType;
	var Mask_$_23 : MaskType;
	var unfoldingSecMask#_1810_$_0 : MaskType;
	var unfoldingSecMask#_1810_$_1 : MaskType;
	var unfoldingSecMask#_1810_$_2 : MaskType;
	var unfoldingSecMask#_1810_$_3 : MaskType;
	var unfoldingSecMask#_1810_$_4 : MaskType;
	var unfoldingSecMask#_1810_$_5 : MaskType;
	var unfoldingSecMask#_1810_$_6 : MaskType;
	var unfoldingSecMask#_1810_$_7 : MaskType;
	var unfoldingSecMask#_1810_$_8 : MaskType;
	var unfoldingSecMask#_1810_$_9 : MaskType;
	var unfoldingSecMask#_1810_$_10 : MaskType;
	var unfoldingSecMask#_1810_$_11 : MaskType;
	var unfoldingSecMask#_1810_$_12 : MaskType;
	var unfoldingSecMask#_1810_$_13 : MaskType;
	var unfoldingSecMask#_1810_$_14 : MaskType;
	var unfoldingSecMask#_1810_$_15 : MaskType;
	var unfoldingSecMask#_1810_$_16 : MaskType;
	var unfoldingSecMask#_1810_$_17 : MaskType;
	var unfoldingSecMask#_1810_$_18 : MaskType;
	var unfoldingSecMask#_1810_$_19 : MaskType;
	var unfoldingSecMask#_1810_$_20 : MaskType;
	var unfoldingSecMask#_1810_$_21 : MaskType;
	var unfoldingSecMask#_1810_$_22 : MaskType;
	var unfoldingSecMask#_1810_$_23 : MaskType;
	var unfoldingSecMask#_1810_$_24 : MaskType;
	var unfoldingSecMask#_1810_$_25 : MaskType;
	var unfoldingSecMask#_1810_$_26 : MaskType;
	var unfoldingSecMask#_1810_$_27 : MaskType;
	var unfoldingSecMask#_1810_$_28 : MaskType;
	var unfoldingSecMask#_1810_$_29 : MaskType;
	var unfoldingSecMask#_1810_$_30 : MaskType;
	var unfoldingSecMask#_1810_$_31 : MaskType;
	var unfoldingSecMask#_1810_$_32 : MaskType;
	var unfoldingSecMask#_1810_$_33 : MaskType;
	var unfoldingSecMask#_1810_$_34 : MaskType;
	var unfoldingSecMask#_1810_$_35 : MaskType;
	var unfoldingSecMask#_1810_$_36 : MaskType;
	var unfoldingSecMask#_1810_$_37 : MaskType;
	var unfoldingSecMask#_1810_$_38 : MaskType;
	var unfoldingSecMask#_1810_$_39 : MaskType;
	var unfoldingSecMask#_1810_$_40 : MaskType;
	var unfoldingSecMask#_1810_$_41 : MaskType;
	var unfoldingSecMask#_1810_$_42 : MaskType;
	var unfoldingSecMask#_1810_$_43 : MaskType;
	var unfoldingSecMask#_1810_$_44 : MaskType;
	var unfoldingSecMask#_1810_$_45 : MaskType;
	var unfoldingSecMask#_1810_$_46 : MaskType;
	var unfoldingSecMask#_1810_$_47 : MaskType;
	var unfoldingSecMask#_1810_$_48 : MaskType;
	var unfoldingSecMask#_1810_$_49 : MaskType;
	var unfoldingSecMask#_1810_$_50 : MaskType;
	var oldVers#_1833_$_0 : int;
	var newVers#_1834_$_0 : int;
	var unfoldingHeap#_1808_$_0 : HeapType;
	var unfoldingHeap#_1808_$_1 : HeapType;
	var unfoldingMask#_1809_$_1 : MaskType;
	var unfoldingMask#_1809_$_2 : MaskType;
	var unfoldingMask#_1809_$_3 : MaskType;
	var unfoldingMask#_1809_$_4 : MaskType;
	var unfoldingMask#_1809_$_5 : MaskType;
	var unfoldingMask#_1809_$_6 : MaskType;
	var unfoldingMask#_1809_$_7 : MaskType;
	var unfoldingMask#_1809_$_8 : MaskType;
	var unfoldingMask#_1809_$_9 : MaskType;
	var unfoldingMask#_1809_$_10 : MaskType;
	var unfoldingMask#_1809_$_11 : MaskType;
	var unfoldingMask#_1809_$_12 : MaskType;
	var unfoldingMask#_1809_$_13 : MaskType;
	var unfoldingMask#_1809_$_14 : MaskType;
	var unfoldingMask#_1809_$_15 : MaskType;
	var unfoldingMask#_1809_$_16 : MaskType;
	var unfoldingMask#_1809_$_17 : MaskType;
	var unfoldingMask#_1809_$_18 : MaskType;
	var unfoldingMask#_1809_$_19 : MaskType;
	var unfoldingMask#_1809_$_20 : MaskType;
	var unfoldingMask#_1809_$_21 : MaskType;
	var unfoldingMask#_1809_$_22 : MaskType;
	var assertSecMask#_1804_$_0 : MaskType;
	var assertSecMask#_1804_$_1 : MaskType;
	var assertSecMask#_1804_$_2 : MaskType;
	var assertSecMask#_1804_$_3 : MaskType;
	var assertSecMask#_1804_$_4 : MaskType;
	var assertSecMask#_1804_$_5 : MaskType;
	var assertSecMask#_1804_$_6 : MaskType;
	var assertSecMask#_1804_$_7 : MaskType;
	var assertSecMask#_1804_$_8 : MaskType;
	var assertSecMask#_1804_$_9 : MaskType;
	var assertSecMask#_1804_$_10 : MaskType;
	var assertSecMask#_1804_$_11 : MaskType;
	var assertSecMask#_1804_$_12 : MaskType;
	var assertSecMask#_1804_$_13 : MaskType;
	var assertSecMask#_1804_$_14 : MaskType;
	var assertSecMask#_1804_$_15 : MaskType;
	var assertSecMask#_1804_$_16 : MaskType;
	var assertSecMask#_1804_$_17 : MaskType;
	var assertSecMask#_1804_$_18 : MaskType;
	var assertSecMask#_1804_$_19 : MaskType;
	var assertSecMask#_1804_$_20 : MaskType;
	var assertSecMask#_1804_$_21 : MaskType;
	var assertSecMask#_1804_$_22 : MaskType;
	var assertSecMask#_1804_$_23 : MaskType;
	var assertSecMask#_1804_$_24 : MaskType;
	var assertSecMask#_1804_$_25 : MaskType;
	var assertSecMask#_1804_$_26 : MaskType;
	var assertSecMask#_1804_$_27 : MaskType;
	var assertSecMask#_1804_$_28 : MaskType;
	var assertSecMask#_1804_$_29 : MaskType;
	var assertSecMask#_1804_$_30 : MaskType;
	var assertSecMask#_1804_$_31 : MaskType;
	var assertSecMask#_1804_$_32 : MaskType;
	var assertSecMask#_1804_$_33 : MaskType;
	var assertSecMask#_1804_$_34 : MaskType;
	var assertSecMask#_1804_$_35 : MaskType;
	var assertSecMask#_1804_$_36 : MaskType;
	var assertSecMask#_1804_$_37 : MaskType;
	var assertSecMask#_1804_$_38 : MaskType;
	var assertSecMask#_1804_$_39 : MaskType;
	var assertSecMask#_1804_$_40 : MaskType;
	var assertSecMask#_1804_$_41 : MaskType;
	var assertSecMask#_1804_$_42 : MaskType;
	var assertSecMask#_1804_$_43 : MaskType;
	var assertSecMask#_1804_$_44 : MaskType;
	var assertSecMask#_1804_$_45 : MaskType;
	var assertSecMask#_1804_$_46 : MaskType;
	var assertSecMask#_1804_$_47 : MaskType;
	var assertSecMask#_1804_$_48 : MaskType;
	var assertSecMask#_1804_$_49 : MaskType;
	var assertSecMask#_1804_$_50 : MaskType;
	var assertSecMask#_1804_$_51 : MaskType;
	var assertSecMask#_1804_$_52 : MaskType;
	var assertSecMask#_1804_$_53 : MaskType;
	var assertSecMask#_1804_$_54 : MaskType;
	var assertSecMask#_1804_$_55 : MaskType;
	var assertSecMask#_1804_$_56 : MaskType;
	var assertSecMask#_1804_$_57 : MaskType;
	var assertSecMask#_1804_$_58 : MaskType;
	var assertSecMask#_1804_$_59 : MaskType;
	var assertSecMask#_1804_$_60 : MaskType;
	var assertSecMask#_1804_$_61 : MaskType;
	var assertSecMask#_1804_$_62 : MaskType;
	var assertSecMask#_1804_$_63 : MaskType;
	var assertSecMask#_1804_$_64 : MaskType;
	var assertSecMask#_1804_$_65 : MaskType;
	var assertSecMask#_1804_$_66 : MaskType;
	var assertSecMask#_1804_$_67 : MaskType;
	var assertSecMask#_1804_$_68 : MaskType;
	var assertSecMask#_1804_$_69 : MaskType;
	var assertSecMask#_1804_$_70 : MaskType;
	var assertSecMask#_1804_$_71 : MaskType;
	var assertSecMask#_1804_$_72 : MaskType;
	var exhaleHeap#_1856_$_0 : HeapType;
	var exhaleMask#_1857_$_0 : MaskType;
	var exhaleMask#_1857_$_1 : MaskType;
	var exhaleMask#_1857_$_2 : MaskType;
	var exhaleMask#_1857_$_3 : MaskType;
	var exhaleMask#_1857_$_4 : MaskType;
	var exhaleMask#_1857_$_5 : MaskType;
	var exhaleMask#_1857_$_6 : MaskType;
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
	var SecMask_$_435 : MaskType;
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
	var SecMask_$_487 : MaskType;
	var SecMask_$_488 : MaskType;
	var SecMask_$_489 : MaskType;
	var SecMask_$_490 : MaskType;
	var SecMask_$_491 : MaskType;
	var SecMask_$_492 : MaskType;
	var SecMask_$_493 : MaskType;
	var SecMask_$_494 : MaskType;
	var SecMask_$_495 : MaskType;
	var SecMask_$_496 : MaskType;
	var SecMask_$_497 : MaskType;
	var SecMask_$_498 : MaskType;
	var SecMask_$_499 : MaskType;
	var SecMask_$_500 : MaskType;
	var SecMask_$_501 : MaskType;
	var SecMask_$_502 : MaskType;
	var SecMask_$_503 : MaskType;
	var SecMask_$_504 : MaskType;
	var SecMask_$_505 : MaskType;
	var SecMask_$_506 : MaskType;
	var SecMask_$_507 : MaskType;
	var SecMask_$_508 : MaskType;
	var SecMask_$_509 : MaskType;
	var SecMask_$_510 : MaskType;
	var SecMask_$_511 : MaskType;
	var SecMask_$_512 : MaskType;
	var SecMask_$_513 : MaskType;
	var SecMask_$_514 : MaskType;
	var SecMask_$_515 : MaskType;
	var SecMask_$_516 : MaskType;
	var SecMask_$_517 : MaskType;
	var SecMask_$_518 : MaskType;
	var SecMask_$_519 : MaskType;
	var SecMask_$_520 : MaskType;
	var SecMask_$_521 : MaskType;
	var SecMask_$_522 : MaskType;
	var SecMask_$_523 : MaskType;
	var SecMask_$_524 : MaskType;
	var SecMask_$_525 : MaskType;
	var SecMask_$_526 : MaskType;
	var SecMask_$_527 : MaskType;
	var SecMask_$_528 : MaskType;
	var SecMask_$_529 : MaskType;
	var SecMask_$_530 : MaskType;
	var SecMask_$_531 : MaskType;
	var SecMask_$_532 : MaskType;
	var SecMask_$_533 : MaskType;
	var SecMask_$_534 : MaskType;
	var SecMask_$_535 : MaskType;
	var SecMask_$_536 : MaskType;
	var SecMask_$_537 : MaskType;
	var SecMask_$_538 : MaskType;
	var SecMask_$_539 : MaskType;
	var SecMask_$_540 : MaskType;
	var SecMask_$_541 : MaskType;
	var SecMask_$_542 : MaskType;
	var SecMask_$_543 : MaskType;
	var SecMask_$_544 : MaskType;
	var SecMask_$_545 : MaskType;
	var SecMask_$_546 : MaskType;
	var SecMask_$_547 : MaskType;
	var SecMask_$_548 : MaskType;
	var SecMask_$_549 : MaskType;
	var SecMask_$_550 : MaskType;
	var SecMask_$_551 : MaskType;
	var SecMask_$_552 : MaskType;
	var SecMask_$_553 : MaskType;
	var SecMask_$_554 : MaskType;
	var exhaleMask#_1857_$_7 : MaskType;
	var exhaleMask#_1857_$_8 : MaskType;
	var exhaleMask#_1857_$_9 : MaskType;
	var exhaleMask#_1857_$_10 : MaskType;
	var SecMask_$_555 : MaskType;
	var SecMask_$_556 : MaskType;
	var SecMask_$_557 : MaskType;
	var SecMask_$_558 : MaskType;
	var SecMask_$_559 : MaskType;
	var SecMask_$_560 : MaskType;
	var SecMask_$_561 : MaskType;
	var SecMask_$_562 : MaskType;
	var SecMask_$_563 : MaskType;
	var SecMask_$_564 : MaskType;
	var SecMask_$_565 : MaskType;
	var SecMask_$_566 : MaskType;
	var SecMask_$_567 : MaskType;
	var SecMask_$_568 : MaskType;
	var SecMask_$_569 : MaskType;
	var SecMask_$_570 : MaskType;
	var SecMask_$_571 : MaskType;
	var SecMask_$_572 : MaskType;
	var SecMask_$_573 : MaskType;
	var SecMask_$_574 : MaskType;
	var SecMask_$_575 : MaskType;
	var SecMask_$_576 : MaskType;
	var SecMask_$_577 : MaskType;
	var SecMask_$_578 : MaskType;
	var SecMask_$_579 : MaskType;
	var SecMask_$_580 : MaskType;
	var SecMask_$_581 : MaskType;
	var SecMask_$_582 : MaskType;
	var SecMask_$_583 : MaskType;
	var SecMask_$_584 : MaskType;
	var SecMask_$_585 : MaskType;
	var SecMask_$_586 : MaskType;
	var SecMask_$_587 : MaskType;
	var SecMask_$_588 : MaskType;
	var SecMask_$_589 : MaskType;
	var SecMask_$_590 : MaskType;
	var SecMask_$_591 : MaskType;
	var SecMask_$_592 : MaskType;
	var SecMask_$_593 : MaskType;
	var SecMask_$_594 : MaskType;
	var SecMask_$_595 : MaskType;
	var SecMask_$_596 : MaskType;
	var SecMask_$_597 : MaskType;
	var SecMask_$_598 : MaskType;
	var SecMask_$_599 : MaskType;
	var SecMask_$_600 : MaskType;
	var SecMask_$_601 : MaskType;
	var SecMask_$_602 : MaskType;
	var SecMask_$_603 : MaskType;
	var SecMask_$_604 : MaskType;
	var SecMask_$_605 : MaskType;
	var SecMask_$_606 : MaskType;
	var SecMask_$_607 : MaskType;
	var SecMask_$_608 : MaskType;
	var SecMask_$_609 : MaskType;
	var SecMask_$_610 : MaskType;
	var SecMask_$_611 : MaskType;
	var SecMask_$_612 : MaskType;
	var SecMask_$_613 : MaskType;
	var SecMask_$_614 : MaskType;
	var SecMask_$_615 : MaskType;
	var SecMask_$_616 : MaskType;
	var SecMask_$_617 : MaskType;
	var SecMask_$_618 : MaskType;
	var SecMask_$_619 : MaskType;
	var SecMask_$_620 : MaskType;
	var SecMask_$_621 : MaskType;
	var SecMask_$_622 : MaskType;
	var SecMask_$_623 : MaskType;
	var SecMask_$_624 : MaskType;
	var SecMask_$_625 : MaskType;
	var SecMask_$_626 : MaskType;
	var SecMask_$_627 : MaskType;
	var SecMask_$_628 : MaskType;
	var SecMask_$_629 : MaskType;
	var SecMask_$_630 : MaskType;
	var SecMask_$_631 : MaskType;
	var SecMask_$_632 : MaskType;
	var SecMask_$_633 : MaskType;
	var SecMask_$_634 : MaskType;
	var SecMask_$_635 : MaskType;
	var SecMask_$_636 : MaskType;
	var SecMask_$_637 : MaskType;
	var SecMask_$_638 : MaskType;
	var SecMask_$_639 : MaskType;
	var SecMask_$_640 : MaskType;
	var SecMask_$_641 : MaskType;
	var SecMask_$_642 : MaskType;
	var SecMask_$_643 : MaskType;
	var SecMask_$_644 : MaskType;
	var SecMask_$_645 : MaskType;
	var SecMask_$_646 : MaskType;
	var SecMask_$_647 : MaskType;
	var SecMask_$_648 : MaskType;
	var SecMask_$_649 : MaskType;
	var SecMask_$_650 : MaskType;
	var SecMask_$_651 : MaskType;
	var SecMask_$_652 : MaskType;
	var SecMask_$_653 : MaskType;
	var SecMask_$_654 : MaskType;
	var SecMask_$_655 : MaskType;
	var SecMask_$_656 : MaskType;
	var SecMask_$_657 : MaskType;
	var SecMask_$_658 : MaskType;
	var SecMask_$_659 : MaskType;
	var SecMask_$_660 : MaskType;
	var SecMask_$_661 : MaskType;
	var SecMask_$_662 : MaskType;
	var SecMask_$_663 : MaskType;
	var SecMask_$_664 : MaskType;
	var SecMask_$_665 : MaskType;
	var SecMask_$_666 : MaskType;
	var SecMask_$_667 : MaskType;
	var SecMask_$_668 : MaskType;
	var SecMask_$_669 : MaskType;
	var SecMask_$_670 : MaskType;
	var SecMask_$_671 : MaskType;
	var SecMask_$_672 : MaskType;
	var SecMask_$_673 : MaskType;
	var SecMask_$_674 : MaskType;
	var SecMask_$_675 : MaskType;
	var SecMask_$_676 : MaskType;
	var SecMask_$_677 : MaskType;
	var SecMask_$_678 : MaskType;
	var SecMask_$_679 : MaskType;
	var SecMask_$_680 : MaskType;
	var SecMask_$_681 : MaskType;
	var SecMask_$_682 : MaskType;
	var SecMask_$_683 : MaskType;
	var SecMask_$_684 : MaskType;
	var SecMask_$_685 : MaskType;
	var SecMask_$_686 : MaskType;
	var SecMask_$_687 : MaskType;
	var SecMask_$_688 : MaskType;
	var SecMask_$_689 : MaskType;
	var SecMask_$_690 : MaskType;
	var SecMask_$_691 : MaskType;
	var SecMask_$_692 : MaskType;
	var SecMask_$_693 : MaskType;
	var SecMask_$_694 : MaskType;
	var SecMask_$_695 : MaskType;
	var SecMask_$_696 : MaskType;
	var SecMask_$_697 : MaskType;
	var SecMask_$_698 : MaskType;
	var SecMask_$_699 : MaskType;
	var SecMask_$_700 : MaskType;
	var SecMask_$_701 : MaskType;
	var SecMask_$_702 : MaskType;
	var SecMask_$_703 : MaskType;
	var SecMask_$_704 : MaskType;
	var SecMask_$_705 : MaskType;
	var SecMask_$_706 : MaskType;
	var SecMask_$_707 : MaskType;
	var SecMask_$_708 : MaskType;
	var exhaleMask#_1857_$_11 : MaskType;
	var exhaleMask#_1857_$_12 : MaskType;
	var exhaleMask#_1857_$_13 : MaskType;
	var exhaleMask#_1857_$_14 : MaskType;
	var exhaleMask#_1857_$_15 : MaskType;
	var exhaleMask#_1857_$_16 : MaskType;
	var exhaleMask#_1857_$_17 : MaskType;
	var r#548_$_0 : ref;
	var Mask_$_24 : MaskType;
	var Mask_$_25 : MaskType;
	var Mask_$_26 : MaskType;
	var Mask_$_27 : MaskType;
	var Mask_$_28 : MaskType;
	var Heap_$_0 : HeapType;
	var SecMask_$_709 : MaskType;
	var r#63_$_0 : ref;
	var exhaleHeap#_2089_$_0 : HeapType;
	var exhaleMask#_2090_$_0 : MaskType;
	var SecMask_$_710 : MaskType;
	var SecMask_$_711 : MaskType;
	var SecMask_$_712 : MaskType;
	var SecMask_$_713 : MaskType;
	var SecMask_$_714 : MaskType;
	var SecMask_$_715 : MaskType;
	var SecMask_$_716 : MaskType;
	var SecMask_$_717 : MaskType;
	var SecMask_$_718 : MaskType;
	var SecMask_$_719 : MaskType;
	var SecMask_$_720 : MaskType;
	var SecMask_$_721 : MaskType;
	var SecMask_$_722 : MaskType;
	var SecMask_$_723 : MaskType;
	var SecMask_$_724 : MaskType;
	var SecMask_$_725 : MaskType;
	var SecMask_$_726 : MaskType;
	var SecMask_$_727 : MaskType;
	var SecMask_$_728 : MaskType;
	var SecMask_$_729 : MaskType;
	var SecMask_$_730 : MaskType;
	var SecMask_$_731 : MaskType;
	var SecMask_$_732 : MaskType;
	var SecMask_$_733 : MaskType;
	var SecMask_$_734 : MaskType;
	var SecMask_$_735 : MaskType;
	var SecMask_$_736 : MaskType;
	var SecMask_$_737 : MaskType;
	var SecMask_$_738 : MaskType;
	var SecMask_$_739 : MaskType;
	var SecMask_$_740 : MaskType;
	var SecMask_$_741 : MaskType;
	var SecMask_$_742 : MaskType;
	var SecMask_$_743 : MaskType;
	var SecMask_$_744 : MaskType;
	var SecMask_$_745 : MaskType;
	var SecMask_$_746 : MaskType;
	var SecMask_$_747 : MaskType;
	var SecMask_$_748 : MaskType;
	var SecMask_$_749 : MaskType;
	var SecMask_$_750 : MaskType;
	var SecMask_$_751 : MaskType;
	var SecMask_$_752 : MaskType;
	var SecMask_$_753 : MaskType;
	var SecMask_$_754 : MaskType;
	var SecMask_$_755 : MaskType;
	var SecMask_$_756 : MaskType;
	var SecMask_$_757 : MaskType;
	var SecMask_$_758 : MaskType;
	var SecMask_$_759 : MaskType;
	var SecMask_$_760 : MaskType;
	var SecMask_$_761 : MaskType;
	var SecMask_$_762 : MaskType;
	var SecMask_$_763 : MaskType;
	var SecMask_$_764 : MaskType;
	var SecMask_$_765 : MaskType;
	var SecMask_$_766 : MaskType;
	var SecMask_$_767 : MaskType;
	var SecMask_$_768 : MaskType;
	var SecMask_$_769 : MaskType;
	var SecMask_$_770 : MaskType;
	var SecMask_$_771 : MaskType;
	var SecMask_$_772 : MaskType;
	var SecMask_$_773 : MaskType;
	var SecMask_$_774 : MaskType;
	var SecMask_$_775 : MaskType;
	var SecMask_$_776 : MaskType;
	var SecMask_$_777 : MaskType;
	var SecMask_$_778 : MaskType;
	var SecMask_$_779 : MaskType;
	var SecMask_$_780 : MaskType;
	var SecMask_$_781 : MaskType;
	var SecMask_$_782 : MaskType;
	var SecMask_$_783 : MaskType;
	var SecMask_$_784 : MaskType;
	var SecMask_$_785 : MaskType;
	var SecMask_$_786 : MaskType;
	var SecMask_$_787 : MaskType;
	var SecMask_$_788 : MaskType;
	var SecMask_$_789 : MaskType;
	var SecMask_$_790 : MaskType;
	var SecMask_$_791 : MaskType;
	var SecMask_$_792 : MaskType;
	var SecMask_$_793 : MaskType;
	var SecMask_$_794 : MaskType;
	var SecMask_$_795 : MaskType;
	var SecMask_$_796 : MaskType;
	var SecMask_$_797 : MaskType;
	var SecMask_$_798 : MaskType;
	var SecMask_$_799 : MaskType;
	var SecMask_$_800 : MaskType;
	var SecMask_$_801 : MaskType;
	var SecMask_$_802 : MaskType;
	var SecMask_$_803 : MaskType;
	var SecMask_$_804 : MaskType;
	var SecMask_$_805 : MaskType;
	var SecMask_$_806 : MaskType;
	var SecMask_$_807 : MaskType;
	var SecMask_$_808 : MaskType;
	var SecMask_$_809 : MaskType;
	var SecMask_$_810 : MaskType;
	var SecMask_$_811 : MaskType;
	var SecMask_$_812 : MaskType;
	var SecMask_$_813 : MaskType;
	var SecMask_$_814 : MaskType;
	var SecMask_$_815 : MaskType;
	var SecMask_$_816 : MaskType;
	var SecMask_$_817 : MaskType;
	var SecMask_$_818 : MaskType;
	var SecMask_$_819 : MaskType;
	var SecMask_$_820 : MaskType;
	var SecMask_$_821 : MaskType;
	var SecMask_$_822 : MaskType;
	var SecMask_$_823 : MaskType;
	var SecMask_$_824 : MaskType;
	var SecMask_$_825 : MaskType;
	var SecMask_$_826 : MaskType;
	var SecMask_$_827 : MaskType;
	var SecMask_$_828 : MaskType;
	var SecMask_$_829 : MaskType;
	var SecMask_$_830 : MaskType;
	var SecMask_$_831 : MaskType;
	var SecMask_$_832 : MaskType;
	var SecMask_$_833 : MaskType;
	var SecMask_$_834 : MaskType;
	var SecMask_$_835 : MaskType;
	var SecMask_$_836 : MaskType;
	var SecMask_$_837 : MaskType;
	var SecMask_$_838 : MaskType;
	var SecMask_$_839 : MaskType;
	var SecMask_$_840 : MaskType;
	var SecMask_$_841 : MaskType;
	var SecMask_$_842 : MaskType;
	var SecMask_$_843 : MaskType;
	var SecMask_$_844 : MaskType;
	var SecMask_$_845 : MaskType;
	var SecMask_$_846 : MaskType;
	var SecMask_$_847 : MaskType;
	var SecMask_$_848 : MaskType;
	var SecMask_$_849 : MaskType;
	var SecMask_$_850 : MaskType;
	var SecMask_$_851 : MaskType;
	var SecMask_$_852 : MaskType;
	var SecMask_$_853 : MaskType;
	var SecMask_$_854 : MaskType;
	var SecMask_$_855 : MaskType;
	var SecMask_$_856 : MaskType;
	var SecMask_$_857 : MaskType;
	var SecMask_$_858 : MaskType;
	var SecMask_$_859 : MaskType;
	var SecMask_$_860 : MaskType;
	var SecMask_$_861 : MaskType;
	var SecMask_$_862 : MaskType;
	var exhaleMask#_2090_$_1 : MaskType;
	var exhaleMask#_2090_$_2 : MaskType;
	var exhaleMask#_2090_$_3 : MaskType;
	var $_$_condition : bool;
	var $_$_condition_$0 : bool;
	var $_$_condition_$2 : bool;
	var $_$_condition_$4 : bool;
	var $_$_condition_$6 : bool;
	var $_$_condition_$8 : bool;
	var $_$_condition_$9 : bool;
	var $_$_condition_$10 : bool;
	var $_$_condition_$11 : bool;
	var $_$_condition_$13 : bool;
	var $_$_condition_$15 : bool;
	var $_$_condition_$17 : bool;
	var $_$_condition_$19 : bool;
	var $_$_condition_$21 : bool;
	var $_$_condition_$23 : bool;
	var $_$_condition_$25 : bool;
	var $_$_condition_$27 : bool;
	var $_$_condition_$29 : bool;
	var $_$_condition_$31 : bool;
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
	var $_$_condition_$70 : bool;
	var $_$_condition_$71 : bool;
	var $_$_condition_$73 : bool;
	var $_$_condition_$75 : bool;
	var $_$_condition_$77 : bool;
	var $_$_condition_$79 : bool;
	var $_$_condition_$81 : bool;
	var $_$_condition_$83 : bool;
	var $_$_condition_$85 : bool;
	var $_$_condition_$87 : bool;
	var $_$_condition_$89 : bool;
	var $_$_condition_$91 : bool;
	var $_$_condition_$93 : bool;
	var $_$_condition_$94 : bool;
	var $_$_condition_$95 : bool;
	var $_$_condition_$96 : bool;
	var $_$_condition_$97 : bool;
	var $_$_condition_$98 : bool;
	var $_$_condition_$100 : bool;
	var $_$_condition_$101 : bool;
	var $_$_condition_$103 : bool;
	var $_$_condition_$104 : bool;
	var $_$_condition_$105 : bool;
	var $_$_condition_$107 : bool;
	var $_$_condition_$109 : bool;
	var $_$_condition_$111 : bool;
	var $_$_condition_$113 : bool;
	var $_$_condition_$115 : bool;
	var $_$_condition_$116 : bool;
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
	var $_$_condition_$134 : bool;
	var $_$_condition_$135 : bool;
	var $_$_condition_$136 : bool;
	var $_$_condition_$137 : bool;
	var $_$_condition_$138 : bool;
	var $_$_condition_$140 : bool;
	var $_$_condition_$141 : bool;
	var $_$_condition_$142 : bool;
	var $_$_condition_$143 : bool;
	var $_$_condition_$145 : bool;
	var $_$_condition_$148 : bool;
	var $_$_condition_$150 : bool;
	var $_$_condition_$151 : bool;
	var $_$_condition_$152 : bool;
	var $_$_condition_$155 : bool;
	var $_$_condition_$156 : bool;
	var $_$_condition_$157 : bool;
	var $_$_condition_$158 : bool;
	var $_$_condition_$160 : bool;
	var $_$_condition_$161 : bool;
	var $_$_condition_$162 : bool;
	var $_$_condition_$164 : bool;
	var $_$_condition_$165 : bool;
	var $_$_condition_$166 : bool;
	var $_$_condition_$167 : bool;
	var $_$_condition_$169 : bool;
	var $_$_condition_$170 : bool;
	var $_$_condition_$171 : bool;
	var $_$_condition_$173 : bool;
	var $_$_condition_$174 : bool;
	var $_$_condition_$175 : bool;
	var $_$_condition_$177 : bool;
	var $_$_condition_$179 : bool;
	var $_$_condition_$180 : bool;
	var $_$_condition_$181 : bool;
	var $_$_condition_$183 : bool;
	var $_$_condition_$186 : bool;
	var $_$_condition_$188 : bool;
	var $_$_condition_$189 : bool;
	var $_$_condition_$190 : bool;
	var $_$_condition_$192 : bool;
	var $_$_condition_$195 : bool;
	var $_$_condition_$197 : bool;
	var $_$_condition_$198 : bool;
	var $_$_condition_$199 : bool;
	var $_$_condition_$201 : bool;
	var $_$_condition_$204 : bool;
	var $_$_condition_$206 : bool;
	var $_$_condition_$207 : bool;
	var $_$_condition_$208 : bool;
	var $_$_condition_$211 : bool;
	var $_$_condition_$212 : bool;
	var $_$_condition_$213 : bool;
	var $_$_condition_$214 : bool;
	var $_$_condition_$215 : bool;
	var $_$_condition_$218 : bool;
	var $_$_condition_$220 : bool;
	var $_$_condition_$221 : bool;
	var $_$_condition_$222 : bool;
	var $_$_condition_$224 : bool;
	var $_$_condition_$227 : bool;
	var $_$_condition_$228 : bool;
	var $_$_condition_$229 : bool;
	var $_$_condition_$231 : bool;
	var $_$_condition_$232 : bool;
	var $_$_condition_$233 : bool;
	var $_$_condition_$234 : bool;
	var $_$_condition_$236 : bool;
	var $_$_condition_$237 : bool;
	var $_$_condition_$238 : bool;
	var $_$_condition_$240 : bool;
	var $_$_condition_$241 : bool;
	var $_$_condition_$242 : bool;
	var $_$_condition_$243 : bool;
	var $_$_condition_$245 : bool;
	var $_$_condition_$246 : bool;
	var $_$_condition_$247 : bool;
	var $_$_condition_$248 : bool;
	var $_$_condition_$250 : bool;
	var $_$_condition_$251 : bool;
	var $_$_condition_$252 : bool;
	var $_$_condition_$253 : bool;
	var $_$_condition_$254 : bool;
	var $_$_condition_$257 : bool;
	var $_$_condition_$259 : bool;
	var $_$_condition_$260 : bool;
	var $_$_condition_$261 : bool;
	var $_$_condition_$263 : bool;
	var $_$_condition_$266 : bool;
	var $_$_condition_$267 : bool;
	var $_$_condition_$268 : bool;
	var $_$_condition_$270 : bool;
	var $_$_condition_$271 : bool;
	var $_$_condition_$272 : bool;
	var $_$_condition_$273 : bool;
	var $_$_condition_$275 : bool;
	var $_$_condition_$276 : bool;
	var $_$_condition_$277 : bool;
	var $_$_condition_$279 : bool;
	var $_$_condition_$280 : bool;
	var $_$_condition_$281 : bool;
	var $_$_condition_$282 : bool;
	var $_$_condition_$284 : bool;
	var $_$_condition_$285 : bool;
	var $_$_condition_$286 : bool;
	var $_$_condition_$287 : bool;
	var $_$_condition_$289 : bool;
	var $_$_condition_$290 : bool;
	var $_$_condition_$291 : bool;
	var $_$_condition_$292 : bool;
	var $_$_condition_$294 : bool;
	var $_$_condition_$297 : bool;
	var $_$_condition_$299 : bool;
	var $_$_condition_$300 : bool;
	var $_$_condition_$301 : bool;
	var $_$_condition_$303 : bool;
	var $_$_condition_$306 : bool;
	var $_$_condition_$308 : bool;
	var $_$_condition_$309 : bool;
	var $_$_condition_$310 : bool;
	var $_$_condition_$312 : bool;
	var $_$_condition_$315 : bool;
	var $_$_condition_$317 : bool;
	var $_$_condition_$318 : bool;
	var $_$_condition_$319 : bool;
	var $_$_condition_$321 : bool;
	var $_$_condition_$324 : bool;
	var $_$_condition_$325 : bool;
	var $_$_condition_$326 : bool;
	var $_$_condition_$328 : bool;
	var $_$_condition_$329 : bool;
	var $_$_condition_$330 : bool;
	var $_$_condition_$331 : bool;
	var $_$_condition_$332 : bool;
	var $_$_condition_$333 : bool;
	var $_$_condition_$336 : bool;
	var $_$_condition_$338 : bool;
	var $_$_condition_$339 : bool;
	var $_$_condition_$341 : bool;
	var $_$_condition_$343 : bool;
	var $_$_condition_$345 : bool;
	var $_$_condition_$346 : bool;
	var $_$_condition_$347 : bool;
	var $_$_condition_$349 : bool;
	var $_$_condition_$350 : bool;
	var $_$_condition_$351 : bool;
	var $_$_condition_$352 : bool;
	var $_$_condition_$354 : bool;
	var $_$_condition_$355 : bool;
	var $_$_condition_$356 : bool;
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
	var $_$_condition_$369 : bool;
	var $_$_condition_$370 : bool;
	var $_$_condition_$372 : bool;
	var $_$_condition_$374 : bool;
	var $_$_condition_$376 : bool;
	var $_$_condition_$378 : bool;
	var $_$_condition_$380 : bool;
	var $_$_condition_$382 : bool;
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
	var $_$_condition_$405 : bool;
	var $_$_condition_$407 : bool;
	var $_$_condition_$408 : bool;
	var $_$_condition_$409 : bool;
	var $_$_condition_$411 : bool;
	var $_$_condition_$414 : bool;
	var $_$_condition_$416 : bool;
	var $_$_condition_$417 : bool;
	var $_$_condition_$418 : bool;
	var $_$_condition_$420 : bool;
	var $_$_condition_$421 : bool;
	var $_$_condition_$422 : bool;
	var $_$_condition_$424 : bool;
	var $_$_condition_$425 : bool;
	var $_$_condition_$426 : bool;
	var $_$_condition_$427 : bool;
	var $_$_condition_$429 : bool;
	var $_$_condition_$430 : bool;
	var $_$_condition_$431 : bool;
	var $_$_condition_$433 : bool;
	var $_$_condition_$434 : bool;
	var $_$_condition_$435 : bool;
	var $_$_condition_$436 : bool;
	var $_$_condition_$438 : bool;
	var $_$_condition_$439 : bool;
	var $_$_condition_$440 : bool;
	var $_$_condition_$442 : bool;
	var $_$_condition_$443 : bool;
	var $_$_condition_$446 : bool;
	var $_$_condition_$447 : bool;
	var $_$_condition_$448 : bool;
	var $_$_condition_$449 : bool;
	var $_$_condition_$452 : bool;
	var $_$_condition_$453 : bool;
	var $_$_condition_$454 : bool;
	var $_$_condition_$455 : bool;
	var $_$_condition_$458 : bool;
	var $_$_condition_$459 : bool;
	var $_$_condition_$460 : bool;
	var $_$_condition_$461 : bool;
	var $_$_condition_$464 : bool;
	var $_$_condition_$465 : bool;
	var $_$_condition_$466 : bool;
	var $_$_condition_$467 : bool;
	var $_$_condition_$468 : bool;
	var $_$_condition_$470 : bool;
	var $_$_condition_$471 : bool;
	var $_$_condition_$472 : bool;
	var $_$_condition_$473 : bool;
	var $_$_condition_$475 : bool;
	var $_$_condition_$478 : bool;
	var $_$_condition_$480 : bool;
	var $_$_condition_$481 : bool;
	var $_$_condition_$483 : bool;
	var $_$_condition_$485 : bool;
	var $_$_condition_$486 : bool;
	var $_$_condition_$487 : bool;
	var $_$_condition_$488 : bool;
	var $_$_condition_$490 : bool;
	var $_$_condition_$491 : bool;
	var $_$_condition_$492 : bool;
	var $_$_condition_$494 : bool;
	var $_$_condition_$495 : bool;
	var $_$_condition_$496 : bool;
	var $_$_condition_$497 : bool;
	var $_$_condition_$499 : bool;
	var $_$_condition_$500 : bool;
	var $_$_condition_$501 : bool;
	var $_$_condition_$502 : bool;
	var $_$_condition_$503 : bool;
	var $_$_condition_$504 : bool;
	var $_$_condition_$505 : bool;
	var $_$_condition_$507 : bool;
	var $_$_condition_$509 : bool;
	var $_$_condition_$510 : bool;
	var $_$_condition_$511 : bool;
	var $_$_condition_$513 : bool;
	var $_$_condition_$516 : bool;
	var $_$_condition_$518 : bool;
	var $_$_condition_$519 : bool;
	var $_$_condition_$520 : bool;
	var $_$_condition_$522 : bool;
	var $_$_condition_$523 : bool;
	var $_$_condition_$524 : bool;
	var $_$_condition_$526 : bool;
	var $_$_condition_$527 : bool;
	var $_$_condition_$528 : bool;
	var $_$_condition_$529 : bool;
	var $_$_condition_$531 : bool;
	var $_$_condition_$532 : bool;
	var $_$_condition_$533 : bool;
	var $_$_condition_$535 : bool;
	var $_$_condition_$536 : bool;
	var $_$_condition_$537 : bool;
	var $_$_condition_$538 : bool;
	var $_$_condition_$540 : bool;
	var $_$_condition_$541 : bool;
	var $_$_condition_$542 : bool;
	var $_$_condition_$544 : bool;
	var $_$_condition_$545 : bool;
	var $_$_condition_$548 : bool;
	var $_$_condition_$549 : bool;
	var $_$_condition_$550 : bool;
	var $_$_condition_$551 : bool;
	var $_$_condition_$554 : bool;
	var $_$_condition_$555 : bool;
	var $_$_condition_$556 : bool;
	var $_$_condition_$557 : bool;
	var $_$_condition_$560 : bool;
	var $_$_condition_$561 : bool;
	var $_$_condition_$562 : bool;
	var $_$_condition_$565 : bool;
	var $_$_condition_$566 : bool;
	var $_$_condition_$567 : bool;
	var $_$_condition_$569 : bool;
	var $_$_condition_$570 : bool;
	var $_$_condition_$571 : bool;
	var $_$_condition_$572 : bool;
	var $_$_condition_$573 : bool;
	var $_$_condition_$574 : bool;
	var $_$_condition_$575 : bool;
	var $_$_condition_$578 : bool;
	var $_$_condition_$580 : bool;
	var $_$_condition_$581 : bool;
	var $_$_condition_$583 : bool;
	var $_$_condition_$585 : bool;
	var $_$_condition_$587 : bool;
	var $_$_condition_$588 : bool;
	var $_$_condition_$589 : bool;
	var $_$_condition_$591 : bool;
	var $_$_condition_$592 : bool;
	var $_$_condition_$593 : bool;
	var $_$_condition_$594 : bool;
	var $_$_condition_$596 : bool;
	var $_$_condition_$597 : bool;
	var $_$_condition_$598 : bool;
	var $_$_condition_$600 : bool;
	var $_$_condition_$602 : bool;
	var $_$_condition_$603 : bool;
	var $_$_condition_$604 : bool;
	var $_$_condition_$606 : bool;
	var $_$_condition_$608 : bool;
	var $_$_condition_$609 : bool;
	var $_$_condition_$610 : bool;
	var $_$_condition_$612 : bool;
	var $_$_condition_$614 : bool;
	var $_$_condition_$616 : bool;
	var $_$_condition_$618 : bool;
	var $_$_condition_$619 : bool;
	var $_$_condition_$620 : bool;
	var $_$_condition_$621 : bool;
	var $_$_condition_$622 : bool;
	var $_$_condition_$623 : bool;
	var $_$_condition_$624 : bool;
	var $_$_condition_$625 : bool;
	var $_$_condition_$626 : bool;
	var $_$_condition_$628 : bool;
	var $_$_condition_$629 : bool;
	var $_$_condition_$631 : bool;
	var $_$_condition_$632 : bool;
	var $_$_condition_$634 : bool;
	var $_$_condition_$635 : bool;
	var $_$_condition_$637 : bool;
	var $_$_condition_$638 : bool;
	var $_$_condition_$640 : bool;
	var $_$_condition_$641 : bool;
	var $_$_condition_$643 : bool;
	var $_$_condition_$644 : bool;
	var $_$_condition_$646 : bool;
	var $_$_condition_$648 : bool;
	var $_$_condition_$649 : bool;
	var $_$_condition_$651 : bool;
	var $_$_condition_$652 : bool;
	var $_$_condition_$654 : bool;
	var $_$_condition_$655 : bool;
	var $_$_condition_$657 : bool;
	var $_$_condition_$658 : bool;
	var $_$_condition_$659 : bool;
	var $_$_condition_$660 : bool;
	var $_$_condition_$661 : bool;
	var $_$_condition_$663 : bool;
	var $_$_condition_$665 : bool;
	var $_$_condition_$667 : bool;
	var $_$_condition_$669 : bool;
	var $_$_condition_$670 : bool;
	var $_$_condition_$671 : bool;
	var $_$_condition_$672 : bool;
	var $_$_condition_$673 : bool;
	var $_$_condition_$674 : bool;
	var $_$_condition_$675 : bool;
	var $_$_condition_$676 : bool;
	var $_$_condition_$677 : bool;
	var $_$_condition_$679 : bool;
	var $_$_condition_$680 : bool;
	var $_$_condition_$682 : bool;
	var $_$_condition_$683 : bool;
	var $_$_condition_$685 : bool;
	var $_$_condition_$686 : bool;
	var $_$_condition_$688 : bool;
	var $_$_condition_$689 : bool;
	var $_$_condition_$691 : bool;
	var $_$_condition_$692 : bool;
	var $_$_condition_$694 : bool;
	var $_$_condition_$695 : bool;
	var $_$_condition_$697 : bool;
	var $_$_condition_$699 : bool;
	var $_$_condition_$700 : bool;
	var $_$_condition_$702 : bool;
	var $_$_condition_$703 : bool;
	var $_$_condition_$705 : bool;
	var $_$_condition_$708 : bool;
	var $_$_condition_$710 : bool;
	var $_$_condition_$712 : bool;
	var $_$_condition_$713 : bool;
	var $_$_condition_$714 : bool;
	var $_$_condition_$715 : bool;
	var $_$_condition_$717 : bool;
	var $_$_condition_$719 : bool;
	var $_$_condition_$721 : bool;
	var $_$_condition_$723 : bool;
	var $_$_condition_$724 : bool;
	var $_$_condition_$725 : bool;
	var $_$_condition_$726 : bool;
	var $_$_condition_$727 : bool;
	var $_$_condition_$728 : bool;
	var $_$_condition_$729 : bool;
	var $_$_condition_$730 : bool;
	var $_$_condition_$731 : bool;
	var $_$_condition_$732 : bool;
	var $_$_condition_$733 : bool;
	var $_$_condition_$734 : bool;
	var $_$_condition_$736 : bool;
	var $_$_condition_$738 : bool;
	var $_$_condition_$740 : bool;
	var $_$_condition_$742 : bool;
	var $_$_condition_$743 : bool;
	var $_$_condition_$744 : bool;
	var $_$_condition_$745 : bool;
	var $_$_condition_$746 : bool;
	var $_$_condition_$747 : bool;
	var $_$_condition_$748 : bool;
	var $_$_condition_$749 : bool;
	var $_$_condition_$750 : bool;
	var $_$_condition_$752 : bool;
	var $_$_condition_$753 : bool;
	var $_$_condition_$755 : bool;
	var $_$_condition_$756 : bool;
	var $_$_condition_$758 : bool;
	var $_$_condition_$759 : bool;
	var $_$_condition_$761 : bool;
	var $_$_condition_$762 : bool;
	var $_$_condition_$764 : bool;
	var $_$_condition_$765 : bool;
	var $_$_condition_$767 : bool;
	var $_$_condition_$768 : bool;
	var $_$_condition_$770 : bool;
	var $_$_condition_$772 : bool;
	var $_$_condition_$773 : bool;
	var $_$_condition_$775 : bool;
	var $_$_condition_$776 : bool;
	var $_$_condition_$778 : bool;
	var $_$_condition_$779 : bool;
	var $_$_condition_$781 : bool;
	var $_$_condition_$782 : bool;
	var $_$_condition_$783 : bool;
	var $_$_condition_$784 : bool;
	var $_$_condition_$785 : bool;
	var $_$_condition_$787 : bool;
	var $_$_condition_$789 : bool;
	var $_$_condition_$791 : bool;
	var $_$_condition_$793 : bool;
	var $_$_condition_$794 : bool;
	var $_$_condition_$795 : bool;
	var $_$_condition_$796 : bool;
	var $_$_condition_$797 : bool;
	var $_$_condition_$798 : bool;
	var $_$_condition_$799 : bool;
	var $_$_condition_$800 : bool;
	var $_$_condition_$801 : bool;
	var $_$_condition_$803 : bool;
	var $_$_condition_$804 : bool;
	var $_$_condition_$806 : bool;
	var $_$_condition_$807 : bool;
	var $_$_condition_$809 : bool;
	var $_$_condition_$810 : bool;
	var $_$_condition_$812 : bool;
	var $_$_condition_$813 : bool;
	var $_$_condition_$815 : bool;
	var $_$_condition_$816 : bool;
	var $_$_condition_$818 : bool;
	var $_$_condition_$819 : bool;
	var $_$_condition_$821 : bool;
	var $_$_condition_$823 : bool;
	var $_$_condition_$824 : bool;
	var $_$_condition_$826 : bool;
	var $_$_condition_$827 : bool;
	var $_$_condition_$829 : bool;
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
	assume (r#63 == null) || (dtype(r#63) == AVLTreeNode#t);
	assume true;
	assume (this#521 == null) || (dtype(this#521) == AVLTreeNode#t);
	assume true;
	assume (this#547 == null) || (dtype(this#547) == AVLTreeNode#t);
	assume (r#548 == null) || (dtype(r#548) == AVLTreeNode#t);
	assume (this#577 == null) || (dtype(this#577) == AVLTreeNode#t);
	assume (r#578 == null) || (dtype(r#578) == AVLTreeNode#t);
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_1751) && ((1000 * methodK#_1751) < Fractions(1));
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
	assume (forall  k#94#519 : Integer :: ( ((0 <= k#94#519) && (k#94#519 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],k#94#519) < Heap[this,AVLTreeNode.key]) ));
	if ($_$_condition) { goto anon1221_Then; } else { goto anon1221_Else; }
anon1221_Then:
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
anon1221_Else:
	assume !$_$_condition;
	assume $_$_condition <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_11 == Mask_$_9;
	goto $branchMerge_0;
anon1222_Then:
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
anon1222_Else:
	assume !$_$_condition_$0;
	assume $_$_condition_$0 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_13 == Mask_$_11;
	goto $branchMerge_1;
anon1223_Then:
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
anon1223_Else:
	assume !$_$_condition_$2;
	assume $_$_condition_$2 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_15 == Mask_$_13;
	goto $branchMerge_2;
anon1224_Then:
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
anon1224_Else:
	assume !$_$_condition_$4;
	assume $_$_condition_$4 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_17 == Mask_$_15;
	goto $branchMerge_3;
anon1225_Then:
	assume $_$_condition_$6;
	assume $_$_condition_$6 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume (forall  k#95#520 : Integer :: ( ((0 <= k#95#520) && (k#95#520 < Seq#Length(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[this,AVLTreeNode.key] < Seq#Index(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys],k#95#520)) ));
	goto anon10;
anon1225_Else:
	assume !$_$_condition_$6;
	assume $_$_condition_$6 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	goto anon10;
anon10:
	assume (Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height] - ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height])) == 2;
	assume IsGoodMask(Mask_$_17);
	assume wf(Heap,Mask_$_17,ZeroMask);
	assume Heap == Heap;
	assume Mask_$_17 == Mask;
	assume ZeroMask == SecMask;
	assume ZeroCredits == Credits;
	assume ((0 < methodCallK#_1756) && ((1000 * methodCallK#_1756) < Fractions(1))) && ((1000 * methodCallK#_1756) < methodK#_1751);
	assume wf(Heap,Mask_$_17,ZeroMask);
	assert { :msg "  633.15: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  633.15: Location might not be readable." } true ==> CanRead(Mask_$_17,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  633.3: The target of the method call might be null." } !(Heap[this,AVLTreeNode.left] == null);
	assume this#521_$_0 == Heap[this,AVLTreeNode.left];
	assert { :msg "  633.3: The precondition at 489.12 might not hold. The permission at 489.12 might not be positive." } methodCallK#_1756 > 0;
	assert { :msg "  633.3: The precondition at 489.12 might not hold. Insufficient fraction at 489.12 for AVLTreeNode.balanceFactor." } Mask_$_17[this#521_$_0,AVLTreeNode.balanceFactor][perm$R] > 0;
	assume methodCallK#_1756 < Mask_$_17[this#521_$_0,AVLTreeNode.balanceFactor][perm$R];
	assume exhaleMask#_1758_$_0 == Mask_$_17[this#521_$_0,AVLTreeNode.balanceFactor := Mask_$_17[this#521_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_17[this#521_$_0,AVLTreeNode.balanceFactor][perm$R] - methodCallK#_1756]];
	assume IsGoodMask(exhaleMask#_1758_$_0);
	assume wf(Heap,exhaleMask#_1758_$_0,ZeroMask);
	assume wf(Heap,Mask_$_17,ZeroMask);
	assert { :msg "  633.3: The precondition at 488.12 might not hold. The permission at 488.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  633.3: The precondition at 488.12 might not hold. Insufficient fraction at 488.12 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1758_$_0[this#521_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1758_$_0[this#521_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1758_$_0[this#521_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1758_$_1 == exhaleMask#_1758_$_0[this#521_$_0,AVLTreeNode.valid := exhaleMask#_1758_$_0[this#521_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_1758_$_0[this#521_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$8) { goto anon1226_Then; } else { goto anon1226_Else; }
anon1226_Then:
	assume $_$_condition_$8;
	assume $_$_condition_$8 <==> (!CanRead(exhaleMask#_1758_$_1,ZeroMask,this#521_$_0,AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_1758_$_1,ZeroMask,this#521_$_0,AVLTreeNode.valid);
	assume Heap[this#521_$_0,AVLTreeNode.valid] < exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.valid];
	goto anon12;
anon1226_Else:
	assume !$_$_condition_$8;
	assume $_$_condition_$8 <==> (!CanRead(exhaleMask#_1758_$_1,ZeroMask,this#521_$_0,AVLTreeNode.valid));
	assume CanRead(exhaleMask#_1758_$_1,ZeroMask,this#521_$_0,AVLTreeNode.valid);
	goto anon12;
anon12:
	assume IsGoodMask(exhaleMask#_1758_$_1);
	assume wf(Heap,exhaleMask#_1758_$_1,ZeroMask);
	assume wf(Heap,Mask_$_17,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_1757_$_0,Heap,exhaleMask#_1758_$_1,ZeroMask);
	assume IsGoodMask(exhaleMask#_1758_$_1);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1758_$_1,ZeroMask);
	assume true;
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1758_$_1,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_18 == exhaleMask#_1758_$_1[this#521_$_0,AVLTreeNode.valid := exhaleMask#_1758_$_1[this#521_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_1758_$_1[this#521_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_18);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_18,ZeroMask);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_18,ZeroMask);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_18,ZeroMask);
	assume true;
	assume methodCallK#_1756 > 0;
	assume Mask_$_19 == Mask_$_18[this#521_$_0,AVLTreeNode.balanceFactor := Mask_$_18[this#521_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_18[this#521_$_0,AVLTreeNode.balanceFactor][perm$R] + methodCallK#_1756]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,ZeroMask);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,ZeroMask);
	assume bf#522_$_0 == exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor];
	assume #AVLTreeNode.valid#trigger(this#521_$_0);
	assume predVer#_1764_$_0 == exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.valid];
	if ($_$_condition_$9) { goto anon1227_Then; } else { goto anon1227_Else; }
anon1227_Then:
	assume $_$_condition_$9;
	assume $_$_condition_$9 <==> false;
	assume false;
	goto $exit;
anon1227_Else:
	assume !$_$_condition_$9;
	assume $_$_condition_$9 <==> false;
	assume !false;
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume SecMask_$_0 == ZeroMask[this#521_$_0,AVLTreeNode.key := ZeroMask[this#521_$_0,AVLTreeNode.key][perm$R := ZeroMask[this#521_$_0,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_0);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_0);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_0);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_1 == SecMask_$_0[this#521_$_0,AVLTreeNode.height := SecMask_$_0[this#521_$_0,AVLTreeNode.height][perm$R := SecMask_$_0[this#521_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_1);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_1);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_1);
	assume (exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null) || (dtype(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume SecMask_$_2 == SecMask_$_1[this#521_$_0,AVLTreeNode.left := SecMask_$_1[this#521_$_0,AVLTreeNode.left][perm$R := SecMask_$_1[this#521_$_0,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_2);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_2);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_2);
	assume (exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null) || (dtype(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume SecMask_$_3 == SecMask_$_2[this#521_$_0,AVLTreeNode.right := SecMask_$_2[this#521_$_0,AVLTreeNode.right][perm$R := SecMask_$_2[this#521_$_0,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_3);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_3);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_3);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_4 == SecMask_$_3[this#521_$_0,AVLTreeNode.keys := SecMask_$_3[this#521_$_0,AVLTreeNode.keys][perm$R := SecMask_$_3[this#521_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_4);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_4);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_4);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_5 == SecMask_$_4[this#521_$_0,AVLTreeNode.balanceFactor := SecMask_$_4[this#521_$_0,AVLTreeNode.balanceFactor][perm$R := SecMask_$_4[this#521_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_5);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_5);
	if ($_$_condition_$10) { goto anon1254_Then; } else { goto anon1254_Else; }
anon1254_Then:
	assume $_$_condition_$10;
	assume $_$_condition_$10 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_5);
	assume Fractions(100) > 0;
	assume SecMask_$_6 == SecMask_$_5[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_5[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_5[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_6);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_6);
	assume SecMask_$_7 == SecMask_$_6;
	goto $branchMerge_4;
anon1254_Else:
	assume !$_$_condition_$10;
	assume $_$_condition_$10 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_7 == SecMask_$_5;
	goto $branchMerge_4;
anon1255_Then:
	assume $_$_condition_$11;
	assume $_$_condition_$11 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_7);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_8 == SecMask_$_7[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_7[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_7[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_8);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_8);
	assume SecMask_$_9 == SecMask_$_8;
	goto $branchMerge_5;
anon1255_Else:
	assume !$_$_condition_$11;
	assume $_$_condition_$11 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_9 == SecMask_$_7;
	goto $branchMerge_5;
anon1256_Then:
	assume $_$_condition_$13;
	assume $_$_condition_$13 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_9);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_10 == SecMask_$_9[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_9[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_9[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_10);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_10);
	assume SecMask_$_11 == SecMask_$_10;
	goto $branchMerge_6;
anon1256_Else:
	assume !$_$_condition_$13;
	assume $_$_condition_$13 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_11 == SecMask_$_9;
	goto $branchMerge_6;
anon1257_Then:
	assume $_$_condition_$15;
	assume $_$_condition_$15 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_11);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_12 == SecMask_$_11[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_11[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_11[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_12);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_12);
	assume SecMask_$_13 == SecMask_$_12;
	goto $branchMerge_7;
anon1257_Else:
	assume !$_$_condition_$15;
	assume $_$_condition_$15 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_13 == SecMask_$_11;
	goto $branchMerge_7;
anon1258_Then:
	assume $_$_condition_$17;
	assume $_$_condition_$17 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#527 : Integer :: ( ((0 <= lk#79#527) && (lk#79#527 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#527) < exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_8;
anon1258_Else:
	assume !$_$_condition_$17;
	assume $_$_condition_$17 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_8;
anon1259_Then:
	assume $_$_condition_$19;
	assume $_$_condition_$19 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_9;
anon1259_Else:
	assume !$_$_condition_$19;
	assume $_$_condition_$19 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_9;
anon1260_Then:
	assume $_$_condition_$21;
	assume $_$_condition_$21 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_13);
	assume Fractions(100) > 0;
	assume SecMask_$_14 == SecMask_$_13[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_13[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_13[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_14);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_14);
	assume SecMask_$_15 == SecMask_$_14;
	goto $branchMerge_10;
anon1260_Else:
	assume !$_$_condition_$21;
	assume $_$_condition_$21 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_15 == SecMask_$_13;
	goto $branchMerge_10;
anon1261_Then:
	assume $_$_condition_$23;
	assume $_$_condition_$23 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_15);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_16 == SecMask_$_15[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_15[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_15[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_16);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_16);
	assume SecMask_$_17 == SecMask_$_16;
	goto $branchMerge_11;
anon1261_Else:
	assume !$_$_condition_$23;
	assume $_$_condition_$23 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_17 == SecMask_$_15;
	goto $branchMerge_11;
anon1262_Then:
	assume $_$_condition_$25;
	assume $_$_condition_$25 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_17);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_18 == SecMask_$_17[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_17[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_17[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_18);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_18);
	assume SecMask_$_19 == SecMask_$_18;
	goto $branchMerge_12;
anon1262_Else:
	assume !$_$_condition_$25;
	assume $_$_condition_$25 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_19 == SecMask_$_17;
	goto $branchMerge_12;
anon1263_Then:
	assume $_$_condition_$27;
	assume $_$_condition_$27 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_19);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_20 == SecMask_$_19[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_19[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_19[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_20);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_20);
	assume SecMask_$_21 == SecMask_$_20;
	goto $branchMerge_13;
anon1263_Else:
	assume !$_$_condition_$27;
	assume $_$_condition_$27 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_21 == SecMask_$_19;
	goto $branchMerge_13;
anon1264_Then:
	assume $_$_condition_$29;
	assume $_$_condition_$29 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#528 : Integer :: ( ((0 <= rk#80#528) && (rk#80#528 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#528)) ));
	goto $branchMerge_14;
anon1264_Else:
	assume !$_$_condition_$29;
	assume $_$_condition_$29 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	goto $branchMerge_14;
anon1265_Then:
	assume $_$_condition_$31;
	assume $_$_condition_$31 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon90;
anon1265_Else:
	assume !$_$_condition_$31;
	assume $_$_condition_$31 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	goto anon90;
anon90:
	assume Seq#Equal(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys],exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key]);
	assume (forall  kk#81 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys],kk#81) <==> ((((!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81)) || ((!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81))) || (kk#81 == exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.height] > 0;
	assume (bf#522_$_0 > 0) ==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume #AVLTreeNode.valid#trigger(this#521_$_0);
	assume predVer#_1783_$_0 == exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.valid];
	if ($_$_condition_$33) { goto anon1266_Then; } else { goto anon1266_Else; }
anon1266_Then:
	assume $_$_condition_$33;
	assume $_$_condition_$33 <==> (false || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.valid]) && (this#521_$_0 == this#521_$_0)) && true) && true));
	assume false || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.valid]) && (this#521_$_0 == this#521_$_0)) && true) && true);
	if ($_$_condition_$34) { goto anon1267_Then; } else { goto anon1267_Else; }
anon1266_Else:
	assume !$_$_condition_$33;
	assume $_$_condition_$33 <==> (false || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.valid]) && (this#521_$_0 == this#521_$_0)) && true) && true));
	assume !(false || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.valid]) && (this#521_$_0 == this#521_$_0)) && true) && true));
	assume SecMask_$_72 == SecMask_$_21;
	goto anon144;
anon1267_Then:
	assume $_$_condition_$34;
	assume $_$_condition_$34 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#529 : Integer :: ( ((0 <= lk#79#529) && (lk#79#529 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#529) < exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_15;
anon1267_Else:
	assume !$_$_condition_$34;
	assume $_$_condition_$34 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_15;
anon144:
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_72);
	assume true;
	assume Fractions(100) > 0;
	assume SecMask_$_73 == SecMask_$_72[this#521_$_0,AVLTreeNode.key := SecMask_$_72[this#521_$_0,AVLTreeNode.key][perm$R := SecMask_$_72[this#521_$_0,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_73);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_73);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_73);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_74 == SecMask_$_73[this#521_$_0,AVLTreeNode.height := SecMask_$_73[this#521_$_0,AVLTreeNode.height][perm$R := SecMask_$_73[this#521_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_74);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_74);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_74);
	assume (exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null) || (dtype(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume SecMask_$_75 == SecMask_$_74[this#521_$_0,AVLTreeNode.left := SecMask_$_74[this#521_$_0,AVLTreeNode.left][perm$R := SecMask_$_74[this#521_$_0,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_75);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_75);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_75);
	assume (exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null) || (dtype(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume SecMask_$_76 == SecMask_$_75[this#521_$_0,AVLTreeNode.right := SecMask_$_75[this#521_$_0,AVLTreeNode.right][perm$R := SecMask_$_75[this#521_$_0,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_76);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_76);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_76);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_77 == SecMask_$_76[this#521_$_0,AVLTreeNode.keys := SecMask_$_76[this#521_$_0,AVLTreeNode.keys][perm$R := SecMask_$_76[this#521_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_77);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_77);
	assume !(this#521_$_0 == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_77);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_78 == SecMask_$_77[this#521_$_0,AVLTreeNode.balanceFactor := SecMask_$_77[this#521_$_0,AVLTreeNode.balanceFactor][perm$R := SecMask_$_77[this#521_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_78);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_78);
	if ($_$_condition_$70) { goto anon1293_Then; } else { goto anon1293_Else; }
anon1268_Then:
	assume $_$_condition_$35;
	assume $_$_condition_$35 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_16;
anon1268_Else:
	assume !$_$_condition_$35;
	assume $_$_condition_$35 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_16;
anon1269_Then:
	assume $_$_condition_$37;
	assume $_$_condition_$37 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#530 : Integer :: ( ((0 <= rk#80#530) && (rk#80#530 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#530)) ));
	goto $branchMerge_17;
anon1269_Else:
	assume !$_$_condition_$37;
	assume $_$_condition_$37 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	goto $branchMerge_17;
anon1270_Then:
	assume $_$_condition_$39;
	assume $_$_condition_$39 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon99;
anon1270_Else:
	assume !$_$_condition_$39;
	assume $_$_condition_$39 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	goto anon99;
anon99:
	assume Seq#Equal(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys],exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key]);
	assume (forall  kk#81_$0 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys],kk#81_$0) <==> ((((!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$0)) || ((!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$0))) || (kk#81_$0 == exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.height] > 0;
	assume SecMask_$_22 == SecMask_$_21[this#521_$_0,AVLTreeNode.key := SecMask_$_21[this#521_$_0,AVLTreeNode.key][perm$R := SecMask_$_21[this#521_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$41) { goto anon1271_Then; } else { goto anon1271_Else; }
anon1271_Then:
	assume $_$_condition_$41;
	assume SecMask_$_22[this#521_$_0,AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_23 == SecMask_$_22[this#521_$_0,AVLTreeNode.key := SecMask_$_22[this#521_$_0,AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_24 == SecMask_$_23;
	goto anon101;
anon1271_Else:
	assume !$_$_condition_$41;
	assume 0 <= SecMask_$_22[this#521_$_0,AVLTreeNode.key][perm$R];
	assume SecMask_$_24 == SecMask_$_22;
	goto anon101;
anon101:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_24,SecMask_$_24);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_24);
	assume SecMask_$_25 == SecMask_$_24[this#521_$_0,AVLTreeNode.height := SecMask_$_24[this#521_$_0,AVLTreeNode.height][perm$R := SecMask_$_24[this#521_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$42) { goto anon1272_Then; } else { goto anon1272_Else; }
anon1272_Then:
	assume $_$_condition_$42;
	assume SecMask_$_25[this#521_$_0,AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_26 == SecMask_$_25[this#521_$_0,AVLTreeNode.height := SecMask_$_25[this#521_$_0,AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_27 == SecMask_$_26;
	goto anon103;
anon1272_Else:
	assume !$_$_condition_$42;
	assume 0 <= SecMask_$_25[this#521_$_0,AVLTreeNode.height][perm$R];
	assume SecMask_$_27 == SecMask_$_25;
	goto anon103;
anon103:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_27,SecMask_$_27);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_27);
	assume SecMask_$_28 == SecMask_$_27[this#521_$_0,AVLTreeNode.left := SecMask_$_27[this#521_$_0,AVLTreeNode.left][perm$R := SecMask_$_27[this#521_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$43) { goto anon1273_Then; } else { goto anon1273_Else; }
anon1273_Then:
	assume $_$_condition_$43;
	assume SecMask_$_28[this#521_$_0,AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_29 == SecMask_$_28[this#521_$_0,AVLTreeNode.left := SecMask_$_28[this#521_$_0,AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_30 == SecMask_$_29;
	goto anon105;
anon1273_Else:
	assume !$_$_condition_$43;
	assume 0 <= SecMask_$_28[this#521_$_0,AVLTreeNode.left][perm$R];
	assume SecMask_$_30 == SecMask_$_28;
	goto anon105;
anon105:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_30,SecMask_$_30);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_30);
	assume SecMask_$_31 == SecMask_$_30[this#521_$_0,AVLTreeNode.right := SecMask_$_30[this#521_$_0,AVLTreeNode.right][perm$R := SecMask_$_30[this#521_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$44) { goto anon1274_Then; } else { goto anon1274_Else; }
anon1274_Then:
	assume $_$_condition_$44;
	assume SecMask_$_31[this#521_$_0,AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_32 == SecMask_$_31[this#521_$_0,AVLTreeNode.right := SecMask_$_31[this#521_$_0,AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_33 == SecMask_$_32;
	goto anon107;
anon1274_Else:
	assume !$_$_condition_$44;
	assume 0 <= SecMask_$_31[this#521_$_0,AVLTreeNode.right][perm$R];
	assume SecMask_$_33 == SecMask_$_31;
	goto anon107;
anon107:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_33,SecMask_$_33);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_33);
	assume SecMask_$_34 == SecMask_$_33[this#521_$_0,AVLTreeNode.keys := SecMask_$_33[this#521_$_0,AVLTreeNode.keys][perm$R := SecMask_$_33[this#521_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$45) { goto anon1275_Then; } else { goto anon1275_Else; }
anon1275_Then:
	assume $_$_condition_$45;
	assume SecMask_$_34[this#521_$_0,AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_35 == SecMask_$_34[this#521_$_0,AVLTreeNode.keys := SecMask_$_34[this#521_$_0,AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_36 == SecMask_$_35;
	goto anon109;
anon1275_Else:
	assume !$_$_condition_$45;
	assume 0 <= SecMask_$_34[this#521_$_0,AVLTreeNode.keys][perm$R];
	assume SecMask_$_36 == SecMask_$_34;
	goto anon109;
anon109:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_36,SecMask_$_36);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_36);
	assume SecMask_$_37 == SecMask_$_36[this#521_$_0,AVLTreeNode.balanceFactor := SecMask_$_36[this#521_$_0,AVLTreeNode.balanceFactor][perm$R := SecMask_$_36[this#521_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$46) { goto anon1276_Then; } else { goto anon1276_Else; }
anon1276_Then:
	assume $_$_condition_$46;
	assume SecMask_$_37[this#521_$_0,AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_38 == SecMask_$_37[this#521_$_0,AVLTreeNode.balanceFactor := SecMask_$_37[this#521_$_0,AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_39 == SecMask_$_38;
	goto anon111;
anon1276_Else:
	assume !$_$_condition_$46;
	assume 0 <= SecMask_$_37[this#521_$_0,AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_39 == SecMask_$_37;
	goto anon111;
anon111:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_39,SecMask_$_39);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_39);
	if ($_$_condition_$47) { goto anon1277_Then; } else { goto anon1277_Else; }
anon1277_Then:
	assume $_$_condition_$47;
	assume $_$_condition_$47 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_40 == SecMask_$_39[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_39[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_39[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$48) { goto anon1278_Then; } else { goto anon1278_Else; }
anon1277_Else:
	assume !$_$_condition_$47;
	assume $_$_condition_$47 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_43 == SecMask_$_39;
	goto $branchMerge_18;
anon1278_Then:
	assume $_$_condition_$48;
	assume SecMask_$_40[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_41 == SecMask_$_40[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_40[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_42 == SecMask_$_41;
	goto anon114;
anon1278_Else:
	assume !$_$_condition_$48;
	assume 0 <= SecMask_$_40[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_42 == SecMask_$_40;
	goto anon114;
anon1279_Then:
	assume $_$_condition_$49;
	assume $_$_condition_$49 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_44 == SecMask_$_43[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_43[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_43[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$51) { goto anon1280_Then; } else { goto anon1280_Else; }
anon1279_Else:
	assume !$_$_condition_$49;
	assume $_$_condition_$49 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_47 == SecMask_$_43;
	goto $branchMerge_19;
anon114:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_42,SecMask_$_42);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_42);
	assume SecMask_$_43 == SecMask_$_42;
	goto $branchMerge_18;
anon1280_Then:
	assume $_$_condition_$51;
	assume SecMask_$_44[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_45 == SecMask_$_44[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_44[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_46 == SecMask_$_45;
	goto anon118;
anon1280_Else:
	assume !$_$_condition_$51;
	assume 0 <= SecMask_$_44[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_46 == SecMask_$_44;
	goto anon118;
anon1281_Then:
	assume $_$_condition_$52;
	assume $_$_condition_$52 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_48 == SecMask_$_47[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_47[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_47[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$54) { goto anon1282_Then; } else { goto anon1282_Else; }
anon1281_Else:
	assume !$_$_condition_$52;
	assume $_$_condition_$52 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_51 == SecMask_$_47;
	goto $branchMerge_20;
anon118:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_46,SecMask_$_46);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_46);
	assume SecMask_$_47 == SecMask_$_46;
	goto $branchMerge_19;
anon1282_Then:
	assume $_$_condition_$54;
	assume SecMask_$_48[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_49 == SecMask_$_48[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_48[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_50 == SecMask_$_49;
	goto anon122;
anon1282_Else:
	assume !$_$_condition_$54;
	assume 0 <= SecMask_$_48[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_50 == SecMask_$_48;
	goto anon122;
anon1283_Then:
	assume $_$_condition_$55;
	assume $_$_condition_$55 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_52 == SecMask_$_51[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_51[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_51[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$57) { goto anon1284_Then; } else { goto anon1284_Else; }
anon1283_Else:
	assume !$_$_condition_$55;
	assume $_$_condition_$55 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_55 == SecMask_$_51;
	goto $branchMerge_21;
anon122:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_50,SecMask_$_50);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_50);
	assume SecMask_$_51 == SecMask_$_50;
	goto $branchMerge_20;
anon1284_Then:
	assume $_$_condition_$57;
	assume SecMask_$_52[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_53 == SecMask_$_52[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_52[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_54 == SecMask_$_53;
	goto anon126;
anon1284_Else:
	assume !$_$_condition_$57;
	assume 0 <= SecMask_$_52[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_54 == SecMask_$_52;
	goto anon126;
anon1285_Then:
	assume $_$_condition_$58;
	assume $_$_condition_$58 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_56 == SecMask_$_55[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_55[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_55[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$60) { goto anon1286_Then; } else { goto anon1286_Else; }
anon1285_Else:
	assume !$_$_condition_$58;
	assume $_$_condition_$58 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_59 == SecMask_$_55;
	goto $branchMerge_22;
anon126:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_54,SecMask_$_54);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_54);
	assume SecMask_$_55 == SecMask_$_54;
	goto $branchMerge_21;
anon1286_Then:
	assume $_$_condition_$60;
	assume SecMask_$_56[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_57 == SecMask_$_56[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_56[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_58 == SecMask_$_57;
	goto anon130;
anon1286_Else:
	assume !$_$_condition_$60;
	assume 0 <= SecMask_$_56[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_58 == SecMask_$_56;
	goto anon130;
anon1287_Then:
	assume $_$_condition_$61;
	assume $_$_condition_$61 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_60 == SecMask_$_59[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_59[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_59[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$63) { goto anon1288_Then; } else { goto anon1288_Else; }
anon1287_Else:
	assume !$_$_condition_$61;
	assume $_$_condition_$61 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_63 == SecMask_$_59;
	goto $branchMerge_23;
anon130:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_58,SecMask_$_58);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_58);
	assume SecMask_$_59 == SecMask_$_58;
	goto $branchMerge_22;
anon1288_Then:
	assume $_$_condition_$63;
	assume SecMask_$_60[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_61 == SecMask_$_60[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_60[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_62 == SecMask_$_61;
	goto anon134;
anon1288_Else:
	assume !$_$_condition_$63;
	assume 0 <= SecMask_$_60[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_62 == SecMask_$_60;
	goto anon134;
anon1289_Then:
	assume $_$_condition_$64;
	assume $_$_condition_$64 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_64 == SecMask_$_63[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_63[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_63[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$66) { goto anon1290_Then; } else { goto anon1290_Else; }
anon1289_Else:
	assume !$_$_condition_$64;
	assume $_$_condition_$64 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_67 == SecMask_$_63;
	goto $branchMerge_24;
anon134:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_62,SecMask_$_62);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_62);
	assume SecMask_$_63 == SecMask_$_62;
	goto $branchMerge_23;
anon1290_Then:
	assume $_$_condition_$66;
	assume SecMask_$_64[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_65 == SecMask_$_64[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_64[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_66 == SecMask_$_65;
	goto anon138;
anon1290_Else:
	assume !$_$_condition_$66;
	assume 0 <= SecMask_$_64[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_66 == SecMask_$_64;
	goto anon138;
anon1291_Then:
	assume $_$_condition_$67;
	assume $_$_condition_$67 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_68 == SecMask_$_67[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_67[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_67[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$69) { goto anon1292_Then; } else { goto anon1292_Else; }
anon1291_Else:
	assume !$_$_condition_$67;
	assume $_$_condition_$67 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_71 == SecMask_$_67;
	goto anon143;
anon138:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_66,SecMask_$_66);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_66);
	assume SecMask_$_67 == SecMask_$_66;
	goto $branchMerge_24;
anon1292_Then:
	assume $_$_condition_$69;
	assume SecMask_$_68[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_69 == SecMask_$_68[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_68[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_70 == SecMask_$_69;
	goto anon142;
anon1292_Else:
	assume !$_$_condition_$69;
	assume 0 <= SecMask_$_68[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_70 == SecMask_$_68;
	goto anon142;
anon143:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_71,SecMask_$_71);
	assume SecMask_$_72 == SecMask_$_71;
	goto anon144;
anon142:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_70,SecMask_$_70);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_70);
	assume SecMask_$_71 == SecMask_$_70;
	goto anon143;
anon1293_Then:
	assume $_$_condition_$70;
	assume $_$_condition_$70 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_78);
	assume Fractions(100) > 0;
	assume SecMask_$_79 == SecMask_$_78[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_78[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_78[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_79);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_79);
	assume SecMask_$_80 == SecMask_$_79;
	goto $branchMerge_25;
anon1293_Else:
	assume !$_$_condition_$70;
	assume $_$_condition_$70 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_80 == SecMask_$_78;
	goto $branchMerge_25;
anon1294_Then:
	assume $_$_condition_$71;
	assume $_$_condition_$71 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_80);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_81 == SecMask_$_80[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_80[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_80[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_81);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_81);
	assume SecMask_$_82 == SecMask_$_81;
	goto $branchMerge_26;
anon1294_Else:
	assume !$_$_condition_$71;
	assume $_$_condition_$71 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_82 == SecMask_$_80;
	goto $branchMerge_26;
anon1295_Then:
	assume $_$_condition_$73;
	assume $_$_condition_$73 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_82);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_83 == SecMask_$_82[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_82[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_82[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_83);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_83);
	assume SecMask_$_84 == SecMask_$_83;
	goto $branchMerge_27;
anon1295_Else:
	assume !$_$_condition_$73;
	assume $_$_condition_$73 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_84 == SecMask_$_82;
	goto $branchMerge_27;
anon1296_Then:
	assume $_$_condition_$75;
	assume $_$_condition_$75 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_84);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_85 == SecMask_$_84[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_84[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_84[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_85);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_85);
	assume SecMask_$_86 == SecMask_$_85;
	goto $branchMerge_28;
anon1296_Else:
	assume !$_$_condition_$75;
	assume $_$_condition_$75 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_86 == SecMask_$_84;
	goto $branchMerge_28;
anon1297_Then:
	assume $_$_condition_$77;
	assume $_$_condition_$77 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#533 : Integer :: ( ((0 <= lk#79#533) && (lk#79#533 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#533) < exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_29;
anon1297_Else:
	assume !$_$_condition_$77;
	assume $_$_condition_$77 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_29;
anon1298_Then:
	assume $_$_condition_$79;
	assume $_$_condition_$79 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_30;
anon1298_Else:
	assume !$_$_condition_$79;
	assume $_$_condition_$79 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_30;
anon1299_Then:
	assume $_$_condition_$81;
	assume $_$_condition_$81 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_86);
	assume Fractions(100) > 0;
	assume SecMask_$_87 == SecMask_$_86[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_86[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_86[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_87);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_87);
	assume SecMask_$_88 == SecMask_$_87;
	goto $branchMerge_31;
anon1299_Else:
	assume !$_$_condition_$81;
	assume $_$_condition_$81 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_88 == SecMask_$_86;
	goto $branchMerge_31;
anon1300_Then:
	assume $_$_condition_$83;
	assume $_$_condition_$83 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_88);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_89 == SecMask_$_88[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_88[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_88[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_89);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_89);
	assume SecMask_$_90 == SecMask_$_89;
	goto $branchMerge_32;
anon1300_Else:
	assume !$_$_condition_$83;
	assume $_$_condition_$83 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_90 == SecMask_$_88;
	goto $branchMerge_32;
anon1301_Then:
	assume $_$_condition_$85;
	assume $_$_condition_$85 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_90);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_91 == SecMask_$_90[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_90[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_90[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_91);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_91);
	assume SecMask_$_92 == SecMask_$_91;
	goto $branchMerge_33;
anon1301_Else:
	assume !$_$_condition_$85;
	assume $_$_condition_$85 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_92 == SecMask_$_90;
	goto $branchMerge_33;
anon1302_Then:
	assume $_$_condition_$87;
	assume $_$_condition_$87 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_92);
	assume true;
	assume Fractions(50) > 0;
	assume SecMask_$_93 == SecMask_$_92[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_92[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_92[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_93);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_93);
	assume SecMask_$_94 == SecMask_$_93;
	goto $branchMerge_34;
anon1302_Else:
	assume !$_$_condition_$87;
	assume $_$_condition_$87 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_94 == SecMask_$_92;
	goto $branchMerge_34;
anon1303_Then:
	assume $_$_condition_$89;
	assume $_$_condition_$89 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#534 : Integer :: ( ((0 <= rk#80#534) && (rk#80#534 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#534)) ));
	goto $branchMerge_35;
anon1303_Else:
	assume !$_$_condition_$89;
	assume $_$_condition_$89 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	goto $branchMerge_35;
anon1304_Then:
	assume $_$_condition_$91;
	assume $_$_condition_$91 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon168;
anon1304_Else:
	assume !$_$_condition_$91;
	assume $_$_condition_$91 <==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null;
	goto anon168;
anon168:
	assume Seq#Equal(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys],exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key]);
	assume (forall  kk#81_$1 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.keys],kk#81_$1) <==> ((((!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$1)) || ((!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$1))) || (kk#81_$1 == exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.height] > 0;
	assume (bf#522_$_0 < 0) ==> (!(exhaleHeap#_1757_$_0[this#521_$_0,AVLTreeNode.right] == null));
	assume IsGoodMask(Mask_$_19);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assume cond#_1801_$_0 <==> (bf#522_$_0 < 0);
	if ($_$_condition_$93) { goto anon1305_Then; } else { goto anon1305_Else; }
anon1305_Then:
	assume $_$_condition_$93;
	assume $_$_condition_$93 <==> cond#_1801_$_0;
	assume cond#_1801_$_0;
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assume (0 < unfoldingK#_1813) && ((1000 * unfoldingK#_1813) < Fractions(1));
	assert { :msg "  635.21: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  635.21: Location might not be readable." } true ==> CanRead(Mask_$_19,SecMask_$_94,this,AVLTreeNode.left);
	assert { :msg "  635.21: Receiver might be null." } true ==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.left] == null));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  635.11: Unfolding might fail. The permission at 635.21 might not be positive." } Fractions(100) > 0;
	assert { :msg "  635.11: Unfolding might fail. Insufficient fraction at 635.21 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_19[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_19[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_19[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume unfoldingMask#_1809_$_0 == Mask_$_19[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_19[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_19[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$94) { goto anon1306_Then; } else { goto anon1306_Else; }
anon1305_Else:
	assume !$_$_condition_$93;
	assume $_$_condition_$93 <==> cond#_1801_$_0;
	assume !cond#_1801_$_0;
	assume ((0 < methodCallK#_1974) && ((1000 * methodCallK#_1974) < Fractions(1))) && ((1000 * methodCallK#_1974) < methodK#_1751);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  638.4: The target of the method call might be null." } !(this == null);
	assert { :msg "  638.4: The precondition at 710.12 might not hold. The expression at 710.12 might not evaluate to true." } !(exhaleHeap#_1757_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  638.4: The precondition at 715.12 might not hold. The expression at 715.12 might not evaluate to true." } (forall  k#102#579 : Integer :: ( ((0 <= k#102#579) && (k#102#579 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#102#579) < exhaleHeap#_1757_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$95) { goto anon1562_Then; } else { goto anon1562_Else; }
anon1306_Then:
	assume $_$_condition_$94;
	assume $_$_condition_$94 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$96) { goto anon1307_Then; } else { goto anon1307_Else; }
anon1306_Else:
	assume !$_$_condition_$94;
	assume $_$_condition_$94 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume unfoldingSecMask#_1810_$_50 == SecMask_$_94;
	goto $branchMerge_36;
anon1562_Then:
	assume $_$_condition_$95;
	assume $_$_condition_$95 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  638.4: The precondition at 721.12 might not hold. The expression at 721.28 might not evaluate to true." } (forall  k#103#580 : Integer :: ( ((0 <= k#103#580) && (k#103#580 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#103#580)) ));
	goto anon692;
anon1562_Else:
	assume !$_$_condition_$95;
	assume $_$_condition_$95 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null;
	goto anon692;
anon1307_Then:
	assume $_$_condition_$96;
	assume $_$_condition_$96 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true;
	goto $branchMerge_37;
anon1307_Else:
	assume !$_$_condition_$96;
	assume $_$_condition_$96 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	goto $branchMerge_37;
anon1334_Then:
	assume $_$_condition_$97;
	assume $_$_condition_$97 <==> (!CanRead(unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_50,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_50,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume oldVers#_1833_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume unfoldingHeap#_1808_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := newVers#_1834_$_0];
	assume oldVers#_1833_$_0 < unfoldingHeap#_1808_$_0[unfoldingHeap#_1808_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume unfoldingHeap#_1808_$_1 == unfoldingHeap#_1808_$_0;
	goto anon228;
anon1334_Else:
	assume !$_$_condition_$97;
	assume $_$_condition_$97 <==> (!CanRead(unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_50,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume CanRead(unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_50,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume unfoldingHeap#_1808_$_1 == exhaleHeap#_1757_$_0;
	goto anon228;
anon692:
	assert { :msg "  638.4: The precondition at 723.12 might not hold. The expression at 723.12 might not evaluate to true." } (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] - ite(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) == 2;
	assert { :msg "  638.4: The precondition at 724.12 might not hold. The expression at 724.12 might not evaluate to true." } exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= 0;
	assert { :msg "  638.4: The precondition at 702.12 might not hold. The permission at 702.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  638.4: The precondition at 702.12 might not hold. Insufficient fraction at 702.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_19[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_19[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_19[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_1976_$_0 == Mask_$_19[this,AVLTreeNode.key := Mask_$_19[this,AVLTreeNode.key][perm$R := Mask_$_19[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1976_$_0);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_0,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  638.4: The precondition at 703.12 might not hold. The permission at 703.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  638.4: The precondition at 703.12 might not hold. Insufficient fraction at 703.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_1976_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_1976_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1976_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1976_$_1 == exhaleMask#_1976_$_0[this,AVLTreeNode.height := exhaleMask#_1976_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_1976_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1976_$_1);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_1,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  638.4: The precondition at 704.12 might not hold. The permission at 704.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  638.4: The precondition at 704.12 might not hold. Insufficient fraction at 704.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_1976_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_1976_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_1976_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_1976_$_2 == exhaleMask#_1976_$_1[this,AVLTreeNode.left := exhaleMask#_1976_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_1976_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1976_$_2);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_2,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  638.4: The precondition at 705.12 might not hold. The permission at 705.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  638.4: The precondition at 705.12 might not hold. Insufficient fraction at 705.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_1976_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_1976_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_1976_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_1976_$_3 == exhaleMask#_1976_$_2[this,AVLTreeNode.right := exhaleMask#_1976_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_1976_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1976_$_3);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_3,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  638.4: The precondition at 707.12 might not hold. The permission at 707.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  638.4: The precondition at 707.12 might not hold. Insufficient fraction at 707.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_1976_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_1976_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1976_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1976_$_4 == exhaleMask#_1976_$_3[this,AVLTreeNode.keys := exhaleMask#_1976_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_1976_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1976_$_4);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_4,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  638.4: The precondition at 708.12 might not hold. The permission at 708.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  638.4: The precondition at 708.12 might not hold. Insufficient fraction at 708.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_1976_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_1976_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1976_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1976_$_5 == exhaleMask#_1976_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_1976_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1976_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1976_$_5);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_5,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  638.4: The precondition at 711.12 might not hold. The permission at 711.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  638.4: The precondition at 711.12 might not hold. Insufficient fraction at 711.12 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1976_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1976_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1976_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1976_$_6 == exhaleMask#_1976_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_1976_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_1976_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$100) { goto anon1563_Then; } else { goto anon1563_Else; }
anon1308_Then:
	assume $_$_condition_$98;
	assume $_$_condition_$98 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#535 : Integer :: ( ((0 <= lk#79#535) && (lk#79#535 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#535) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_38;
anon1308_Else:
	assume !$_$_condition_$98;
	assume $_$_condition_$98 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_38;
anon1563_Then:
	assume $_$_condition_$100;
	assume $_$_condition_$100 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$103) { goto anon1564_Then; } else { goto anon1564_Else; }
anon1563_Else:
	assume !$_$_condition_$100;
	assume $_$_condition_$100 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_247 == SecMask_$_94;
	goto $branchMerge_39;
anon1309_Then:
	assume $_$_condition_$101;
	assume $_$_condition_$101 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_40;
anon1309_Else:
	assume !$_$_condition_$101;
	assume $_$_condition_$101 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_40;
anon1564_Then:
	assume $_$_condition_$103;
	assume $_$_condition_$103 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true;
	goto $branchMerge_41;
anon1564_Else:
	assume !$_$_condition_$103;
	assume $_$_condition_$103 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	goto $branchMerge_41;
anon1647_Then:
	assume $_$_condition_$104;
	assume $_$_condition_$104 <==> (!CanRead(exhaleMask#_1976_$_6,SecMask_$_247,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_1976_$_6,SecMask_$_247,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_1975_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon865;
anon1647_Else:
	assume !$_$_condition_$104;
	assume $_$_condition_$104 <==> (!CanRead(exhaleMask#_1976_$_6,SecMask_$_247,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_1976_$_6,SecMask_$_247,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon865;
anon1310_Then:
	assume $_$_condition_$105;
	assume $_$_condition_$105 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#536 : Integer :: ( ((0 <= rk#80#536) && (rk#80#536 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#536)) ));
	goto $branchMerge_42;
anon1310_Else:
	assume !$_$_condition_$105;
	assume $_$_condition_$105 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_42;
anon1565_Then:
	assume $_$_condition_$107;
	assume $_$_condition_$107 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#581 : Integer :: ( ((0 <= lk#79#581) && (lk#79#581 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#581) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_43;
anon1565_Else:
	assume !$_$_condition_$107;
	assume $_$_condition_$107 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_43;
anon1311_Then:
	assume $_$_condition_$109;
	assume $_$_condition_$109 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon181;
anon1311_Else:
	assume !$_$_condition_$109;
	assume $_$_condition_$109 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon181;
anon1566_Then:
	assume $_$_condition_$111;
	assume $_$_condition_$111 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_44;
anon1566_Else:
	assume !$_$_condition_$111;
	assume $_$_condition_$111 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_44;
anon181:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$2 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$2) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$2)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$2))) || (kk#81_$2 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume unfoldingSecMask#_1810_$_0 == SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$115) { goto anon1312_Then; } else { goto anon1312_Else; }
anon1567_Then:
	assume $_$_condition_$113;
	assume $_$_condition_$113 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#582 : Integer :: ( ((0 <= rk#80#582) && (rk#80#582 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#582)) ));
	goto $branchMerge_45;
anon1567_Else:
	assume !$_$_condition_$113;
	assume $_$_condition_$113 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_45;
anon1312_Then:
	assume $_$_condition_$115;
	assume unfoldingSecMask#_1810_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_1 == unfoldingSecMask#_1810_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key := unfoldingSecMask#_1810_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_2 == unfoldingSecMask#_1810_$_1;
	goto anon183;
anon1312_Else:
	assume !$_$_condition_$115;
	assume 0 <= unfoldingSecMask#_1810_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume unfoldingSecMask#_1810_$_2 == unfoldingSecMask#_1810_$_0;
	goto anon183;
anon1568_Then:
	assume $_$_condition_$116;
	assume $_$_condition_$116 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon704;
anon1568_Else:
	assume !$_$_condition_$116;
	assume $_$_condition_$116 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon704;
anon183:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_2,unfoldingSecMask#_1810_$_2);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_2);
	assume unfoldingSecMask#_1810_$_3 == unfoldingSecMask#_1810_$_2[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := unfoldingSecMask#_1810_$_2[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := unfoldingSecMask#_1810_$_2[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$118) { goto anon1313_Then; } else { goto anon1313_Else; }
anon704:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$3 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$3) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$3)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$3))) || (kk#81_$3 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_95 == SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$119) { goto anon1569_Then; } else { goto anon1569_Else; }
anon1313_Then:
	assume $_$_condition_$118;
	assume unfoldingSecMask#_1810_$_3[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_4 == unfoldingSecMask#_1810_$_3[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := unfoldingSecMask#_1810_$_3[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_5 == unfoldingSecMask#_1810_$_4;
	goto anon185;
anon1313_Else:
	assume !$_$_condition_$118;
	assume 0 <= unfoldingSecMask#_1810_$_3[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume unfoldingSecMask#_1810_$_5 == unfoldingSecMask#_1810_$_3;
	goto anon185;
anon1569_Then:
	assume $_$_condition_$119;
	assume SecMask_$_95[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_96 == SecMask_$_95[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_95[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_97 == SecMask_$_96;
	goto anon706;
anon1569_Else:
	assume !$_$_condition_$119;
	assume 0 <= SecMask_$_95[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_97 == SecMask_$_95;
	goto anon706;
anon185:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_5,unfoldingSecMask#_1810_$_5);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_5);
	assume unfoldingSecMask#_1810_$_6 == unfoldingSecMask#_1810_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left := unfoldingSecMask#_1810_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := unfoldingSecMask#_1810_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$120) { goto anon1314_Then; } else { goto anon1314_Else; }
anon706:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_97,SecMask_$_97);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_97);
	assume SecMask_$_98 == SecMask_$_97[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_97[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_97[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$121) { goto anon1570_Then; } else { goto anon1570_Else; }
anon1314_Then:
	assume $_$_condition_$120;
	assume unfoldingSecMask#_1810_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_7 == unfoldingSecMask#_1810_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left := unfoldingSecMask#_1810_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_8 == unfoldingSecMask#_1810_$_7;
	goto anon187;
anon1314_Else:
	assume !$_$_condition_$120;
	assume 0 <= unfoldingSecMask#_1810_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume unfoldingSecMask#_1810_$_8 == unfoldingSecMask#_1810_$_6;
	goto anon187;
anon1570_Then:
	assume $_$_condition_$121;
	assume SecMask_$_98[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_99 == SecMask_$_98[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_98[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_100 == SecMask_$_99;
	goto anon708;
anon1570_Else:
	assume !$_$_condition_$121;
	assume 0 <= SecMask_$_98[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_100 == SecMask_$_98;
	goto anon708;
anon187:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_8,unfoldingSecMask#_1810_$_8);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_8);
	assume unfoldingSecMask#_1810_$_9 == unfoldingSecMask#_1810_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right := unfoldingSecMask#_1810_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := unfoldingSecMask#_1810_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$122) { goto anon1315_Then; } else { goto anon1315_Else; }
anon708:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_100,SecMask_$_100);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_100);
	assume SecMask_$_101 == SecMask_$_100[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_100[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_100[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$123) { goto anon1571_Then; } else { goto anon1571_Else; }
anon1315_Then:
	assume $_$_condition_$122;
	assume unfoldingSecMask#_1810_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_10 == unfoldingSecMask#_1810_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right := unfoldingSecMask#_1810_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_11 == unfoldingSecMask#_1810_$_10;
	goto anon189;
anon1315_Else:
	assume !$_$_condition_$122;
	assume 0 <= unfoldingSecMask#_1810_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume unfoldingSecMask#_1810_$_11 == unfoldingSecMask#_1810_$_9;
	goto anon189;
anon1571_Then:
	assume $_$_condition_$123;
	assume SecMask_$_101[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_102 == SecMask_$_101[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_101[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_103 == SecMask_$_102;
	goto anon710;
anon1571_Else:
	assume !$_$_condition_$123;
	assume 0 <= SecMask_$_101[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_103 == SecMask_$_101;
	goto anon710;
anon189:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_11,unfoldingSecMask#_1810_$_11);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_11);
	assume unfoldingSecMask#_1810_$_12 == unfoldingSecMask#_1810_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := unfoldingSecMask#_1810_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := unfoldingSecMask#_1810_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$124) { goto anon1316_Then; } else { goto anon1316_Else; }
anon710:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_103,SecMask_$_103);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_103);
	assume SecMask_$_104 == SecMask_$_103[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_103[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_103[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$125) { goto anon1572_Then; } else { goto anon1572_Else; }
anon1316_Then:
	assume $_$_condition_$124;
	assume unfoldingSecMask#_1810_$_12[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_13 == unfoldingSecMask#_1810_$_12[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := unfoldingSecMask#_1810_$_12[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_14 == unfoldingSecMask#_1810_$_13;
	goto anon191;
anon1316_Else:
	assume !$_$_condition_$124;
	assume 0 <= unfoldingSecMask#_1810_$_12[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume unfoldingSecMask#_1810_$_14 == unfoldingSecMask#_1810_$_12;
	goto anon191;
anon1572_Then:
	assume $_$_condition_$125;
	assume SecMask_$_104[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_105 == SecMask_$_104[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_104[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_106 == SecMask_$_105;
	goto anon712;
anon1572_Else:
	assume !$_$_condition_$125;
	assume 0 <= SecMask_$_104[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_106 == SecMask_$_104;
	goto anon712;
anon191:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_14,unfoldingSecMask#_1810_$_14);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_14);
	assume unfoldingSecMask#_1810_$_15 == unfoldingSecMask#_1810_$_14[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingSecMask#_1810_$_14[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := unfoldingSecMask#_1810_$_14[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$126) { goto anon1317_Then; } else { goto anon1317_Else; }
anon712:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_106,SecMask_$_106);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_106);
	assume SecMask_$_107 == SecMask_$_106[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_106[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_106[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$127) { goto anon1573_Then; } else { goto anon1573_Else; }
anon1317_Then:
	assume $_$_condition_$126;
	assume unfoldingSecMask#_1810_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_16 == unfoldingSecMask#_1810_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingSecMask#_1810_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_17 == unfoldingSecMask#_1810_$_16;
	goto anon193;
anon1317_Else:
	assume !$_$_condition_$126;
	assume 0 <= unfoldingSecMask#_1810_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume unfoldingSecMask#_1810_$_17 == unfoldingSecMask#_1810_$_15;
	goto anon193;
anon1573_Then:
	assume $_$_condition_$127;
	assume SecMask_$_107[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_108 == SecMask_$_107[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_107[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_109 == SecMask_$_108;
	goto anon714;
anon1573_Else:
	assume !$_$_condition_$127;
	assume 0 <= SecMask_$_107[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_109 == SecMask_$_107;
	goto anon714;
anon193:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_17,unfoldingSecMask#_1810_$_17);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_17);
	if ($_$_condition_$128) { goto anon1318_Then; } else { goto anon1318_Else; }
anon714:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_109,SecMask_$_109);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_109);
	assume SecMask_$_110 == SecMask_$_109[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_109[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_109[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$129) { goto anon1574_Then; } else { goto anon1574_Else; }
anon1318_Then:
	assume $_$_condition_$128;
	assume $_$_condition_$128 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume unfoldingSecMask#_1810_$_18 == unfoldingSecMask#_1810_$_17[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := unfoldingSecMask#_1810_$_17[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := unfoldingSecMask#_1810_$_17[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$130) { goto anon1319_Then; } else { goto anon1319_Else; }
anon1318_Else:
	assume !$_$_condition_$128;
	assume $_$_condition_$128 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingSecMask#_1810_$_21 == unfoldingSecMask#_1810_$_17;
	goto $branchMerge_46;
anon1574_Then:
	assume $_$_condition_$129;
	assume SecMask_$_110[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_111 == SecMask_$_110[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_110[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_112 == SecMask_$_111;
	goto anon716;
anon1574_Else:
	assume !$_$_condition_$129;
	assume 0 <= SecMask_$_110[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_112 == SecMask_$_110;
	goto anon716;
anon1319_Then:
	assume $_$_condition_$130;
	assume unfoldingSecMask#_1810_$_18[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_19 == unfoldingSecMask#_1810_$_18[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := unfoldingSecMask#_1810_$_18[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_20 == unfoldingSecMask#_1810_$_19;
	goto anon196;
anon1319_Else:
	assume !$_$_condition_$130;
	assume 0 <= unfoldingSecMask#_1810_$_18[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume unfoldingSecMask#_1810_$_20 == unfoldingSecMask#_1810_$_18;
	goto anon196;
anon1320_Then:
	assume $_$_condition_$131;
	assume $_$_condition_$131 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume unfoldingSecMask#_1810_$_22 == unfoldingSecMask#_1810_$_21[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := unfoldingSecMask#_1810_$_21[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := unfoldingSecMask#_1810_$_21[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$136) { goto anon1321_Then; } else { goto anon1321_Else; }
anon1320_Else:
	assume !$_$_condition_$131;
	assume $_$_condition_$131 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingSecMask#_1810_$_25 == unfoldingSecMask#_1810_$_21;
	goto $branchMerge_47;
anon716:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_112,SecMask_$_112);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_112);
	if ($_$_condition_$132) { goto anon1575_Then; } else { goto anon1575_Else; }
anon196:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_20,unfoldingSecMask#_1810_$_20);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_20);
	assume unfoldingSecMask#_1810_$_21 == unfoldingSecMask#_1810_$_20;
	goto $branchMerge_46;
anon1575_Then:
	assume $_$_condition_$132;
	assume $_$_condition_$132 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_113 == SecMask_$_112[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_112[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_112[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$134) { goto anon1576_Then; } else { goto anon1576_Else; }
anon1575_Else:
	assume !$_$_condition_$132;
	assume $_$_condition_$132 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_167 == SecMask_$_112;
	goto $branchMerge_48;
anon1576_Then:
	assume $_$_condition_$134;
	assume SecMask_$_113[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_114 == SecMask_$_113[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_113[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_115 == SecMask_$_114;
	goto anon719;
anon1576_Else:
	assume !$_$_condition_$134;
	assume 0 <= SecMask_$_113[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_115 == SecMask_$_113;
	goto anon719;
anon1605_Then:
	assume $_$_condition_$135;
	assume $_$_condition_$135 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_168 == SecMask_$_167[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_167[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_167[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$232) { goto anon1606_Then; } else { goto anon1606_Else; }
anon1605_Else:
	assume !$_$_condition_$135;
	assume $_$_condition_$135 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_171 == SecMask_$_167;
	goto $branchMerge_49;
anon1321_Then:
	assume $_$_condition_$136;
	assume unfoldingSecMask#_1810_$_22[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_23 == unfoldingSecMask#_1810_$_22[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := unfoldingSecMask#_1810_$_22[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_24 == unfoldingSecMask#_1810_$_23;
	goto anon200;
anon1321_Else:
	assume !$_$_condition_$136;
	assume 0 <= unfoldingSecMask#_1810_$_22[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume unfoldingSecMask#_1810_$_24 == unfoldingSecMask#_1810_$_22;
	goto anon200;
anon1322_Then:
	assume $_$_condition_$137;
	assume $_$_condition_$137 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume unfoldingSecMask#_1810_$_26 == unfoldingSecMask#_1810_$_25[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := unfoldingSecMask#_1810_$_25[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := unfoldingSecMask#_1810_$_25[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$141) { goto anon1323_Then; } else { goto anon1323_Else; }
anon1322_Else:
	assume !$_$_condition_$137;
	assume $_$_condition_$137 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingSecMask#_1810_$_29 == unfoldingSecMask#_1810_$_25;
	goto $branchMerge_50;
anon719:
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == exhaleHeap#_1757_$_0[this,AVLTreeNode.left]);
	if ($_$_condition_$138) { goto anon1577_Then; } else { goto anon1577_Else; }
anon200:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_24,unfoldingSecMask#_1810_$_24);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_24);
	assume unfoldingSecMask#_1810_$_25 == unfoldingSecMask#_1810_$_24;
	goto $branchMerge_47;
anon1577_Then:
	assume $_$_condition_$138;
	assume $_$_condition_$138 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$140) { goto anon1578_Then; } else { goto anon1578_Else; }
anon1577_Else:
	assume !$_$_condition_$138;
	assume $_$_condition_$138 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true));
	assume SecMask_$_166 == SecMask_$_115;
	goto anon776;
anon1578_Then:
	assume $_$_condition_$140;
	assume $_$_condition_$140 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true;
	goto $branchMerge_51;
anon1578_Else:
	assume !$_$_condition_$140;
	assume $_$_condition_$140 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true);
	goto $branchMerge_51;
anon776:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_166,SecMask_$_166);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_166);
	assume SecMask_$_167 == SecMask_$_166;
	goto $branchMerge_48;
anon1323_Then:
	assume $_$_condition_$141;
	assume unfoldingSecMask#_1810_$_26[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_27 == unfoldingSecMask#_1810_$_26[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := unfoldingSecMask#_1810_$_26[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_28 == unfoldingSecMask#_1810_$_27;
	goto anon204;
anon1323_Else:
	assume !$_$_condition_$141;
	assume 0 <= unfoldingSecMask#_1810_$_26[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume unfoldingSecMask#_1810_$_28 == unfoldingSecMask#_1810_$_26;
	goto anon204;
anon1324_Then:
	assume $_$_condition_$142;
	assume $_$_condition_$142 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume unfoldingSecMask#_1810_$_30 == unfoldingSecMask#_1810_$_29[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingSecMask#_1810_$_29[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := unfoldingSecMask#_1810_$_29[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$150) { goto anon1325_Then; } else { goto anon1325_Else; }
anon1324_Else:
	assume !$_$_condition_$142;
	assume $_$_condition_$142 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingSecMask#_1810_$_33 == unfoldingSecMask#_1810_$_29;
	goto $branchMerge_52;
anon1579_Then:
	assume $_$_condition_$143;
	assume $_$_condition_$143 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#585 : Integer :: ( ((0 <= lk#79#585) && (lk#79#585 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#585) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_53;
anon1579_Else:
	assume !$_$_condition_$143;
	assume $_$_condition_$143 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_53;
anon204:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_28,unfoldingSecMask#_1810_$_28);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_28);
	assume unfoldingSecMask#_1810_$_29 == unfoldingSecMask#_1810_$_28;
	goto $branchMerge_50;
anon1580_Then:
	assume $_$_condition_$145;
	assume $_$_condition_$145 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_54;
anon1580_Else:
	assume !$_$_condition_$145;
	assume $_$_condition_$145 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_54;
anon1581_Then:
	assume $_$_condition_$148;
	assume $_$_condition_$148 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#586 : Integer :: ( ((0 <= rk#80#586) && (rk#80#586 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#586)) ));
	goto $branchMerge_55;
anon1581_Else:
	assume !$_$_condition_$148;
	assume $_$_condition_$148 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_55;
anon1325_Then:
	assume $_$_condition_$150;
	assume unfoldingSecMask#_1810_$_30[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_31 == unfoldingSecMask#_1810_$_30[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingSecMask#_1810_$_30[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_32 == unfoldingSecMask#_1810_$_31;
	goto anon208;
anon1325_Else:
	assume !$_$_condition_$150;
	assume 0 <= unfoldingSecMask#_1810_$_30[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume unfoldingSecMask#_1810_$_32 == unfoldingSecMask#_1810_$_30;
	goto anon208;
anon1326_Then:
	assume $_$_condition_$151;
	assume $_$_condition_$151 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume unfoldingSecMask#_1810_$_34 == unfoldingSecMask#_1810_$_33[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := unfoldingSecMask#_1810_$_33[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := unfoldingSecMask#_1810_$_33[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$156) { goto anon1327_Then; } else { goto anon1327_Else; }
anon1326_Else:
	assume !$_$_condition_$151;
	assume $_$_condition_$151 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingSecMask#_1810_$_37 == unfoldingSecMask#_1810_$_33;
	goto $branchMerge_56;
anon1582_Then:
	assume $_$_condition_$152;
	assume $_$_condition_$152 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon731;
anon1582_Else:
	assume !$_$_condition_$152;
	assume $_$_condition_$152 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon731;
anon208:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_32,unfoldingSecMask#_1810_$_32);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_32);
	assume unfoldingSecMask#_1810_$_33 == unfoldingSecMask#_1810_$_32;
	goto $branchMerge_52;
anon731:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$4 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$4) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$4)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$4))) || (kk#81_$4 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_116 == SecMask_$_115[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key := SecMask_$_115[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_115[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$155) { goto anon1583_Then; } else { goto anon1583_Else; }
anon1583_Then:
	assume $_$_condition_$155;
	assume SecMask_$_116[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_117 == SecMask_$_116[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key := SecMask_$_116[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_118 == SecMask_$_117;
	goto anon733;
anon1583_Else:
	assume !$_$_condition_$155;
	assume 0 <= SecMask_$_116[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_118 == SecMask_$_116;
	goto anon733;
anon1327_Then:
	assume $_$_condition_$156;
	assume unfoldingSecMask#_1810_$_34[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_35 == unfoldingSecMask#_1810_$_34[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := unfoldingSecMask#_1810_$_34[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_36 == unfoldingSecMask#_1810_$_35;
	goto anon212;
anon1327_Else:
	assume !$_$_condition_$156;
	assume 0 <= unfoldingSecMask#_1810_$_34[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume unfoldingSecMask#_1810_$_36 == unfoldingSecMask#_1810_$_34;
	goto anon212;
anon1328_Then:
	assume $_$_condition_$157;
	assume $_$_condition_$157 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume unfoldingSecMask#_1810_$_38 == unfoldingSecMask#_1810_$_37[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := unfoldingSecMask#_1810_$_37[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := unfoldingSecMask#_1810_$_37[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$160) { goto anon1329_Then; } else { goto anon1329_Else; }
anon1328_Else:
	assume !$_$_condition_$157;
	assume $_$_condition_$157 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingSecMask#_1810_$_41 == unfoldingSecMask#_1810_$_37;
	goto $branchMerge_57;
anon733:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_118,SecMask_$_118);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_118);
	assume SecMask_$_119 == SecMask_$_118[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_118[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_118[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$158) { goto anon1584_Then; } else { goto anon1584_Else; }
anon212:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_36,unfoldingSecMask#_1810_$_36);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_36);
	assume unfoldingSecMask#_1810_$_37 == unfoldingSecMask#_1810_$_36;
	goto $branchMerge_56;
anon1584_Then:
	assume $_$_condition_$158;
	assume SecMask_$_119[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_120 == SecMask_$_119[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_119[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_121 == SecMask_$_120;
	goto anon735;
anon1584_Else:
	assume !$_$_condition_$158;
	assume 0 <= SecMask_$_119[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_121 == SecMask_$_119;
	goto anon735;
anon735:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_121,SecMask_$_121);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_121);
	assume SecMask_$_122 == SecMask_$_121[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left := SecMask_$_121[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_121[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$162) { goto anon1585_Then; } else { goto anon1585_Else; }
anon1329_Then:
	assume $_$_condition_$160;
	assume unfoldingSecMask#_1810_$_38[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_39 == unfoldingSecMask#_1810_$_38[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := unfoldingSecMask#_1810_$_38[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_40 == unfoldingSecMask#_1810_$_39;
	goto anon216;
anon1329_Else:
	assume !$_$_condition_$160;
	assume 0 <= unfoldingSecMask#_1810_$_38[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume unfoldingSecMask#_1810_$_40 == unfoldingSecMask#_1810_$_38;
	goto anon216;
anon1330_Then:
	assume $_$_condition_$161;
	assume $_$_condition_$161 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume unfoldingSecMask#_1810_$_42 == unfoldingSecMask#_1810_$_41[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := unfoldingSecMask#_1810_$_41[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := unfoldingSecMask#_1810_$_41[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$165) { goto anon1331_Then; } else { goto anon1331_Else; }
anon1330_Else:
	assume !$_$_condition_$161;
	assume $_$_condition_$161 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingSecMask#_1810_$_45 == unfoldingSecMask#_1810_$_41;
	goto $branchMerge_58;
anon1585_Then:
	assume $_$_condition_$162;
	assume SecMask_$_122[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_123 == SecMask_$_122[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left := SecMask_$_122[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_124 == SecMask_$_123;
	goto anon737;
anon1585_Else:
	assume !$_$_condition_$162;
	assume 0 <= SecMask_$_122[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_124 == SecMask_$_122;
	goto anon737;
anon216:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_40,unfoldingSecMask#_1810_$_40);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_40);
	assume unfoldingSecMask#_1810_$_41 == unfoldingSecMask#_1810_$_40;
	goto $branchMerge_57;
anon737:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_124,SecMask_$_124);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_124);
	assume SecMask_$_125 == SecMask_$_124[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right := SecMask_$_124[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_124[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$164) { goto anon1586_Then; } else { goto anon1586_Else; }
anon1586_Then:
	assume $_$_condition_$164;
	assume SecMask_$_125[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_126 == SecMask_$_125[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right := SecMask_$_125[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_127 == SecMask_$_126;
	goto anon739;
anon1586_Else:
	assume !$_$_condition_$164;
	assume 0 <= SecMask_$_125[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_127 == SecMask_$_125;
	goto anon739;
anon1331_Then:
	assume $_$_condition_$165;
	assume unfoldingSecMask#_1810_$_42[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_43 == unfoldingSecMask#_1810_$_42[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := unfoldingSecMask#_1810_$_42[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_44 == unfoldingSecMask#_1810_$_43;
	goto anon220;
anon1331_Else:
	assume !$_$_condition_$165;
	assume 0 <= unfoldingSecMask#_1810_$_42[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume unfoldingSecMask#_1810_$_44 == unfoldingSecMask#_1810_$_42;
	goto anon220;
anon1332_Then:
	assume $_$_condition_$166;
	assume $_$_condition_$166 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume unfoldingSecMask#_1810_$_46 == unfoldingSecMask#_1810_$_45[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := unfoldingSecMask#_1810_$_45[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := unfoldingSecMask#_1810_$_45[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$169) { goto anon1333_Then; } else { goto anon1333_Else; }
anon1332_Else:
	assume !$_$_condition_$166;
	assume $_$_condition_$166 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingSecMask#_1810_$_49 == unfoldingSecMask#_1810_$_45;
	goto anon225;
anon739:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_127,SecMask_$_127);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_127);
	assume SecMask_$_128 == SecMask_$_127[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_127[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_127[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$167) { goto anon1587_Then; } else { goto anon1587_Else; }
anon220:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_44,unfoldingSecMask#_1810_$_44);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_44);
	assume unfoldingSecMask#_1810_$_45 == unfoldingSecMask#_1810_$_44;
	goto $branchMerge_58;
anon1587_Then:
	assume $_$_condition_$167;
	assume SecMask_$_128[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_129 == SecMask_$_128[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_128[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_130 == SecMask_$_129;
	goto anon741;
anon1587_Else:
	assume !$_$_condition_$167;
	assume 0 <= SecMask_$_128[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_130 == SecMask_$_128;
	goto anon741;
anon741:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_130,SecMask_$_130);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_130);
	assume SecMask_$_131 == SecMask_$_130[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_130[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_130[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$170) { goto anon1588_Then; } else { goto anon1588_Else; }
anon1333_Then:
	assume $_$_condition_$169;
	assume unfoldingSecMask#_1810_$_46[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume unfoldingSecMask#_1810_$_47 == unfoldingSecMask#_1810_$_46[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := unfoldingSecMask#_1810_$_46[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume unfoldingSecMask#_1810_$_48 == unfoldingSecMask#_1810_$_47;
	goto anon224;
anon1333_Else:
	assume !$_$_condition_$169;
	assume 0 <= unfoldingSecMask#_1810_$_46[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume unfoldingSecMask#_1810_$_48 == unfoldingSecMask#_1810_$_46;
	goto anon224;
anon225:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_49,unfoldingSecMask#_1810_$_49);
	assume unfoldingSecMask#_1810_$_50 == unfoldingSecMask#_1810_$_49;
	goto $branchMerge_36;
anon1588_Then:
	assume $_$_condition_$170;
	assume SecMask_$_131[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_132 == SecMask_$_131[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_131[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_133 == SecMask_$_132;
	goto anon743;
anon1588_Else:
	assume !$_$_condition_$170;
	assume 0 <= SecMask_$_131[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_133 == SecMask_$_131;
	goto anon743;
anon224:
	assume wf(exhaleHeap#_1757_$_0,unfoldingSecMask#_1810_$_48,unfoldingSecMask#_1810_$_48);
	assume wf(exhaleHeap#_1757_$_0,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_48);
	assume unfoldingSecMask#_1810_$_49 == unfoldingSecMask#_1810_$_48;
	goto anon225;
anon743:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_133,SecMask_$_133);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_133);
	if ($_$_condition_$171) { goto anon1589_Then; } else { goto anon1589_Else; }
anon1589_Then:
	assume $_$_condition_$171;
	assume $_$_condition_$171 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_134 == SecMask_$_133[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_133[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_133[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$173) { goto anon1590_Then; } else { goto anon1590_Else; }
anon1589_Else:
	assume !$_$_condition_$171;
	assume $_$_condition_$171 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_137 == SecMask_$_133;
	goto $branchMerge_59;
anon1590_Then:
	assume $_$_condition_$173;
	assume SecMask_$_134[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_135 == SecMask_$_134[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_134[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_136 == SecMask_$_135;
	goto anon746;
anon1590_Else:
	assume !$_$_condition_$173;
	assume 0 <= SecMask_$_134[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_136 == SecMask_$_134;
	goto anon746;
anon1591_Then:
	assume $_$_condition_$174;
	assume $_$_condition_$174 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_138 == SecMask_$_137[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_137[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_137[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$179) { goto anon1592_Then; } else { goto anon1592_Else; }
anon1591_Else:
	assume !$_$_condition_$174;
	assume $_$_condition_$174 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_141 == SecMask_$_137;
	goto $branchMerge_60;
anon228:
	assume IsGoodMask(unfoldingMask#_1809_$_0);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_50);
	assume IsGoodMask(unfoldingMask#_1809_$_0);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_50);
	assume !(unfoldingHeap#_1808_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_0,unfoldingSecMask#_1810_$_50);
	assume true;
	assume Fractions(100) > 0;
	assume unfoldingMask#_1809_$_1 == unfoldingMask#_1809_$_0[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.key := unfoldingMask#_1809_$_0[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := unfoldingMask#_1809_$_0[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1809_$_1);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.key]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_1,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_1,unfoldingSecMask#_1810_$_50);
	assume !(unfoldingHeap#_1808_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_1,unfoldingSecMask#_1810_$_50);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1809_$_2 == unfoldingMask#_1809_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.height := unfoldingMask#_1809_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := unfoldingMask#_1809_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1809_$_2);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_2,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_2,unfoldingSecMask#_1810_$_50);
	assume !(unfoldingHeap#_1808_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_2,unfoldingSecMask#_1810_$_50);
	assume (unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null) || (dtype(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1809_$_3 == unfoldingMask#_1809_$_2[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left := unfoldingMask#_1809_$_2[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := unfoldingMask#_1809_$_2[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1809_$_3);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_3,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_3,unfoldingSecMask#_1810_$_50);
	assume !(unfoldingHeap#_1808_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_3,unfoldingSecMask#_1810_$_50);
	assume (unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null) || (dtype(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1809_$_4 == unfoldingMask#_1809_$_3[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right := unfoldingMask#_1809_$_3[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := unfoldingMask#_1809_$_3[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1809_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_4,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_4,unfoldingSecMask#_1810_$_50);
	assume !(unfoldingHeap#_1808_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_4,unfoldingSecMask#_1810_$_50);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1809_$_5 == unfoldingMask#_1809_$_4[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.keys := unfoldingMask#_1809_$_4[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := unfoldingMask#_1809_$_4[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1809_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_5,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_5,unfoldingSecMask#_1810_$_50);
	assume !(unfoldingHeap#_1808_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_5,unfoldingSecMask#_1810_$_50);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1809_$_6 == unfoldingMask#_1809_$_5[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingMask#_1809_$_5[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_1809_$_5[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1809_$_6);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_6,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_6,unfoldingSecMask#_1810_$_50);
	if ($_$_condition_$175) { goto anon1335_Then; } else { goto anon1335_Else; }
anon746:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_136,SecMask_$_136);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_136);
	assume SecMask_$_137 == SecMask_$_136;
	goto $branchMerge_59;
anon1335_Then:
	assume $_$_condition_$175;
	assume $_$_condition_$175 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_6,unfoldingSecMask#_1810_$_50);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1809_$_7 == unfoldingMask#_1809_$_6[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := unfoldingMask#_1809_$_6[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := unfoldingMask#_1809_$_6[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1809_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_7,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_7,unfoldingSecMask#_1810_$_50);
	assume unfoldingMask#_1809_$_8 == unfoldingMask#_1809_$_7;
	goto $branchMerge_61;
anon1335_Else:
	assume !$_$_condition_$175;
	assume $_$_condition_$175 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1809_$_8 == unfoldingMask#_1809_$_6;
	goto $branchMerge_61;
anon1336_Then:
	assume $_$_condition_$177;
	assume $_$_condition_$177 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_8,unfoldingSecMask#_1810_$_50);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1809_$_9 == unfoldingMask#_1809_$_8[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := unfoldingMask#_1809_$_8[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := unfoldingMask#_1809_$_8[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1809_$_9);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_9,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_9,unfoldingSecMask#_1810_$_50);
	assume unfoldingMask#_1809_$_10 == unfoldingMask#_1809_$_9;
	goto $branchMerge_62;
anon1336_Else:
	assume !$_$_condition_$177;
	assume $_$_condition_$177 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1809_$_10 == unfoldingMask#_1809_$_8;
	goto $branchMerge_62;
anon1592_Then:
	assume $_$_condition_$179;
	assume SecMask_$_138[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_139 == SecMask_$_138[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_138[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_140 == SecMask_$_139;
	goto anon750;
anon1592_Else:
	assume !$_$_condition_$179;
	assume 0 <= SecMask_$_138[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_140 == SecMask_$_138;
	goto anon750;
anon1593_Then:
	assume $_$_condition_$180;
	assume $_$_condition_$180 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_142 == SecMask_$_141[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_141[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_141[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$188) { goto anon1594_Then; } else { goto anon1594_Else; }
anon1593_Else:
	assume !$_$_condition_$180;
	assume $_$_condition_$180 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_145 == SecMask_$_141;
	goto $branchMerge_63;
anon1337_Then:
	assume $_$_condition_$181;
	assume $_$_condition_$181 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_10,unfoldingSecMask#_1810_$_50);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1809_$_11 == unfoldingMask#_1809_$_10[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := unfoldingMask#_1809_$_10[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := unfoldingMask#_1809_$_10[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1809_$_11);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_11,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_11,unfoldingSecMask#_1810_$_50);
	assume unfoldingMask#_1809_$_12 == unfoldingMask#_1809_$_11;
	goto $branchMerge_64;
anon1337_Else:
	assume !$_$_condition_$181;
	assume $_$_condition_$181 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1809_$_12 == unfoldingMask#_1809_$_10;
	goto $branchMerge_64;
anon750:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_140,SecMask_$_140);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_140);
	assume SecMask_$_141 == SecMask_$_140;
	goto $branchMerge_60;
anon1338_Then:
	assume $_$_condition_$183;
	assume $_$_condition_$183 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_12,unfoldingSecMask#_1810_$_50);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1809_$_13 == unfoldingMask#_1809_$_12[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingMask#_1809_$_12[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_1809_$_12[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1809_$_13);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_13,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_13,unfoldingSecMask#_1810_$_50);
	assume unfoldingMask#_1809_$_14 == unfoldingMask#_1809_$_13;
	goto $branchMerge_65;
anon1338_Else:
	assume !$_$_condition_$183;
	assume $_$_condition_$183 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1809_$_14 == unfoldingMask#_1809_$_12;
	goto $branchMerge_65;
anon1339_Then:
	assume $_$_condition_$186;
	assume $_$_condition_$186 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#539 : Integer :: ( ((0 <= lk#79#539) && (lk#79#539 < Seq#Length(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#539) < unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_66;
anon1339_Else:
	assume !$_$_condition_$186;
	assume $_$_condition_$186 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_66;
anon1594_Then:
	assume $_$_condition_$188;
	assume SecMask_$_142[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_143 == SecMask_$_142[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_142[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_144 == SecMask_$_143;
	goto anon754;
anon1594_Else:
	assume !$_$_condition_$188;
	assume 0 <= SecMask_$_142[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_144 == SecMask_$_142;
	goto anon754;
anon1595_Then:
	assume $_$_condition_$189;
	assume $_$_condition_$189 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_146 == SecMask_$_145[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_145[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_145[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$197) { goto anon1596_Then; } else { goto anon1596_Else; }
anon1595_Else:
	assume !$_$_condition_$189;
	assume $_$_condition_$189 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_149 == SecMask_$_145;
	goto $branchMerge_67;
anon1340_Then:
	assume $_$_condition_$190;
	assume $_$_condition_$190 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_68;
anon1340_Else:
	assume !$_$_condition_$190;
	assume $_$_condition_$190 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_68;
anon754:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_144,SecMask_$_144);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_144);
	assume SecMask_$_145 == SecMask_$_144;
	goto $branchMerge_63;
anon1341_Then:
	assume $_$_condition_$192;
	assume $_$_condition_$192 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_14,unfoldingSecMask#_1810_$_50);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1809_$_15 == unfoldingMask#_1809_$_14[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := unfoldingMask#_1809_$_14[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := unfoldingMask#_1809_$_14[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1809_$_15);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_15,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_15,unfoldingSecMask#_1810_$_50);
	assume unfoldingMask#_1809_$_16 == unfoldingMask#_1809_$_15;
	goto $branchMerge_69;
anon1341_Else:
	assume !$_$_condition_$192;
	assume $_$_condition_$192 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1809_$_16 == unfoldingMask#_1809_$_14;
	goto $branchMerge_69;
anon1342_Then:
	assume $_$_condition_$195;
	assume $_$_condition_$195 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_16,unfoldingSecMask#_1810_$_50);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1809_$_17 == unfoldingMask#_1809_$_16[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := unfoldingMask#_1809_$_16[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := unfoldingMask#_1809_$_16[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1809_$_17);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_17,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_17,unfoldingSecMask#_1810_$_50);
	assume unfoldingMask#_1809_$_18 == unfoldingMask#_1809_$_17;
	goto $branchMerge_70;
anon1342_Else:
	assume !$_$_condition_$195;
	assume $_$_condition_$195 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1809_$_18 == unfoldingMask#_1809_$_16;
	goto $branchMerge_70;
anon1596_Then:
	assume $_$_condition_$197;
	assume SecMask_$_146[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_147 == SecMask_$_146[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_146[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_148 == SecMask_$_147;
	goto anon758;
anon1596_Else:
	assume !$_$_condition_$197;
	assume 0 <= SecMask_$_146[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_148 == SecMask_$_146;
	goto anon758;
anon1597_Then:
	assume $_$_condition_$198;
	assume $_$_condition_$198 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_150 == SecMask_$_149[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_149[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_149[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$206) { goto anon1598_Then; } else { goto anon1598_Else; }
anon1597_Else:
	assume !$_$_condition_$198;
	assume $_$_condition_$198 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_153 == SecMask_$_149;
	goto $branchMerge_71;
anon1343_Then:
	assume $_$_condition_$199;
	assume $_$_condition_$199 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_18,unfoldingSecMask#_1810_$_50);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1809_$_19 == unfoldingMask#_1809_$_18[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := unfoldingMask#_1809_$_18[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := unfoldingMask#_1809_$_18[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1809_$_19);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_19,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_19,unfoldingSecMask#_1810_$_50);
	assume unfoldingMask#_1809_$_20 == unfoldingMask#_1809_$_19;
	goto $branchMerge_72;
anon1343_Else:
	assume !$_$_condition_$199;
	assume $_$_condition_$199 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1809_$_20 == unfoldingMask#_1809_$_18;
	goto $branchMerge_72;
anon758:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_148,SecMask_$_148);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_148);
	assume SecMask_$_149 == SecMask_$_148;
	goto $branchMerge_67;
anon1344_Then:
	assume $_$_condition_$201;
	assume $_$_condition_$201 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_20,unfoldingSecMask#_1810_$_50);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1809_$_21 == unfoldingMask#_1809_$_20[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := unfoldingMask#_1809_$_20[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_1809_$_20[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1809_$_21);
	assume IsGoodState(heapFragment(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_21,unfoldingSecMask#_1810_$_50);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_21,unfoldingSecMask#_1810_$_50);
	assume unfoldingMask#_1809_$_22 == unfoldingMask#_1809_$_21;
	goto $branchMerge_73;
anon1344_Else:
	assume !$_$_condition_$201;
	assume $_$_condition_$201 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1809_$_22 == unfoldingMask#_1809_$_20;
	goto $branchMerge_73;
anon1345_Then:
	assume $_$_condition_$204;
	assume $_$_condition_$204 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#540 : Integer :: ( ((0 <= rk#80#540) && (rk#80#540 < Seq#Length(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#540)) ));
	goto $branchMerge_74;
anon1345_Else:
	assume !$_$_condition_$204;
	assume $_$_condition_$204 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_74;
anon1598_Then:
	assume $_$_condition_$206;
	assume SecMask_$_150[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_151 == SecMask_$_150[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_150[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_152 == SecMask_$_151;
	goto anon762;
anon1598_Else:
	assume !$_$_condition_$206;
	assume 0 <= SecMask_$_150[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_152 == SecMask_$_150;
	goto anon762;
anon1599_Then:
	assume $_$_condition_$207;
	assume $_$_condition_$207 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_154 == SecMask_$_153[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_153[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_153[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$212) { goto anon1600_Then; } else { goto anon1600_Else; }
anon1599_Else:
	assume !$_$_condition_$207;
	assume $_$_condition_$207 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_157 == SecMask_$_153;
	goto $branchMerge_75;
anon1346_Then:
	assume $_$_condition_$208;
	assume $_$_condition_$208 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon252;
anon1346_Else:
	assume !$_$_condition_$208;
	assume $_$_condition_$208 <==> (!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon252;
anon762:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_152,SecMask_$_152);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_152);
	assume SecMask_$_153 == SecMask_$_152;
	goto $branchMerge_71;
anon252:
	assume Seq#Equal(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.key])),ite(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$5 : Integer :: ( Seq#Contains(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$5) <==> ((((!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$5)) || ((!(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$5))) || (kk#81_$5 == unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume unfoldingHeap#_1808_$_1[unfoldingHeap#_1808_$_1[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume IsGoodMask(unfoldingMask#_1809_$_22);
	assume wf(unfoldingHeap#_1808_$_1,unfoldingMask#_1809_$_22,unfoldingSecMask#_1810_$_50);
	if ($_$_condition_$211) { goto anon1347_Then; } else { goto anon1347_Else; }
anon1347_Then:
	assume $_$_condition_$211;
	assume $_$_condition_$211 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$214) { goto anon1348_Then; } else { goto anon1348_Else; }
anon1347_Else:
	assume !$_$_condition_$211;
	assume $_$_condition_$211 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume assertSecMask#_1804_$_50 == SecMask_$_94;
	goto anon309;
anon1600_Then:
	assume $_$_condition_$212;
	assume SecMask_$_154[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_155 == SecMask_$_154[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_154[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_156 == SecMask_$_155;
	goto anon766;
anon1600_Else:
	assume !$_$_condition_$212;
	assume 0 <= SecMask_$_154[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_156 == SecMask_$_154;
	goto anon766;
anon1601_Then:
	assume $_$_condition_$213;
	assume $_$_condition_$213 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_158 == SecMask_$_157[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_157[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_157[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$220) { goto anon1602_Then; } else { goto anon1602_Else; }
anon1601_Else:
	assume !$_$_condition_$213;
	assume $_$_condition_$213 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_161 == SecMask_$_157;
	goto $branchMerge_76;
anon1348_Then:
	assume $_$_condition_$214;
	assume $_$_condition_$214 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true;
	goto $branchMerge_77;
anon1348_Else:
	assume !$_$_condition_$214;
	assume $_$_condition_$214 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	goto $branchMerge_77;
anon309:
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_50);
	assume true;
	assume Fractions(100) > 0;
	assume assertSecMask#_1804_$_51 == assertSecMask#_1804_$_50[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key := assertSecMask#_1804_$_50[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := assertSecMask#_1804_$_50[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_51);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_51);
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_51);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1804_$_52 == assertSecMask#_1804_$_51[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_1804_$_51[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := assertSecMask#_1804_$_51[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_52);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_52);
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_52);
	assume (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null) || (dtype(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume assertSecMask#_1804_$_53 == assertSecMask#_1804_$_52[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left := assertSecMask#_1804_$_52[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := assertSecMask#_1804_$_52[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_53);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_53);
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_53);
	assume (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null) || (dtype(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume assertSecMask#_1804_$_54 == assertSecMask#_1804_$_53[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right := assertSecMask#_1804_$_53[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := assertSecMask#_1804_$_53[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_54);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_54);
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_54);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1804_$_55 == assertSecMask#_1804_$_54[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_1804_$_54[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := assertSecMask#_1804_$_54[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_55);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_55);
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_55);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1804_$_56 == assertSecMask#_1804_$_55[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_1804_$_55[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1804_$_55[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_56);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_56);
	if ($_$_condition_$289) { goto anon1375_Then; } else { goto anon1375_Else; }
anon766:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_156,SecMask_$_156);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_156);
	assume SecMask_$_157 == SecMask_$_156;
	goto $branchMerge_75;
anon1349_Then:
	assume $_$_condition_$215;
	assume $_$_condition_$215 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#541 : Integer :: ( ((0 <= lk#79#541) && (lk#79#541 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#541) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_78;
anon1349_Else:
	assume !$_$_condition_$215;
	assume $_$_condition_$215 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_78;
anon1350_Then:
	assume $_$_condition_$218;
	assume $_$_condition_$218 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_79;
anon1350_Else:
	assume !$_$_condition_$218;
	assume $_$_condition_$218 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_79;
anon1602_Then:
	assume $_$_condition_$220;
	assume SecMask_$_158[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_159 == SecMask_$_158[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_158[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_160 == SecMask_$_159;
	goto anon770;
anon1602_Else:
	assume !$_$_condition_$220;
	assume 0 <= SecMask_$_158[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_160 == SecMask_$_158;
	goto anon770;
anon1603_Then:
	assume $_$_condition_$221;
	assume $_$_condition_$221 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_162 == SecMask_$_161[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_161[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_161[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$227) { goto anon1604_Then; } else { goto anon1604_Else; }
anon1603_Else:
	assume !$_$_condition_$221;
	assume $_$_condition_$221 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_165 == SecMask_$_161;
	goto anon775;
anon1351_Then:
	assume $_$_condition_$222;
	assume $_$_condition_$222 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#542 : Integer :: ( ((0 <= rk#80#542) && (rk#80#542 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#542)) ));
	goto $branchMerge_80;
anon1351_Else:
	assume !$_$_condition_$222;
	assume $_$_condition_$222 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_80;
anon770:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_160,SecMask_$_160);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_160);
	assume SecMask_$_161 == SecMask_$_160;
	goto $branchMerge_76;
anon1352_Then:
	assume $_$_condition_$224;
	assume $_$_condition_$224 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon264;
anon1352_Else:
	assume !$_$_condition_$224;
	assume $_$_condition_$224 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon264;
anon264:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$6 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$6) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$6)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$6))) || (kk#81_$6 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume assertSecMask#_1804_$_0 == SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$228) { goto anon1353_Then; } else { goto anon1353_Else; }
anon1604_Then:
	assume $_$_condition_$227;
	assume SecMask_$_162[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_163 == SecMask_$_162[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_162[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_164 == SecMask_$_163;
	goto anon774;
anon1604_Else:
	assume !$_$_condition_$227;
	assume 0 <= SecMask_$_162[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_164 == SecMask_$_162;
	goto anon774;
anon775:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_165,SecMask_$_165);
	assume SecMask_$_166 == SecMask_$_165;
	goto anon776;
anon1353_Then:
	assume $_$_condition_$228;
	assume assertSecMask#_1804_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume assertSecMask#_1804_$_1 == assertSecMask#_1804_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key := assertSecMask#_1804_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume assertSecMask#_1804_$_2 == assertSecMask#_1804_$_1;
	goto anon266;
anon1353_Else:
	assume !$_$_condition_$228;
	assume 0 <= assertSecMask#_1804_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume assertSecMask#_1804_$_2 == assertSecMask#_1804_$_0;
	goto anon266;
anon774:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_164,SecMask_$_164);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_164);
	assume SecMask_$_165 == SecMask_$_164;
	goto anon775;
anon266:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_2,assertSecMask#_1804_$_2);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_2);
	assume assertSecMask#_1804_$_3 == assertSecMask#_1804_$_2[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_1804_$_2[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := assertSecMask#_1804_$_2[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$229) { goto anon1354_Then; } else { goto anon1354_Else; }
anon1354_Then:
	assume $_$_condition_$229;
	assume assertSecMask#_1804_$_3[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume assertSecMask#_1804_$_4 == assertSecMask#_1804_$_3[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_1804_$_3[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume assertSecMask#_1804_$_5 == assertSecMask#_1804_$_4;
	goto anon268;
anon1354_Else:
	assume !$_$_condition_$229;
	assume 0 <= assertSecMask#_1804_$_3[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume assertSecMask#_1804_$_5 == assertSecMask#_1804_$_3;
	goto anon268;
anon268:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_5,assertSecMask#_1804_$_5);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_5);
	assume assertSecMask#_1804_$_6 == assertSecMask#_1804_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left := assertSecMask#_1804_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := assertSecMask#_1804_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$231) { goto anon1355_Then; } else { goto anon1355_Else; }
anon1355_Then:
	assume $_$_condition_$231;
	assume assertSecMask#_1804_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume assertSecMask#_1804_$_7 == assertSecMask#_1804_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left := assertSecMask#_1804_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume assertSecMask#_1804_$_8 == assertSecMask#_1804_$_7;
	goto anon270;
anon1355_Else:
	assume !$_$_condition_$231;
	assume 0 <= assertSecMask#_1804_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume assertSecMask#_1804_$_8 == assertSecMask#_1804_$_6;
	goto anon270;
anon1606_Then:
	assume $_$_condition_$232;
	assume SecMask_$_168[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_169 == SecMask_$_168[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_168[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_170 == SecMask_$_169;
	goto anon780;
anon1606_Else:
	assume !$_$_condition_$232;
	assume 0 <= SecMask_$_168[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_170 == SecMask_$_168;
	goto anon780;
anon1607_Then:
	assume $_$_condition_$233;
	assume $_$_condition_$233 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_172 == SecMask_$_171[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_171[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_171[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$236) { goto anon1608_Then; } else { goto anon1608_Else; }
anon1607_Else:
	assume !$_$_condition_$233;
	assume $_$_condition_$233 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_175 == SecMask_$_171;
	goto $branchMerge_81;
anon270:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_8,assertSecMask#_1804_$_8);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_8);
	assume assertSecMask#_1804_$_9 == assertSecMask#_1804_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right := assertSecMask#_1804_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := assertSecMask#_1804_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$234) { goto anon1356_Then; } else { goto anon1356_Else; }
anon780:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_170,SecMask_$_170);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_170);
	assume SecMask_$_171 == SecMask_$_170;
	goto $branchMerge_49;
anon1356_Then:
	assume $_$_condition_$234;
	assume assertSecMask#_1804_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume assertSecMask#_1804_$_10 == assertSecMask#_1804_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right := assertSecMask#_1804_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume assertSecMask#_1804_$_11 == assertSecMask#_1804_$_10;
	goto anon272;
anon1356_Else:
	assume !$_$_condition_$234;
	assume 0 <= assertSecMask#_1804_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume assertSecMask#_1804_$_11 == assertSecMask#_1804_$_9;
	goto anon272;
anon272:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_11,assertSecMask#_1804_$_11);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_11);
	assume assertSecMask#_1804_$_12 == assertSecMask#_1804_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_1804_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := assertSecMask#_1804_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$238) { goto anon1357_Then; } else { goto anon1357_Else; }
anon1608_Then:
	assume $_$_condition_$236;
	assume SecMask_$_172[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_173 == SecMask_$_172[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_172[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_174 == SecMask_$_173;
	goto anon784;
anon1608_Else:
	assume !$_$_condition_$236;
	assume 0 <= SecMask_$_172[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_174 == SecMask_$_172;
	goto anon784;
anon1609_Then:
	assume $_$_condition_$237;
	assume $_$_condition_$237 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_176 == SecMask_$_175[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_175[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_175[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$241) { goto anon1610_Then; } else { goto anon1610_Else; }
anon1609_Else:
	assume !$_$_condition_$237;
	assume $_$_condition_$237 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_179 == SecMask_$_175;
	goto $branchMerge_82;
anon1357_Then:
	assume $_$_condition_$238;
	assume assertSecMask#_1804_$_12[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume assertSecMask#_1804_$_13 == assertSecMask#_1804_$_12[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_1804_$_12[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume assertSecMask#_1804_$_14 == assertSecMask#_1804_$_13;
	goto anon274;
anon1357_Else:
	assume !$_$_condition_$238;
	assume 0 <= assertSecMask#_1804_$_12[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume assertSecMask#_1804_$_14 == assertSecMask#_1804_$_12;
	goto anon274;
anon784:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_174,SecMask_$_174);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_174);
	assume SecMask_$_175 == SecMask_$_174;
	goto $branchMerge_81;
anon274:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_14,assertSecMask#_1804_$_14);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_14);
	assume assertSecMask#_1804_$_15 == assertSecMask#_1804_$_14[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_1804_$_14[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1804_$_14[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$240) { goto anon1358_Then; } else { goto anon1358_Else; }
anon1358_Then:
	assume $_$_condition_$240;
	assume assertSecMask#_1804_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume assertSecMask#_1804_$_16 == assertSecMask#_1804_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_1804_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume assertSecMask#_1804_$_17 == assertSecMask#_1804_$_16;
	goto anon276;
anon1358_Else:
	assume !$_$_condition_$240;
	assume 0 <= assertSecMask#_1804_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume assertSecMask#_1804_$_17 == assertSecMask#_1804_$_15;
	goto anon276;
anon1610_Then:
	assume $_$_condition_$241;
	assume SecMask_$_176[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_177 == SecMask_$_176[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_176[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_178 == SecMask_$_177;
	goto anon788;
anon1610_Else:
	assume !$_$_condition_$241;
	assume 0 <= SecMask_$_176[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_178 == SecMask_$_176;
	goto anon788;
anon1611_Then:
	assume $_$_condition_$242;
	assume $_$_condition_$242 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_180 == SecMask_$_179[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_179[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_179[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$247) { goto anon1612_Then; } else { goto anon1612_Else; }
anon1611_Else:
	assume !$_$_condition_$242;
	assume $_$_condition_$242 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_234 == SecMask_$_179;
	goto $branchMerge_83;
anon276:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_17,assertSecMask#_1804_$_17);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_17);
	if ($_$_condition_$243) { goto anon1359_Then; } else { goto anon1359_Else; }
anon788:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_178,SecMask_$_178);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_178);
	assume SecMask_$_179 == SecMask_$_178;
	goto $branchMerge_82;
anon1359_Then:
	assume $_$_condition_$243;
	assume $_$_condition_$243 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume assertSecMask#_1804_$_18 == assertSecMask#_1804_$_17[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := assertSecMask#_1804_$_17[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := assertSecMask#_1804_$_17[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$245) { goto anon1360_Then; } else { goto anon1360_Else; }
anon1359_Else:
	assume !$_$_condition_$243;
	assume $_$_condition_$243 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1804_$_21 == assertSecMask#_1804_$_17;
	goto $branchMerge_84;
anon1360_Then:
	assume $_$_condition_$245;
	assume assertSecMask#_1804_$_18[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume assertSecMask#_1804_$_19 == assertSecMask#_1804_$_18[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := assertSecMask#_1804_$_18[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume assertSecMask#_1804_$_20 == assertSecMask#_1804_$_19;
	goto anon279;
anon1360_Else:
	assume !$_$_condition_$245;
	assume 0 <= assertSecMask#_1804_$_18[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume assertSecMask#_1804_$_20 == assertSecMask#_1804_$_18;
	goto anon279;
anon1361_Then:
	assume $_$_condition_$246;
	assume $_$_condition_$246 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume assertSecMask#_1804_$_22 == assertSecMask#_1804_$_21[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_1804_$_21[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := assertSecMask#_1804_$_21[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$251) { goto anon1362_Then; } else { goto anon1362_Else; }
anon1361_Else:
	assume !$_$_condition_$246;
	assume $_$_condition_$246 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1804_$_25 == assertSecMask#_1804_$_21;
	goto $branchMerge_85;
anon1612_Then:
	assume $_$_condition_$247;
	assume SecMask_$_180[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_181 == SecMask_$_180[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_180[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_182 == SecMask_$_181;
	goto anon792;
anon1612_Else:
	assume !$_$_condition_$247;
	assume 0 <= SecMask_$_180[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_182 == SecMask_$_180;
	goto anon792;
anon1641_Then:
	assume $_$_condition_$248;
	assume $_$_condition_$248 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_235 == SecMask_$_234[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_234[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_234[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$345) { goto anon1642_Then; } else { goto anon1642_Else; }
anon1641_Else:
	assume !$_$_condition_$248;
	assume $_$_condition_$248 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_238 == SecMask_$_234;
	goto $branchMerge_86;
anon279:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_20,assertSecMask#_1804_$_20);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_20);
	assume assertSecMask#_1804_$_21 == assertSecMask#_1804_$_20;
	goto $branchMerge_84;
anon792:
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == exhaleHeap#_1757_$_0[this,AVLTreeNode.left]);
	if ($_$_condition_$250) { goto anon1613_Then; } else { goto anon1613_Else; }
anon1613_Then:
	assume $_$_condition_$250;
	assume $_$_condition_$250 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$253) { goto anon1614_Then; } else { goto anon1614_Else; }
anon1613_Else:
	assume !$_$_condition_$250;
	assume $_$_condition_$250 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true));
	assume SecMask_$_233 == SecMask_$_182;
	goto anon849;
anon1362_Then:
	assume $_$_condition_$251;
	assume assertSecMask#_1804_$_22[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume assertSecMask#_1804_$_23 == assertSecMask#_1804_$_22[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_1804_$_22[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume assertSecMask#_1804_$_24 == assertSecMask#_1804_$_23;
	goto anon283;
anon1362_Else:
	assume !$_$_condition_$251;
	assume 0 <= assertSecMask#_1804_$_22[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume assertSecMask#_1804_$_24 == assertSecMask#_1804_$_22;
	goto anon283;
anon1363_Then:
	assume $_$_condition_$252;
	assume $_$_condition_$252 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume assertSecMask#_1804_$_26 == assertSecMask#_1804_$_25[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_1804_$_25[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := assertSecMask#_1804_$_25[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$259) { goto anon1364_Then; } else { goto anon1364_Else; }
anon1363_Else:
	assume !$_$_condition_$252;
	assume $_$_condition_$252 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1804_$_29 == assertSecMask#_1804_$_25;
	goto $branchMerge_87;
anon1614_Then:
	assume $_$_condition_$253;
	assume $_$_condition_$253 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true;
	goto $branchMerge_88;
anon1614_Else:
	assume !$_$_condition_$253;
	assume $_$_condition_$253 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true);
	goto $branchMerge_88;
anon849:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_233,SecMask_$_233);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_233);
	assume SecMask_$_234 == SecMask_$_233;
	goto $branchMerge_83;
anon283:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_24,assertSecMask#_1804_$_24);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_24);
	assume assertSecMask#_1804_$_25 == assertSecMask#_1804_$_24;
	goto $branchMerge_85;
anon1615_Then:
	assume $_$_condition_$254;
	assume $_$_condition_$254 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#589 : Integer :: ( ((0 <= lk#79#589) && (lk#79#589 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#589) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_89;
anon1615_Else:
	assume !$_$_condition_$254;
	assume $_$_condition_$254 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_89;
anon1616_Then:
	assume $_$_condition_$257;
	assume $_$_condition_$257 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_90;
anon1616_Else:
	assume !$_$_condition_$257;
	assume $_$_condition_$257 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_90;
anon1364_Then:
	assume $_$_condition_$259;
	assume assertSecMask#_1804_$_26[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume assertSecMask#_1804_$_27 == assertSecMask#_1804_$_26[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_1804_$_26[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume assertSecMask#_1804_$_28 == assertSecMask#_1804_$_27;
	goto anon287;
anon1364_Else:
	assume !$_$_condition_$259;
	assume 0 <= assertSecMask#_1804_$_26[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume assertSecMask#_1804_$_28 == assertSecMask#_1804_$_26;
	goto anon287;
anon1365_Then:
	assume $_$_condition_$260;
	assume $_$_condition_$260 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume assertSecMask#_1804_$_30 == assertSecMask#_1804_$_29[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_1804_$_29[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1804_$_29[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$266) { goto anon1366_Then; } else { goto anon1366_Else; }
anon1365_Else:
	assume !$_$_condition_$260;
	assume $_$_condition_$260 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1804_$_33 == assertSecMask#_1804_$_29;
	goto $branchMerge_91;
anon1617_Then:
	assume $_$_condition_$261;
	assume $_$_condition_$261 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#590 : Integer :: ( ((0 <= rk#80#590) && (rk#80#590 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#590)) ));
	goto $branchMerge_92;
anon1617_Else:
	assume !$_$_condition_$261;
	assume $_$_condition_$261 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_92;
anon287:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_28,assertSecMask#_1804_$_28);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_28);
	assume assertSecMask#_1804_$_29 == assertSecMask#_1804_$_28;
	goto $branchMerge_87;
anon1618_Then:
	assume $_$_condition_$263;
	assume $_$_condition_$263 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon804;
anon1618_Else:
	assume !$_$_condition_$263;
	assume $_$_condition_$263 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon804;
anon804:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$7 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$7) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$7)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$7))) || (kk#81_$7 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume SecMask_$_183 == SecMask_$_182[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key := SecMask_$_182[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key][perm$R := SecMask_$_182[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$268) { goto anon1619_Then; } else { goto anon1619_Else; }
anon1366_Then:
	assume $_$_condition_$266;
	assume assertSecMask#_1804_$_30[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume assertSecMask#_1804_$_31 == assertSecMask#_1804_$_30[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_1804_$_30[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume assertSecMask#_1804_$_32 == assertSecMask#_1804_$_31;
	goto anon291;
anon1366_Else:
	assume !$_$_condition_$266;
	assume 0 <= assertSecMask#_1804_$_30[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume assertSecMask#_1804_$_32 == assertSecMask#_1804_$_30;
	goto anon291;
anon1367_Then:
	assume $_$_condition_$267;
	assume $_$_condition_$267 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume assertSecMask#_1804_$_34 == assertSecMask#_1804_$_33[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := assertSecMask#_1804_$_33[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := assertSecMask#_1804_$_33[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$271) { goto anon1368_Then; } else { goto anon1368_Else; }
anon1367_Else:
	assume !$_$_condition_$267;
	assume $_$_condition_$267 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1804_$_37 == assertSecMask#_1804_$_33;
	goto $branchMerge_93;
anon1619_Then:
	assume $_$_condition_$268;
	assume SecMask_$_183[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_184 == SecMask_$_183[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key := SecMask_$_183[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_185 == SecMask_$_184;
	goto anon806;
anon1619_Else:
	assume !$_$_condition_$268;
	assume 0 <= SecMask_$_183[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_185 == SecMask_$_183;
	goto anon806;
anon291:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_32,assertSecMask#_1804_$_32);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_32);
	assume assertSecMask#_1804_$_33 == assertSecMask#_1804_$_32;
	goto $branchMerge_91;
anon806:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_185,SecMask_$_185);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_185);
	assume SecMask_$_186 == SecMask_$_185[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_185[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_185[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$270) { goto anon1620_Then; } else { goto anon1620_Else; }
anon1620_Then:
	assume $_$_condition_$270;
	assume SecMask_$_186[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_187 == SecMask_$_186[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_186[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_188 == SecMask_$_187;
	goto anon808;
anon1620_Else:
	assume !$_$_condition_$270;
	assume 0 <= SecMask_$_186[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_188 == SecMask_$_186;
	goto anon808;
anon1368_Then:
	assume $_$_condition_$271;
	assume assertSecMask#_1804_$_34[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume assertSecMask#_1804_$_35 == assertSecMask#_1804_$_34[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := assertSecMask#_1804_$_34[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume assertSecMask#_1804_$_36 == assertSecMask#_1804_$_35;
	goto anon295;
anon1368_Else:
	assume !$_$_condition_$271;
	assume 0 <= assertSecMask#_1804_$_34[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume assertSecMask#_1804_$_36 == assertSecMask#_1804_$_34;
	goto anon295;
anon1369_Then:
	assume $_$_condition_$272;
	assume $_$_condition_$272 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume assertSecMask#_1804_$_38 == assertSecMask#_1804_$_37[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := assertSecMask#_1804_$_37[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := assertSecMask#_1804_$_37[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$275) { goto anon1370_Then; } else { goto anon1370_Else; }
anon1369_Else:
	assume !$_$_condition_$272;
	assume $_$_condition_$272 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1804_$_41 == assertSecMask#_1804_$_37;
	goto $branchMerge_94;
anon808:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_188,SecMask_$_188);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_188);
	assume SecMask_$_189 == SecMask_$_188[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left := SecMask_$_188[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_188[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$273) { goto anon1621_Then; } else { goto anon1621_Else; }
anon295:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_36,assertSecMask#_1804_$_36);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_36);
	assume assertSecMask#_1804_$_37 == assertSecMask#_1804_$_36;
	goto $branchMerge_93;
anon1621_Then:
	assume $_$_condition_$273;
	assume SecMask_$_189[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_190 == SecMask_$_189[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left := SecMask_$_189[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_191 == SecMask_$_190;
	goto anon810;
anon1621_Else:
	assume !$_$_condition_$273;
	assume 0 <= SecMask_$_189[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_191 == SecMask_$_189;
	goto anon810;
anon810:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_191,SecMask_$_191);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_191);
	assume SecMask_$_192 == SecMask_$_191[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right := SecMask_$_191[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_191[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$277) { goto anon1622_Then; } else { goto anon1622_Else; }
anon1370_Then:
	assume $_$_condition_$275;
	assume assertSecMask#_1804_$_38[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume assertSecMask#_1804_$_39 == assertSecMask#_1804_$_38[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := assertSecMask#_1804_$_38[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume assertSecMask#_1804_$_40 == assertSecMask#_1804_$_39;
	goto anon299;
anon1370_Else:
	assume !$_$_condition_$275;
	assume 0 <= assertSecMask#_1804_$_38[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume assertSecMask#_1804_$_40 == assertSecMask#_1804_$_38;
	goto anon299;
anon1371_Then:
	assume $_$_condition_$276;
	assume $_$_condition_$276 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume assertSecMask#_1804_$_42 == assertSecMask#_1804_$_41[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := assertSecMask#_1804_$_41[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := assertSecMask#_1804_$_41[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$280) { goto anon1372_Then; } else { goto anon1372_Else; }
anon1371_Else:
	assume !$_$_condition_$276;
	assume $_$_condition_$276 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1804_$_45 == assertSecMask#_1804_$_41;
	goto $branchMerge_95;
anon1622_Then:
	assume $_$_condition_$277;
	assume SecMask_$_192[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_193 == SecMask_$_192[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right := SecMask_$_192[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_194 == SecMask_$_193;
	goto anon812;
anon1622_Else:
	assume !$_$_condition_$277;
	assume 0 <= SecMask_$_192[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_194 == SecMask_$_192;
	goto anon812;
anon299:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_40,assertSecMask#_1804_$_40);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_40);
	assume assertSecMask#_1804_$_41 == assertSecMask#_1804_$_40;
	goto $branchMerge_94;
anon812:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_194,SecMask_$_194);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_194);
	assume SecMask_$_195 == SecMask_$_194[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_194[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_194[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$279) { goto anon1623_Then; } else { goto anon1623_Else; }
anon1623_Then:
	assume $_$_condition_$279;
	assume SecMask_$_195[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_196 == SecMask_$_195[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_195[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_197 == SecMask_$_196;
	goto anon814;
anon1623_Else:
	assume !$_$_condition_$279;
	assume 0 <= SecMask_$_195[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_197 == SecMask_$_195;
	goto anon814;
anon1372_Then:
	assume $_$_condition_$280;
	assume assertSecMask#_1804_$_42[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume assertSecMask#_1804_$_43 == assertSecMask#_1804_$_42[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := assertSecMask#_1804_$_42[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume assertSecMask#_1804_$_44 == assertSecMask#_1804_$_43;
	goto anon303;
anon1372_Else:
	assume !$_$_condition_$280;
	assume 0 <= assertSecMask#_1804_$_42[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume assertSecMask#_1804_$_44 == assertSecMask#_1804_$_42;
	goto anon303;
anon1373_Then:
	assume $_$_condition_$281;
	assume $_$_condition_$281 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume assertSecMask#_1804_$_46 == assertSecMask#_1804_$_45[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := assertSecMask#_1804_$_45[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1804_$_45[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$284) { goto anon1374_Then; } else { goto anon1374_Else; }
anon1373_Else:
	assume !$_$_condition_$281;
	assume $_$_condition_$281 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1804_$_49 == assertSecMask#_1804_$_45;
	goto anon308;
anon814:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_197,SecMask_$_197);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_197);
	assume SecMask_$_198 == SecMask_$_197[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_197[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_197[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$282) { goto anon1624_Then; } else { goto anon1624_Else; }
anon303:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_44,assertSecMask#_1804_$_44);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_44);
	assume assertSecMask#_1804_$_45 == assertSecMask#_1804_$_44;
	goto $branchMerge_95;
anon1624_Then:
	assume $_$_condition_$282;
	assume SecMask_$_198[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_199 == SecMask_$_198[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_198[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_200 == SecMask_$_199;
	goto anon816;
anon1624_Else:
	assume !$_$_condition_$282;
	assume 0 <= SecMask_$_198[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_200 == SecMask_$_198;
	goto anon816;
anon816:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_200,SecMask_$_200);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_200);
	if ($_$_condition_$285) { goto anon1625_Then; } else { goto anon1625_Else; }
anon1374_Then:
	assume $_$_condition_$284;
	assume assertSecMask#_1804_$_46[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume assertSecMask#_1804_$_47 == assertSecMask#_1804_$_46[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := assertSecMask#_1804_$_46[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume assertSecMask#_1804_$_48 == assertSecMask#_1804_$_47;
	goto anon307;
anon1374_Else:
	assume !$_$_condition_$284;
	assume 0 <= assertSecMask#_1804_$_46[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume assertSecMask#_1804_$_48 == assertSecMask#_1804_$_46;
	goto anon307;
anon308:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_49,assertSecMask#_1804_$_49);
	assume assertSecMask#_1804_$_50 == assertSecMask#_1804_$_49;
	goto anon309;
anon1625_Then:
	assume $_$_condition_$285;
	assume $_$_condition_$285 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_201 == SecMask_$_200[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_200[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_200[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$286) { goto anon1626_Then; } else { goto anon1626_Else; }
anon1625_Else:
	assume !$_$_condition_$285;
	assume $_$_condition_$285 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_204 == SecMask_$_200;
	goto $branchMerge_96;
anon307:
	assume wf(exhaleHeap#_1757_$_0,assertSecMask#_1804_$_48,assertSecMask#_1804_$_48);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_48);
	assume assertSecMask#_1804_$_49 == assertSecMask#_1804_$_48;
	goto anon308;
anon1626_Then:
	assume $_$_condition_$286;
	assume SecMask_$_201[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_202 == SecMask_$_201[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_201[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_203 == SecMask_$_202;
	goto anon819;
anon1626_Else:
	assume !$_$_condition_$286;
	assume 0 <= SecMask_$_201[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_203 == SecMask_$_201;
	goto anon819;
anon1627_Then:
	assume $_$_condition_$287;
	assume $_$_condition_$287 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_205 == SecMask_$_204[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_204[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_204[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$290) { goto anon1628_Then; } else { goto anon1628_Else; }
anon1627_Else:
	assume !$_$_condition_$287;
	assume $_$_condition_$287 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_208 == SecMask_$_204;
	goto $branchMerge_97;
anon819:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_203,SecMask_$_203);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_203);
	assume SecMask_$_204 == SecMask_$_203;
	goto $branchMerge_96;
anon1375_Then:
	assume $_$_condition_$289;
	assume $_$_condition_$289 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_56);
	assume Fractions(100) > 0;
	assume assertSecMask#_1804_$_57 == assertSecMask#_1804_$_56[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := assertSecMask#_1804_$_56[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := assertSecMask#_1804_$_56[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_57);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_57);
	assume assertSecMask#_1804_$_58 == assertSecMask#_1804_$_57;
	goto $branchMerge_98;
anon1375_Else:
	assume !$_$_condition_$289;
	assume $_$_condition_$289 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1804_$_58 == assertSecMask#_1804_$_56;
	goto $branchMerge_98;
anon1628_Then:
	assume $_$_condition_$290;
	assume SecMask_$_205[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_206 == SecMask_$_205[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_205[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_207 == SecMask_$_206;
	goto anon823;
anon1628_Else:
	assume !$_$_condition_$290;
	assume 0 <= SecMask_$_205[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_207 == SecMask_$_205;
	goto anon823;
anon1629_Then:
	assume $_$_condition_$291;
	assume $_$_condition_$291 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_209 == SecMask_$_208[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_208[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_208[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$299) { goto anon1630_Then; } else { goto anon1630_Else; }
anon1629_Else:
	assume !$_$_condition_$291;
	assume $_$_condition_$291 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_212 == SecMask_$_208;
	goto $branchMerge_99;
anon1376_Then:
	assume $_$_condition_$292;
	assume $_$_condition_$292 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_58);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1804_$_59 == assertSecMask#_1804_$_58[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_1804_$_58[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := assertSecMask#_1804_$_58[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_59);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_59);
	assume assertSecMask#_1804_$_60 == assertSecMask#_1804_$_59;
	goto $branchMerge_100;
anon1376_Else:
	assume !$_$_condition_$292;
	assume $_$_condition_$292 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1804_$_60 == assertSecMask#_1804_$_58;
	goto $branchMerge_100;
anon823:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_207,SecMask_$_207);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_207);
	assume SecMask_$_208 == SecMask_$_207;
	goto $branchMerge_97;
anon1377_Then:
	assume $_$_condition_$294;
	assume $_$_condition_$294 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_60);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1804_$_61 == assertSecMask#_1804_$_60[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_1804_$_60[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := assertSecMask#_1804_$_60[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_61);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_61);
	assume assertSecMask#_1804_$_62 == assertSecMask#_1804_$_61;
	goto $branchMerge_101;
anon1377_Else:
	assume !$_$_condition_$294;
	assume $_$_condition_$294 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1804_$_62 == assertSecMask#_1804_$_60;
	goto $branchMerge_101;
anon1378_Then:
	assume $_$_condition_$297;
	assume $_$_condition_$297 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_62);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1804_$_63 == assertSecMask#_1804_$_62[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_1804_$_62[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1804_$_62[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_63);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_63);
	assume assertSecMask#_1804_$_64 == assertSecMask#_1804_$_63;
	goto $branchMerge_102;
anon1378_Else:
	assume !$_$_condition_$297;
	assume $_$_condition_$297 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1804_$_64 == assertSecMask#_1804_$_62;
	goto $branchMerge_102;
anon1630_Then:
	assume $_$_condition_$299;
	assume SecMask_$_209[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_210 == SecMask_$_209[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_209[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_211 == SecMask_$_210;
	goto anon827;
anon1630_Else:
	assume !$_$_condition_$299;
	assume 0 <= SecMask_$_209[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_211 == SecMask_$_209;
	goto anon827;
anon1631_Then:
	assume $_$_condition_$300;
	assume $_$_condition_$300 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_213 == SecMask_$_212[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_212[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_212[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$308) { goto anon1632_Then; } else { goto anon1632_Else; }
anon1631_Else:
	assume !$_$_condition_$300;
	assume $_$_condition_$300 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_216 == SecMask_$_212;
	goto $branchMerge_103;
anon1379_Then:
	assume $_$_condition_$301;
	assume $_$_condition_$301 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#545 : Integer :: ( ((0 <= lk#79#545) && (lk#79#545 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#545) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_104;
anon1379_Else:
	assume !$_$_condition_$301;
	assume $_$_condition_$301 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_104;
anon827:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_211,SecMask_$_211);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_211);
	assume SecMask_$_212 == SecMask_$_211;
	goto $branchMerge_99;
anon1380_Then:
	assume $_$_condition_$303;
	assume $_$_condition_$303 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_105;
anon1380_Else:
	assume !$_$_condition_$303;
	assume $_$_condition_$303 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_105;
anon1381_Then:
	assume $_$_condition_$306;
	assume $_$_condition_$306 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_64);
	assume Fractions(100) > 0;
	assume assertSecMask#_1804_$_65 == assertSecMask#_1804_$_64[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := assertSecMask#_1804_$_64[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := assertSecMask#_1804_$_64[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_65);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_65);
	assume assertSecMask#_1804_$_66 == assertSecMask#_1804_$_65;
	goto $branchMerge_106;
anon1381_Else:
	assume !$_$_condition_$306;
	assume $_$_condition_$306 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1804_$_66 == assertSecMask#_1804_$_64;
	goto $branchMerge_106;
anon1632_Then:
	assume $_$_condition_$308;
	assume SecMask_$_213[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_214 == SecMask_$_213[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_213[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_215 == SecMask_$_214;
	goto anon831;
anon1632_Else:
	assume !$_$_condition_$308;
	assume 0 <= SecMask_$_213[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_215 == SecMask_$_213;
	goto anon831;
anon1633_Then:
	assume $_$_condition_$309;
	assume $_$_condition_$309 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_217 == SecMask_$_216[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_216[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_216[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$317) { goto anon1634_Then; } else { goto anon1634_Else; }
anon1633_Else:
	assume !$_$_condition_$309;
	assume $_$_condition_$309 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_220 == SecMask_$_216;
	goto $branchMerge_107;
anon1382_Then:
	assume $_$_condition_$310;
	assume $_$_condition_$310 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_66);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1804_$_67 == assertSecMask#_1804_$_66[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := assertSecMask#_1804_$_66[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := assertSecMask#_1804_$_66[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_67);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_67);
	assume assertSecMask#_1804_$_68 == assertSecMask#_1804_$_67;
	goto $branchMerge_108;
anon1382_Else:
	assume !$_$_condition_$310;
	assume $_$_condition_$310 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1804_$_68 == assertSecMask#_1804_$_66;
	goto $branchMerge_108;
anon831:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_215,SecMask_$_215);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_215);
	assume SecMask_$_216 == SecMask_$_215;
	goto $branchMerge_103;
anon1383_Then:
	assume $_$_condition_$312;
	assume $_$_condition_$312 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_68);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1804_$_69 == assertSecMask#_1804_$_68[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := assertSecMask#_1804_$_68[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := assertSecMask#_1804_$_68[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_69);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_69);
	assume assertSecMask#_1804_$_70 == assertSecMask#_1804_$_69;
	goto $branchMerge_109;
anon1383_Else:
	assume !$_$_condition_$312;
	assume $_$_condition_$312 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1804_$_70 == assertSecMask#_1804_$_68;
	goto $branchMerge_109;
anon1384_Then:
	assume $_$_condition_$315;
	assume $_$_condition_$315 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_70);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1804_$_71 == assertSecMask#_1804_$_70[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := assertSecMask#_1804_$_70[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1804_$_70[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_71);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_71);
	assume assertSecMask#_1804_$_72 == assertSecMask#_1804_$_71;
	goto $branchMerge_110;
anon1384_Else:
	assume !$_$_condition_$315;
	assume $_$_condition_$315 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1804_$_72 == assertSecMask#_1804_$_70;
	goto $branchMerge_110;
anon1634_Then:
	assume $_$_condition_$317;
	assume SecMask_$_217[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_218 == SecMask_$_217[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_217[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_219 == SecMask_$_218;
	goto anon835;
anon1634_Else:
	assume !$_$_condition_$317;
	assume 0 <= SecMask_$_217[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_219 == SecMask_$_217;
	goto anon835;
anon1635_Then:
	assume $_$_condition_$318;
	assume $_$_condition_$318 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_221 == SecMask_$_220[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_220[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_220[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$324) { goto anon1636_Then; } else { goto anon1636_Else; }
anon1635_Else:
	assume !$_$_condition_$318;
	assume $_$_condition_$318 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_224 == SecMask_$_220;
	goto $branchMerge_111;
anon1385_Then:
	assume $_$_condition_$319;
	assume $_$_condition_$319 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#546 : Integer :: ( ((0 <= rk#80#546) && (rk#80#546 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#546)) ));
	goto $branchMerge_112;
anon1385_Else:
	assume !$_$_condition_$319;
	assume $_$_condition_$319 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_112;
anon835:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_219,SecMask_$_219);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_219);
	assume SecMask_$_220 == SecMask_$_219;
	goto $branchMerge_107;
anon1386_Then:
	assume $_$_condition_$321;
	assume $_$_condition_$321 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon333;
anon1386_Else:
	assume !$_$_condition_$321;
	assume $_$_condition_$321 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon333;
anon333:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$8 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$8) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$8)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$8))) || (kk#81_$8 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assert { :msg "  635.4: Assertion might not hold. The expression at 635.11 might not evaluate to true." } bf#522_$_0 == (0 - 1);
	assume IsGoodExhaleState(exhaleHeap#_1806_$_0,exhaleHeap#_1757_$_0,Mask_$_19,assertSecMask#_1804_$_72);
	assume IsGoodMask(Mask_$_19);
	assume wf(exhaleHeap#_1806_$_0,Mask_$_19,assertSecMask#_1804_$_72);
	assume ((0 < methodCallK#_1855) && ((1000 * methodCallK#_1855) < Fractions(1))) && ((1000 * methodCallK#_1855) < methodK#_1751);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  636.4: The target of the method call might be null." } !(this == null);
	assert { :msg "  636.4: The precondition at 652.12 might not hold. The expression at 652.12 might not evaluate to true." } !(exhaleHeap#_1757_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  636.4: The precondition at 657.12 might not hold. The expression at 657.12 might not evaluate to true." } (forall  k#96#549 : Integer :: ( ((0 <= k#96#549) && (k#96#549 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#96#549) < exhaleHeap#_1757_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$326) { goto anon1387_Then; } else { goto anon1387_Else; }
anon1636_Then:
	assume $_$_condition_$324;
	assume SecMask_$_221[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_222 == SecMask_$_221[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_221[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_223 == SecMask_$_222;
	goto anon839;
anon1636_Else:
	assume !$_$_condition_$324;
	assume 0 <= SecMask_$_221[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_223 == SecMask_$_221;
	goto anon839;
anon1637_Then:
	assume $_$_condition_$325;
	assume $_$_condition_$325 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_225 == SecMask_$_224[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_224[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_224[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$329) { goto anon1638_Then; } else { goto anon1638_Else; }
anon1637_Else:
	assume !$_$_condition_$325;
	assume $_$_condition_$325 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_228 == SecMask_$_224;
	goto $branchMerge_113;
anon1387_Then:
	assume $_$_condition_$326;
	assume $_$_condition_$326 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  636.4: The precondition at 663.12 might not hold. The expression at 663.28 might not evaluate to true." } (forall  k#97#550 : Integer :: ( ((0 <= k#97#550) && (k#97#550 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#97#550)) ));
	goto anon335;
anon1387_Else:
	assume !$_$_condition_$326;
	assume $_$_condition_$326 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null;
	goto anon335;
anon839:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_223,SecMask_$_223);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_223);
	assume SecMask_$_224 == SecMask_$_223;
	goto $branchMerge_111;
anon335:
	assert { :msg "  636.4: The precondition at 665.12 might not hold. The expression at 665.12 might not evaluate to true." } !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assert { :msg "  636.4: The precondition at 667.12 might not hold. The expression at 667.12 might not evaluate to true." } (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] - ite(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) == 2;
	assert { :msg "  636.4: The precondition at 668.12 might not hold. The expression at 668.12 might not evaluate to true." } exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (0 - 1);
	assert { :msg "  636.4: The precondition at 644.12 might not hold. The permission at 644.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  636.4: The precondition at 644.12 might not hold. Insufficient fraction at 644.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_19[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_19[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_19[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_1857_$_0 == Mask_$_19[this,AVLTreeNode.key := Mask_$_19[this,AVLTreeNode.key][perm$R := Mask_$_19[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1857_$_0);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_0,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  636.4: The precondition at 645.12 might not hold. The permission at 645.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  636.4: The precondition at 645.12 might not hold. Insufficient fraction at 645.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_1857_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_1857_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1857_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1857_$_1 == exhaleMask#_1857_$_0[this,AVLTreeNode.height := exhaleMask#_1857_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_1857_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1857_$_1);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_1,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  636.4: The precondition at 646.12 might not hold. The permission at 646.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  636.4: The precondition at 646.12 might not hold. Insufficient fraction at 646.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_1857_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_1857_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_1857_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_1857_$_2 == exhaleMask#_1857_$_1[this,AVLTreeNode.left := exhaleMask#_1857_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_1857_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1857_$_2);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_2,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  636.4: The precondition at 647.12 might not hold. The permission at 647.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  636.4: The precondition at 647.12 might not hold. Insufficient fraction at 647.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_1857_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_1857_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_1857_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_1857_$_3 == exhaleMask#_1857_$_2[this,AVLTreeNode.right := exhaleMask#_1857_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_1857_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1857_$_3);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_3,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  636.4: The precondition at 649.12 might not hold. The permission at 649.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  636.4: The precondition at 649.12 might not hold. Insufficient fraction at 649.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_1857_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_1857_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1857_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1857_$_4 == exhaleMask#_1857_$_3[this,AVLTreeNode.keys := exhaleMask#_1857_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_1857_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1857_$_4);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_4,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  636.4: The precondition at 650.12 might not hold. The permission at 650.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  636.4: The precondition at 650.12 might not hold. Insufficient fraction at 650.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_1857_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_1857_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1857_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1857_$_5 == exhaleMask#_1857_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_1857_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1857_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1857_$_5);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_5,SecMask_$_94);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_94);
	assert { :msg "  636.4: The precondition at 653.12 might not hold. The permission at 653.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  636.4: The precondition at 653.12 might not hold. Insufficient fraction at 653.12 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1857_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1857_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1857_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1857_$_6 == exhaleMask#_1857_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_1857_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_1857_$_5[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$328) { goto anon1388_Then; } else { goto anon1388_Else; }
anon1388_Then:
	assume $_$_condition_$328;
	assume $_$_condition_$328 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$331) { goto anon1389_Then; } else { goto anon1389_Else; }
anon1388_Else:
	assume !$_$_condition_$328;
	assume $_$_condition_$328 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_554 == SecMask_$_94;
	goto $branchMerge_114;
anon1638_Then:
	assume $_$_condition_$329;
	assume SecMask_$_225[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_226 == SecMask_$_225[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_225[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_227 == SecMask_$_226;
	goto anon843;
anon1638_Else:
	assume !$_$_condition_$329;
	assume 0 <= SecMask_$_225[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_227 == SecMask_$_225;
	goto anon843;
anon1639_Then:
	assume $_$_condition_$330;
	assume $_$_condition_$330 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_229 == SecMask_$_228[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_228[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_228[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$338) { goto anon1640_Then; } else { goto anon1640_Else; }
anon1639_Else:
	assume !$_$_condition_$330;
	assume $_$_condition_$330 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_232 == SecMask_$_228;
	goto anon848;
anon1389_Then:
	assume $_$_condition_$331;
	assume $_$_condition_$331 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true;
	goto $branchMerge_115;
anon1389_Else:
	assume !$_$_condition_$331;
	assume $_$_condition_$331 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.left])) && true) && true);
	goto $branchMerge_115;
anon1472_Then:
	assume $_$_condition_$332;
	assume $_$_condition_$332 <==> (!CanRead(exhaleMask#_1857_$_6,SecMask_$_554,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_1857_$_6,SecMask_$_554,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_1856_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon508;
anon1472_Else:
	assume !$_$_condition_$332;
	assume $_$_condition_$332 <==> (!CanRead(exhaleMask#_1857_$_6,SecMask_$_554,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_1857_$_6,SecMask_$_554,exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon508;
anon843:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_227,SecMask_$_227);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_227);
	assume SecMask_$_228 == SecMask_$_227;
	goto $branchMerge_113;
anon1390_Then:
	assume $_$_condition_$333;
	assume $_$_condition_$333 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#551 : Integer :: ( ((0 <= lk#79#551) && (lk#79#551 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#551) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_116;
anon1390_Else:
	assume !$_$_condition_$333;
	assume $_$_condition_$333 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_116;
anon1391_Then:
	assume $_$_condition_$336;
	assume $_$_condition_$336 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_117;
anon1391_Else:
	assume !$_$_condition_$336;
	assume $_$_condition_$336 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_117;
anon1640_Then:
	assume $_$_condition_$338;
	assume SecMask_$_229[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_230 == SecMask_$_229[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_229[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_231 == SecMask_$_230;
	goto anon847;
anon1640_Else:
	assume !$_$_condition_$338;
	assume 0 <= SecMask_$_229[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_231 == SecMask_$_229;
	goto anon847;
anon848:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_232,SecMask_$_232);
	assume SecMask_$_233 == SecMask_$_232;
	goto anon849;
anon1392_Then:
	assume $_$_condition_$339;
	assume $_$_condition_$339 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#552 : Integer :: ( ((0 <= rk#80#552) && (rk#80#552 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#552)) ));
	goto $branchMerge_118;
anon1392_Else:
	assume !$_$_condition_$339;
	assume $_$_condition_$339 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_118;
anon847:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_231,SecMask_$_231);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_231);
	assume SecMask_$_232 == SecMask_$_231;
	goto anon848;
anon1393_Then:
	assume $_$_condition_$341;
	assume $_$_condition_$341 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon347;
anon1393_Else:
	assume !$_$_condition_$341;
	assume $_$_condition_$341 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon347;
anon347:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$9 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$9) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$9)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$9))) || (kk#81_$9 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_402 == SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_94[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$343) { goto anon1394_Then; } else { goto anon1394_Else; }
anon1394_Then:
	assume $_$_condition_$343;
	assume SecMask_$_402[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_403 == SecMask_$_402[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_402[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_404 == SecMask_$_403;
	goto anon349;
anon1394_Else:
	assume !$_$_condition_$343;
	assume 0 <= SecMask_$_402[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_404 == SecMask_$_402;
	goto anon349;
anon349:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_404,SecMask_$_404);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_404);
	assume SecMask_$_405 == SecMask_$_404[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_404[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_404[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$347) { goto anon1395_Then; } else { goto anon1395_Else; }
anon1642_Then:
	assume $_$_condition_$345;
	assume SecMask_$_235[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_236 == SecMask_$_235[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_235[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_237 == SecMask_$_236;
	goto anon853;
anon1642_Else:
	assume !$_$_condition_$345;
	assume 0 <= SecMask_$_235[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_237 == SecMask_$_235;
	goto anon853;
anon1643_Then:
	assume $_$_condition_$346;
	assume $_$_condition_$346 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_239 == SecMask_$_238[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_238[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_238[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$350) { goto anon1644_Then; } else { goto anon1644_Else; }
anon1643_Else:
	assume !$_$_condition_$346;
	assume $_$_condition_$346 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_242 == SecMask_$_238;
	goto $branchMerge_119;
anon1395_Then:
	assume $_$_condition_$347;
	assume SecMask_$_405[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_406 == SecMask_$_405[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_405[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_407 == SecMask_$_406;
	goto anon351;
anon1395_Else:
	assume !$_$_condition_$347;
	assume 0 <= SecMask_$_405[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_407 == SecMask_$_405;
	goto anon351;
anon853:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_237,SecMask_$_237);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_237);
	assume SecMask_$_238 == SecMask_$_237;
	goto $branchMerge_86;
anon351:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_407,SecMask_$_407);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_407);
	assume SecMask_$_408 == SecMask_$_407[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_407[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_407[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$349) { goto anon1396_Then; } else { goto anon1396_Else; }
anon1396_Then:
	assume $_$_condition_$349;
	assume SecMask_$_408[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_409 == SecMask_$_408[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_408[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_410 == SecMask_$_409;
	goto anon353;
anon1396_Else:
	assume !$_$_condition_$349;
	assume 0 <= SecMask_$_408[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_410 == SecMask_$_408;
	goto anon353;
anon1644_Then:
	assume $_$_condition_$350;
	assume SecMask_$_239[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_240 == SecMask_$_239[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_239[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_241 == SecMask_$_240;
	goto anon857;
anon1644_Else:
	assume !$_$_condition_$350;
	assume 0 <= SecMask_$_239[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_241 == SecMask_$_239;
	goto anon857;
anon1645_Then:
	assume $_$_condition_$351;
	assume $_$_condition_$351 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_243 == SecMask_$_242[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_242[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_242[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$354) { goto anon1646_Then; } else { goto anon1646_Else; }
anon1645_Else:
	assume !$_$_condition_$351;
	assume $_$_condition_$351 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_246 == SecMask_$_242;
	goto anon862;
anon353:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_410,SecMask_$_410);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_410);
	assume SecMask_$_411 == SecMask_$_410[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_410[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_410[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$352) { goto anon1397_Then; } else { goto anon1397_Else; }
anon857:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_241,SecMask_$_241);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_241);
	assume SecMask_$_242 == SecMask_$_241;
	goto $branchMerge_119;
anon1397_Then:
	assume $_$_condition_$352;
	assume SecMask_$_411[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_412 == SecMask_$_411[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_411[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_413 == SecMask_$_412;
	goto anon355;
anon1397_Else:
	assume !$_$_condition_$352;
	assume 0 <= SecMask_$_411[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_413 == SecMask_$_411;
	goto anon355;
anon355:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_413,SecMask_$_413);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_413);
	assume SecMask_$_414 == SecMask_$_413[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_413[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_413[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$355) { goto anon1398_Then; } else { goto anon1398_Else; }
anon1646_Then:
	assume $_$_condition_$354;
	assume SecMask_$_243[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_244 == SecMask_$_243[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_243[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_245 == SecMask_$_244;
	goto anon861;
anon1646_Else:
	assume !$_$_condition_$354;
	assume 0 <= SecMask_$_243[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_245 == SecMask_$_243;
	goto anon861;
anon862:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_246,SecMask_$_246);
	assume SecMask_$_247 == SecMask_$_246;
	goto $branchMerge_39;
anon1398_Then:
	assume $_$_condition_$355;
	assume SecMask_$_414[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_415 == SecMask_$_414[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_414[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_416 == SecMask_$_415;
	goto anon357;
anon1398_Else:
	assume !$_$_condition_$355;
	assume 0 <= SecMask_$_414[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_416 == SecMask_$_414;
	goto anon357;
anon861:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_245,SecMask_$_245);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_245);
	assume SecMask_$_246 == SecMask_$_245;
	goto anon862;
anon357:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_416,SecMask_$_416);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_416);
	assume SecMask_$_417 == SecMask_$_416[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_416[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_416[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$356) { goto anon1399_Then; } else { goto anon1399_Else; }
anon1399_Then:
	assume $_$_condition_$356;
	assume SecMask_$_417[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_418 == SecMask_$_417[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_417[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_419 == SecMask_$_418;
	goto anon359;
anon1399_Else:
	assume !$_$_condition_$356;
	assume 0 <= SecMask_$_417[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_419 == SecMask_$_417;
	goto anon359;
anon359:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_419,SecMask_$_419);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_419);
	if ($_$_condition_$358) { goto anon1400_Then; } else { goto anon1400_Else; }
anon865:
	assume IsGoodMask(exhaleMask#_1976_$_6);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_6,SecMask_$_247);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_247);
	assert { :msg "  638.4: The precondition at 712.12 might not hold. The permission at 712.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  638.4: The precondition at 712.12 might not hold. Insufficient fraction at 712.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1976_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1976_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1976_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1976_$_7 == exhaleMask#_1976_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_1976_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_1976_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1976_$_7);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_7,SecMask_$_247);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_247);
	assert { :msg "  638.4: The precondition at 713.12 might not hold. The permission at 713.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  638.4: The precondition at 713.12 might not hold. Insufficient fraction at 713.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1976_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1976_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1976_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1976_$_8 == exhaleMask#_1976_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_1976_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_1976_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1976_$_8);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_8,SecMask_$_247);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_247);
	assert { :msg "  638.4: The precondition at 714.12 might not hold. The permission at 714.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  638.4: The precondition at 714.12 might not hold. Insufficient fraction at 714.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1976_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1976_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1976_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1976_$_9 == exhaleMask#_1976_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_1976_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1976_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1976_$_9);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_9,SecMask_$_247);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_247);
	if ($_$_condition_$359) { goto anon1648_Then; } else { goto anon1648_Else; }
anon1400_Then:
	assume $_$_condition_$358;
	assume $_$_condition_$358 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_420 == SecMask_$_419[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_419[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_419[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$360) { goto anon1401_Then; } else { goto anon1401_Else; }
anon1400_Else:
	assume !$_$_condition_$358;
	assume $_$_condition_$358 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_474 == SecMask_$_419;
	goto $branchMerge_120;
anon1648_Then:
	assume $_$_condition_$359;
	assume $_$_condition_$359 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  638.4: The precondition at 717.12 might not hold. The permission at 717.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  638.4: The precondition at 717.12 might not hold. Insufficient fraction at 717.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1976_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1976_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1976_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1976_$_10 == exhaleMask#_1976_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_1976_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_1976_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$362) { goto anon1649_Then; } else { goto anon1649_Else; }
anon1648_Else:
	assume !$_$_condition_$359;
	assume $_$_condition_$359 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null;
	assume SecMask_$_401 == SecMask_$_247;
	assume exhaleMask#_1976_$_11 == exhaleMask#_1976_$_9;
	goto $branchMerge_121;
anon1401_Then:
	assume $_$_condition_$360;
	assume SecMask_$_420[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_421 == SecMask_$_420[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_420[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_422 == SecMask_$_421;
	goto anon362;
anon1401_Else:
	assume !$_$_condition_$360;
	assume 0 <= SecMask_$_420[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_422 == SecMask_$_420;
	goto anon362;
anon1430_Then:
	assume $_$_condition_$361;
	assume $_$_condition_$361 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_475 == SecMask_$_474[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_474[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_474[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$446) { goto anon1431_Then; } else { goto anon1431_Else; }
anon1430_Else:
	assume !$_$_condition_$361;
	assume $_$_condition_$361 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_478 == SecMask_$_474;
	goto $branchMerge_122;
anon1649_Then:
	assume $_$_condition_$362;
	assume $_$_condition_$362 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$364) { goto anon1650_Then; } else { goto anon1650_Else; }
anon1649_Else:
	assume !$_$_condition_$362;
	assume $_$_condition_$362 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true));
	assume SecMask_$_400 == SecMask_$_247;
	goto $branchMerge_123;
anon1734_Then:
	assume $_$_condition_$363;
	assume $_$_condition_$363 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  638.4: The precondition at 718.12 might not hold. The permission at 718.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  638.4: The precondition at 718.12 might not hold. Insufficient fraction at 718.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1976_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1976_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1976_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1976_$_12 == exhaleMask#_1976_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_1976_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_1976_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1976_$_12);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_12,SecMask_$_401);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_401);
	assume exhaleMask#_1976_$_13 == exhaleMask#_1976_$_12;
	goto $branchMerge_124;
anon1734_Else:
	assume !$_$_condition_$363;
	assume $_$_condition_$363 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1976_$_13 == exhaleMask#_1976_$_11;
	goto $branchMerge_124;
anon362:
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == exhaleHeap#_1757_$_0[this,AVLTreeNode.left]);
	if ($_$_condition_$366) { goto anon1402_Then; } else { goto anon1402_Else; }
anon1650_Then:
	assume $_$_condition_$364;
	assume $_$_condition_$364 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true;
	goto $branchMerge_125;
anon1650_Else:
	assume !$_$_condition_$364;
	assume $_$_condition_$364 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true);
	goto $branchMerge_125;
anon1733_Then:
	assume $_$_condition_$365;
	assume $_$_condition_$365 <==> (!CanRead(exhaleMask#_1976_$_10,SecMask_$_400,exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_1976_$_10,SecMask_$_400,exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_1975_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon1039;
anon1733_Else:
	assume !$_$_condition_$365;
	assume $_$_condition_$365 <==> (!CanRead(exhaleMask#_1976_$_10,SecMask_$_400,exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_1976_$_10,SecMask_$_400,exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon1039;
anon1402_Then:
	assume $_$_condition_$366;
	assume $_$_condition_$366 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$369) { goto anon1403_Then; } else { goto anon1403_Else; }
anon1402_Else:
	assume !$_$_condition_$366;
	assume $_$_condition_$366 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true));
	assume SecMask_$_473 == SecMask_$_422;
	goto anon419;
anon1651_Then:
	assume $_$_condition_$367;
	assume $_$_condition_$367 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#594 : Integer :: ( ((0 <= lk#79#594) && (lk#79#594 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#594) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_126;
anon1651_Else:
	assume !$_$_condition_$367;
	assume $_$_condition_$367 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_126;
anon1403_Then:
	assume $_$_condition_$369;
	assume $_$_condition_$369 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true;
	goto $branchMerge_127;
anon1403_Else:
	assume !$_$_condition_$369;
	assume $_$_condition_$369 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left])) && true) && true);
	goto $branchMerge_127;
anon419:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_473,SecMask_$_473);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_473);
	assume SecMask_$_474 == SecMask_$_473;
	goto $branchMerge_120;
anon1652_Then:
	assume $_$_condition_$370;
	assume $_$_condition_$370 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_128;
anon1652_Else:
	assume !$_$_condition_$370;
	assume $_$_condition_$370 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_128;
anon1404_Then:
	assume $_$_condition_$372;
	assume $_$_condition_$372 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#555 : Integer :: ( ((0 <= lk#79#555) && (lk#79#555 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#555) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_129;
anon1404_Else:
	assume !$_$_condition_$372;
	assume $_$_condition_$372 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_129;
anon1653_Then:
	assume $_$_condition_$374;
	assume $_$_condition_$374 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#595 : Integer :: ( ((0 <= rk#80#595) && (rk#80#595 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#595)) ));
	goto $branchMerge_130;
anon1653_Else:
	assume !$_$_condition_$374;
	assume $_$_condition_$374 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_130;
anon1405_Then:
	assume $_$_condition_$376;
	assume $_$_condition_$376 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_131;
anon1405_Else:
	assume !$_$_condition_$376;
	assume $_$_condition_$376 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_131;
anon1654_Then:
	assume $_$_condition_$378;
	assume $_$_condition_$378 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon878;
anon1654_Else:
	assume !$_$_condition_$378;
	assume $_$_condition_$378 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon878;
anon1406_Then:
	assume $_$_condition_$380;
	assume $_$_condition_$380 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#556 : Integer :: ( ((0 <= rk#80#556) && (rk#80#556 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#556)) ));
	goto $branchMerge_132;
anon1406_Else:
	assume !$_$_condition_$380;
	assume $_$_condition_$380 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_132;
anon878:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$10 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$10) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$10)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$10))) || (kk#81_$10 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume SecMask_$_248 == SecMask_$_247[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_247[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := SecMask_$_247[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$384) { goto anon1655_Then; } else { goto anon1655_Else; }
anon1407_Then:
	assume $_$_condition_$382;
	assume $_$_condition_$382 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon374;
anon1407_Else:
	assume !$_$_condition_$382;
	assume $_$_condition_$382 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon374;
anon1655_Then:
	assume $_$_condition_$384;
	assume SecMask_$_248[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_249 == SecMask_$_248[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_248[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_250 == SecMask_$_249;
	goto anon880;
anon1655_Else:
	assume !$_$_condition_$384;
	assume 0 <= SecMask_$_248[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_250 == SecMask_$_248;
	goto anon880;
anon374:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$11 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$11) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$11)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$11))) || (kk#81_$11 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_423 == SecMask_$_422[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key := SecMask_$_422[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_422[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$385) { goto anon1408_Then; } else { goto anon1408_Else; }
anon880:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_250,SecMask_$_250);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_250);
	assume SecMask_$_251 == SecMask_$_250[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_250[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_250[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$386) { goto anon1656_Then; } else { goto anon1656_Else; }
anon1408_Then:
	assume $_$_condition_$385;
	assume SecMask_$_423[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_424 == SecMask_$_423[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key := SecMask_$_423[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_425 == SecMask_$_424;
	goto anon376;
anon1408_Else:
	assume !$_$_condition_$385;
	assume 0 <= SecMask_$_423[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_425 == SecMask_$_423;
	goto anon376;
anon1656_Then:
	assume $_$_condition_$386;
	assume SecMask_$_251[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_252 == SecMask_$_251[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_251[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_253 == SecMask_$_252;
	goto anon882;
anon1656_Else:
	assume !$_$_condition_$386;
	assume 0 <= SecMask_$_251[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_253 == SecMask_$_251;
	goto anon882;
anon376:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_425,SecMask_$_425);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_425);
	assume SecMask_$_426 == SecMask_$_425[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_425[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_425[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$387) { goto anon1409_Then; } else { goto anon1409_Else; }
anon882:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_253,SecMask_$_253);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_253);
	assume SecMask_$_254 == SecMask_$_253[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_253[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_253[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$388) { goto anon1657_Then; } else { goto anon1657_Else; }
anon1409_Then:
	assume $_$_condition_$387;
	assume SecMask_$_426[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_427 == SecMask_$_426[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_426[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_428 == SecMask_$_427;
	goto anon378;
anon1409_Else:
	assume !$_$_condition_$387;
	assume 0 <= SecMask_$_426[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_428 == SecMask_$_426;
	goto anon378;
anon1657_Then:
	assume $_$_condition_$388;
	assume SecMask_$_254[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_255 == SecMask_$_254[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_254[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_256 == SecMask_$_255;
	goto anon884;
anon1657_Else:
	assume !$_$_condition_$388;
	assume 0 <= SecMask_$_254[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_256 == SecMask_$_254;
	goto anon884;
anon378:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_428,SecMask_$_428);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_428);
	assume SecMask_$_429 == SecMask_$_428[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left := SecMask_$_428[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_428[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$389) { goto anon1410_Then; } else { goto anon1410_Else; }
anon884:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_256,SecMask_$_256);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_256);
	assume SecMask_$_257 == SecMask_$_256[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_256[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_256[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$390) { goto anon1658_Then; } else { goto anon1658_Else; }
anon1410_Then:
	assume $_$_condition_$389;
	assume SecMask_$_429[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_430 == SecMask_$_429[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left := SecMask_$_429[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_431 == SecMask_$_430;
	goto anon380;
anon1410_Else:
	assume !$_$_condition_$389;
	assume 0 <= SecMask_$_429[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_431 == SecMask_$_429;
	goto anon380;
anon1658_Then:
	assume $_$_condition_$390;
	assume SecMask_$_257[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_258 == SecMask_$_257[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_257[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_259 == SecMask_$_258;
	goto anon886;
anon1658_Else:
	assume !$_$_condition_$390;
	assume 0 <= SecMask_$_257[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_259 == SecMask_$_257;
	goto anon886;
anon380:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_431,SecMask_$_431);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_431);
	assume SecMask_$_432 == SecMask_$_431[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right := SecMask_$_431[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_431[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$391) { goto anon1411_Then; } else { goto anon1411_Else; }
anon886:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_259,SecMask_$_259);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_259);
	assume SecMask_$_260 == SecMask_$_259[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_259[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_259[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$392) { goto anon1659_Then; } else { goto anon1659_Else; }
anon1411_Then:
	assume $_$_condition_$391;
	assume SecMask_$_432[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_433 == SecMask_$_432[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right := SecMask_$_432[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_434 == SecMask_$_433;
	goto anon382;
anon1411_Else:
	assume !$_$_condition_$391;
	assume 0 <= SecMask_$_432[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_434 == SecMask_$_432;
	goto anon382;
anon1659_Then:
	assume $_$_condition_$392;
	assume SecMask_$_260[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_261 == SecMask_$_260[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_260[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_262 == SecMask_$_261;
	goto anon888;
anon1659_Else:
	assume !$_$_condition_$392;
	assume 0 <= SecMask_$_260[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_262 == SecMask_$_260;
	goto anon888;
anon382:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_434,SecMask_$_434);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_434);
	assume SecMask_$_435 == SecMask_$_434[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_434[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_434[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$393) { goto anon1412_Then; } else { goto anon1412_Else; }
anon888:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_262,SecMask_$_262);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_262);
	assume SecMask_$_263 == SecMask_$_262[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_262[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_262[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$394) { goto anon1660_Then; } else { goto anon1660_Else; }
anon1412_Then:
	assume $_$_condition_$393;
	assume SecMask_$_435[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_436 == SecMask_$_435[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_435[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_437 == SecMask_$_436;
	goto anon384;
anon1412_Else:
	assume !$_$_condition_$393;
	assume 0 <= SecMask_$_435[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_437 == SecMask_$_435;
	goto anon384;
anon1660_Then:
	assume $_$_condition_$394;
	assume SecMask_$_263[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_264 == SecMask_$_263[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_263[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_265 == SecMask_$_264;
	goto anon890;
anon1660_Else:
	assume !$_$_condition_$394;
	assume 0 <= SecMask_$_263[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_265 == SecMask_$_263;
	goto anon890;
anon384:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_437,SecMask_$_437);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_437);
	assume SecMask_$_438 == SecMask_$_437[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_437[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_437[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$395) { goto anon1413_Then; } else { goto anon1413_Else; }
anon890:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_265,SecMask_$_265);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_265);
	if ($_$_condition_$396) { goto anon1661_Then; } else { goto anon1661_Else; }
anon1413_Then:
	assume $_$_condition_$395;
	assume SecMask_$_438[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_439 == SecMask_$_438[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_438[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_440 == SecMask_$_439;
	goto anon386;
anon1413_Else:
	assume !$_$_condition_$395;
	assume 0 <= SecMask_$_438[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_440 == SecMask_$_438;
	goto anon386;
anon1661_Then:
	assume $_$_condition_$396;
	assume $_$_condition_$396 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_266 == SecMask_$_265[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_265[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_265[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$397) { goto anon1662_Then; } else { goto anon1662_Else; }
anon1661_Else:
	assume !$_$_condition_$396;
	assume $_$_condition_$396 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_320 == SecMask_$_265;
	goto $branchMerge_133;
anon386:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_440,SecMask_$_440);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_440);
	if ($_$_condition_$399) { goto anon1414_Then; } else { goto anon1414_Else; }
anon1662_Then:
	assume $_$_condition_$397;
	assume SecMask_$_266[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_267 == SecMask_$_266[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_266[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_268 == SecMask_$_267;
	goto anon893;
anon1662_Else:
	assume !$_$_condition_$397;
	assume 0 <= SecMask_$_266[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_268 == SecMask_$_266;
	goto anon893;
anon1691_Then:
	assume $_$_condition_$398;
	assume $_$_condition_$398 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_321 == SecMask_$_320[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_320[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_320[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$486) { goto anon1692_Then; } else { goto anon1692_Else; }
anon1691_Else:
	assume !$_$_condition_$398;
	assume $_$_condition_$398 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_324 == SecMask_$_320;
	goto $branchMerge_134;
anon1414_Then:
	assume $_$_condition_$399;
	assume $_$_condition_$399 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_441 == SecMask_$_440[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_440[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_440[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$400) { goto anon1415_Then; } else { goto anon1415_Else; }
anon1414_Else:
	assume !$_$_condition_$399;
	assume $_$_condition_$399 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_444 == SecMask_$_440;
	goto $branchMerge_135;
anon893:
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == exhaleHeap#_1757_$_0[this,AVLTreeNode.right]);
	if ($_$_condition_$402) { goto anon1663_Then; } else { goto anon1663_Else; }
anon1415_Then:
	assume $_$_condition_$400;
	assume SecMask_$_441[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_442 == SecMask_$_441[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_441[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_443 == SecMask_$_442;
	goto anon389;
anon1415_Else:
	assume !$_$_condition_$400;
	assume 0 <= SecMask_$_441[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_443 == SecMask_$_441;
	goto anon389;
anon1416_Then:
	assume $_$_condition_$401;
	assume $_$_condition_$401 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_445 == SecMask_$_444[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_444[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_444[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$407) { goto anon1417_Then; } else { goto anon1417_Else; }
anon1416_Else:
	assume !$_$_condition_$401;
	assume $_$_condition_$401 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_448 == SecMask_$_444;
	goto $branchMerge_136;
anon1663_Then:
	assume $_$_condition_$402;
	assume $_$_condition_$402 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$403) { goto anon1664_Then; } else { goto anon1664_Else; }
anon1663_Else:
	assume !$_$_condition_$402;
	assume $_$_condition_$402 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true));
	assume SecMask_$_319 == SecMask_$_268;
	goto anon950;
anon389:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_443,SecMask_$_443);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_443);
	assume SecMask_$_444 == SecMask_$_443;
	goto $branchMerge_135;
anon1664_Then:
	assume $_$_condition_$403;
	assume $_$_condition_$403 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true;
	goto $branchMerge_137;
anon1664_Else:
	assume !$_$_condition_$403;
	assume $_$_condition_$403 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true);
	goto $branchMerge_137;
anon950:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_319,SecMask_$_319);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_319);
	assume SecMask_$_320 == SecMask_$_319;
	goto $branchMerge_133;
anon1665_Then:
	assume $_$_condition_$405;
	assume $_$_condition_$405 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#598 : Integer :: ( ((0 <= lk#79#598) && (lk#79#598 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#598) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_138;
anon1665_Else:
	assume !$_$_condition_$405;
	assume $_$_condition_$405 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_138;
anon1417_Then:
	assume $_$_condition_$407;
	assume SecMask_$_445[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_446 == SecMask_$_445[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_445[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_447 == SecMask_$_446;
	goto anon393;
anon1417_Else:
	assume !$_$_condition_$407;
	assume 0 <= SecMask_$_445[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_447 == SecMask_$_445;
	goto anon393;
anon1418_Then:
	assume $_$_condition_$408;
	assume $_$_condition_$408 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_449 == SecMask_$_448[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_448[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_448[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$416) { goto anon1419_Then; } else { goto anon1419_Else; }
anon1418_Else:
	assume !$_$_condition_$408;
	assume $_$_condition_$408 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_452 == SecMask_$_448;
	goto $branchMerge_139;
anon1666_Then:
	assume $_$_condition_$409;
	assume $_$_condition_$409 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_140;
anon1666_Else:
	assume !$_$_condition_$409;
	assume $_$_condition_$409 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_140;
anon393:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_447,SecMask_$_447);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_447);
	assume SecMask_$_448 == SecMask_$_447;
	goto $branchMerge_136;
anon1667_Then:
	assume $_$_condition_$411;
	assume $_$_condition_$411 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#599 : Integer :: ( ((0 <= rk#80#599) && (rk#80#599 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#599)) ));
	goto $branchMerge_141;
anon1667_Else:
	assume !$_$_condition_$411;
	assume $_$_condition_$411 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_141;
anon1668_Then:
	assume $_$_condition_$414;
	assume $_$_condition_$414 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon905;
anon1668_Else:
	assume !$_$_condition_$414;
	assume $_$_condition_$414 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon905;
anon1419_Then:
	assume $_$_condition_$416;
	assume SecMask_$_449[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_450 == SecMask_$_449[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_449[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_451 == SecMask_$_450;
	goto anon397;
anon1419_Else:
	assume !$_$_condition_$416;
	assume 0 <= SecMask_$_449[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_451 == SecMask_$_449;
	goto anon397;
anon1420_Then:
	assume $_$_condition_$417;
	assume $_$_condition_$417 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_453 == SecMask_$_452[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_452[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_452[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$420) { goto anon1421_Then; } else { goto anon1421_Else; }
anon1420_Else:
	assume !$_$_condition_$417;
	assume $_$_condition_$417 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_456 == SecMask_$_452;
	goto $branchMerge_142;
anon905:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$12 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$12) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$12)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$12))) || (kk#81_$12 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_269 == SecMask_$_268[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key := SecMask_$_268[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_268[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$418) { goto anon1669_Then; } else { goto anon1669_Else; }
anon397:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_451,SecMask_$_451);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_451);
	assume SecMask_$_452 == SecMask_$_451;
	goto $branchMerge_139;
anon1669_Then:
	assume $_$_condition_$418;
	assume SecMask_$_269[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_270 == SecMask_$_269[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key := SecMask_$_269[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_271 == SecMask_$_270;
	goto anon907;
anon1669_Else:
	assume !$_$_condition_$418;
	assume 0 <= SecMask_$_269[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_271 == SecMask_$_269;
	goto anon907;
anon907:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_271,SecMask_$_271);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_271);
	assume SecMask_$_272 == SecMask_$_271[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_271[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_271[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$422) { goto anon1670_Then; } else { goto anon1670_Else; }
anon1421_Then:
	assume $_$_condition_$420;
	assume SecMask_$_453[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_454 == SecMask_$_453[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_453[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_455 == SecMask_$_454;
	goto anon401;
anon1421_Else:
	assume !$_$_condition_$420;
	assume 0 <= SecMask_$_453[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_455 == SecMask_$_453;
	goto anon401;
anon1422_Then:
	assume $_$_condition_$421;
	assume $_$_condition_$421 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_457 == SecMask_$_456[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_456[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_456[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$425) { goto anon1423_Then; } else { goto anon1423_Else; }
anon1422_Else:
	assume !$_$_condition_$421;
	assume $_$_condition_$421 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_460 == SecMask_$_456;
	goto $branchMerge_143;
anon1670_Then:
	assume $_$_condition_$422;
	assume SecMask_$_272[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_273 == SecMask_$_272[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_272[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_274 == SecMask_$_273;
	goto anon909;
anon1670_Else:
	assume !$_$_condition_$422;
	assume 0 <= SecMask_$_272[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_274 == SecMask_$_272;
	goto anon909;
anon401:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_455,SecMask_$_455);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_455);
	assume SecMask_$_456 == SecMask_$_455;
	goto $branchMerge_142;
anon909:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_274,SecMask_$_274);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_274);
	assume SecMask_$_275 == SecMask_$_274[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left := SecMask_$_274[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_274[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$424) { goto anon1671_Then; } else { goto anon1671_Else; }
anon1671_Then:
	assume $_$_condition_$424;
	assume SecMask_$_275[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_276 == SecMask_$_275[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left := SecMask_$_275[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_277 == SecMask_$_276;
	goto anon911;
anon1671_Else:
	assume !$_$_condition_$424;
	assume 0 <= SecMask_$_275[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_277 == SecMask_$_275;
	goto anon911;
anon1423_Then:
	assume $_$_condition_$425;
	assume SecMask_$_457[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_458 == SecMask_$_457[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_457[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_459 == SecMask_$_458;
	goto anon405;
anon1423_Else:
	assume !$_$_condition_$425;
	assume 0 <= SecMask_$_457[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_459 == SecMask_$_457;
	goto anon405;
anon1424_Then:
	assume $_$_condition_$426;
	assume $_$_condition_$426 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_461 == SecMask_$_460[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_460[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_460[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$429) { goto anon1425_Then; } else { goto anon1425_Else; }
anon1424_Else:
	assume !$_$_condition_$426;
	assume $_$_condition_$426 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_464 == SecMask_$_460;
	goto $branchMerge_144;
anon911:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_277,SecMask_$_277);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_277);
	assume SecMask_$_278 == SecMask_$_277[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right := SecMask_$_277[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_277[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$427) { goto anon1672_Then; } else { goto anon1672_Else; }
anon405:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_459,SecMask_$_459);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_459);
	assume SecMask_$_460 == SecMask_$_459;
	goto $branchMerge_143;
anon1672_Then:
	assume $_$_condition_$427;
	assume SecMask_$_278[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_279 == SecMask_$_278[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right := SecMask_$_278[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_280 == SecMask_$_279;
	goto anon913;
anon1672_Else:
	assume !$_$_condition_$427;
	assume 0 <= SecMask_$_278[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_280 == SecMask_$_278;
	goto anon913;
anon913:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_280,SecMask_$_280);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_280);
	assume SecMask_$_281 == SecMask_$_280[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_280[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_280[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$431) { goto anon1673_Then; } else { goto anon1673_Else; }
anon1425_Then:
	assume $_$_condition_$429;
	assume SecMask_$_461[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_462 == SecMask_$_461[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_461[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_463 == SecMask_$_462;
	goto anon409;
anon1425_Else:
	assume !$_$_condition_$429;
	assume 0 <= SecMask_$_461[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_463 == SecMask_$_461;
	goto anon409;
anon1426_Then:
	assume $_$_condition_$430;
	assume $_$_condition_$430 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_465 == SecMask_$_464[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_464[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_464[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$434) { goto anon1427_Then; } else { goto anon1427_Else; }
anon1426_Else:
	assume !$_$_condition_$430;
	assume $_$_condition_$430 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_468 == SecMask_$_464;
	goto $branchMerge_145;
anon1673_Then:
	assume $_$_condition_$431;
	assume SecMask_$_281[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_282 == SecMask_$_281[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_281[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_283 == SecMask_$_282;
	goto anon915;
anon1673_Else:
	assume !$_$_condition_$431;
	assume 0 <= SecMask_$_281[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_283 == SecMask_$_281;
	goto anon915;
anon409:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_463,SecMask_$_463);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_463);
	assume SecMask_$_464 == SecMask_$_463;
	goto $branchMerge_144;
anon915:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_283,SecMask_$_283);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_283);
	assume SecMask_$_284 == SecMask_$_283[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_283[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_283[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$433) { goto anon1674_Then; } else { goto anon1674_Else; }
anon1674_Then:
	assume $_$_condition_$433;
	assume SecMask_$_284[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_285 == SecMask_$_284[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_284[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_286 == SecMask_$_285;
	goto anon917;
anon1674_Else:
	assume !$_$_condition_$433;
	assume 0 <= SecMask_$_284[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_286 == SecMask_$_284;
	goto anon917;
anon1427_Then:
	assume $_$_condition_$434;
	assume SecMask_$_465[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_466 == SecMask_$_465[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_465[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_467 == SecMask_$_466;
	goto anon413;
anon1427_Else:
	assume !$_$_condition_$434;
	assume 0 <= SecMask_$_465[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_467 == SecMask_$_465;
	goto anon413;
anon1428_Then:
	assume $_$_condition_$435;
	assume $_$_condition_$435 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_469 == SecMask_$_468[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_468[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_468[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$440) { goto anon1429_Then; } else { goto anon1429_Else; }
anon1428_Else:
	assume !$_$_condition_$435;
	assume $_$_condition_$435 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_472 == SecMask_$_468;
	goto anon418;
anon917:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_286,SecMask_$_286);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_286);
	if ($_$_condition_$436) { goto anon1675_Then; } else { goto anon1675_Else; }
anon413:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_467,SecMask_$_467);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_467);
	assume SecMask_$_468 == SecMask_$_467;
	goto $branchMerge_145;
anon1675_Then:
	assume $_$_condition_$436;
	assume $_$_condition_$436 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_287 == SecMask_$_286[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_286[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_286[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$438) { goto anon1676_Then; } else { goto anon1676_Else; }
anon1675_Else:
	assume !$_$_condition_$436;
	assume $_$_condition_$436 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_290 == SecMask_$_286;
	goto $branchMerge_146;
anon1676_Then:
	assume $_$_condition_$438;
	assume SecMask_$_287[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_288 == SecMask_$_287[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_287[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_289 == SecMask_$_288;
	goto anon920;
anon1676_Else:
	assume !$_$_condition_$438;
	assume 0 <= SecMask_$_287[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_289 == SecMask_$_287;
	goto anon920;
anon1677_Then:
	assume $_$_condition_$439;
	assume $_$_condition_$439 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_291 == SecMask_$_290[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_290[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_290[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$442) { goto anon1678_Then; } else { goto anon1678_Else; }
anon1677_Else:
	assume !$_$_condition_$439;
	assume $_$_condition_$439 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_294 == SecMask_$_290;
	goto $branchMerge_147;
anon1429_Then:
	assume $_$_condition_$440;
	assume SecMask_$_469[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_470 == SecMask_$_469[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_469[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_471 == SecMask_$_470;
	goto anon417;
anon1429_Else:
	assume !$_$_condition_$440;
	assume 0 <= SecMask_$_469[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_471 == SecMask_$_469;
	goto anon417;
anon418:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_472,SecMask_$_472);
	assume SecMask_$_473 == SecMask_$_472;
	goto anon419;
anon920:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_289,SecMask_$_289);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_289);
	assume SecMask_$_290 == SecMask_$_289;
	goto $branchMerge_146;
anon417:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_471,SecMask_$_471);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_471);
	assume SecMask_$_472 == SecMask_$_471;
	goto anon418;
anon1678_Then:
	assume $_$_condition_$442;
	assume SecMask_$_291[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_292 == SecMask_$_291[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_291[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_293 == SecMask_$_292;
	goto anon924;
anon1678_Else:
	assume !$_$_condition_$442;
	assume 0 <= SecMask_$_291[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_293 == SecMask_$_291;
	goto anon924;
anon1679_Then:
	assume $_$_condition_$443;
	assume $_$_condition_$443 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_295 == SecMask_$_294[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_294[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_294[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$448) { goto anon1680_Then; } else { goto anon1680_Else; }
anon1679_Else:
	assume !$_$_condition_$443;
	assume $_$_condition_$443 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_298 == SecMask_$_294;
	goto $branchMerge_148;
anon924:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_293,SecMask_$_293);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_293);
	assume SecMask_$_294 == SecMask_$_293;
	goto $branchMerge_147;
anon1431_Then:
	assume $_$_condition_$446;
	assume SecMask_$_475[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_476 == SecMask_$_475[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_475[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_477 == SecMask_$_476;
	goto anon423;
anon1431_Else:
	assume !$_$_condition_$446;
	assume 0 <= SecMask_$_475[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_477 == SecMask_$_475;
	goto anon423;
anon1432_Then:
	assume $_$_condition_$447;
	assume $_$_condition_$447 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_479 == SecMask_$_478[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_478[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_478[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$452) { goto anon1433_Then; } else { goto anon1433_Else; }
anon1432_Else:
	assume !$_$_condition_$447;
	assume $_$_condition_$447 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_482 == SecMask_$_478;
	goto $branchMerge_149;
anon1680_Then:
	assume $_$_condition_$448;
	assume SecMask_$_295[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_296 == SecMask_$_295[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_295[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_297 == SecMask_$_296;
	goto anon928;
anon1680_Else:
	assume !$_$_condition_$448;
	assume 0 <= SecMask_$_295[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_297 == SecMask_$_295;
	goto anon928;
anon1681_Then:
	assume $_$_condition_$449;
	assume $_$_condition_$449 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_299 == SecMask_$_298[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_298[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_298[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$454) { goto anon1682_Then; } else { goto anon1682_Else; }
anon1681_Else:
	assume !$_$_condition_$449;
	assume $_$_condition_$449 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_302 == SecMask_$_298;
	goto $branchMerge_150;
anon423:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_477,SecMask_$_477);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_477);
	assume SecMask_$_478 == SecMask_$_477;
	goto $branchMerge_122;
anon928:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_297,SecMask_$_297);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_297);
	assume SecMask_$_298 == SecMask_$_297;
	goto $branchMerge_148;
anon1433_Then:
	assume $_$_condition_$452;
	assume SecMask_$_479[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_480 == SecMask_$_479[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_479[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_481 == SecMask_$_480;
	goto anon427;
anon1433_Else:
	assume !$_$_condition_$452;
	assume 0 <= SecMask_$_479[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_481 == SecMask_$_479;
	goto anon427;
anon1434_Then:
	assume $_$_condition_$453;
	assume $_$_condition_$453 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_483 == SecMask_$_482[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_482[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_482[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$458) { goto anon1435_Then; } else { goto anon1435_Else; }
anon1434_Else:
	assume !$_$_condition_$453;
	assume $_$_condition_$453 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_486 == SecMask_$_482;
	goto $branchMerge_151;
anon1682_Then:
	assume $_$_condition_$454;
	assume SecMask_$_299[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_300 == SecMask_$_299[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_299[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_301 == SecMask_$_300;
	goto anon932;
anon1682_Else:
	assume !$_$_condition_$454;
	assume 0 <= SecMask_$_299[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_301 == SecMask_$_299;
	goto anon932;
anon1683_Then:
	assume $_$_condition_$455;
	assume $_$_condition_$455 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_303 == SecMask_$_302[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_302[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_302[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$460) { goto anon1684_Then; } else { goto anon1684_Else; }
anon1683_Else:
	assume !$_$_condition_$455;
	assume $_$_condition_$455 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_306 == SecMask_$_302;
	goto $branchMerge_152;
anon427:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_481,SecMask_$_481);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_481);
	assume SecMask_$_482 == SecMask_$_481;
	goto $branchMerge_149;
anon932:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_301,SecMask_$_301);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_301);
	assume SecMask_$_302 == SecMask_$_301;
	goto $branchMerge_150;
anon1435_Then:
	assume $_$_condition_$458;
	assume SecMask_$_483[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_484 == SecMask_$_483[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_483[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_485 == SecMask_$_484;
	goto anon431;
anon1435_Else:
	assume !$_$_condition_$458;
	assume 0 <= SecMask_$_483[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_485 == SecMask_$_483;
	goto anon431;
anon1436_Then:
	assume $_$_condition_$459;
	assume $_$_condition_$459 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_487 == SecMask_$_486[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_486[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_486[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$464) { goto anon1437_Then; } else { goto anon1437_Else; }
anon1436_Else:
	assume !$_$_condition_$459;
	assume $_$_condition_$459 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_541 == SecMask_$_486;
	goto $branchMerge_153;
anon1684_Then:
	assume $_$_condition_$460;
	assume SecMask_$_303[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_304 == SecMask_$_303[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_303[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_305 == SecMask_$_304;
	goto anon936;
anon1684_Else:
	assume !$_$_condition_$460;
	assume 0 <= SecMask_$_303[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_305 == SecMask_$_303;
	goto anon936;
anon1685_Then:
	assume $_$_condition_$461;
	assume $_$_condition_$461 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_307 == SecMask_$_306[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_306[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_306[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$466) { goto anon1686_Then; } else { goto anon1686_Else; }
anon1685_Else:
	assume !$_$_condition_$461;
	assume $_$_condition_$461 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_310 == SecMask_$_306;
	goto $branchMerge_154;
anon431:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_485,SecMask_$_485);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_485);
	assume SecMask_$_486 == SecMask_$_485;
	goto $branchMerge_151;
anon936:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_305,SecMask_$_305);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_305);
	assume SecMask_$_306 == SecMask_$_305;
	goto $branchMerge_152;
anon1437_Then:
	assume $_$_condition_$464;
	assume SecMask_$_487[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_488 == SecMask_$_487[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_487[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_489 == SecMask_$_488;
	goto anon435;
anon1437_Else:
	assume !$_$_condition_$464;
	assume 0 <= SecMask_$_487[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_489 == SecMask_$_487;
	goto anon435;
anon1466_Then:
	assume $_$_condition_$465;
	assume $_$_condition_$465 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_542 == SecMask_$_541[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_541[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_541[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$548) { goto anon1467_Then; } else { goto anon1467_Else; }
anon1466_Else:
	assume !$_$_condition_$465;
	assume $_$_condition_$465 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_545 == SecMask_$_541;
	goto $branchMerge_155;
anon1686_Then:
	assume $_$_condition_$466;
	assume SecMask_$_307[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_308 == SecMask_$_307[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_307[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_309 == SecMask_$_308;
	goto anon940;
anon1686_Else:
	assume !$_$_condition_$466;
	assume 0 <= SecMask_$_307[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_309 == SecMask_$_307;
	goto anon940;
anon1687_Then:
	assume $_$_condition_$467;
	assume $_$_condition_$467 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_311 == SecMask_$_310[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_310[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_310[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$471) { goto anon1688_Then; } else { goto anon1688_Else; }
anon1687_Else:
	assume !$_$_condition_$467;
	assume $_$_condition_$467 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_314 == SecMask_$_310;
	goto $branchMerge_156;
anon435:
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == exhaleHeap#_1757_$_0[this,AVLTreeNode.left]);
	if ($_$_condition_$468) { goto anon1438_Then; } else { goto anon1438_Else; }
anon940:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_309,SecMask_$_309);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_309);
	assume SecMask_$_310 == SecMask_$_309;
	goto $branchMerge_154;
anon1438_Then:
	assume $_$_condition_$468;
	assume $_$_condition_$468 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$470) { goto anon1439_Then; } else { goto anon1439_Else; }
anon1438_Else:
	assume !$_$_condition_$468;
	assume $_$_condition_$468 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true));
	assume SecMask_$_540 == SecMask_$_489;
	goto anon492;
anon1439_Then:
	assume $_$_condition_$470;
	assume $_$_condition_$470 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true;
	goto $branchMerge_157;
anon1439_Else:
	assume !$_$_condition_$470;
	assume $_$_condition_$470 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right])) && true) && true);
	goto $branchMerge_157;
anon492:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_540,SecMask_$_540);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_540);
	assume SecMask_$_541 == SecMask_$_540;
	goto $branchMerge_153;
anon1688_Then:
	assume $_$_condition_$471;
	assume SecMask_$_311[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_312 == SecMask_$_311[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_311[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_313 == SecMask_$_312;
	goto anon944;
anon1688_Else:
	assume !$_$_condition_$471;
	assume 0 <= SecMask_$_311[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_313 == SecMask_$_311;
	goto anon944;
anon1689_Then:
	assume $_$_condition_$472;
	assume $_$_condition_$472 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_315 == SecMask_$_314[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_314[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_314[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$480) { goto anon1690_Then; } else { goto anon1690_Else; }
anon1689_Else:
	assume !$_$_condition_$472;
	assume $_$_condition_$472 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_318 == SecMask_$_314;
	goto anon949;
anon1440_Then:
	assume $_$_condition_$473;
	assume $_$_condition_$473 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#559 : Integer :: ( ((0 <= lk#79#559) && (lk#79#559 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#559) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_158;
anon1440_Else:
	assume !$_$_condition_$473;
	assume $_$_condition_$473 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_158;
anon944:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_313,SecMask_$_313);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_313);
	assume SecMask_$_314 == SecMask_$_313;
	goto $branchMerge_156;
anon1441_Then:
	assume $_$_condition_$475;
	assume $_$_condition_$475 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_159;
anon1441_Else:
	assume !$_$_condition_$475;
	assume $_$_condition_$475 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_159;
anon1442_Then:
	assume $_$_condition_$478;
	assume $_$_condition_$478 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#560 : Integer :: ( ((0 <= rk#80#560) && (rk#80#560 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#560)) ));
	goto $branchMerge_160;
anon1442_Else:
	assume !$_$_condition_$478;
	assume $_$_condition_$478 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_160;
anon1690_Then:
	assume $_$_condition_$480;
	assume SecMask_$_315[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_316 == SecMask_$_315[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_315[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_317 == SecMask_$_316;
	goto anon948;
anon1690_Else:
	assume !$_$_condition_$480;
	assume 0 <= SecMask_$_315[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_317 == SecMask_$_315;
	goto anon948;
anon949:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_318,SecMask_$_318);
	assume SecMask_$_319 == SecMask_$_318;
	goto anon950;
anon1443_Then:
	assume $_$_condition_$481;
	assume $_$_condition_$481 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon447;
anon1443_Else:
	assume !$_$_condition_$481;
	assume $_$_condition_$481 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon447;
anon948:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_317,SecMask_$_317);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_317);
	assume SecMask_$_318 == SecMask_$_317;
	goto anon949;
anon447:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$13 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$13) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$13)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$13))) || (kk#81_$13 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume SecMask_$_490 == SecMask_$_489[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key := SecMask_$_489[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key][perm$R := SecMask_$_489[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$483) { goto anon1444_Then; } else { goto anon1444_Else; }
anon1444_Then:
	assume $_$_condition_$483;
	assume SecMask_$_490[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_491 == SecMask_$_490[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key := SecMask_$_490[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_492 == SecMask_$_491;
	goto anon449;
anon1444_Else:
	assume !$_$_condition_$483;
	assume 0 <= SecMask_$_490[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_492 == SecMask_$_490;
	goto anon449;
anon449:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_492,SecMask_$_492);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_492);
	assume SecMask_$_493 == SecMask_$_492[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_492[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_492[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$485) { goto anon1445_Then; } else { goto anon1445_Else; }
anon1445_Then:
	assume $_$_condition_$485;
	assume SecMask_$_493[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_494 == SecMask_$_493[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_493[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_495 == SecMask_$_494;
	goto anon451;
anon1445_Else:
	assume !$_$_condition_$485;
	assume 0 <= SecMask_$_493[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_495 == SecMask_$_493;
	goto anon451;
anon1692_Then:
	assume $_$_condition_$486;
	assume SecMask_$_321[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_322 == SecMask_$_321[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_321[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_323 == SecMask_$_322;
	goto anon954;
anon1692_Else:
	assume !$_$_condition_$486;
	assume 0 <= SecMask_$_321[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_323 == SecMask_$_321;
	goto anon954;
anon1693_Then:
	assume $_$_condition_$487;
	assume $_$_condition_$487 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_325 == SecMask_$_324[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_324[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_324[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$490) { goto anon1694_Then; } else { goto anon1694_Else; }
anon1693_Else:
	assume !$_$_condition_$487;
	assume $_$_condition_$487 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_328 == SecMask_$_324;
	goto $branchMerge_161;
anon451:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_495,SecMask_$_495);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_495);
	assume SecMask_$_496 == SecMask_$_495[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left := SecMask_$_495[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_495[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$488) { goto anon1446_Then; } else { goto anon1446_Else; }
anon954:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_323,SecMask_$_323);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_323);
	assume SecMask_$_324 == SecMask_$_323;
	goto $branchMerge_134;
anon1446_Then:
	assume $_$_condition_$488;
	assume SecMask_$_496[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_497 == SecMask_$_496[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left := SecMask_$_496[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_498 == SecMask_$_497;
	goto anon453;
anon1446_Else:
	assume !$_$_condition_$488;
	assume 0 <= SecMask_$_496[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_498 == SecMask_$_496;
	goto anon453;
anon453:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_498,SecMask_$_498);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_498);
	assume SecMask_$_499 == SecMask_$_498[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right := SecMask_$_498[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_498[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$492) { goto anon1447_Then; } else { goto anon1447_Else; }
anon1694_Then:
	assume $_$_condition_$490;
	assume SecMask_$_325[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_326 == SecMask_$_325[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_325[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_327 == SecMask_$_326;
	goto anon958;
anon1694_Else:
	assume !$_$_condition_$490;
	assume 0 <= SecMask_$_325[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_327 == SecMask_$_325;
	goto anon958;
anon1695_Then:
	assume $_$_condition_$491;
	assume $_$_condition_$491 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_329 == SecMask_$_328[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_328[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_328[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$495) { goto anon1696_Then; } else { goto anon1696_Else; }
anon1695_Else:
	assume !$_$_condition_$491;
	assume $_$_condition_$491 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_332 == SecMask_$_328;
	goto $branchMerge_162;
anon1447_Then:
	assume $_$_condition_$492;
	assume SecMask_$_499[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_500 == SecMask_$_499[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right := SecMask_$_499[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_501 == SecMask_$_500;
	goto anon455;
anon1447_Else:
	assume !$_$_condition_$492;
	assume 0 <= SecMask_$_499[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_501 == SecMask_$_499;
	goto anon455;
anon958:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_327,SecMask_$_327);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_327);
	assume SecMask_$_328 == SecMask_$_327;
	goto $branchMerge_161;
anon455:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_501,SecMask_$_501);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_501);
	assume SecMask_$_502 == SecMask_$_501[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_501[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_501[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$494) { goto anon1448_Then; } else { goto anon1448_Else; }
anon1448_Then:
	assume $_$_condition_$494;
	assume SecMask_$_502[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_503 == SecMask_$_502[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_502[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_504 == SecMask_$_503;
	goto anon457;
anon1448_Else:
	assume !$_$_condition_$494;
	assume 0 <= SecMask_$_502[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_504 == SecMask_$_502;
	goto anon457;
anon1696_Then:
	assume $_$_condition_$495;
	assume SecMask_$_329[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_330 == SecMask_$_329[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_329[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_331 == SecMask_$_330;
	goto anon962;
anon1696_Else:
	assume !$_$_condition_$495;
	assume 0 <= SecMask_$_329[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_331 == SecMask_$_329;
	goto anon962;
anon1697_Then:
	assume $_$_condition_$496;
	assume $_$_condition_$496 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_333 == SecMask_$_332[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_332[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_332[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$499) { goto anon1698_Then; } else { goto anon1698_Else; }
anon1697_Else:
	assume !$_$_condition_$496;
	assume $_$_condition_$496 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_387 == SecMask_$_332;
	goto $branchMerge_163;
anon457:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_504,SecMask_$_504);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_504);
	assume SecMask_$_505 == SecMask_$_504[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_504[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_504[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$497) { goto anon1449_Then; } else { goto anon1449_Else; }
anon962:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_331,SecMask_$_331);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_331);
	assume SecMask_$_332 == SecMask_$_331;
	goto $branchMerge_162;
anon1449_Then:
	assume $_$_condition_$497;
	assume SecMask_$_505[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_506 == SecMask_$_505[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_505[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_507 == SecMask_$_506;
	goto anon459;
anon1449_Else:
	assume !$_$_condition_$497;
	assume 0 <= SecMask_$_505[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_507 == SecMask_$_505;
	goto anon459;
anon459:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_507,SecMask_$_507);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_507);
	if ($_$_condition_$501) { goto anon1450_Then; } else { goto anon1450_Else; }
anon1698_Then:
	assume $_$_condition_$499;
	assume SecMask_$_333[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_334 == SecMask_$_333[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_333[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_335 == SecMask_$_334;
	goto anon966;
anon1698_Else:
	assume !$_$_condition_$499;
	assume 0 <= SecMask_$_333[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_335 == SecMask_$_333;
	goto anon966;
anon1727_Then:
	assume $_$_condition_$500;
	assume $_$_condition_$500 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_388 == SecMask_$_387[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_387[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_387[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$587) { goto anon1728_Then; } else { goto anon1728_Else; }
anon1727_Else:
	assume !$_$_condition_$500;
	assume $_$_condition_$500 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_391 == SecMask_$_387;
	goto $branchMerge_164;
anon1450_Then:
	assume $_$_condition_$501;
	assume $_$_condition_$501 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_508 == SecMask_$_507[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_507[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_507[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$502) { goto anon1451_Then; } else { goto anon1451_Else; }
anon1450_Else:
	assume !$_$_condition_$501;
	assume $_$_condition_$501 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_511 == SecMask_$_507;
	goto $branchMerge_165;
anon966:
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == exhaleHeap#_1757_$_0[this,AVLTreeNode.right]);
	if ($_$_condition_$504) { goto anon1699_Then; } else { goto anon1699_Else; }
anon1451_Then:
	assume $_$_condition_$502;
	assume SecMask_$_508[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_509 == SecMask_$_508[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_508[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_510 == SecMask_$_509;
	goto anon462;
anon1451_Else:
	assume !$_$_condition_$502;
	assume 0 <= SecMask_$_508[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_510 == SecMask_$_508;
	goto anon462;
anon1452_Then:
	assume $_$_condition_$503;
	assume $_$_condition_$503 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_512 == SecMask_$_511[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_511[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_511[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$509) { goto anon1453_Then; } else { goto anon1453_Else; }
anon1452_Else:
	assume !$_$_condition_$503;
	assume $_$_condition_$503 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_515 == SecMask_$_511;
	goto $branchMerge_166;
anon1699_Then:
	assume $_$_condition_$504;
	assume $_$_condition_$504 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$505) { goto anon1700_Then; } else { goto anon1700_Else; }
anon1699_Else:
	assume !$_$_condition_$504;
	assume $_$_condition_$504 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true));
	assume SecMask_$_386 == SecMask_$_335;
	goto anon1023;
anon462:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_510,SecMask_$_510);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_510);
	assume SecMask_$_511 == SecMask_$_510;
	goto $branchMerge_165;
anon1700_Then:
	assume $_$_condition_$505;
	assume $_$_condition_$505 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true;
	goto $branchMerge_167;
anon1700_Else:
	assume !$_$_condition_$505;
	assume $_$_condition_$505 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true);
	goto $branchMerge_167;
anon1023:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_386,SecMask_$_386);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_386);
	assume SecMask_$_387 == SecMask_$_386;
	goto $branchMerge_163;
anon1701_Then:
	assume $_$_condition_$507;
	assume $_$_condition_$507 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#602 : Integer :: ( ((0 <= lk#79#602) && (lk#79#602 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#602) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_168;
anon1701_Else:
	assume !$_$_condition_$507;
	assume $_$_condition_$507 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_168;
anon1453_Then:
	assume $_$_condition_$509;
	assume SecMask_$_512[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_513 == SecMask_$_512[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_512[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_514 == SecMask_$_513;
	goto anon466;
anon1453_Else:
	assume !$_$_condition_$509;
	assume 0 <= SecMask_$_512[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_514 == SecMask_$_512;
	goto anon466;
anon1454_Then:
	assume $_$_condition_$510;
	assume $_$_condition_$510 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_516 == SecMask_$_515[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_515[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_515[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$518) { goto anon1455_Then; } else { goto anon1455_Else; }
anon1454_Else:
	assume !$_$_condition_$510;
	assume $_$_condition_$510 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_519 == SecMask_$_515;
	goto $branchMerge_169;
anon1702_Then:
	assume $_$_condition_$511;
	assume $_$_condition_$511 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_170;
anon1702_Else:
	assume !$_$_condition_$511;
	assume $_$_condition_$511 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_170;
anon466:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_514,SecMask_$_514);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_514);
	assume SecMask_$_515 == SecMask_$_514;
	goto $branchMerge_166;
anon1703_Then:
	assume $_$_condition_$513;
	assume $_$_condition_$513 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#603 : Integer :: ( ((0 <= rk#80#603) && (rk#80#603 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#603)) ));
	goto $branchMerge_171;
anon1703_Else:
	assume !$_$_condition_$513;
	assume $_$_condition_$513 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_171;
anon1704_Then:
	assume $_$_condition_$516;
	assume $_$_condition_$516 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon978;
anon1704_Else:
	assume !$_$_condition_$516;
	assume $_$_condition_$516 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon978;
anon1455_Then:
	assume $_$_condition_$518;
	assume SecMask_$_516[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_517 == SecMask_$_516[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_516[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_518 == SecMask_$_517;
	goto anon470;
anon1455_Else:
	assume !$_$_condition_$518;
	assume 0 <= SecMask_$_516[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_518 == SecMask_$_516;
	goto anon470;
anon1456_Then:
	assume $_$_condition_$519;
	assume $_$_condition_$519 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_520 == SecMask_$_519[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_519[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_519[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$522) { goto anon1457_Then; } else { goto anon1457_Else; }
anon1456_Else:
	assume !$_$_condition_$519;
	assume $_$_condition_$519 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_523 == SecMask_$_519;
	goto $branchMerge_172;
anon978:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$14 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$14) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$14)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$14))) || (kk#81_$14 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume SecMask_$_336 == SecMask_$_335[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key := SecMask_$_335[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key][perm$R := SecMask_$_335[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$520) { goto anon1705_Then; } else { goto anon1705_Else; }
anon470:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_518,SecMask_$_518);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_518);
	assume SecMask_$_519 == SecMask_$_518;
	goto $branchMerge_169;
anon1705_Then:
	assume $_$_condition_$520;
	assume SecMask_$_336[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_337 == SecMask_$_336[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key := SecMask_$_336[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_338 == SecMask_$_337;
	goto anon980;
anon1705_Else:
	assume !$_$_condition_$520;
	assume 0 <= SecMask_$_336[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_338 == SecMask_$_336;
	goto anon980;
anon980:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_338,SecMask_$_338);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_338);
	assume SecMask_$_339 == SecMask_$_338[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_338[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_338[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$524) { goto anon1706_Then; } else { goto anon1706_Else; }
anon1457_Then:
	assume $_$_condition_$522;
	assume SecMask_$_520[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_521 == SecMask_$_520[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_520[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_522 == SecMask_$_521;
	goto anon474;
anon1457_Else:
	assume !$_$_condition_$522;
	assume 0 <= SecMask_$_520[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_522 == SecMask_$_520;
	goto anon474;
anon1458_Then:
	assume $_$_condition_$523;
	assume $_$_condition_$523 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_524 == SecMask_$_523[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_523[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_523[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$527) { goto anon1459_Then; } else { goto anon1459_Else; }
anon1458_Else:
	assume !$_$_condition_$523;
	assume $_$_condition_$523 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_527 == SecMask_$_523;
	goto $branchMerge_173;
anon1706_Then:
	assume $_$_condition_$524;
	assume SecMask_$_339[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_340 == SecMask_$_339[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_339[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_341 == SecMask_$_340;
	goto anon982;
anon1706_Else:
	assume !$_$_condition_$524;
	assume 0 <= SecMask_$_339[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_341 == SecMask_$_339;
	goto anon982;
anon474:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_522,SecMask_$_522);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_522);
	assume SecMask_$_523 == SecMask_$_522;
	goto $branchMerge_172;
anon982:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_341,SecMask_$_341);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_341);
	assume SecMask_$_342 == SecMask_$_341[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left := SecMask_$_341[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_341[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$526) { goto anon1707_Then; } else { goto anon1707_Else; }
anon1707_Then:
	assume $_$_condition_$526;
	assume SecMask_$_342[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_343 == SecMask_$_342[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left := SecMask_$_342[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_344 == SecMask_$_343;
	goto anon984;
anon1707_Else:
	assume !$_$_condition_$526;
	assume 0 <= SecMask_$_342[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_344 == SecMask_$_342;
	goto anon984;
anon1459_Then:
	assume $_$_condition_$527;
	assume SecMask_$_524[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_525 == SecMask_$_524[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_524[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_526 == SecMask_$_525;
	goto anon478;
anon1459_Else:
	assume !$_$_condition_$527;
	assume 0 <= SecMask_$_524[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_526 == SecMask_$_524;
	goto anon478;
anon1460_Then:
	assume $_$_condition_$528;
	assume $_$_condition_$528 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_528 == SecMask_$_527[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_527[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_527[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$531) { goto anon1461_Then; } else { goto anon1461_Else; }
anon1460_Else:
	assume !$_$_condition_$528;
	assume $_$_condition_$528 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_531 == SecMask_$_527;
	goto $branchMerge_174;
anon984:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_344,SecMask_$_344);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_344);
	assume SecMask_$_345 == SecMask_$_344[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right := SecMask_$_344[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_344[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$529) { goto anon1708_Then; } else { goto anon1708_Else; }
anon478:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_526,SecMask_$_526);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_526);
	assume SecMask_$_527 == SecMask_$_526;
	goto $branchMerge_173;
anon1708_Then:
	assume $_$_condition_$529;
	assume SecMask_$_345[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_346 == SecMask_$_345[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right := SecMask_$_345[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_347 == SecMask_$_346;
	goto anon986;
anon1708_Else:
	assume !$_$_condition_$529;
	assume 0 <= SecMask_$_345[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_347 == SecMask_$_345;
	goto anon986;
anon986:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_347,SecMask_$_347);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_347);
	assume SecMask_$_348 == SecMask_$_347[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_347[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_347[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$533) { goto anon1709_Then; } else { goto anon1709_Else; }
anon1461_Then:
	assume $_$_condition_$531;
	assume SecMask_$_528[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_529 == SecMask_$_528[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_528[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_530 == SecMask_$_529;
	goto anon482;
anon1461_Else:
	assume !$_$_condition_$531;
	assume 0 <= SecMask_$_528[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_530 == SecMask_$_528;
	goto anon482;
anon1462_Then:
	assume $_$_condition_$532;
	assume $_$_condition_$532 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_532 == SecMask_$_531[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_531[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_531[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$536) { goto anon1463_Then; } else { goto anon1463_Else; }
anon1462_Else:
	assume !$_$_condition_$532;
	assume $_$_condition_$532 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_535 == SecMask_$_531;
	goto $branchMerge_175;
anon1709_Then:
	assume $_$_condition_$533;
	assume SecMask_$_348[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_349 == SecMask_$_348[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_348[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_350 == SecMask_$_349;
	goto anon988;
anon1709_Else:
	assume !$_$_condition_$533;
	assume 0 <= SecMask_$_348[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_350 == SecMask_$_348;
	goto anon988;
anon482:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_530,SecMask_$_530);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_530);
	assume SecMask_$_531 == SecMask_$_530;
	goto $branchMerge_174;
anon988:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_350,SecMask_$_350);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_350);
	assume SecMask_$_351 == SecMask_$_350[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_350[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_350[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$535) { goto anon1710_Then; } else { goto anon1710_Else; }
anon1710_Then:
	assume $_$_condition_$535;
	assume SecMask_$_351[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_352 == SecMask_$_351[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_351[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_353 == SecMask_$_352;
	goto anon990;
anon1710_Else:
	assume !$_$_condition_$535;
	assume 0 <= SecMask_$_351[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_353 == SecMask_$_351;
	goto anon990;
anon1463_Then:
	assume $_$_condition_$536;
	assume SecMask_$_532[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_533 == SecMask_$_532[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_532[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_534 == SecMask_$_533;
	goto anon486;
anon1463_Else:
	assume !$_$_condition_$536;
	assume 0 <= SecMask_$_532[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_534 == SecMask_$_532;
	goto anon486;
anon1464_Then:
	assume $_$_condition_$537;
	assume $_$_condition_$537 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_536 == SecMask_$_535[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_535[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_535[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$542) { goto anon1465_Then; } else { goto anon1465_Else; }
anon1464_Else:
	assume !$_$_condition_$537;
	assume $_$_condition_$537 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_539 == SecMask_$_535;
	goto anon491;
anon990:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_353,SecMask_$_353);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_353);
	if ($_$_condition_$538) { goto anon1711_Then; } else { goto anon1711_Else; }
anon486:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_534,SecMask_$_534);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_534);
	assume SecMask_$_535 == SecMask_$_534;
	goto $branchMerge_175;
anon1711_Then:
	assume $_$_condition_$538;
	assume $_$_condition_$538 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_354 == SecMask_$_353[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_353[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_353[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$540) { goto anon1712_Then; } else { goto anon1712_Else; }
anon1711_Else:
	assume !$_$_condition_$538;
	assume $_$_condition_$538 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_357 == SecMask_$_353;
	goto $branchMerge_176;
anon1712_Then:
	assume $_$_condition_$540;
	assume SecMask_$_354[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_355 == SecMask_$_354[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_354[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_356 == SecMask_$_355;
	goto anon993;
anon1712_Else:
	assume !$_$_condition_$540;
	assume 0 <= SecMask_$_354[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_356 == SecMask_$_354;
	goto anon993;
anon1713_Then:
	assume $_$_condition_$541;
	assume $_$_condition_$541 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_358 == SecMask_$_357[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_357[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_357[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$544) { goto anon1714_Then; } else { goto anon1714_Else; }
anon1713_Else:
	assume !$_$_condition_$541;
	assume $_$_condition_$541 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_361 == SecMask_$_357;
	goto $branchMerge_177;
anon1465_Then:
	assume $_$_condition_$542;
	assume SecMask_$_536[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_537 == SecMask_$_536[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_536[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_538 == SecMask_$_537;
	goto anon490;
anon1465_Else:
	assume !$_$_condition_$542;
	assume 0 <= SecMask_$_536[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_538 == SecMask_$_536;
	goto anon490;
anon491:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_539,SecMask_$_539);
	assume SecMask_$_540 == SecMask_$_539;
	goto anon492;
anon993:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_356,SecMask_$_356);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_356);
	assume SecMask_$_357 == SecMask_$_356;
	goto $branchMerge_176;
anon490:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_538,SecMask_$_538);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_538);
	assume SecMask_$_539 == SecMask_$_538;
	goto anon491;
anon1714_Then:
	assume $_$_condition_$544;
	assume SecMask_$_358[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_359 == SecMask_$_358[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_358[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_360 == SecMask_$_359;
	goto anon997;
anon1714_Else:
	assume !$_$_condition_$544;
	assume 0 <= SecMask_$_358[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_360 == SecMask_$_358;
	goto anon997;
anon1715_Then:
	assume $_$_condition_$545;
	assume $_$_condition_$545 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_362 == SecMask_$_361[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_361[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_361[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$550) { goto anon1716_Then; } else { goto anon1716_Else; }
anon1715_Else:
	assume !$_$_condition_$545;
	assume $_$_condition_$545 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_365 == SecMask_$_361;
	goto $branchMerge_178;
anon997:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_360,SecMask_$_360);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_360);
	assume SecMask_$_361 == SecMask_$_360;
	goto $branchMerge_177;
anon1467_Then:
	assume $_$_condition_$548;
	assume SecMask_$_542[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_543 == SecMask_$_542[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_542[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_544 == SecMask_$_543;
	goto anon496;
anon1467_Else:
	assume !$_$_condition_$548;
	assume 0 <= SecMask_$_542[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_544 == SecMask_$_542;
	goto anon496;
anon1468_Then:
	assume $_$_condition_$549;
	assume $_$_condition_$549 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_546 == SecMask_$_545[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_545[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_545[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$554) { goto anon1469_Then; } else { goto anon1469_Else; }
anon1468_Else:
	assume !$_$_condition_$549;
	assume $_$_condition_$549 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_549 == SecMask_$_545;
	goto $branchMerge_179;
anon1716_Then:
	assume $_$_condition_$550;
	assume SecMask_$_362[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_363 == SecMask_$_362[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_362[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_364 == SecMask_$_363;
	goto anon1001;
anon1716_Else:
	assume !$_$_condition_$550;
	assume 0 <= SecMask_$_362[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_364 == SecMask_$_362;
	goto anon1001;
anon1717_Then:
	assume $_$_condition_$551;
	assume $_$_condition_$551 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_366 == SecMask_$_365[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_365[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_365[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$556) { goto anon1718_Then; } else { goto anon1718_Else; }
anon1717_Else:
	assume !$_$_condition_$551;
	assume $_$_condition_$551 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_369 == SecMask_$_365;
	goto $branchMerge_180;
anon496:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_544,SecMask_$_544);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_544);
	assume SecMask_$_545 == SecMask_$_544;
	goto $branchMerge_155;
anon1001:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_364,SecMask_$_364);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_364);
	assume SecMask_$_365 == SecMask_$_364;
	goto $branchMerge_178;
anon1469_Then:
	assume $_$_condition_$554;
	assume SecMask_$_546[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_547 == SecMask_$_546[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_546[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_548 == SecMask_$_547;
	goto anon500;
anon1469_Else:
	assume !$_$_condition_$554;
	assume 0 <= SecMask_$_546[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_548 == SecMask_$_546;
	goto anon500;
anon1470_Then:
	assume $_$_condition_$555;
	assume $_$_condition_$555 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_550 == SecMask_$_549[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_549[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_549[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$560) { goto anon1471_Then; } else { goto anon1471_Else; }
anon1470_Else:
	assume !$_$_condition_$555;
	assume $_$_condition_$555 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_553 == SecMask_$_549;
	goto anon505;
anon1718_Then:
	assume $_$_condition_$556;
	assume SecMask_$_366[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_367 == SecMask_$_366[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_366[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_368 == SecMask_$_367;
	goto anon1005;
anon1718_Else:
	assume !$_$_condition_$556;
	assume 0 <= SecMask_$_366[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_368 == SecMask_$_366;
	goto anon1005;
anon1719_Then:
	assume $_$_condition_$557;
	assume $_$_condition_$557 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_370 == SecMask_$_369[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_369[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_369[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$561) { goto anon1720_Then; } else { goto anon1720_Else; }
anon1719_Else:
	assume !$_$_condition_$557;
	assume $_$_condition_$557 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_373 == SecMask_$_369;
	goto $branchMerge_181;
anon500:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_548,SecMask_$_548);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_548);
	assume SecMask_$_549 == SecMask_$_548;
	goto $branchMerge_179;
anon1005:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_368,SecMask_$_368);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_368);
	assume SecMask_$_369 == SecMask_$_368;
	goto $branchMerge_180;
anon1471_Then:
	assume $_$_condition_$560;
	assume SecMask_$_550[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_551 == SecMask_$_550[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_550[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_552 == SecMask_$_551;
	goto anon504;
anon1471_Else:
	assume !$_$_condition_$560;
	assume 0 <= SecMask_$_550[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_552 == SecMask_$_550;
	goto anon504;
anon505:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_553,SecMask_$_553);
	assume SecMask_$_554 == SecMask_$_553;
	goto $branchMerge_114;
anon1720_Then:
	assume $_$_condition_$561;
	assume SecMask_$_370[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_371 == SecMask_$_370[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_370[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_372 == SecMask_$_371;
	goto anon1009;
anon1720_Else:
	assume !$_$_condition_$561;
	assume 0 <= SecMask_$_370[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_372 == SecMask_$_370;
	goto anon1009;
anon1721_Then:
	assume $_$_condition_$562;
	assume $_$_condition_$562 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_374 == SecMask_$_373[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_373[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_373[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$565) { goto anon1722_Then; } else { goto anon1722_Else; }
anon1721_Else:
	assume !$_$_condition_$562;
	assume $_$_condition_$562 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_377 == SecMask_$_373;
	goto $branchMerge_182;
anon504:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_552,SecMask_$_552);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_552);
	assume SecMask_$_553 == SecMask_$_552;
	goto anon505;
anon1009:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_372,SecMask_$_372);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_372);
	assume SecMask_$_373 == SecMask_$_372;
	goto $branchMerge_181;
anon1722_Then:
	assume $_$_condition_$565;
	assume SecMask_$_374[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_375 == SecMask_$_374[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_374[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_376 == SecMask_$_375;
	goto anon1013;
anon1722_Else:
	assume !$_$_condition_$565;
	assume 0 <= SecMask_$_374[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_376 == SecMask_$_374;
	goto anon1013;
anon1723_Then:
	assume $_$_condition_$566;
	assume $_$_condition_$566 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_378 == SecMask_$_377[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_377[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_377[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$571) { goto anon1724_Then; } else { goto anon1724_Else; }
anon1723_Else:
	assume !$_$_condition_$566;
	assume $_$_condition_$566 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_381 == SecMask_$_377;
	goto $branchMerge_183;
anon508:
	assume IsGoodMask(exhaleMask#_1857_$_6);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_6,SecMask_$_554);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_554);
	assert { :msg "  636.4: The precondition at 654.12 might not hold. The permission at 654.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  636.4: The precondition at 654.12 might not hold. Insufficient fraction at 654.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1857_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1857_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1857_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1857_$_7 == exhaleMask#_1857_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_1857_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_1857_$_6[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1857_$_7);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_7,SecMask_$_554);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_554);
	assert { :msg "  636.4: The precondition at 655.12 might not hold. The permission at 655.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  636.4: The precondition at 655.12 might not hold. Insufficient fraction at 655.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1857_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1857_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1857_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1857_$_8 == exhaleMask#_1857_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_1857_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_1857_$_7[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1857_$_8);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_8,SecMask_$_554);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_554);
	assert { :msg "  636.4: The precondition at 656.12 might not hold. The permission at 656.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  636.4: The precondition at 656.12 might not hold. Insufficient fraction at 656.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1857_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1857_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1857_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1857_$_9 == exhaleMask#_1857_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_1857_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1857_$_8[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1857_$_9);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_9,SecMask_$_554);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_554);
	if ($_$_condition_$567) { goto anon1473_Then; } else { goto anon1473_Else; }
anon1013:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_376,SecMask_$_376);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_376);
	assume SecMask_$_377 == SecMask_$_376;
	goto $branchMerge_182;
anon1473_Then:
	assume $_$_condition_$567;
	assume $_$_condition_$567 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  636.4: The precondition at 659.12 might not hold. The permission at 659.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  636.4: The precondition at 659.12 might not hold. Insufficient fraction at 659.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1857_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1857_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1857_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1857_$_10 == exhaleMask#_1857_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_1857_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_1857_$_9[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$569) { goto anon1474_Then; } else { goto anon1474_Else; }
anon1473_Else:
	assume !$_$_condition_$567;
	assume $_$_condition_$567 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null;
	assume SecMask_$_708 == SecMask_$_554;
	assume exhaleMask#_1857_$_11 == exhaleMask#_1857_$_9;
	goto $branchMerge_184;
anon1474_Then:
	assume $_$_condition_$569;
	assume $_$_condition_$569 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$573) { goto anon1475_Then; } else { goto anon1475_Else; }
anon1474_Else:
	assume !$_$_condition_$569;
	assume $_$_condition_$569 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true));
	assume SecMask_$_707 == SecMask_$_554;
	goto $branchMerge_185;
anon1559_Then:
	assume $_$_condition_$570;
	assume $_$_condition_$570 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  636.4: The precondition at 660.12 might not hold. The permission at 660.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  636.4: The precondition at 660.12 might not hold. Insufficient fraction at 660.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1857_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1857_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1857_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1857_$_12 == exhaleMask#_1857_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_1857_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_1857_$_11[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1857_$_12);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_12,SecMask_$_708);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_708);
	assume exhaleMask#_1857_$_13 == exhaleMask#_1857_$_12;
	goto $branchMerge_186;
anon1559_Else:
	assume !$_$_condition_$570;
	assume $_$_condition_$570 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1857_$_13 == exhaleMask#_1857_$_11;
	goto $branchMerge_186;
anon1724_Then:
	assume $_$_condition_$571;
	assume SecMask_$_378[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_379 == SecMask_$_378[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_378[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_380 == SecMask_$_379;
	goto anon1017;
anon1724_Else:
	assume !$_$_condition_$571;
	assume 0 <= SecMask_$_378[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_380 == SecMask_$_378;
	goto anon1017;
anon1725_Then:
	assume $_$_condition_$572;
	assume $_$_condition_$572 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_382 == SecMask_$_381[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_381[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_381[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$580) { goto anon1726_Then; } else { goto anon1726_Else; }
anon1725_Else:
	assume !$_$_condition_$572;
	assume $_$_condition_$572 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_385 == SecMask_$_381;
	goto anon1022;
anon1475_Then:
	assume $_$_condition_$573;
	assume $_$_condition_$573 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true;
	goto $branchMerge_187;
anon1475_Else:
	assume !$_$_condition_$573;
	assume $_$_condition_$573 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[this,AVLTreeNode.right])) && true) && true);
	goto $branchMerge_187;
anon1558_Then:
	assume $_$_condition_$574;
	assume $_$_condition_$574 <==> (!CanRead(exhaleMask#_1857_$_10,SecMask_$_707,exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_1857_$_10,SecMask_$_707,exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_1856_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon682;
anon1558_Else:
	assume !$_$_condition_$574;
	assume $_$_condition_$574 <==> (!CanRead(exhaleMask#_1857_$_10,SecMask_$_707,exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_1857_$_10,SecMask_$_707,exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon682;
anon1017:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_380,SecMask_$_380);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_380);
	assume SecMask_$_381 == SecMask_$_380;
	goto $branchMerge_183;
anon1476_Then:
	assume $_$_condition_$575;
	assume $_$_condition_$575 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#564 : Integer :: ( ((0 <= lk#79#564) && (lk#79#564 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#564) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_188;
anon1476_Else:
	assume !$_$_condition_$575;
	assume $_$_condition_$575 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_188;
anon1477_Then:
	assume $_$_condition_$578;
	assume $_$_condition_$578 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_189;
anon1477_Else:
	assume !$_$_condition_$578;
	assume $_$_condition_$578 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_189;
anon1726_Then:
	assume $_$_condition_$580;
	assume SecMask_$_382[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_383 == SecMask_$_382[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_382[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_384 == SecMask_$_383;
	goto anon1021;
anon1726_Else:
	assume !$_$_condition_$580;
	assume 0 <= SecMask_$_382[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_384 == SecMask_$_382;
	goto anon1021;
anon1022:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_385,SecMask_$_385);
	assume SecMask_$_386 == SecMask_$_385;
	goto anon1023;
anon1478_Then:
	assume $_$_condition_$581;
	assume $_$_condition_$581 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#565 : Integer :: ( ((0 <= rk#80#565) && (rk#80#565 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#565)) ));
	goto $branchMerge_190;
anon1478_Else:
	assume !$_$_condition_$581;
	assume $_$_condition_$581 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_190;
anon1021:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_384,SecMask_$_384);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_384);
	assume SecMask_$_385 == SecMask_$_384;
	goto anon1022;
anon1479_Then:
	assume $_$_condition_$583;
	assume $_$_condition_$583 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon521;
anon1479_Else:
	assume !$_$_condition_$583;
	assume $_$_condition_$583 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon521;
anon521:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$15 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$15) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$15)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$15))) || (kk#81_$15 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume SecMask_$_555 == SecMask_$_554[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_554[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := SecMask_$_554[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$585) { goto anon1480_Then; } else { goto anon1480_Else; }
anon1480_Then:
	assume $_$_condition_$585;
	assume SecMask_$_555[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_556 == SecMask_$_555[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_555[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_557 == SecMask_$_556;
	goto anon523;
anon1480_Else:
	assume !$_$_condition_$585;
	assume 0 <= SecMask_$_555[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_557 == SecMask_$_555;
	goto anon523;
anon523:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_557,SecMask_$_557);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_557);
	assume SecMask_$_558 == SecMask_$_557[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_557[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_557[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$589) { goto anon1481_Then; } else { goto anon1481_Else; }
anon1728_Then:
	assume $_$_condition_$587;
	assume SecMask_$_388[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_389 == SecMask_$_388[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_388[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_390 == SecMask_$_389;
	goto anon1027;
anon1728_Else:
	assume !$_$_condition_$587;
	assume 0 <= SecMask_$_388[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_390 == SecMask_$_388;
	goto anon1027;
anon1729_Then:
	assume $_$_condition_$588;
	assume $_$_condition_$588 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_392 == SecMask_$_391[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_391[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_391[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$592) { goto anon1730_Then; } else { goto anon1730_Else; }
anon1729_Else:
	assume !$_$_condition_$588;
	assume $_$_condition_$588 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_395 == SecMask_$_391;
	goto $branchMerge_191;
anon1481_Then:
	assume $_$_condition_$589;
	assume SecMask_$_558[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_559 == SecMask_$_558[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_558[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_560 == SecMask_$_559;
	goto anon525;
anon1481_Else:
	assume !$_$_condition_$589;
	assume 0 <= SecMask_$_558[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_560 == SecMask_$_558;
	goto anon525;
anon1027:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_390,SecMask_$_390);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_390);
	assume SecMask_$_391 == SecMask_$_390;
	goto $branchMerge_164;
anon525:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_560,SecMask_$_560);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_560);
	assume SecMask_$_561 == SecMask_$_560[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_560[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_560[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$591) { goto anon1482_Then; } else { goto anon1482_Else; }
anon1482_Then:
	assume $_$_condition_$591;
	assume SecMask_$_561[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_562 == SecMask_$_561[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_561[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_563 == SecMask_$_562;
	goto anon527;
anon1482_Else:
	assume !$_$_condition_$591;
	assume 0 <= SecMask_$_561[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_563 == SecMask_$_561;
	goto anon527;
anon1730_Then:
	assume $_$_condition_$592;
	assume SecMask_$_392[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_393 == SecMask_$_392[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_392[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_394 == SecMask_$_393;
	goto anon1031;
anon1730_Else:
	assume !$_$_condition_$592;
	assume 0 <= SecMask_$_392[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_394 == SecMask_$_392;
	goto anon1031;
anon1731_Then:
	assume $_$_condition_$593;
	assume $_$_condition_$593 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_396 == SecMask_$_395[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_395[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_395[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$596) { goto anon1732_Then; } else { goto anon1732_Else; }
anon1731_Else:
	assume !$_$_condition_$593;
	assume $_$_condition_$593 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_399 == SecMask_$_395;
	goto anon1036;
anon527:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_563,SecMask_$_563);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_563);
	assume SecMask_$_564 == SecMask_$_563[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_563[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_563[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$594) { goto anon1483_Then; } else { goto anon1483_Else; }
anon1031:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_394,SecMask_$_394);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_394);
	assume SecMask_$_395 == SecMask_$_394;
	goto $branchMerge_191;
anon1483_Then:
	assume $_$_condition_$594;
	assume SecMask_$_564[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_565 == SecMask_$_564[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_564[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_566 == SecMask_$_565;
	goto anon529;
anon1483_Else:
	assume !$_$_condition_$594;
	assume 0 <= SecMask_$_564[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_566 == SecMask_$_564;
	goto anon529;
anon529:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_566,SecMask_$_566);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_566);
	assume SecMask_$_567 == SecMask_$_566[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_566[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_566[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$597) { goto anon1484_Then; } else { goto anon1484_Else; }
anon1732_Then:
	assume $_$_condition_$596;
	assume SecMask_$_396[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_397 == SecMask_$_396[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_396[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_398 == SecMask_$_397;
	goto anon1035;
anon1732_Else:
	assume !$_$_condition_$596;
	assume 0 <= SecMask_$_396[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_398 == SecMask_$_396;
	goto anon1035;
anon1036:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_399,SecMask_$_399);
	assume SecMask_$_400 == SecMask_$_399;
	goto $branchMerge_123;
anon1484_Then:
	assume $_$_condition_$597;
	assume SecMask_$_567[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_568 == SecMask_$_567[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_567[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_569 == SecMask_$_568;
	goto anon531;
anon1484_Else:
	assume !$_$_condition_$597;
	assume 0 <= SecMask_$_567[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_569 == SecMask_$_567;
	goto anon531;
anon1035:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_398,SecMask_$_398);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_398);
	assume SecMask_$_399 == SecMask_$_398;
	goto anon1036;
anon531:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_569,SecMask_$_569);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_569);
	assume SecMask_$_570 == SecMask_$_569[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_569[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_569[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$598) { goto anon1485_Then; } else { goto anon1485_Else; }
anon1485_Then:
	assume $_$_condition_$598;
	assume SecMask_$_570[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_571 == SecMask_$_570[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_570[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_572 == SecMask_$_571;
	goto anon533;
anon1485_Else:
	assume !$_$_condition_$598;
	assume 0 <= SecMask_$_570[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_572 == SecMask_$_570;
	goto anon533;
anon533:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_572,SecMask_$_572);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_572);
	if ($_$_condition_$600) { goto anon1486_Then; } else { goto anon1486_Else; }
anon1039:
	assume IsGoodMask(exhaleMask#_1976_$_10);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_10,SecMask_$_400);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_400);
	assume SecMask_$_401 == SecMask_$_400;
	assume exhaleMask#_1976_$_11 == exhaleMask#_1976_$_10;
	goto $branchMerge_121;
anon1486_Then:
	assume $_$_condition_$600;
	assume $_$_condition_$600 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_573 == SecMask_$_572[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_572[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_572[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$602) { goto anon1487_Then; } else { goto anon1487_Else; }
anon1486_Else:
	assume !$_$_condition_$600;
	assume $_$_condition_$600 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_627 == SecMask_$_572;
	goto $branchMerge_192;
anon1487_Then:
	assume $_$_condition_$602;
	assume SecMask_$_573[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_574 == SecMask_$_573[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_573[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_575 == SecMask_$_574;
	goto anon536;
anon1487_Else:
	assume !$_$_condition_$602;
	assume 0 <= SecMask_$_573[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_575 == SecMask_$_573;
	goto anon536;
anon1516_Then:
	assume $_$_condition_$603;
	assume $_$_condition_$603 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_628 == SecMask_$_627[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_627[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_627[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$648) { goto anon1517_Then; } else { goto anon1517_Else; }
anon1516_Else:
	assume !$_$_condition_$603;
	assume $_$_condition_$603 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_631 == SecMask_$_627;
	goto $branchMerge_193;
anon1735_Then:
	assume $_$_condition_$604;
	assume $_$_condition_$604 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  638.4: The precondition at 719.12 might not hold. The permission at 719.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  638.4: The precondition at 719.12 might not hold. Insufficient fraction at 719.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1976_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1976_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1976_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1976_$_14 == exhaleMask#_1976_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_1976_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_1976_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1976_$_14);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_14,SecMask_$_401);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_401);
	assume exhaleMask#_1976_$_15 == exhaleMask#_1976_$_14;
	goto $branchMerge_194;
anon1735_Else:
	assume !$_$_condition_$604;
	assume $_$_condition_$604 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1976_$_15 == exhaleMask#_1976_$_13;
	goto $branchMerge_194;
anon536:
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == exhaleHeap#_1757_$_0[this,AVLTreeNode.right]);
	if ($_$_condition_$608) { goto anon1488_Then; } else { goto anon1488_Else; }
anon1736_Then:
	assume $_$_condition_$606;
	assume $_$_condition_$606 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  638.4: The precondition at 720.12 might not hold. The permission at 720.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  638.4: The precondition at 720.12 might not hold. Insufficient fraction at 720.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1976_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1976_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1976_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1976_$_16 == exhaleMask#_1976_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_1976_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1976_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1976_$_16);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1976_$_16,SecMask_$_401);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_401);
	assume exhaleMask#_1976_$_17 == exhaleMask#_1976_$_16;
	goto anon1046;
anon1736_Else:
	assume !$_$_condition_$606;
	assume $_$_condition_$606 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1976_$_17 == exhaleMask#_1976_$_15;
	goto anon1046;
anon1488_Then:
	assume $_$_condition_$608;
	assume $_$_condition_$608 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$609) { goto anon1489_Then; } else { goto anon1489_Else; }
anon1488_Else:
	assume !$_$_condition_$608;
	assume $_$_condition_$608 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true));
	assume SecMask_$_626 == SecMask_$_575;
	goto anon593;
anon1046:
	assume IsGoodExhaleState(exhaleHeap#_1975_$_0,exhaleHeap#_1757_$_0,exhaleMask#_1976_$_17,SecMask_$_401);
	assume IsGoodMask(exhaleMask#_1976_$_17);
	assume wf(exhaleHeap#_1975_$_0,exhaleMask#_1976_$_17,SecMask_$_401);
	assume (r#578_$_0 == null) || (dtype(r#578_$_0) == AVLTreeNode#t);
	assume !(r#578_$_0 == null);
	assume !(r#578_$_0 == null);
	assume wf(exhaleHeap#_1975_$_0,exhaleMask#_1976_$_17,SecMask_$_401);
	assume Fractions(100) > 0;
	assume Mask_$_20 == exhaleMask#_1976_$_17[r#578_$_0,AVLTreeNode.valid := exhaleMask#_1976_$_17[r#578_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_1976_$_17[r#578_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_20);
	assume IsGoodState(heapFragment(exhaleHeap#_1975_$_0[r#578_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1975_$_0,Mask_$_20,SecMask_$_401);
	assume wf(exhaleHeap#_1975_$_0,Mask_$_20,SecMask_$_401);
	assume !(r#578_$_0 == null);
	assume wf(exhaleHeap#_1975_$_0,Mask_$_20,SecMask_$_401);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_21 == Mask_$_20[r#578_$_0,AVLTreeNode.height := Mask_$_20[r#578_$_0,AVLTreeNode.height][perm$R := Mask_$_20[r#578_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(exhaleHeap#_1975_$_0[r#578_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_1975_$_0,Mask_$_21,SecMask_$_401);
	assume wf(exhaleHeap#_1975_$_0,Mask_$_21,SecMask_$_401);
	assume !(r#578_$_0 == null);
	assume wf(exhaleHeap#_1975_$_0,Mask_$_21,SecMask_$_401);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_22 == Mask_$_21[r#578_$_0,AVLTreeNode.keys := Mask_$_21[r#578_$_0,AVLTreeNode.keys][perm$R := Mask_$_21[r#578_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_22);
	assume IsGoodState(heapFragment(exhaleHeap#_1975_$_0[r#578_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1975_$_0,Mask_$_22,SecMask_$_401);
	assume wf(exhaleHeap#_1975_$_0,Mask_$_22,SecMask_$_401);
	assume !(r#578_$_0 == null);
	assume wf(exhaleHeap#_1975_$_0,Mask_$_22,SecMask_$_401);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_23 == Mask_$_22[r#578_$_0,AVLTreeNode.balanceFactor := Mask_$_22[r#578_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_22[r#578_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_23);
	assume IsGoodState(heapFragment(exhaleHeap#_1975_$_0[r#578_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1975_$_0,Mask_$_23,SecMask_$_401);
	assume wf(exhaleHeap#_1975_$_0,Mask_$_23,SecMask_$_401);
	assume (exhaleHeap#_1975_$_0[r#578_$_0,AVLTreeNode.height] == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) || (exhaleHeap#_1975_$_0[r#578_$_0,AVLTreeNode.height] == (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height] + 1));
	assume Seq#Equal(exhaleHeap#_1975_$_0[r#578_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Singleton(exhaleHeap#_1757_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume IsGoodMask(Mask_$_23);
	assume wf(exhaleHeap#_1975_$_0,Mask_$_23,SecMask_$_401);
	assume Mask_$_28 == Mask_$_23;
	assume Heap_$_0 == exhaleHeap#_1975_$_0;
	assume SecMask_$_709 == SecMask_$_401;
	assume r#63_$_0 == r#578_$_0;
	goto anon1047;
anon1489_Then:
	assume $_$_condition_$609;
	assume $_$_condition_$609 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true;
	goto $branchMerge_195;
anon1489_Else:
	assume !$_$_condition_$609;
	assume $_$_condition_$609 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left])) && true) && true);
	goto $branchMerge_195;
anon593:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_626,SecMask_$_626);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_626);
	assume SecMask_$_627 == SecMask_$_626;
	goto $branchMerge_192;
anon1047:
	assert { :msg "  599.2: The postcondition at 623.11 might not hold. The expression at 623.11 might not evaluate to true." } !(r#63_$_0 == null);
	assert { :msg "  599.2: The postcondition at 629.11 might not hold. The expression at 629.11 might not evaluate to true." } (Heap_$_0[r#63_$_0,AVLTreeNode.height] == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) || (Heap_$_0[r#63_$_0,AVLTreeNode.height] == (Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height] + 1));
	assert { :msg "  599.2: The postcondition at 630.11 might not hold. The expression at 630.11 might not evaluate to true." } Seq#Equal(Heap_$_0[r#63_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Singleton(Heap[this,AVLTreeNode.key])),ite(Heap[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assert { :msg "  599.2: The postcondition at 624.11 might not hold. The permission at 624.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  599.2: The postcondition at 624.11 might not hold. Insufficient fraction at 624.11 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_28[r#63_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_28[r#63_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_28[r#63_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_2090_$_0 == Mask_$_28[r#63_$_0,AVLTreeNode.valid := Mask_$_28[r#63_$_0,AVLTreeNode.valid][perm$R := Mask_$_28[r#63_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$712) { goto anon1737_Then; } else { goto anon1737_Else; }
anon1490_Then:
	assume $_$_condition_$610;
	assume $_$_condition_$610 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#568 : Integer :: ( ((0 <= lk#79#568) && (lk#79#568 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#568) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_196;
anon1490_Else:
	assume !$_$_condition_$610;
	assume $_$_condition_$610 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_196;
anon1491_Then:
	assume $_$_condition_$612;
	assume $_$_condition_$612 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_197;
anon1491_Else:
	assume !$_$_condition_$612;
	assume $_$_condition_$612 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_197;
anon1492_Then:
	assume $_$_condition_$614;
	assume $_$_condition_$614 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#569 : Integer :: ( ((0 <= rk#80#569) && (rk#80#569 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#569)) ));
	goto $branchMerge_198;
anon1492_Else:
	assume !$_$_condition_$614;
	assume $_$_condition_$614 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_198;
anon1493_Then:
	assume $_$_condition_$616;
	assume $_$_condition_$616 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon548;
anon1493_Else:
	assume !$_$_condition_$616;
	assume $_$_condition_$616 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon548;
anon548:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$16 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$16) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$16)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$16))) || (kk#81_$16 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_576 == SecMask_$_575[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key := SecMask_$_575[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_575[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$618) { goto anon1494_Then; } else { goto anon1494_Else; }
anon1494_Then:
	assume $_$_condition_$618;
	assume SecMask_$_576[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_577 == SecMask_$_576[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key := SecMask_$_576[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_578 == SecMask_$_577;
	goto anon550;
anon1494_Else:
	assume !$_$_condition_$618;
	assume 0 <= SecMask_$_576[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_578 == SecMask_$_576;
	goto anon550;
anon550:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_578,SecMask_$_578);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_578);
	assume SecMask_$_579 == SecMask_$_578[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_578[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_578[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$619) { goto anon1495_Then; } else { goto anon1495_Else; }
anon1495_Then:
	assume $_$_condition_$619;
	assume SecMask_$_579[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_580 == SecMask_$_579[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_579[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_581 == SecMask_$_580;
	goto anon552;
anon1495_Else:
	assume !$_$_condition_$619;
	assume 0 <= SecMask_$_579[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_581 == SecMask_$_579;
	goto anon552;
anon552:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_581,SecMask_$_581);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_581);
	assume SecMask_$_582 == SecMask_$_581[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left := SecMask_$_581[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_581[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$620) { goto anon1496_Then; } else { goto anon1496_Else; }
anon1496_Then:
	assume $_$_condition_$620;
	assume SecMask_$_582[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_583 == SecMask_$_582[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left := SecMask_$_582[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_584 == SecMask_$_583;
	goto anon554;
anon1496_Else:
	assume !$_$_condition_$620;
	assume 0 <= SecMask_$_582[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_584 == SecMask_$_582;
	goto anon554;
anon554:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_584,SecMask_$_584);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_584);
	assume SecMask_$_585 == SecMask_$_584[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right := SecMask_$_584[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_584[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$621) { goto anon1497_Then; } else { goto anon1497_Else; }
anon1497_Then:
	assume $_$_condition_$621;
	assume SecMask_$_585[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_586 == SecMask_$_585[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right := SecMask_$_585[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_587 == SecMask_$_586;
	goto anon556;
anon1497_Else:
	assume !$_$_condition_$621;
	assume 0 <= SecMask_$_585[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_587 == SecMask_$_585;
	goto anon556;
anon556:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_587,SecMask_$_587);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_587);
	assume SecMask_$_588 == SecMask_$_587[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_587[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_587[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$622) { goto anon1498_Then; } else { goto anon1498_Else; }
anon1498_Then:
	assume $_$_condition_$622;
	assume SecMask_$_588[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_589 == SecMask_$_588[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_588[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_590 == SecMask_$_589;
	goto anon558;
anon1498_Else:
	assume !$_$_condition_$622;
	assume 0 <= SecMask_$_588[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_590 == SecMask_$_588;
	goto anon558;
anon558:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_590,SecMask_$_590);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_590);
	assume SecMask_$_591 == SecMask_$_590[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_590[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_590[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$623) { goto anon1499_Then; } else { goto anon1499_Else; }
anon1499_Then:
	assume $_$_condition_$623;
	assume SecMask_$_591[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_592 == SecMask_$_591[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_591[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_593 == SecMask_$_592;
	goto anon560;
anon1499_Else:
	assume !$_$_condition_$623;
	assume 0 <= SecMask_$_591[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_593 == SecMask_$_591;
	goto anon560;
anon560:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_593,SecMask_$_593);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_593);
	if ($_$_condition_$624) { goto anon1500_Then; } else { goto anon1500_Else; }
anon1500_Then:
	assume $_$_condition_$624;
	assume $_$_condition_$624 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_594 == SecMask_$_593[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_593[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_593[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$625) { goto anon1501_Then; } else { goto anon1501_Else; }
anon1500_Else:
	assume !$_$_condition_$624;
	assume $_$_condition_$624 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_597 == SecMask_$_593;
	goto $branchMerge_199;
anon1501_Then:
	assume $_$_condition_$625;
	assume SecMask_$_594[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_595 == SecMask_$_594[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_594[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_596 == SecMask_$_595;
	goto anon563;
anon1501_Else:
	assume !$_$_condition_$625;
	assume 0 <= SecMask_$_594[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_596 == SecMask_$_594;
	goto anon563;
anon1502_Then:
	assume $_$_condition_$626;
	assume $_$_condition_$626 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_598 == SecMask_$_597[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_597[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_597[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$628) { goto anon1503_Then; } else { goto anon1503_Else; }
anon1502_Else:
	assume !$_$_condition_$626;
	assume $_$_condition_$626 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_601 == SecMask_$_597;
	goto $branchMerge_200;
anon563:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_596,SecMask_$_596);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_596);
	assume SecMask_$_597 == SecMask_$_596;
	goto $branchMerge_199;
anon1503_Then:
	assume $_$_condition_$628;
	assume SecMask_$_598[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_599 == SecMask_$_598[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_598[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_600 == SecMask_$_599;
	goto anon567;
anon1503_Else:
	assume !$_$_condition_$628;
	assume 0 <= SecMask_$_598[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_600 == SecMask_$_598;
	goto anon567;
anon1504_Then:
	assume $_$_condition_$629;
	assume $_$_condition_$629 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_602 == SecMask_$_601[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_601[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_601[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$631) { goto anon1505_Then; } else { goto anon1505_Else; }
anon1504_Else:
	assume !$_$_condition_$629;
	assume $_$_condition_$629 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_605 == SecMask_$_601;
	goto $branchMerge_201;
anon567:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_600,SecMask_$_600);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_600);
	assume SecMask_$_601 == SecMask_$_600;
	goto $branchMerge_200;
anon1505_Then:
	assume $_$_condition_$631;
	assume SecMask_$_602[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_603 == SecMask_$_602[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_602[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_604 == SecMask_$_603;
	goto anon571;
anon1505_Else:
	assume !$_$_condition_$631;
	assume 0 <= SecMask_$_602[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_604 == SecMask_$_602;
	goto anon571;
anon1506_Then:
	assume $_$_condition_$632;
	assume $_$_condition_$632 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_606 == SecMask_$_605[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_605[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_605[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$634) { goto anon1507_Then; } else { goto anon1507_Else; }
anon1506_Else:
	assume !$_$_condition_$632;
	assume $_$_condition_$632 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_609 == SecMask_$_605;
	goto $branchMerge_202;
anon571:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_604,SecMask_$_604);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_604);
	assume SecMask_$_605 == SecMask_$_604;
	goto $branchMerge_201;
anon1507_Then:
	assume $_$_condition_$634;
	assume SecMask_$_606[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_607 == SecMask_$_606[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_606[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_608 == SecMask_$_607;
	goto anon575;
anon1507_Else:
	assume !$_$_condition_$634;
	assume 0 <= SecMask_$_606[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_608 == SecMask_$_606;
	goto anon575;
anon1508_Then:
	assume $_$_condition_$635;
	assume $_$_condition_$635 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_610 == SecMask_$_609[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_609[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_609[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$637) { goto anon1509_Then; } else { goto anon1509_Else; }
anon1508_Else:
	assume !$_$_condition_$635;
	assume $_$_condition_$635 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_613 == SecMask_$_609;
	goto $branchMerge_203;
anon575:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_608,SecMask_$_608);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_608);
	assume SecMask_$_609 == SecMask_$_608;
	goto $branchMerge_202;
anon1509_Then:
	assume $_$_condition_$637;
	assume SecMask_$_610[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_611 == SecMask_$_610[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_610[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_612 == SecMask_$_611;
	goto anon579;
anon1509_Else:
	assume !$_$_condition_$637;
	assume 0 <= SecMask_$_610[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_612 == SecMask_$_610;
	goto anon579;
anon1510_Then:
	assume $_$_condition_$638;
	assume $_$_condition_$638 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_614 == SecMask_$_613[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_613[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_613[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$640) { goto anon1511_Then; } else { goto anon1511_Else; }
anon1510_Else:
	assume !$_$_condition_$638;
	assume $_$_condition_$638 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_617 == SecMask_$_613;
	goto $branchMerge_204;
anon579:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_612,SecMask_$_612);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_612);
	assume SecMask_$_613 == SecMask_$_612;
	goto $branchMerge_203;
anon1511_Then:
	assume $_$_condition_$640;
	assume SecMask_$_614[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_615 == SecMask_$_614[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_614[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_616 == SecMask_$_615;
	goto anon583;
anon1511_Else:
	assume !$_$_condition_$640;
	assume 0 <= SecMask_$_614[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_616 == SecMask_$_614;
	goto anon583;
anon1512_Then:
	assume $_$_condition_$641;
	assume $_$_condition_$641 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_618 == SecMask_$_617[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_617[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_617[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$643) { goto anon1513_Then; } else { goto anon1513_Else; }
anon1512_Else:
	assume !$_$_condition_$641;
	assume $_$_condition_$641 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_621 == SecMask_$_617;
	goto $branchMerge_205;
anon583:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_616,SecMask_$_616);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_616);
	assume SecMask_$_617 == SecMask_$_616;
	goto $branchMerge_204;
anon1513_Then:
	assume $_$_condition_$643;
	assume SecMask_$_618[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_619 == SecMask_$_618[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_618[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_620 == SecMask_$_619;
	goto anon587;
anon1513_Else:
	assume !$_$_condition_$643;
	assume 0 <= SecMask_$_618[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_620 == SecMask_$_618;
	goto anon587;
anon1514_Then:
	assume $_$_condition_$644;
	assume $_$_condition_$644 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_622 == SecMask_$_621[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_621[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_621[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$646) { goto anon1515_Then; } else { goto anon1515_Else; }
anon1514_Else:
	assume !$_$_condition_$644;
	assume $_$_condition_$644 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_625 == SecMask_$_621;
	goto anon592;
anon587:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_620,SecMask_$_620);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_620);
	assume SecMask_$_621 == SecMask_$_620;
	goto $branchMerge_205;
anon1515_Then:
	assume $_$_condition_$646;
	assume SecMask_$_622[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_623 == SecMask_$_622[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_622[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_624 == SecMask_$_623;
	goto anon591;
anon1515_Else:
	assume !$_$_condition_$646;
	assume 0 <= SecMask_$_622[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_624 == SecMask_$_622;
	goto anon591;
anon592:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_625,SecMask_$_625);
	assume SecMask_$_626 == SecMask_$_625;
	goto anon593;
anon591:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_624,SecMask_$_624);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_624);
	assume SecMask_$_625 == SecMask_$_624;
	goto anon592;
anon1517_Then:
	assume $_$_condition_$648;
	assume SecMask_$_628[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_629 == SecMask_$_628[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_628[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_630 == SecMask_$_629;
	goto anon597;
anon1517_Else:
	assume !$_$_condition_$648;
	assume 0 <= SecMask_$_628[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_630 == SecMask_$_628;
	goto anon597;
anon1518_Then:
	assume $_$_condition_$649;
	assume $_$_condition_$649 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_632 == SecMask_$_631[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_631[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_631[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$651) { goto anon1519_Then; } else { goto anon1519_Else; }
anon1518_Else:
	assume !$_$_condition_$649;
	assume $_$_condition_$649 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_635 == SecMask_$_631;
	goto $branchMerge_206;
anon597:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_630,SecMask_$_630);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_630);
	assume SecMask_$_631 == SecMask_$_630;
	goto $branchMerge_193;
anon1519_Then:
	assume $_$_condition_$651;
	assume SecMask_$_632[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_633 == SecMask_$_632[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_632[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_634 == SecMask_$_633;
	goto anon601;
anon1519_Else:
	assume !$_$_condition_$651;
	assume 0 <= SecMask_$_632[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_634 == SecMask_$_632;
	goto anon601;
anon1520_Then:
	assume $_$_condition_$652;
	assume $_$_condition_$652 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_636 == SecMask_$_635[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_635[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_635[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$654) { goto anon1521_Then; } else { goto anon1521_Else; }
anon1520_Else:
	assume !$_$_condition_$652;
	assume $_$_condition_$652 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_639 == SecMask_$_635;
	goto $branchMerge_207;
anon601:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_634,SecMask_$_634);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_634);
	assume SecMask_$_635 == SecMask_$_634;
	goto $branchMerge_206;
anon1521_Then:
	assume $_$_condition_$654;
	assume SecMask_$_636[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_637 == SecMask_$_636[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_636[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_638 == SecMask_$_637;
	goto anon605;
anon1521_Else:
	assume !$_$_condition_$654;
	assume 0 <= SecMask_$_636[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_638 == SecMask_$_636;
	goto anon605;
anon1522_Then:
	assume $_$_condition_$655;
	assume $_$_condition_$655 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_640 == SecMask_$_639[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_639[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_639[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$657) { goto anon1523_Then; } else { goto anon1523_Else; }
anon1522_Else:
	assume !$_$_condition_$655;
	assume $_$_condition_$655 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_694 == SecMask_$_639;
	goto $branchMerge_208;
anon605:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_638,SecMask_$_638);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_638);
	assume SecMask_$_639 == SecMask_$_638;
	goto $branchMerge_207;
anon1523_Then:
	assume $_$_condition_$657;
	assume SecMask_$_640[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_641 == SecMask_$_640[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_640[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_642 == SecMask_$_641;
	goto anon609;
anon1523_Else:
	assume !$_$_condition_$657;
	assume 0 <= SecMask_$_640[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_642 == SecMask_$_640;
	goto anon609;
anon1552_Then:
	assume $_$_condition_$658;
	assume $_$_condition_$658 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_695 == SecMask_$_694[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_694[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_694[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$699) { goto anon1553_Then; } else { goto anon1553_Else; }
anon1552_Else:
	assume !$_$_condition_$658;
	assume $_$_condition_$658 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_698 == SecMask_$_694;
	goto $branchMerge_209;
anon609:
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == exhaleHeap#_1757_$_0[this,AVLTreeNode.right]);
	if ($_$_condition_$659) { goto anon1524_Then; } else { goto anon1524_Else; }
anon1524_Then:
	assume $_$_condition_$659;
	assume $_$_condition_$659 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$660) { goto anon1525_Then; } else { goto anon1525_Else; }
anon1524_Else:
	assume !$_$_condition_$659;
	assume $_$_condition_$659 <==> ((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true));
	assume SecMask_$_693 == SecMask_$_642;
	goto anon666;
anon1525_Then:
	assume $_$_condition_$660;
	assume $_$_condition_$660 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true);
	assume (((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true;
	goto $branchMerge_210;
anon1525_Else:
	assume !$_$_condition_$660;
	assume $_$_condition_$660 <==> ((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true);
	assume !((((predVer#_1764_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right])) && true) && true);
	goto $branchMerge_210;
anon666:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_693,SecMask_$_693);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_693);
	assume SecMask_$_694 == SecMask_$_693;
	goto $branchMerge_208;
anon1526_Then:
	assume $_$_condition_$661;
	assume $_$_condition_$661 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#572 : Integer :: ( ((0 <= lk#79#572) && (lk#79#572 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#572) < exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_211;
anon1526_Else:
	assume !$_$_condition_$661;
	assume $_$_condition_$661 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_211;
anon1527_Then:
	assume $_$_condition_$663;
	assume $_$_condition_$663 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_212;
anon1527_Else:
	assume !$_$_condition_$663;
	assume $_$_condition_$663 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_212;
anon1528_Then:
	assume $_$_condition_$665;
	assume $_$_condition_$665 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#573 : Integer :: ( ((0 <= rk#80#573) && (rk#80#573 < Seq#Length(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#573)) ));
	goto $branchMerge_213;
anon1528_Else:
	assume !$_$_condition_$665;
	assume $_$_condition_$665 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_213;
anon1529_Then:
	assume $_$_condition_$667;
	assume $_$_condition_$667 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon621;
anon1529_Else:
	assume !$_$_condition_$667;
	assume $_$_condition_$667 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon621;
anon621:
	assume Seq#Equal(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$17 : Integer :: ( Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$17) <==> ((((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$17)) || ((!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$17))) || (kk#81_$17 == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key])) ));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] == ite(ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null,0,exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume SecMask_$_643 == SecMask_$_642[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key := SecMask_$_642[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key][perm$R := SecMask_$_642[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$669) { goto anon1530_Then; } else { goto anon1530_Else; }
anon1530_Then:
	assume $_$_condition_$669;
	assume SecMask_$_643[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_644 == SecMask_$_643[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key := SecMask_$_643[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_645 == SecMask_$_644;
	goto anon623;
anon1530_Else:
	assume !$_$_condition_$669;
	assume 0 <= SecMask_$_643[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_645 == SecMask_$_643;
	goto anon623;
anon623:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_645,SecMask_$_645);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_645);
	assume SecMask_$_646 == SecMask_$_645[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_645[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_645[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$670) { goto anon1531_Then; } else { goto anon1531_Else; }
anon1531_Then:
	assume $_$_condition_$670;
	assume SecMask_$_646[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_647 == SecMask_$_646[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_646[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_648 == SecMask_$_647;
	goto anon625;
anon1531_Else:
	assume !$_$_condition_$670;
	assume 0 <= SecMask_$_646[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_648 == SecMask_$_646;
	goto anon625;
anon625:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_648,SecMask_$_648);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_648);
	assume SecMask_$_649 == SecMask_$_648[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left := SecMask_$_648[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_648[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$671) { goto anon1532_Then; } else { goto anon1532_Else; }
anon1532_Then:
	assume $_$_condition_$671;
	assume SecMask_$_649[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_650 == SecMask_$_649[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left := SecMask_$_649[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_651 == SecMask_$_650;
	goto anon627;
anon1532_Else:
	assume !$_$_condition_$671;
	assume 0 <= SecMask_$_649[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_651 == SecMask_$_649;
	goto anon627;
anon627:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_651,SecMask_$_651);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_651);
	assume SecMask_$_652 == SecMask_$_651[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right := SecMask_$_651[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_651[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$672) { goto anon1533_Then; } else { goto anon1533_Else; }
anon1533_Then:
	assume $_$_condition_$672;
	assume SecMask_$_652[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_653 == SecMask_$_652[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right := SecMask_$_652[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_654 == SecMask_$_653;
	goto anon629;
anon1533_Else:
	assume !$_$_condition_$672;
	assume 0 <= SecMask_$_652[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_654 == SecMask_$_652;
	goto anon629;
anon629:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_654,SecMask_$_654);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_654);
	assume SecMask_$_655 == SecMask_$_654[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_654[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_654[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$673) { goto anon1534_Then; } else { goto anon1534_Else; }
anon1534_Then:
	assume $_$_condition_$673;
	assume SecMask_$_655[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_656 == SecMask_$_655[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_655[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_657 == SecMask_$_656;
	goto anon631;
anon1534_Else:
	assume !$_$_condition_$673;
	assume 0 <= SecMask_$_655[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_657 == SecMask_$_655;
	goto anon631;
anon631:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_657,SecMask_$_657);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_657);
	assume SecMask_$_658 == SecMask_$_657[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_657[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_657[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$674) { goto anon1535_Then; } else { goto anon1535_Else; }
anon1535_Then:
	assume $_$_condition_$674;
	assume SecMask_$_658[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_659 == SecMask_$_658[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_658[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_660 == SecMask_$_659;
	goto anon633;
anon1535_Else:
	assume !$_$_condition_$674;
	assume 0 <= SecMask_$_658[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_660 == SecMask_$_658;
	goto anon633;
anon633:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_660,SecMask_$_660);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_660);
	if ($_$_condition_$675) { goto anon1536_Then; } else { goto anon1536_Else; }
anon1536_Then:
	assume $_$_condition_$675;
	assume $_$_condition_$675 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_661 == SecMask_$_660[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_660[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_660[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$676) { goto anon1537_Then; } else { goto anon1537_Else; }
anon1536_Else:
	assume !$_$_condition_$675;
	assume $_$_condition_$675 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_664 == SecMask_$_660;
	goto $branchMerge_214;
anon1537_Then:
	assume $_$_condition_$676;
	assume SecMask_$_661[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_662 == SecMask_$_661[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_661[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_663 == SecMask_$_662;
	goto anon636;
anon1537_Else:
	assume !$_$_condition_$676;
	assume 0 <= SecMask_$_661[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_663 == SecMask_$_661;
	goto anon636;
anon1538_Then:
	assume $_$_condition_$677;
	assume $_$_condition_$677 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_665 == SecMask_$_664[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_664[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_664[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$679) { goto anon1539_Then; } else { goto anon1539_Else; }
anon1538_Else:
	assume !$_$_condition_$677;
	assume $_$_condition_$677 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_668 == SecMask_$_664;
	goto $branchMerge_215;
anon636:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_663,SecMask_$_663);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_663);
	assume SecMask_$_664 == SecMask_$_663;
	goto $branchMerge_214;
anon1539_Then:
	assume $_$_condition_$679;
	assume SecMask_$_665[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_666 == SecMask_$_665[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_665[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_667 == SecMask_$_666;
	goto anon640;
anon1539_Else:
	assume !$_$_condition_$679;
	assume 0 <= SecMask_$_665[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_667 == SecMask_$_665;
	goto anon640;
anon1540_Then:
	assume $_$_condition_$680;
	assume $_$_condition_$680 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_669 == SecMask_$_668[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_668[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_668[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$682) { goto anon1541_Then; } else { goto anon1541_Else; }
anon1540_Else:
	assume !$_$_condition_$680;
	assume $_$_condition_$680 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_672 == SecMask_$_668;
	goto $branchMerge_216;
anon640:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_667,SecMask_$_667);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_667);
	assume SecMask_$_668 == SecMask_$_667;
	goto $branchMerge_215;
anon1541_Then:
	assume $_$_condition_$682;
	assume SecMask_$_669[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_670 == SecMask_$_669[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_669[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_671 == SecMask_$_670;
	goto anon644;
anon1541_Else:
	assume !$_$_condition_$682;
	assume 0 <= SecMask_$_669[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_671 == SecMask_$_669;
	goto anon644;
anon1542_Then:
	assume $_$_condition_$683;
	assume $_$_condition_$683 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_673 == SecMask_$_672[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_672[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_672[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$685) { goto anon1543_Then; } else { goto anon1543_Else; }
anon1542_Else:
	assume !$_$_condition_$683;
	assume $_$_condition_$683 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_676 == SecMask_$_672;
	goto $branchMerge_217;
anon644:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_671,SecMask_$_671);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_671);
	assume SecMask_$_672 == SecMask_$_671;
	goto $branchMerge_216;
anon1543_Then:
	assume $_$_condition_$685;
	assume SecMask_$_673[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_674 == SecMask_$_673[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_673[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_675 == SecMask_$_674;
	goto anon648;
anon1543_Else:
	assume !$_$_condition_$685;
	assume 0 <= SecMask_$_673[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_675 == SecMask_$_673;
	goto anon648;
anon1544_Then:
	assume $_$_condition_$686;
	assume $_$_condition_$686 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_677 == SecMask_$_676[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_676[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_676[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$688) { goto anon1545_Then; } else { goto anon1545_Else; }
anon1544_Else:
	assume !$_$_condition_$686;
	assume $_$_condition_$686 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_680 == SecMask_$_676;
	goto $branchMerge_218;
anon648:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_675,SecMask_$_675);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_675);
	assume SecMask_$_676 == SecMask_$_675;
	goto $branchMerge_217;
anon1545_Then:
	assume $_$_condition_$688;
	assume SecMask_$_677[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_678 == SecMask_$_677[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_677[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_679 == SecMask_$_678;
	goto anon652;
anon1545_Else:
	assume !$_$_condition_$688;
	assume 0 <= SecMask_$_677[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_679 == SecMask_$_677;
	goto anon652;
anon1546_Then:
	assume $_$_condition_$689;
	assume $_$_condition_$689 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_681 == SecMask_$_680[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_680[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_680[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$691) { goto anon1547_Then; } else { goto anon1547_Else; }
anon1546_Else:
	assume !$_$_condition_$689;
	assume $_$_condition_$689 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_684 == SecMask_$_680;
	goto $branchMerge_219;
anon652:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_679,SecMask_$_679);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_679);
	assume SecMask_$_680 == SecMask_$_679;
	goto $branchMerge_218;
anon1547_Then:
	assume $_$_condition_$691;
	assume SecMask_$_681[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_682 == SecMask_$_681[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_681[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_683 == SecMask_$_682;
	goto anon656;
anon1547_Else:
	assume !$_$_condition_$691;
	assume 0 <= SecMask_$_681[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_683 == SecMask_$_681;
	goto anon656;
anon1548_Then:
	assume $_$_condition_$692;
	assume $_$_condition_$692 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_685 == SecMask_$_684[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_684[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_684[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$694) { goto anon1549_Then; } else { goto anon1549_Else; }
anon1548_Else:
	assume !$_$_condition_$692;
	assume $_$_condition_$692 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_688 == SecMask_$_684;
	goto $branchMerge_220;
anon656:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_683,SecMask_$_683);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_683);
	assume SecMask_$_684 == SecMask_$_683;
	goto $branchMerge_219;
anon1549_Then:
	assume $_$_condition_$694;
	assume SecMask_$_685[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_686 == SecMask_$_685[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_685[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_687 == SecMask_$_686;
	goto anon660;
anon1549_Else:
	assume !$_$_condition_$694;
	assume 0 <= SecMask_$_685[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_687 == SecMask_$_685;
	goto anon660;
anon1550_Then:
	assume $_$_condition_$695;
	assume $_$_condition_$695 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_689 == SecMask_$_688[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_688[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_688[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$697) { goto anon1551_Then; } else { goto anon1551_Else; }
anon1550_Else:
	assume !$_$_condition_$695;
	assume $_$_condition_$695 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_692 == SecMask_$_688;
	goto anon665;
anon660:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_687,SecMask_$_687);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_687);
	assume SecMask_$_688 == SecMask_$_687;
	goto $branchMerge_220;
anon1551_Then:
	assume $_$_condition_$697;
	assume SecMask_$_689[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_690 == SecMask_$_689[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_689[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_691 == SecMask_$_690;
	goto anon664;
anon1551_Else:
	assume !$_$_condition_$697;
	assume 0 <= SecMask_$_689[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_691 == SecMask_$_689;
	goto anon664;
anon665:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_692,SecMask_$_692);
	assume SecMask_$_693 == SecMask_$_692;
	goto anon666;
anon664:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_691,SecMask_$_691);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_691);
	assume SecMask_$_692 == SecMask_$_691;
	goto anon665;
anon1553_Then:
	assume $_$_condition_$699;
	assume SecMask_$_695[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_696 == SecMask_$_695[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_695[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_697 == SecMask_$_696;
	goto anon670;
anon1553_Else:
	assume !$_$_condition_$699;
	assume 0 <= SecMask_$_695[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_697 == SecMask_$_695;
	goto anon670;
anon1554_Then:
	assume $_$_condition_$700;
	assume $_$_condition_$700 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_699 == SecMask_$_698[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_698[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_698[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$702) { goto anon1555_Then; } else { goto anon1555_Else; }
anon1554_Else:
	assume !$_$_condition_$700;
	assume $_$_condition_$700 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_702 == SecMask_$_698;
	goto $branchMerge_221;
anon670:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_697,SecMask_$_697);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_697);
	assume SecMask_$_698 == SecMask_$_697;
	goto $branchMerge_209;
anon1555_Then:
	assume $_$_condition_$702;
	assume SecMask_$_699[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_700 == SecMask_$_699[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_699[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_701 == SecMask_$_700;
	goto anon674;
anon1555_Else:
	assume !$_$_condition_$702;
	assume 0 <= SecMask_$_699[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_701 == SecMask_$_699;
	goto anon674;
anon1556_Then:
	assume $_$_condition_$703;
	assume $_$_condition_$703 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_703 == SecMask_$_702[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_702[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_702[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$705) { goto anon1557_Then; } else { goto anon1557_Else; }
anon1556_Else:
	assume !$_$_condition_$703;
	assume $_$_condition_$703 <==> (!(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_706 == SecMask_$_702;
	goto anon679;
anon674:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_701,SecMask_$_701);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_701);
	assume SecMask_$_702 == SecMask_$_701;
	goto $branchMerge_221;
anon1557_Then:
	assume $_$_condition_$705;
	assume SecMask_$_703[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_704 == SecMask_$_703[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_703[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_705 == SecMask_$_704;
	goto anon678;
anon1557_Else:
	assume !$_$_condition_$705;
	assume 0 <= SecMask_$_703[exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_705 == SecMask_$_703;
	goto anon678;
anon679:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_706,SecMask_$_706);
	assume SecMask_$_707 == SecMask_$_706;
	goto $branchMerge_185;
anon678:
	assume wf(exhaleHeap#_1757_$_0,SecMask_$_705,SecMask_$_705);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_705);
	assume SecMask_$_706 == SecMask_$_705;
	goto anon679;
anon682:
	assume IsGoodMask(exhaleMask#_1857_$_10);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_10,SecMask_$_707);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_707);
	assume SecMask_$_708 == SecMask_$_707;
	assume exhaleMask#_1857_$_11 == exhaleMask#_1857_$_10;
	goto $branchMerge_184;
anon1560_Then:
	assume $_$_condition_$708;
	assume $_$_condition_$708 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  636.4: The precondition at 661.12 might not hold. The permission at 661.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  636.4: The precondition at 661.12 might not hold. Insufficient fraction at 661.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1857_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1857_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1857_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1857_$_14 == exhaleMask#_1857_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_1857_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_1857_$_13[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1857_$_14);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_14,SecMask_$_708);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_708);
	assume exhaleMask#_1857_$_15 == exhaleMask#_1857_$_14;
	goto $branchMerge_222;
anon1560_Else:
	assume !$_$_condition_$708;
	assume $_$_condition_$708 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1857_$_15 == exhaleMask#_1857_$_13;
	goto $branchMerge_222;
anon1561_Then:
	assume $_$_condition_$710;
	assume $_$_condition_$710 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  636.4: The precondition at 662.12 might not hold. The permission at 662.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  636.4: The precondition at 662.12 might not hold. Insufficient fraction at 662.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1857_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1857_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1857_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1857_$_16 == exhaleMask#_1857_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_1857_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1857_$_15[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1857_$_16);
	assume wf(exhaleHeap#_1757_$_0,exhaleMask#_1857_$_16,SecMask_$_708);
	assume wf(exhaleHeap#_1757_$_0,Mask_$_19,SecMask_$_708);
	assume exhaleMask#_1857_$_17 == exhaleMask#_1857_$_16;
	goto anon689;
anon1561_Else:
	assume !$_$_condition_$710;
	assume $_$_condition_$710 <==> (!(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1857_$_17 == exhaleMask#_1857_$_15;
	goto anon689;
anon689:
	assume IsGoodExhaleState(exhaleHeap#_1856_$_0,exhaleHeap#_1757_$_0,exhaleMask#_1857_$_17,SecMask_$_708);
	assume IsGoodMask(exhaleMask#_1857_$_17);
	assume wf(exhaleHeap#_1856_$_0,exhaleMask#_1857_$_17,SecMask_$_708);
	assume (r#548_$_0 == null) || (dtype(r#548_$_0) == AVLTreeNode#t);
	assume !(r#548_$_0 == null);
	assume !(r#548_$_0 == null);
	assume wf(exhaleHeap#_1856_$_0,exhaleMask#_1857_$_17,SecMask_$_708);
	assume Fractions(100) > 0;
	assume Mask_$_24 == exhaleMask#_1857_$_17[r#548_$_0,AVLTreeNode.valid := exhaleMask#_1857_$_17[r#548_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_1857_$_17[r#548_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_24);
	assume IsGoodState(heapFragment(exhaleHeap#_1856_$_0[r#548_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1856_$_0,Mask_$_24,SecMask_$_708);
	assume wf(exhaleHeap#_1856_$_0,Mask_$_24,SecMask_$_708);
	assume !(r#548_$_0 == null);
	assume wf(exhaleHeap#_1856_$_0,Mask_$_24,SecMask_$_708);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_25 == Mask_$_24[r#548_$_0,AVLTreeNode.height := Mask_$_24[r#548_$_0,AVLTreeNode.height][perm$R := Mask_$_24[r#548_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_25);
	assume IsGoodState(heapFragment(exhaleHeap#_1856_$_0[r#548_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_1856_$_0,Mask_$_25,SecMask_$_708);
	assume wf(exhaleHeap#_1856_$_0,Mask_$_25,SecMask_$_708);
	assume !(r#548_$_0 == null);
	assume wf(exhaleHeap#_1856_$_0,Mask_$_25,SecMask_$_708);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_26 == Mask_$_25[r#548_$_0,AVLTreeNode.keys := Mask_$_25[r#548_$_0,AVLTreeNode.keys][perm$R := Mask_$_25[r#548_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(exhaleHeap#_1856_$_0[r#548_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1856_$_0,Mask_$_26,SecMask_$_708);
	assume wf(exhaleHeap#_1856_$_0,Mask_$_26,SecMask_$_708);
	assume !(r#548_$_0 == null);
	assume wf(exhaleHeap#_1856_$_0,Mask_$_26,SecMask_$_708);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_27 == Mask_$_26[r#548_$_0,AVLTreeNode.balanceFactor := Mask_$_26[r#548_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_26[r#548_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_27);
	assume IsGoodState(heapFragment(exhaleHeap#_1856_$_0[r#548_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1856_$_0,Mask_$_27,SecMask_$_708);
	assume wf(exhaleHeap#_1856_$_0,Mask_$_27,SecMask_$_708);
	assume exhaleHeap#_1856_$_0[r#548_$_0,AVLTreeNode.height] == exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.height];
	assume Seq#Equal(exhaleHeap#_1856_$_0[r#548_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Singleton(exhaleHeap#_1757_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_1757_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1757_$_0[exhaleHeap#_1757_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume IsGoodMask(Mask_$_27);
	assume wf(exhaleHeap#_1856_$_0,Mask_$_27,SecMask_$_708);
	assume Mask_$_28 == Mask_$_27;
	assume Heap_$_0 == exhaleHeap#_1856_$_0;
	assume SecMask_$_709 == SecMask_$_708;
	assume r#63_$_0 == r#548_$_0;
	goto anon1047;
anon1737_Then:
	assume $_$_condition_$712;
	assume $_$_condition_$712 <==> ((false || ((((predVer#_1783_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true);
	if ($_$_condition_$713) { goto anon1738_Then; } else { goto anon1738_Else; }
anon1737_Else:
	assume !$_$_condition_$712;
	assume $_$_condition_$712 <==> ((false || ((((predVer#_1783_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true));
	assume SecMask_$_862 == SecMask_$_709;
	goto $branchMerge_223;
anon1738_Then:
	assume $_$_condition_$713;
	assume $_$_condition_$713 <==> ((((predVer#_1764_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true);
	assume (((predVer#_1764_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true;
	goto $branchMerge_224;
anon1738_Else:
	assume !$_$_condition_$713;
	assume $_$_condition_$713 <==> ((((predVer#_1764_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true);
	assume !((((predVer#_1764_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.valid]) && (this#521_$_0 == r#63_$_0)) && true) && true);
	goto $branchMerge_224;
anon1821_Then:
	assume $_$_condition_$714;
	assume $_$_condition_$714 <==> (!CanRead(exhaleMask#_2090_$_0,SecMask_$_862,r#63_$_0,AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_2090_$_0,SecMask_$_862,r#63_$_0,AVLTreeNode.valid);
	assume Heap_$_0[r#63_$_0,AVLTreeNode.valid] < exhaleHeap#_2089_$_0[r#63_$_0,AVLTreeNode.valid];
	goto anon1220;
anon1821_Else:
	assume !$_$_condition_$714;
	assume $_$_condition_$714 <==> (!CanRead(exhaleMask#_2090_$_0,SecMask_$_862,r#63_$_0,AVLTreeNode.valid));
	assume CanRead(exhaleMask#_2090_$_0,SecMask_$_862,r#63_$_0,AVLTreeNode.valid);
	goto anon1220;
anon1739_Then:
	assume $_$_condition_$715;
	assume $_$_condition_$715 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#607 : Integer :: ( ((0 <= lk#79#607) && (lk#79#607 < Seq#Length(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#607) < Heap_$_0[r#63_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_225;
anon1739_Else:
	assume !$_$_condition_$715;
	assume $_$_condition_$715 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_225;
anon1740_Then:
	assume $_$_condition_$717;
	assume $_$_condition_$717 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null);
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_226;
anon1740_Else:
	assume !$_$_condition_$717;
	assume $_$_condition_$717 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_226;
anon1741_Then:
	assume $_$_condition_$719;
	assume $_$_condition_$719 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#608 : Integer :: ( ((0 <= rk#80#608) && (rk#80#608 < Seq#Length(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_0[r#63_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#608)) ));
	goto $branchMerge_227;
anon1741_Else:
	assume !$_$_condition_$719;
	assume $_$_condition_$719 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.right] == null;
	goto $branchMerge_227;
anon1742_Then:
	assume $_$_condition_$721;
	assume $_$_condition_$721 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null);
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon1059;
anon1742_Else:
	assume !$_$_condition_$721;
	assume $_$_condition_$721 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.right] == null;
	goto anon1059;
anon1059:
	assume Seq#Equal(Heap_$_0[r#63_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_0[r#63_$_0,AVLTreeNode.key])),ite(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_0[r#63_$_0,AVLTreeNode.keys],Heap_$_0[r#63_$_0,AVLTreeNode.key]);
	assume (forall  kk#81_$18 : Integer :: ( Seq#Contains(Heap_$_0[r#63_$_0,AVLTreeNode.keys],kk#81_$18) <==> ((((!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$18)) || ((!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$18))) || (kk#81_$18 == Heap_$_0[r#63_$_0,AVLTreeNode.key])) ));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.height] == ite(ite(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null,0,Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null,0,Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null,0,Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null,0,Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_0[r#63_$_0,AVLTreeNode.balanceFactor] == (ite(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null,0,Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null,0,Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_0[r#63_$_0,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_0[r#63_$_0,AVLTreeNode.height] > 0;
	assume SecMask_$_710 == SecMask_$_709[r#63_$_0,AVLTreeNode.key := SecMask_$_709[r#63_$_0,AVLTreeNode.key][perm$R := SecMask_$_709[r#63_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$723) { goto anon1743_Then; } else { goto anon1743_Else; }
anon1743_Then:
	assume $_$_condition_$723;
	assume SecMask_$_710[r#63_$_0,AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_711 == SecMask_$_710[r#63_$_0,AVLTreeNode.key := SecMask_$_710[r#63_$_0,AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_712 == SecMask_$_711;
	goto anon1061;
anon1743_Else:
	assume !$_$_condition_$723;
	assume 0 <= SecMask_$_710[r#63_$_0,AVLTreeNode.key][perm$R];
	assume SecMask_$_712 == SecMask_$_710;
	goto anon1061;
anon1061:
	assume wf(Heap_$_0,SecMask_$_712,SecMask_$_712);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_712);
	assume SecMask_$_713 == SecMask_$_712[r#63_$_0,AVLTreeNode.height := SecMask_$_712[r#63_$_0,AVLTreeNode.height][perm$R := SecMask_$_712[r#63_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$724) { goto anon1744_Then; } else { goto anon1744_Else; }
anon1744_Then:
	assume $_$_condition_$724;
	assume SecMask_$_713[r#63_$_0,AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_714 == SecMask_$_713[r#63_$_0,AVLTreeNode.height := SecMask_$_713[r#63_$_0,AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_715 == SecMask_$_714;
	goto anon1063;
anon1744_Else:
	assume !$_$_condition_$724;
	assume 0 <= SecMask_$_713[r#63_$_0,AVLTreeNode.height][perm$R];
	assume SecMask_$_715 == SecMask_$_713;
	goto anon1063;
anon1063:
	assume wf(Heap_$_0,SecMask_$_715,SecMask_$_715);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_715);
	assume SecMask_$_716 == SecMask_$_715[r#63_$_0,AVLTreeNode.left := SecMask_$_715[r#63_$_0,AVLTreeNode.left][perm$R := SecMask_$_715[r#63_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$725) { goto anon1745_Then; } else { goto anon1745_Else; }
anon1745_Then:
	assume $_$_condition_$725;
	assume SecMask_$_716[r#63_$_0,AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_717 == SecMask_$_716[r#63_$_0,AVLTreeNode.left := SecMask_$_716[r#63_$_0,AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_718 == SecMask_$_717;
	goto anon1065;
anon1745_Else:
	assume !$_$_condition_$725;
	assume 0 <= SecMask_$_716[r#63_$_0,AVLTreeNode.left][perm$R];
	assume SecMask_$_718 == SecMask_$_716;
	goto anon1065;
anon1065:
	assume wf(Heap_$_0,SecMask_$_718,SecMask_$_718);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_718);
	assume SecMask_$_719 == SecMask_$_718[r#63_$_0,AVLTreeNode.right := SecMask_$_718[r#63_$_0,AVLTreeNode.right][perm$R := SecMask_$_718[r#63_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$726) { goto anon1746_Then; } else { goto anon1746_Else; }
anon1746_Then:
	assume $_$_condition_$726;
	assume SecMask_$_719[r#63_$_0,AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_720 == SecMask_$_719[r#63_$_0,AVLTreeNode.right := SecMask_$_719[r#63_$_0,AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_721 == SecMask_$_720;
	goto anon1067;
anon1746_Else:
	assume !$_$_condition_$726;
	assume 0 <= SecMask_$_719[r#63_$_0,AVLTreeNode.right][perm$R];
	assume SecMask_$_721 == SecMask_$_719;
	goto anon1067;
anon1067:
	assume wf(Heap_$_0,SecMask_$_721,SecMask_$_721);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_721);
	assume SecMask_$_722 == SecMask_$_721[r#63_$_0,AVLTreeNode.keys := SecMask_$_721[r#63_$_0,AVLTreeNode.keys][perm$R := SecMask_$_721[r#63_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$727) { goto anon1747_Then; } else { goto anon1747_Else; }
anon1747_Then:
	assume $_$_condition_$727;
	assume SecMask_$_722[r#63_$_0,AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_723 == SecMask_$_722[r#63_$_0,AVLTreeNode.keys := SecMask_$_722[r#63_$_0,AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_724 == SecMask_$_723;
	goto anon1069;
anon1747_Else:
	assume !$_$_condition_$727;
	assume 0 <= SecMask_$_722[r#63_$_0,AVLTreeNode.keys][perm$R];
	assume SecMask_$_724 == SecMask_$_722;
	goto anon1069;
anon1069:
	assume wf(Heap_$_0,SecMask_$_724,SecMask_$_724);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_724);
	assume SecMask_$_725 == SecMask_$_724[r#63_$_0,AVLTreeNode.balanceFactor := SecMask_$_724[r#63_$_0,AVLTreeNode.balanceFactor][perm$R := SecMask_$_724[r#63_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$728) { goto anon1748_Then; } else { goto anon1748_Else; }
anon1748_Then:
	assume $_$_condition_$728;
	assume SecMask_$_725[r#63_$_0,AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_726 == SecMask_$_725[r#63_$_0,AVLTreeNode.balanceFactor := SecMask_$_725[r#63_$_0,AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_727 == SecMask_$_726;
	goto anon1071;
anon1748_Else:
	assume !$_$_condition_$728;
	assume 0 <= SecMask_$_725[r#63_$_0,AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_727 == SecMask_$_725;
	goto anon1071;
anon1071:
	assume wf(Heap_$_0,SecMask_$_727,SecMask_$_727);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_727);
	if ($_$_condition_$729) { goto anon1749_Then; } else { goto anon1749_Else; }
anon1749_Then:
	assume $_$_condition_$729;
	assume $_$_condition_$729 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_728 == SecMask_$_727[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_727[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_727[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$730) { goto anon1750_Then; } else { goto anon1750_Else; }
anon1749_Else:
	assume !$_$_condition_$729;
	assume $_$_condition_$729 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_782 == SecMask_$_727;
	goto $branchMerge_228;
anon1750_Then:
	assume $_$_condition_$730;
	assume SecMask_$_728[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_729 == SecMask_$_728[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_728[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_730 == SecMask_$_729;
	goto anon1074;
anon1750_Else:
	assume !$_$_condition_$730;
	assume 0 <= SecMask_$_728[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_730 == SecMask_$_728;
	goto anon1074;
anon1779_Then:
	assume $_$_condition_$731;
	assume $_$_condition_$731 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_783 == SecMask_$_782[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_782[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_782[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$772) { goto anon1780_Then; } else { goto anon1780_Else; }
anon1779_Else:
	assume !$_$_condition_$731;
	assume $_$_condition_$731 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_786 == SecMask_$_782;
	goto $branchMerge_229;
anon1074:
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.left] == r#63_$_0);
	if ($_$_condition_$732) { goto anon1751_Then; } else { goto anon1751_Else; }
anon1751_Then:
	assume $_$_condition_$732;
	assume $_$_condition_$732 <==> ((false || ((((predVer#_1783_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true);
	if ($_$_condition_$733) { goto anon1752_Then; } else { goto anon1752_Else; }
anon1751_Else:
	assume !$_$_condition_$732;
	assume $_$_condition_$732 <==> ((false || ((((predVer#_1783_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true));
	assume SecMask_$_781 == SecMask_$_730;
	goto anon1131;
anon1752_Then:
	assume $_$_condition_$733;
	assume $_$_condition_$733 <==> ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true);
	assume (((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true;
	goto $branchMerge_230;
anon1752_Else:
	assume !$_$_condition_$733;
	assume $_$_condition_$733 <==> ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true);
	assume !((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.left])) && true) && true);
	goto $branchMerge_230;
anon1131:
	assume wf(Heap_$_0,SecMask_$_781,SecMask_$_781);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_781);
	assume SecMask_$_782 == SecMask_$_781;
	goto $branchMerge_228;
anon1753_Then:
	assume $_$_condition_$734;
	assume $_$_condition_$734 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#611 : Integer :: ( ((0 <= lk#79#611) && (lk#79#611 < Seq#Length(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#611) < Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_231;
anon1753_Else:
	assume !$_$_condition_$734;
	assume $_$_condition_$734 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_231;
anon1754_Then:
	assume $_$_condition_$736;
	assume $_$_condition_$736 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_232;
anon1754_Else:
	assume !$_$_condition_$736;
	assume $_$_condition_$736 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_232;
anon1755_Then:
	assume $_$_condition_$738;
	assume $_$_condition_$738 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#612 : Integer :: ( ((0 <= rk#80#612) && (rk#80#612 < Seq#Length(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#612)) ));
	goto $branchMerge_233;
anon1755_Else:
	assume !$_$_condition_$738;
	assume $_$_condition_$738 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_233;
anon1756_Then:
	assume $_$_condition_$740;
	assume $_$_condition_$740 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon1086;
anon1756_Else:
	assume !$_$_condition_$740;
	assume $_$_condition_$740 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon1086;
anon1086:
	assume Seq#Equal(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key])),ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys],Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$19 : Integer :: ( Seq#Contains(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$19) <==> ((((!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$19)) || ((!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$19))) || (kk#81_$19 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume SecMask_$_731 == SecMask_$_730[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_730[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R := SecMask_$_730[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$742) { goto anon1757_Then; } else { goto anon1757_Else; }
anon1757_Then:
	assume $_$_condition_$742;
	assume SecMask_$_731[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_732 == SecMask_$_731[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key := SecMask_$_731[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_733 == SecMask_$_732;
	goto anon1088;
anon1757_Else:
	assume !$_$_condition_$742;
	assume 0 <= SecMask_$_731[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.key][perm$R];
	assume SecMask_$_733 == SecMask_$_731;
	goto anon1088;
anon1088:
	assume wf(Heap_$_0,SecMask_$_733,SecMask_$_733);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_733);
	assume SecMask_$_734 == SecMask_$_733[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_733[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_733[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$743) { goto anon1758_Then; } else { goto anon1758_Else; }
anon1758_Then:
	assume $_$_condition_$743;
	assume SecMask_$_734[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_735 == SecMask_$_734[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_734[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_736 == SecMask_$_735;
	goto anon1090;
anon1758_Else:
	assume !$_$_condition_$743;
	assume 0 <= SecMask_$_734[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_736 == SecMask_$_734;
	goto anon1090;
anon1090:
	assume wf(Heap_$_0,SecMask_$_736,SecMask_$_736);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_736);
	assume SecMask_$_737 == SecMask_$_736[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_736[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R := SecMask_$_736[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$744) { goto anon1759_Then; } else { goto anon1759_Else; }
anon1759_Then:
	assume $_$_condition_$744;
	assume SecMask_$_737[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_738 == SecMask_$_737[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left := SecMask_$_737[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_739 == SecMask_$_738;
	goto anon1092;
anon1759_Else:
	assume !$_$_condition_$744;
	assume 0 <= SecMask_$_737[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left][perm$R];
	assume SecMask_$_739 == SecMask_$_737;
	goto anon1092;
anon1092:
	assume wf(Heap_$_0,SecMask_$_739,SecMask_$_739);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_739);
	assume SecMask_$_740 == SecMask_$_739[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_739[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R := SecMask_$_739[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$745) { goto anon1760_Then; } else { goto anon1760_Else; }
anon1760_Then:
	assume $_$_condition_$745;
	assume SecMask_$_740[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_741 == SecMask_$_740[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right := SecMask_$_740[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_742 == SecMask_$_741;
	goto anon1094;
anon1760_Else:
	assume !$_$_condition_$745;
	assume 0 <= SecMask_$_740[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right][perm$R];
	assume SecMask_$_742 == SecMask_$_740;
	goto anon1094;
anon1094:
	assume wf(Heap_$_0,SecMask_$_742,SecMask_$_742);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_742);
	assume SecMask_$_743 == SecMask_$_742[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_742[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_742[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$746) { goto anon1761_Then; } else { goto anon1761_Else; }
anon1761_Then:
	assume $_$_condition_$746;
	assume SecMask_$_743[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_744 == SecMask_$_743[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_743[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_745 == SecMask_$_744;
	goto anon1096;
anon1761_Else:
	assume !$_$_condition_$746;
	assume 0 <= SecMask_$_743[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_745 == SecMask_$_743;
	goto anon1096;
anon1096:
	assume wf(Heap_$_0,SecMask_$_745,SecMask_$_745);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_745);
	assume SecMask_$_746 == SecMask_$_745[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_745[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_745[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$747) { goto anon1762_Then; } else { goto anon1762_Else; }
anon1762_Then:
	assume $_$_condition_$747;
	assume SecMask_$_746[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_747 == SecMask_$_746[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_746[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_748 == SecMask_$_747;
	goto anon1098;
anon1762_Else:
	assume !$_$_condition_$747;
	assume 0 <= SecMask_$_746[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_748 == SecMask_$_746;
	goto anon1098;
anon1098:
	assume wf(Heap_$_0,SecMask_$_748,SecMask_$_748);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_748);
	if ($_$_condition_$748) { goto anon1763_Then; } else { goto anon1763_Else; }
anon1763_Then:
	assume $_$_condition_$748;
	assume $_$_condition_$748 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_749 == SecMask_$_748[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_748[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_748[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$749) { goto anon1764_Then; } else { goto anon1764_Else; }
anon1763_Else:
	assume !$_$_condition_$748;
	assume $_$_condition_$748 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_752 == SecMask_$_748;
	goto $branchMerge_234;
anon1764_Then:
	assume $_$_condition_$749;
	assume SecMask_$_749[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_750 == SecMask_$_749[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_749[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_751 == SecMask_$_750;
	goto anon1101;
anon1764_Else:
	assume !$_$_condition_$749;
	assume 0 <= SecMask_$_749[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_751 == SecMask_$_749;
	goto anon1101;
anon1765_Then:
	assume $_$_condition_$750;
	assume $_$_condition_$750 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_753 == SecMask_$_752[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_752[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_752[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$752) { goto anon1766_Then; } else { goto anon1766_Else; }
anon1765_Else:
	assume !$_$_condition_$750;
	assume $_$_condition_$750 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_756 == SecMask_$_752;
	goto $branchMerge_235;
anon1101:
	assume wf(Heap_$_0,SecMask_$_751,SecMask_$_751);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_751);
	assume SecMask_$_752 == SecMask_$_751;
	goto $branchMerge_234;
anon1766_Then:
	assume $_$_condition_$752;
	assume SecMask_$_753[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_754 == SecMask_$_753[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_753[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_755 == SecMask_$_754;
	goto anon1105;
anon1766_Else:
	assume !$_$_condition_$752;
	assume 0 <= SecMask_$_753[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_755 == SecMask_$_753;
	goto anon1105;
anon1767_Then:
	assume $_$_condition_$753;
	assume $_$_condition_$753 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_757 == SecMask_$_756[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_756[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_756[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$755) { goto anon1768_Then; } else { goto anon1768_Else; }
anon1767_Else:
	assume !$_$_condition_$753;
	assume $_$_condition_$753 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_760 == SecMask_$_756;
	goto $branchMerge_236;
anon1105:
	assume wf(Heap_$_0,SecMask_$_755,SecMask_$_755);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_755);
	assume SecMask_$_756 == SecMask_$_755;
	goto $branchMerge_235;
anon1768_Then:
	assume $_$_condition_$755;
	assume SecMask_$_757[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_758 == SecMask_$_757[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_757[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_759 == SecMask_$_758;
	goto anon1109;
anon1768_Else:
	assume !$_$_condition_$755;
	assume 0 <= SecMask_$_757[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_759 == SecMask_$_757;
	goto anon1109;
anon1769_Then:
	assume $_$_condition_$756;
	assume $_$_condition_$756 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume SecMask_$_761 == SecMask_$_760[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_760[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_760[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$758) { goto anon1770_Then; } else { goto anon1770_Else; }
anon1769_Else:
	assume !$_$_condition_$756;
	assume $_$_condition_$756 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume SecMask_$_764 == SecMask_$_760;
	goto $branchMerge_237;
anon1109:
	assume wf(Heap_$_0,SecMask_$_759,SecMask_$_759);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_759);
	assume SecMask_$_760 == SecMask_$_759;
	goto $branchMerge_236;
anon1770_Then:
	assume $_$_condition_$758;
	assume SecMask_$_761[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_762 == SecMask_$_761[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_761[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_763 == SecMask_$_762;
	goto anon1113;
anon1770_Else:
	assume !$_$_condition_$758;
	assume 0 <= SecMask_$_761[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_763 == SecMask_$_761;
	goto anon1113;
anon1771_Then:
	assume $_$_condition_$759;
	assume $_$_condition_$759 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_765 == SecMask_$_764[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_764[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_764[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$761) { goto anon1772_Then; } else { goto anon1772_Else; }
anon1771_Else:
	assume !$_$_condition_$759;
	assume $_$_condition_$759 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_768 == SecMask_$_764;
	goto $branchMerge_238;
anon1113:
	assume wf(Heap_$_0,SecMask_$_763,SecMask_$_763);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_763);
	assume SecMask_$_764 == SecMask_$_763;
	goto $branchMerge_237;
anon1772_Then:
	assume $_$_condition_$761;
	assume SecMask_$_765[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_766 == SecMask_$_765[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_765[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_767 == SecMask_$_766;
	goto anon1117;
anon1772_Else:
	assume !$_$_condition_$761;
	assume 0 <= SecMask_$_765[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_767 == SecMask_$_765;
	goto anon1117;
anon1773_Then:
	assume $_$_condition_$762;
	assume $_$_condition_$762 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_769 == SecMask_$_768[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_768[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_768[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$764) { goto anon1774_Then; } else { goto anon1774_Else; }
anon1773_Else:
	assume !$_$_condition_$762;
	assume $_$_condition_$762 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_772 == SecMask_$_768;
	goto $branchMerge_239;
anon1117:
	assume wf(Heap_$_0,SecMask_$_767,SecMask_$_767);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_767);
	assume SecMask_$_768 == SecMask_$_767;
	goto $branchMerge_238;
anon1774_Then:
	assume $_$_condition_$764;
	assume SecMask_$_769[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_770 == SecMask_$_769[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_769[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_771 == SecMask_$_770;
	goto anon1121;
anon1774_Else:
	assume !$_$_condition_$764;
	assume 0 <= SecMask_$_769[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_771 == SecMask_$_769;
	goto anon1121;
anon1775_Then:
	assume $_$_condition_$765;
	assume $_$_condition_$765 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_773 == SecMask_$_772[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_772[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_772[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$767) { goto anon1776_Then; } else { goto anon1776_Else; }
anon1775_Else:
	assume !$_$_condition_$765;
	assume $_$_condition_$765 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_776 == SecMask_$_772;
	goto $branchMerge_240;
anon1121:
	assume wf(Heap_$_0,SecMask_$_771,SecMask_$_771);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_771);
	assume SecMask_$_772 == SecMask_$_771;
	goto $branchMerge_239;
anon1776_Then:
	assume $_$_condition_$767;
	assume SecMask_$_773[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_774 == SecMask_$_773[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_773[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_775 == SecMask_$_774;
	goto anon1125;
anon1776_Else:
	assume !$_$_condition_$767;
	assume 0 <= SecMask_$_773[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_775 == SecMask_$_773;
	goto anon1125;
anon1777_Then:
	assume $_$_condition_$768;
	assume $_$_condition_$768 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume SecMask_$_777 == SecMask_$_776[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_776[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_776[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$770) { goto anon1778_Then; } else { goto anon1778_Else; }
anon1777_Else:
	assume !$_$_condition_$768;
	assume $_$_condition_$768 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume SecMask_$_780 == SecMask_$_776;
	goto anon1130;
anon1125:
	assume wf(Heap_$_0,SecMask_$_775,SecMask_$_775);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_775);
	assume SecMask_$_776 == SecMask_$_775;
	goto $branchMerge_240;
anon1778_Then:
	assume $_$_condition_$770;
	assume SecMask_$_777[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_778 == SecMask_$_777[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_777[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_779 == SecMask_$_778;
	goto anon1129;
anon1778_Else:
	assume !$_$_condition_$770;
	assume 0 <= SecMask_$_777[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_779 == SecMask_$_777;
	goto anon1129;
anon1130:
	assume wf(Heap_$_0,SecMask_$_780,SecMask_$_780);
	assume SecMask_$_781 == SecMask_$_780;
	goto anon1131;
anon1129:
	assume wf(Heap_$_0,SecMask_$_779,SecMask_$_779);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_779);
	assume SecMask_$_780 == SecMask_$_779;
	goto anon1130;
anon1780_Then:
	assume $_$_condition_$772;
	assume SecMask_$_783[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_784 == SecMask_$_783[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_783[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_785 == SecMask_$_784;
	goto anon1135;
anon1780_Else:
	assume !$_$_condition_$772;
	assume 0 <= SecMask_$_783[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_785 == SecMask_$_783;
	goto anon1135;
anon1781_Then:
	assume $_$_condition_$773;
	assume $_$_condition_$773 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_787 == SecMask_$_786[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_786[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_786[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$775) { goto anon1782_Then; } else { goto anon1782_Else; }
anon1781_Else:
	assume !$_$_condition_$773;
	assume $_$_condition_$773 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_790 == SecMask_$_786;
	goto $branchMerge_241;
anon1135:
	assume wf(Heap_$_0,SecMask_$_785,SecMask_$_785);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_785);
	assume SecMask_$_786 == SecMask_$_785;
	goto $branchMerge_229;
anon1782_Then:
	assume $_$_condition_$775;
	assume SecMask_$_787[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_788 == SecMask_$_787[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_787[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_789 == SecMask_$_788;
	goto anon1139;
anon1782_Else:
	assume !$_$_condition_$775;
	assume 0 <= SecMask_$_787[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_789 == SecMask_$_787;
	goto anon1139;
anon1783_Then:
	assume $_$_condition_$776;
	assume $_$_condition_$776 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null);
	assume SecMask_$_791 == SecMask_$_790[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_790[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_790[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$778) { goto anon1784_Then; } else { goto anon1784_Else; }
anon1783_Else:
	assume !$_$_condition_$776;
	assume $_$_condition_$776 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.left] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.left] == null;
	assume SecMask_$_794 == SecMask_$_790;
	goto $branchMerge_242;
anon1139:
	assume wf(Heap_$_0,SecMask_$_789,SecMask_$_789);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_789);
	assume SecMask_$_790 == SecMask_$_789;
	goto $branchMerge_241;
anon1784_Then:
	assume $_$_condition_$778;
	assume SecMask_$_791[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_792 == SecMask_$_791[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_791[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_793 == SecMask_$_792;
	goto anon1143;
anon1784_Else:
	assume !$_$_condition_$778;
	assume 0 <= SecMask_$_791[Heap_$_0[r#63_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_793 == SecMask_$_791;
	goto anon1143;
anon1785_Then:
	assume $_$_condition_$779;
	assume $_$_condition_$779 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_795 == SecMask_$_794[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_794[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_794[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$781) { goto anon1786_Then; } else { goto anon1786_Else; }
anon1785_Else:
	assume !$_$_condition_$779;
	assume $_$_condition_$779 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_849 == SecMask_$_794;
	goto $branchMerge_243;
anon1143:
	assume wf(Heap_$_0,SecMask_$_793,SecMask_$_793);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_793);
	assume SecMask_$_794 == SecMask_$_793;
	goto $branchMerge_242;
anon1786_Then:
	assume $_$_condition_$781;
	assume SecMask_$_795[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_796 == SecMask_$_795[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_795[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_797 == SecMask_$_796;
	goto anon1147;
anon1786_Else:
	assume !$_$_condition_$781;
	assume 0 <= SecMask_$_795[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_797 == SecMask_$_795;
	goto anon1147;
anon1815_Then:
	assume $_$_condition_$782;
	assume $_$_condition_$782 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_850 == SecMask_$_849[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_849[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_849[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$823) { goto anon1816_Then; } else { goto anon1816_Else; }
anon1815_Else:
	assume !$_$_condition_$782;
	assume $_$_condition_$782 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_853 == SecMask_$_849;
	goto $branchMerge_244;
anon1147:
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.right] == r#63_$_0);
	if ($_$_condition_$783) { goto anon1787_Then; } else { goto anon1787_Else; }
anon1787_Then:
	assume $_$_condition_$783;
	assume $_$_condition_$783 <==> ((false || ((((predVer#_1783_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true));
	assume (false || ((((predVer#_1783_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true);
	if ($_$_condition_$784) { goto anon1788_Then; } else { goto anon1788_Else; }
anon1787_Else:
	assume !$_$_condition_$783;
	assume $_$_condition_$783 <==> ((false || ((((predVer#_1783_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true));
	assume !((false || ((((predVer#_1783_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true)) || ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true));
	assume SecMask_$_848 == SecMask_$_797;
	goto anon1204;
anon1788_Then:
	assume $_$_condition_$784;
	assume $_$_condition_$784 <==> ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true);
	assume (((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true;
	goto $branchMerge_245;
anon1788_Else:
	assume !$_$_condition_$784;
	assume $_$_condition_$784 <==> ((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true);
	assume !((((predVer#_1764_$_0 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.valid]) && (this#521_$_0 == Heap_$_0[r#63_$_0,AVLTreeNode.right])) && true) && true);
	goto $branchMerge_245;
anon1204:
	assume wf(Heap_$_0,SecMask_$_848,SecMask_$_848);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_848);
	assume SecMask_$_849 == SecMask_$_848;
	goto $branchMerge_243;
anon1789_Then:
	assume $_$_condition_$785;
	assume $_$_condition_$785 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#615 : Integer :: ( ((0 <= lk#79#615) && (lk#79#615 < Seq#Length(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#615) < Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_246;
anon1789_Else:
	assume !$_$_condition_$785;
	assume $_$_condition_$785 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_246;
anon1790_Then:
	assume $_$_condition_$787;
	assume $_$_condition_$787 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_247;
anon1790_Else:
	assume !$_$_condition_$787;
	assume $_$_condition_$787 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_247;
anon1791_Then:
	assume $_$_condition_$789;
	assume $_$_condition_$789 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#616 : Integer :: ( ((0 <= rk#80#616) && (rk#80#616 < Seq#Length(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#616)) ));
	goto $branchMerge_248;
anon1791_Else:
	assume !$_$_condition_$789;
	assume $_$_condition_$789 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_248;
anon1792_Then:
	assume $_$_condition_$791;
	assume $_$_condition_$791 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon1159;
anon1792_Else:
	assume !$_$_condition_$791;
	assume $_$_condition_$791 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon1159;
anon1159:
	assume Seq#Equal(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key])),ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys],Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$20 : Integer :: ( Seq#Contains(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$20) <==> ((((!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$20)) || ((!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$20))) || (kk#81_$20 == Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_0[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume SecMask_$_798 == SecMask_$_797[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_797[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R := SecMask_$_797[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$793) { goto anon1793_Then; } else { goto anon1793_Else; }
anon1793_Then:
	assume $_$_condition_$793;
	assume SecMask_$_798[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_799 == SecMask_$_798[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key := SecMask_$_798[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_800 == SecMask_$_799;
	goto anon1161;
anon1793_Else:
	assume !$_$_condition_$793;
	assume 0 <= SecMask_$_798[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.key][perm$R];
	assume SecMask_$_800 == SecMask_$_798;
	goto anon1161;
anon1161:
	assume wf(Heap_$_0,SecMask_$_800,SecMask_$_800);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_800);
	assume SecMask_$_801 == SecMask_$_800[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_800[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_800[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$794) { goto anon1794_Then; } else { goto anon1794_Else; }
anon1794_Then:
	assume $_$_condition_$794;
	assume SecMask_$_801[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_802 == SecMask_$_801[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_801[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_803 == SecMask_$_802;
	goto anon1163;
anon1794_Else:
	assume !$_$_condition_$794;
	assume 0 <= SecMask_$_801[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_803 == SecMask_$_801;
	goto anon1163;
anon1163:
	assume wf(Heap_$_0,SecMask_$_803,SecMask_$_803);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_803);
	assume SecMask_$_804 == SecMask_$_803[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_803[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R := SecMask_$_803[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$795) { goto anon1795_Then; } else { goto anon1795_Else; }
anon1795_Then:
	assume $_$_condition_$795;
	assume SecMask_$_804[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_805 == SecMask_$_804[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left := SecMask_$_804[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_806 == SecMask_$_805;
	goto anon1165;
anon1795_Else:
	assume !$_$_condition_$795;
	assume 0 <= SecMask_$_804[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left][perm$R];
	assume SecMask_$_806 == SecMask_$_804;
	goto anon1165;
anon1165:
	assume wf(Heap_$_0,SecMask_$_806,SecMask_$_806);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_806);
	assume SecMask_$_807 == SecMask_$_806[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_806[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R := SecMask_$_806[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$796) { goto anon1796_Then; } else { goto anon1796_Else; }
anon1796_Then:
	assume $_$_condition_$796;
	assume SecMask_$_807[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_808 == SecMask_$_807[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right := SecMask_$_807[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_809 == SecMask_$_808;
	goto anon1167;
anon1796_Else:
	assume !$_$_condition_$796;
	assume 0 <= SecMask_$_807[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right][perm$R];
	assume SecMask_$_809 == SecMask_$_807;
	goto anon1167;
anon1167:
	assume wf(Heap_$_0,SecMask_$_809,SecMask_$_809);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_809);
	assume SecMask_$_810 == SecMask_$_809[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_809[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_809[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$797) { goto anon1797_Then; } else { goto anon1797_Else; }
anon1797_Then:
	assume $_$_condition_$797;
	assume SecMask_$_810[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_811 == SecMask_$_810[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_810[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_812 == SecMask_$_811;
	goto anon1169;
anon1797_Else:
	assume !$_$_condition_$797;
	assume 0 <= SecMask_$_810[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_812 == SecMask_$_810;
	goto anon1169;
anon1169:
	assume wf(Heap_$_0,SecMask_$_812,SecMask_$_812);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_812);
	assume SecMask_$_813 == SecMask_$_812[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_812[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_812[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$798) { goto anon1798_Then; } else { goto anon1798_Else; }
anon1798_Then:
	assume $_$_condition_$798;
	assume SecMask_$_813[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_814 == SecMask_$_813[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_813[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_815 == SecMask_$_814;
	goto anon1171;
anon1798_Else:
	assume !$_$_condition_$798;
	assume 0 <= SecMask_$_813[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_815 == SecMask_$_813;
	goto anon1171;
anon1171:
	assume wf(Heap_$_0,SecMask_$_815,SecMask_$_815);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_815);
	if ($_$_condition_$799) { goto anon1799_Then; } else { goto anon1799_Else; }
anon1799_Then:
	assume $_$_condition_$799;
	assume $_$_condition_$799 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_816 == SecMask_$_815[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_815[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_815[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$800) { goto anon1800_Then; } else { goto anon1800_Else; }
anon1799_Else:
	assume !$_$_condition_$799;
	assume $_$_condition_$799 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_819 == SecMask_$_815;
	goto $branchMerge_249;
anon1800_Then:
	assume $_$_condition_$800;
	assume SecMask_$_816[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_817 == SecMask_$_816[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_816[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_818 == SecMask_$_817;
	goto anon1174;
anon1800_Else:
	assume !$_$_condition_$800;
	assume 0 <= SecMask_$_816[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_818 == SecMask_$_816;
	goto anon1174;
anon1801_Then:
	assume $_$_condition_$801;
	assume $_$_condition_$801 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_820 == SecMask_$_819[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_819[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_819[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$803) { goto anon1802_Then; } else { goto anon1802_Else; }
anon1801_Else:
	assume !$_$_condition_$801;
	assume $_$_condition_$801 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_823 == SecMask_$_819;
	goto $branchMerge_250;
anon1174:
	assume wf(Heap_$_0,SecMask_$_818,SecMask_$_818);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_818);
	assume SecMask_$_819 == SecMask_$_818;
	goto $branchMerge_249;
anon1802_Then:
	assume $_$_condition_$803;
	assume SecMask_$_820[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_821 == SecMask_$_820[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := SecMask_$_820[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_822 == SecMask_$_821;
	goto anon1178;
anon1802_Else:
	assume !$_$_condition_$803;
	assume 0 <= SecMask_$_820[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_822 == SecMask_$_820;
	goto anon1178;
anon1803_Then:
	assume $_$_condition_$804;
	assume $_$_condition_$804 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_824 == SecMask_$_823[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_823[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_823[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$806) { goto anon1804_Then; } else { goto anon1804_Else; }
anon1803_Else:
	assume !$_$_condition_$804;
	assume $_$_condition_$804 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_827 == SecMask_$_823;
	goto $branchMerge_251;
anon1178:
	assume wf(Heap_$_0,SecMask_$_822,SecMask_$_822);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_822);
	assume SecMask_$_823 == SecMask_$_822;
	goto $branchMerge_250;
anon1804_Then:
	assume $_$_condition_$806;
	assume SecMask_$_824[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_825 == SecMask_$_824[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_824[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_826 == SecMask_$_825;
	goto anon1182;
anon1804_Else:
	assume !$_$_condition_$806;
	assume 0 <= SecMask_$_824[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_826 == SecMask_$_824;
	goto anon1182;
anon1805_Then:
	assume $_$_condition_$807;
	assume $_$_condition_$807 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume SecMask_$_828 == SecMask_$_827[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_827[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_827[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$809) { goto anon1806_Then; } else { goto anon1806_Else; }
anon1805_Else:
	assume !$_$_condition_$807;
	assume $_$_condition_$807 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume SecMask_$_831 == SecMask_$_827;
	goto $branchMerge_252;
anon1182:
	assume wf(Heap_$_0,SecMask_$_826,SecMask_$_826);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_826);
	assume SecMask_$_827 == SecMask_$_826;
	goto $branchMerge_251;
anon1806_Then:
	assume $_$_condition_$809;
	assume SecMask_$_828[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_829 == SecMask_$_828[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_828[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_830 == SecMask_$_829;
	goto anon1186;
anon1806_Else:
	assume !$_$_condition_$809;
	assume 0 <= SecMask_$_828[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_830 == SecMask_$_828;
	goto anon1186;
anon1807_Then:
	assume $_$_condition_$810;
	assume $_$_condition_$810 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_832 == SecMask_$_831[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_831[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_831[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$812) { goto anon1808_Then; } else { goto anon1808_Else; }
anon1807_Else:
	assume !$_$_condition_$810;
	assume $_$_condition_$810 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_835 == SecMask_$_831;
	goto $branchMerge_253;
anon1186:
	assume wf(Heap_$_0,SecMask_$_830,SecMask_$_830);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_830);
	assume SecMask_$_831 == SecMask_$_830;
	goto $branchMerge_252;
anon1808_Then:
	assume $_$_condition_$812;
	assume SecMask_$_832[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_833 == SecMask_$_832[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_832[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_834 == SecMask_$_833;
	goto anon1190;
anon1808_Else:
	assume !$_$_condition_$812;
	assume 0 <= SecMask_$_832[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_834 == SecMask_$_832;
	goto anon1190;
anon1809_Then:
	assume $_$_condition_$813;
	assume $_$_condition_$813 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_836 == SecMask_$_835[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_835[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_835[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$815) { goto anon1810_Then; } else { goto anon1810_Else; }
anon1809_Else:
	assume !$_$_condition_$813;
	assume $_$_condition_$813 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_839 == SecMask_$_835;
	goto $branchMerge_254;
anon1190:
	assume wf(Heap_$_0,SecMask_$_834,SecMask_$_834);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_834);
	assume SecMask_$_835 == SecMask_$_834;
	goto $branchMerge_253;
anon1810_Then:
	assume $_$_condition_$815;
	assume SecMask_$_836[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_837 == SecMask_$_836[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := SecMask_$_836[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_838 == SecMask_$_837;
	goto anon1194;
anon1810_Else:
	assume !$_$_condition_$815;
	assume 0 <= SecMask_$_836[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_838 == SecMask_$_836;
	goto anon1194;
anon1811_Then:
	assume $_$_condition_$816;
	assume $_$_condition_$816 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_840 == SecMask_$_839[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_839[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_839[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$818) { goto anon1812_Then; } else { goto anon1812_Else; }
anon1811_Else:
	assume !$_$_condition_$816;
	assume $_$_condition_$816 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_843 == SecMask_$_839;
	goto $branchMerge_255;
anon1194:
	assume wf(Heap_$_0,SecMask_$_838,SecMask_$_838);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_838);
	assume SecMask_$_839 == SecMask_$_838;
	goto $branchMerge_254;
anon1812_Then:
	assume $_$_condition_$818;
	assume SecMask_$_840[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_841 == SecMask_$_840[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_840[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_842 == SecMask_$_841;
	goto anon1198;
anon1812_Else:
	assume !$_$_condition_$818;
	assume 0 <= SecMask_$_840[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_842 == SecMask_$_840;
	goto anon1198;
anon1813_Then:
	assume $_$_condition_$819;
	assume $_$_condition_$819 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume SecMask_$_844 == SecMask_$_843[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_843[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_843[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$821) { goto anon1814_Then; } else { goto anon1814_Else; }
anon1813_Else:
	assume !$_$_condition_$819;
	assume $_$_condition_$819 <==> (!(Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume SecMask_$_847 == SecMask_$_843;
	goto anon1203;
anon1198:
	assume wf(Heap_$_0,SecMask_$_842,SecMask_$_842);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_842);
	assume SecMask_$_843 == SecMask_$_842;
	goto $branchMerge_255;
anon1814_Then:
	assume $_$_condition_$821;
	assume SecMask_$_844[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_845 == SecMask_$_844[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_844[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_846 == SecMask_$_845;
	goto anon1202;
anon1814_Else:
	assume !$_$_condition_$821;
	assume 0 <= SecMask_$_844[Heap_$_0[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_846 == SecMask_$_844;
	goto anon1202;
anon1203:
	assume wf(Heap_$_0,SecMask_$_847,SecMask_$_847);
	assume SecMask_$_848 == SecMask_$_847;
	goto anon1204;
anon1202:
	assume wf(Heap_$_0,SecMask_$_846,SecMask_$_846);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_846);
	assume SecMask_$_847 == SecMask_$_846;
	goto anon1203;
anon1816_Then:
	assume $_$_condition_$823;
	assume SecMask_$_850[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_851 == SecMask_$_850[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_850[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_852 == SecMask_$_851;
	goto anon1208;
anon1816_Else:
	assume !$_$_condition_$823;
	assume 0 <= SecMask_$_850[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_852 == SecMask_$_850;
	goto anon1208;
anon1817_Then:
	assume $_$_condition_$824;
	assume $_$_condition_$824 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_854 == SecMask_$_853[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_853[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_853[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$826) { goto anon1818_Then; } else { goto anon1818_Else; }
anon1817_Else:
	assume !$_$_condition_$824;
	assume $_$_condition_$824 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_857 == SecMask_$_853;
	goto $branchMerge_256;
anon1208:
	assume wf(Heap_$_0,SecMask_$_852,SecMask_$_852);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_852);
	assume SecMask_$_853 == SecMask_$_852;
	goto $branchMerge_244;
anon1818_Then:
	assume $_$_condition_$826;
	assume SecMask_$_854[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_855 == SecMask_$_854[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_854[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_856 == SecMask_$_855;
	goto anon1212;
anon1818_Else:
	assume !$_$_condition_$826;
	assume 0 <= SecMask_$_854[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_856 == SecMask_$_854;
	goto anon1212;
anon1819_Then:
	assume $_$_condition_$827;
	assume $_$_condition_$827 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null);
	assume SecMask_$_858 == SecMask_$_857[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_857[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_857[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$829) { goto anon1820_Then; } else { goto anon1820_Else; }
anon1819_Else:
	assume !$_$_condition_$827;
	assume $_$_condition_$827 <==> (!(Heap_$_0[r#63_$_0,AVLTreeNode.right] == null));
	assume Heap_$_0[r#63_$_0,AVLTreeNode.right] == null;
	assume SecMask_$_861 == SecMask_$_857;
	goto anon1217;
anon1212:
	assume wf(Heap_$_0,SecMask_$_856,SecMask_$_856);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_856);
	assume SecMask_$_857 == SecMask_$_856;
	goto $branchMerge_256;
anon1820_Then:
	assume $_$_condition_$829;
	assume SecMask_$_858[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_859 == SecMask_$_858[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_858[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_860 == SecMask_$_859;
	goto anon1216;
anon1820_Else:
	assume !$_$_condition_$829;
	assume 0 <= SecMask_$_858[Heap_$_0[r#63_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_860 == SecMask_$_858;
	goto anon1216;
anon1217:
	assume wf(Heap_$_0,SecMask_$_861,SecMask_$_861);
	assume SecMask_$_862 == SecMask_$_861;
	goto $branchMerge_223;
anon1216:
	assume wf(Heap_$_0,SecMask_$_860,SecMask_$_860);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_860);
	assume SecMask_$_861 == SecMask_$_860;
	goto anon1217;
anon1220:
	assume IsGoodMask(exhaleMask#_2090_$_0);
	assume wf(Heap_$_0,exhaleMask#_2090_$_0,SecMask_$_862);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_862);
	assert { :msg "  599.2: The postcondition at 625.11 might not hold. The permission at 625.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  599.2: The postcondition at 625.11 might not hold. Insufficient fraction at 625.11 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_2090_$_0[r#63_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2090_$_0[r#63_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2090_$_0[r#63_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_2090_$_1 == exhaleMask#_2090_$_0[r#63_$_0,AVLTreeNode.height := exhaleMask#_2090_$_0[r#63_$_0,AVLTreeNode.height][perm$R := exhaleMask#_2090_$_0[r#63_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2090_$_1);
	assume wf(Heap_$_0,exhaleMask#_2090_$_1,SecMask_$_862);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_862);
	assert { :msg "  599.2: The postcondition at 626.11 might not hold. The permission at 626.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  599.2: The postcondition at 626.11 might not hold. Insufficient fraction at 626.11 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_2090_$_1[r#63_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2090_$_1[r#63_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2090_$_1[r#63_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_2090_$_2 == exhaleMask#_2090_$_1[r#63_$_0,AVLTreeNode.keys := exhaleMask#_2090_$_1[r#63_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_2090_$_1[r#63_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2090_$_2);
	assume wf(Heap_$_0,exhaleMask#_2090_$_2,SecMask_$_862);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_862);
	assert { :msg "  599.2: The postcondition at 627.11 might not hold. The permission at 627.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  599.2: The postcondition at 627.11 might not hold. Insufficient fraction at 627.11 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_2090_$_2[r#63_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2090_$_2[r#63_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2090_$_2[r#63_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_2090_$_3 == exhaleMask#_2090_$_2[r#63_$_0,AVLTreeNode.balanceFactor := exhaleMask#_2090_$_2[r#63_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2090_$_2[r#63_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_2090_$_3);
	assume wf(Heap_$_0,exhaleMask#_2090_$_3,SecMask_$_862);
	assume wf(Heap_$_0,Mask_$_28,SecMask_$_862);
	assume IsGoodExhaleState(exhaleHeap#_2089_$_0,Heap_$_0,exhaleMask#_2090_$_3,SecMask_$_862);
	assume IsGoodMask(exhaleMask#_2090_$_3);
	assume wf(exhaleHeap#_2089_$_0,exhaleMask#_2090_$_3,SecMask_$_862);
	assert { :msg "  599.2: Method might lock/unlock more than allowed." } (forall  lk#_2143 : ref :: {exhaleHeap#_2089_$_0[lk#_2143,held]} {exhaleHeap#_2089_$_0[lk#_2143,rdheld]} ( (((0 < exhaleHeap#_2089_$_0[lk#_2143,held]) <==> (0 < Heap[lk#_2143,held])) && (exhaleHeap#_2089_$_0[lk#_2143,rdheld] <==> Heap[lk#_2143,rdheld])) || false ));
	assert { :msg "  599.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
$branchMerge_0:
	if ($_$_condition_$0) { goto anon1222_Then; } else { goto anon1222_Else; }
$branchMerge_1:
	if ($_$_condition_$2) { goto anon1223_Then; } else { goto anon1223_Else; }
$branchMerge_2:
	if ($_$_condition_$4) { goto anon1224_Then; } else { goto anon1224_Else; }
$branchMerge_3:
	if ($_$_condition_$6) { goto anon1225_Then; } else { goto anon1225_Else; }
$branchMerge_4:
	if ($_$_condition_$11) { goto anon1255_Then; } else { goto anon1255_Else; }
$branchMerge_5:
	if ($_$_condition_$13) { goto anon1256_Then; } else { goto anon1256_Else; }
$branchMerge_6:
	if ($_$_condition_$15) { goto anon1257_Then; } else { goto anon1257_Else; }
$branchMerge_7:
	if ($_$_condition_$17) { goto anon1258_Then; } else { goto anon1258_Else; }
$branchMerge_8:
	if ($_$_condition_$19) { goto anon1259_Then; } else { goto anon1259_Else; }
$branchMerge_9:
	if ($_$_condition_$21) { goto anon1260_Then; } else { goto anon1260_Else; }
$branchMerge_10:
	if ($_$_condition_$23) { goto anon1261_Then; } else { goto anon1261_Else; }
$branchMerge_11:
	if ($_$_condition_$25) { goto anon1262_Then; } else { goto anon1262_Else; }
$branchMerge_12:
	if ($_$_condition_$27) { goto anon1263_Then; } else { goto anon1263_Else; }
$branchMerge_13:
	if ($_$_condition_$29) { goto anon1264_Then; } else { goto anon1264_Else; }
$branchMerge_14:
	if ($_$_condition_$31) { goto anon1265_Then; } else { goto anon1265_Else; }
$branchMerge_15:
	if ($_$_condition_$35) { goto anon1268_Then; } else { goto anon1268_Else; }
$branchMerge_16:
	if ($_$_condition_$37) { goto anon1269_Then; } else { goto anon1269_Else; }
$branchMerge_17:
	if ($_$_condition_$39) { goto anon1270_Then; } else { goto anon1270_Else; }
$branchMerge_18:
	if ($_$_condition_$49) { goto anon1279_Then; } else { goto anon1279_Else; }
$branchMerge_19:
	if ($_$_condition_$52) { goto anon1281_Then; } else { goto anon1281_Else; }
$branchMerge_20:
	if ($_$_condition_$55) { goto anon1283_Then; } else { goto anon1283_Else; }
$branchMerge_21:
	if ($_$_condition_$58) { goto anon1285_Then; } else { goto anon1285_Else; }
$branchMerge_22:
	if ($_$_condition_$61) { goto anon1287_Then; } else { goto anon1287_Else; }
$branchMerge_23:
	if ($_$_condition_$64) { goto anon1289_Then; } else { goto anon1289_Else; }
$branchMerge_24:
	if ($_$_condition_$67) { goto anon1291_Then; } else { goto anon1291_Else; }
$branchMerge_25:
	if ($_$_condition_$71) { goto anon1294_Then; } else { goto anon1294_Else; }
$branchMerge_26:
	if ($_$_condition_$73) { goto anon1295_Then; } else { goto anon1295_Else; }
$branchMerge_27:
	if ($_$_condition_$75) { goto anon1296_Then; } else { goto anon1296_Else; }
$branchMerge_28:
	if ($_$_condition_$77) { goto anon1297_Then; } else { goto anon1297_Else; }
$branchMerge_29:
	if ($_$_condition_$79) { goto anon1298_Then; } else { goto anon1298_Else; }
$branchMerge_30:
	if ($_$_condition_$81) { goto anon1299_Then; } else { goto anon1299_Else; }
$branchMerge_31:
	if ($_$_condition_$83) { goto anon1300_Then; } else { goto anon1300_Else; }
$branchMerge_32:
	if ($_$_condition_$85) { goto anon1301_Then; } else { goto anon1301_Else; }
$branchMerge_33:
	if ($_$_condition_$87) { goto anon1302_Then; } else { goto anon1302_Else; }
$branchMerge_34:
	if ($_$_condition_$89) { goto anon1303_Then; } else { goto anon1303_Else; }
$branchMerge_35:
	if ($_$_condition_$91) { goto anon1304_Then; } else { goto anon1304_Else; }
$branchMerge_36:
	if ($_$_condition_$97) { goto anon1334_Then; } else { goto anon1334_Else; }
$branchMerge_37:
	if ($_$_condition_$98) { goto anon1308_Then; } else { goto anon1308_Else; }
$branchMerge_38:
	if ($_$_condition_$101) { goto anon1309_Then; } else { goto anon1309_Else; }
$branchMerge_39:
	if ($_$_condition_$104) { goto anon1647_Then; } else { goto anon1647_Else; }
$branchMerge_40:
	if ($_$_condition_$105) { goto anon1310_Then; } else { goto anon1310_Else; }
$branchMerge_41:
	if ($_$_condition_$107) { goto anon1565_Then; } else { goto anon1565_Else; }
$branchMerge_42:
	if ($_$_condition_$109) { goto anon1311_Then; } else { goto anon1311_Else; }
$branchMerge_43:
	if ($_$_condition_$111) { goto anon1566_Then; } else { goto anon1566_Else; }
$branchMerge_44:
	if ($_$_condition_$113) { goto anon1567_Then; } else { goto anon1567_Else; }
$branchMerge_45:
	if ($_$_condition_$116) { goto anon1568_Then; } else { goto anon1568_Else; }
$branchMerge_46:
	if ($_$_condition_$131) { goto anon1320_Then; } else { goto anon1320_Else; }
$branchMerge_47:
	if ($_$_condition_$137) { goto anon1322_Then; } else { goto anon1322_Else; }
$branchMerge_48:
	if ($_$_condition_$135) { goto anon1605_Then; } else { goto anon1605_Else; }
$branchMerge_49:
	if ($_$_condition_$233) { goto anon1607_Then; } else { goto anon1607_Else; }
$branchMerge_50:
	if ($_$_condition_$142) { goto anon1324_Then; } else { goto anon1324_Else; }
$branchMerge_51:
	if ($_$_condition_$143) { goto anon1579_Then; } else { goto anon1579_Else; }
$branchMerge_52:
	if ($_$_condition_$151) { goto anon1326_Then; } else { goto anon1326_Else; }
$branchMerge_53:
	if ($_$_condition_$145) { goto anon1580_Then; } else { goto anon1580_Else; }
$branchMerge_54:
	if ($_$_condition_$148) { goto anon1581_Then; } else { goto anon1581_Else; }
$branchMerge_55:
	if ($_$_condition_$152) { goto anon1582_Then; } else { goto anon1582_Else; }
$branchMerge_56:
	if ($_$_condition_$157) { goto anon1328_Then; } else { goto anon1328_Else; }
$branchMerge_57:
	if ($_$_condition_$161) { goto anon1330_Then; } else { goto anon1330_Else; }
$branchMerge_58:
	if ($_$_condition_$166) { goto anon1332_Then; } else { goto anon1332_Else; }
$branchMerge_59:
	if ($_$_condition_$174) { goto anon1591_Then; } else { goto anon1591_Else; }
$branchMerge_60:
	if ($_$_condition_$180) { goto anon1593_Then; } else { goto anon1593_Else; }
$branchMerge_61:
	if ($_$_condition_$177) { goto anon1336_Then; } else { goto anon1336_Else; }
$branchMerge_62:
	if ($_$_condition_$181) { goto anon1337_Then; } else { goto anon1337_Else; }
$branchMerge_63:
	if ($_$_condition_$189) { goto anon1595_Then; } else { goto anon1595_Else; }
$branchMerge_64:
	if ($_$_condition_$183) { goto anon1338_Then; } else { goto anon1338_Else; }
$branchMerge_65:
	if ($_$_condition_$186) { goto anon1339_Then; } else { goto anon1339_Else; }
$branchMerge_66:
	if ($_$_condition_$190) { goto anon1340_Then; } else { goto anon1340_Else; }
$branchMerge_67:
	if ($_$_condition_$198) { goto anon1597_Then; } else { goto anon1597_Else; }
$branchMerge_68:
	if ($_$_condition_$192) { goto anon1341_Then; } else { goto anon1341_Else; }
$branchMerge_69:
	if ($_$_condition_$195) { goto anon1342_Then; } else { goto anon1342_Else; }
$branchMerge_70:
	if ($_$_condition_$199) { goto anon1343_Then; } else { goto anon1343_Else; }
$branchMerge_71:
	if ($_$_condition_$207) { goto anon1599_Then; } else { goto anon1599_Else; }
$branchMerge_72:
	if ($_$_condition_$201) { goto anon1344_Then; } else { goto anon1344_Else; }
$branchMerge_73:
	if ($_$_condition_$204) { goto anon1345_Then; } else { goto anon1345_Else; }
$branchMerge_74:
	if ($_$_condition_$208) { goto anon1346_Then; } else { goto anon1346_Else; }
$branchMerge_75:
	if ($_$_condition_$213) { goto anon1601_Then; } else { goto anon1601_Else; }
$branchMerge_76:
	if ($_$_condition_$221) { goto anon1603_Then; } else { goto anon1603_Else; }
$branchMerge_77:
	if ($_$_condition_$215) { goto anon1349_Then; } else { goto anon1349_Else; }
$branchMerge_78:
	if ($_$_condition_$218) { goto anon1350_Then; } else { goto anon1350_Else; }
$branchMerge_79:
	if ($_$_condition_$222) { goto anon1351_Then; } else { goto anon1351_Else; }
$branchMerge_80:
	if ($_$_condition_$224) { goto anon1352_Then; } else { goto anon1352_Else; }
$branchMerge_81:
	if ($_$_condition_$237) { goto anon1609_Then; } else { goto anon1609_Else; }
$branchMerge_82:
	if ($_$_condition_$242) { goto anon1611_Then; } else { goto anon1611_Else; }
$branchMerge_83:
	if ($_$_condition_$248) { goto anon1641_Then; } else { goto anon1641_Else; }
$branchMerge_84:
	if ($_$_condition_$246) { goto anon1361_Then; } else { goto anon1361_Else; }
$branchMerge_85:
	if ($_$_condition_$252) { goto anon1363_Then; } else { goto anon1363_Else; }
$branchMerge_86:
	if ($_$_condition_$346) { goto anon1643_Then; } else { goto anon1643_Else; }
$branchMerge_87:
	if ($_$_condition_$260) { goto anon1365_Then; } else { goto anon1365_Else; }
$branchMerge_88:
	if ($_$_condition_$254) { goto anon1615_Then; } else { goto anon1615_Else; }
$branchMerge_89:
	if ($_$_condition_$257) { goto anon1616_Then; } else { goto anon1616_Else; }
$branchMerge_90:
	if ($_$_condition_$261) { goto anon1617_Then; } else { goto anon1617_Else; }
$branchMerge_91:
	if ($_$_condition_$267) { goto anon1367_Then; } else { goto anon1367_Else; }
$branchMerge_92:
	if ($_$_condition_$263) { goto anon1618_Then; } else { goto anon1618_Else; }
$branchMerge_93:
	if ($_$_condition_$272) { goto anon1369_Then; } else { goto anon1369_Else; }
$branchMerge_94:
	if ($_$_condition_$276) { goto anon1371_Then; } else { goto anon1371_Else; }
$branchMerge_95:
	if ($_$_condition_$281) { goto anon1373_Then; } else { goto anon1373_Else; }
$branchMerge_96:
	if ($_$_condition_$287) { goto anon1627_Then; } else { goto anon1627_Else; }
$branchMerge_97:
	if ($_$_condition_$291) { goto anon1629_Then; } else { goto anon1629_Else; }
$branchMerge_98:
	if ($_$_condition_$292) { goto anon1376_Then; } else { goto anon1376_Else; }
$branchMerge_99:
	if ($_$_condition_$300) { goto anon1631_Then; } else { goto anon1631_Else; }
$branchMerge_100:
	if ($_$_condition_$294) { goto anon1377_Then; } else { goto anon1377_Else; }
$branchMerge_101:
	if ($_$_condition_$297) { goto anon1378_Then; } else { goto anon1378_Else; }
$branchMerge_102:
	if ($_$_condition_$301) { goto anon1379_Then; } else { goto anon1379_Else; }
$branchMerge_103:
	if ($_$_condition_$309) { goto anon1633_Then; } else { goto anon1633_Else; }
$branchMerge_104:
	if ($_$_condition_$303) { goto anon1380_Then; } else { goto anon1380_Else; }
$branchMerge_105:
	if ($_$_condition_$306) { goto anon1381_Then; } else { goto anon1381_Else; }
$branchMerge_106:
	if ($_$_condition_$310) { goto anon1382_Then; } else { goto anon1382_Else; }
$branchMerge_107:
	if ($_$_condition_$318) { goto anon1635_Then; } else { goto anon1635_Else; }
$branchMerge_108:
	if ($_$_condition_$312) { goto anon1383_Then; } else { goto anon1383_Else; }
$branchMerge_109:
	if ($_$_condition_$315) { goto anon1384_Then; } else { goto anon1384_Else; }
$branchMerge_110:
	if ($_$_condition_$319) { goto anon1385_Then; } else { goto anon1385_Else; }
$branchMerge_111:
	if ($_$_condition_$325) { goto anon1637_Then; } else { goto anon1637_Else; }
$branchMerge_112:
	if ($_$_condition_$321) { goto anon1386_Then; } else { goto anon1386_Else; }
$branchMerge_113:
	if ($_$_condition_$330) { goto anon1639_Then; } else { goto anon1639_Else; }
$branchMerge_114:
	if ($_$_condition_$332) { goto anon1472_Then; } else { goto anon1472_Else; }
$branchMerge_115:
	if ($_$_condition_$333) { goto anon1390_Then; } else { goto anon1390_Else; }
$branchMerge_116:
	if ($_$_condition_$336) { goto anon1391_Then; } else { goto anon1391_Else; }
$branchMerge_117:
	if ($_$_condition_$339) { goto anon1392_Then; } else { goto anon1392_Else; }
$branchMerge_118:
	if ($_$_condition_$341) { goto anon1393_Then; } else { goto anon1393_Else; }
$branchMerge_119:
	if ($_$_condition_$351) { goto anon1645_Then; } else { goto anon1645_Else; }
$branchMerge_120:
	if ($_$_condition_$361) { goto anon1430_Then; } else { goto anon1430_Else; }
$branchMerge_121:
	if ($_$_condition_$363) { goto anon1734_Then; } else { goto anon1734_Else; }
$branchMerge_122:
	if ($_$_condition_$447) { goto anon1432_Then; } else { goto anon1432_Else; }
$branchMerge_123:
	if ($_$_condition_$365) { goto anon1733_Then; } else { goto anon1733_Else; }
$branchMerge_124:
	if ($_$_condition_$604) { goto anon1735_Then; } else { goto anon1735_Else; }
$branchMerge_125:
	if ($_$_condition_$367) { goto anon1651_Then; } else { goto anon1651_Else; }
$branchMerge_126:
	if ($_$_condition_$370) { goto anon1652_Then; } else { goto anon1652_Else; }
$branchMerge_127:
	if ($_$_condition_$372) { goto anon1404_Then; } else { goto anon1404_Else; }
$branchMerge_128:
	if ($_$_condition_$374) { goto anon1653_Then; } else { goto anon1653_Else; }
$branchMerge_129:
	if ($_$_condition_$376) { goto anon1405_Then; } else { goto anon1405_Else; }
$branchMerge_130:
	if ($_$_condition_$378) { goto anon1654_Then; } else { goto anon1654_Else; }
$branchMerge_131:
	if ($_$_condition_$380) { goto anon1406_Then; } else { goto anon1406_Else; }
$branchMerge_132:
	if ($_$_condition_$382) { goto anon1407_Then; } else { goto anon1407_Else; }
$branchMerge_133:
	if ($_$_condition_$398) { goto anon1691_Then; } else { goto anon1691_Else; }
$branchMerge_134:
	if ($_$_condition_$487) { goto anon1693_Then; } else { goto anon1693_Else; }
$branchMerge_135:
	if ($_$_condition_$401) { goto anon1416_Then; } else { goto anon1416_Else; }
$branchMerge_136:
	if ($_$_condition_$408) { goto anon1418_Then; } else { goto anon1418_Else; }
$branchMerge_137:
	if ($_$_condition_$405) { goto anon1665_Then; } else { goto anon1665_Else; }
$branchMerge_138:
	if ($_$_condition_$409) { goto anon1666_Then; } else { goto anon1666_Else; }
$branchMerge_139:
	if ($_$_condition_$417) { goto anon1420_Then; } else { goto anon1420_Else; }
$branchMerge_140:
	if ($_$_condition_$411) { goto anon1667_Then; } else { goto anon1667_Else; }
$branchMerge_141:
	if ($_$_condition_$414) { goto anon1668_Then; } else { goto anon1668_Else; }
$branchMerge_142:
	if ($_$_condition_$421) { goto anon1422_Then; } else { goto anon1422_Else; }
$branchMerge_143:
	if ($_$_condition_$426) { goto anon1424_Then; } else { goto anon1424_Else; }
$branchMerge_144:
	if ($_$_condition_$430) { goto anon1426_Then; } else { goto anon1426_Else; }
$branchMerge_145:
	if ($_$_condition_$435) { goto anon1428_Then; } else { goto anon1428_Else; }
$branchMerge_146:
	if ($_$_condition_$439) { goto anon1677_Then; } else { goto anon1677_Else; }
$branchMerge_147:
	if ($_$_condition_$443) { goto anon1679_Then; } else { goto anon1679_Else; }
$branchMerge_148:
	if ($_$_condition_$449) { goto anon1681_Then; } else { goto anon1681_Else; }
$branchMerge_149:
	if ($_$_condition_$453) { goto anon1434_Then; } else { goto anon1434_Else; }
$branchMerge_150:
	if ($_$_condition_$455) { goto anon1683_Then; } else { goto anon1683_Else; }
$branchMerge_151:
	if ($_$_condition_$459) { goto anon1436_Then; } else { goto anon1436_Else; }
$branchMerge_152:
	if ($_$_condition_$461) { goto anon1685_Then; } else { goto anon1685_Else; }
$branchMerge_153:
	if ($_$_condition_$465) { goto anon1466_Then; } else { goto anon1466_Else; }
$branchMerge_154:
	if ($_$_condition_$467) { goto anon1687_Then; } else { goto anon1687_Else; }
$branchMerge_155:
	if ($_$_condition_$549) { goto anon1468_Then; } else { goto anon1468_Else; }
$branchMerge_156:
	if ($_$_condition_$472) { goto anon1689_Then; } else { goto anon1689_Else; }
$branchMerge_157:
	if ($_$_condition_$473) { goto anon1440_Then; } else { goto anon1440_Else; }
$branchMerge_158:
	if ($_$_condition_$475) { goto anon1441_Then; } else { goto anon1441_Else; }
$branchMerge_159:
	if ($_$_condition_$478) { goto anon1442_Then; } else { goto anon1442_Else; }
$branchMerge_160:
	if ($_$_condition_$481) { goto anon1443_Then; } else { goto anon1443_Else; }
$branchMerge_161:
	if ($_$_condition_$491) { goto anon1695_Then; } else { goto anon1695_Else; }
$branchMerge_162:
	if ($_$_condition_$496) { goto anon1697_Then; } else { goto anon1697_Else; }
$branchMerge_163:
	if ($_$_condition_$500) { goto anon1727_Then; } else { goto anon1727_Else; }
$branchMerge_164:
	if ($_$_condition_$588) { goto anon1729_Then; } else { goto anon1729_Else; }
$branchMerge_165:
	if ($_$_condition_$503) { goto anon1452_Then; } else { goto anon1452_Else; }
$branchMerge_166:
	if ($_$_condition_$510) { goto anon1454_Then; } else { goto anon1454_Else; }
$branchMerge_167:
	if ($_$_condition_$507) { goto anon1701_Then; } else { goto anon1701_Else; }
$branchMerge_168:
	if ($_$_condition_$511) { goto anon1702_Then; } else { goto anon1702_Else; }
$branchMerge_169:
	if ($_$_condition_$519) { goto anon1456_Then; } else { goto anon1456_Else; }
$branchMerge_170:
	if ($_$_condition_$513) { goto anon1703_Then; } else { goto anon1703_Else; }
$branchMerge_171:
	if ($_$_condition_$516) { goto anon1704_Then; } else { goto anon1704_Else; }
$branchMerge_172:
	if ($_$_condition_$523) { goto anon1458_Then; } else { goto anon1458_Else; }
$branchMerge_173:
	if ($_$_condition_$528) { goto anon1460_Then; } else { goto anon1460_Else; }
$branchMerge_174:
	if ($_$_condition_$532) { goto anon1462_Then; } else { goto anon1462_Else; }
$branchMerge_175:
	if ($_$_condition_$537) { goto anon1464_Then; } else { goto anon1464_Else; }
$branchMerge_176:
	if ($_$_condition_$541) { goto anon1713_Then; } else { goto anon1713_Else; }
$branchMerge_177:
	if ($_$_condition_$545) { goto anon1715_Then; } else { goto anon1715_Else; }
$branchMerge_178:
	if ($_$_condition_$551) { goto anon1717_Then; } else { goto anon1717_Else; }
$branchMerge_179:
	if ($_$_condition_$555) { goto anon1470_Then; } else { goto anon1470_Else; }
$branchMerge_180:
	if ($_$_condition_$557) { goto anon1719_Then; } else { goto anon1719_Else; }
$branchMerge_181:
	if ($_$_condition_$562) { goto anon1721_Then; } else { goto anon1721_Else; }
$branchMerge_182:
	if ($_$_condition_$566) { goto anon1723_Then; } else { goto anon1723_Else; }
$branchMerge_183:
	if ($_$_condition_$572) { goto anon1725_Then; } else { goto anon1725_Else; }
$branchMerge_184:
	if ($_$_condition_$570) { goto anon1559_Then; } else { goto anon1559_Else; }
$branchMerge_185:
	if ($_$_condition_$574) { goto anon1558_Then; } else { goto anon1558_Else; }
$branchMerge_186:
	if ($_$_condition_$708) { goto anon1560_Then; } else { goto anon1560_Else; }
$branchMerge_187:
	if ($_$_condition_$575) { goto anon1476_Then; } else { goto anon1476_Else; }
$branchMerge_188:
	if ($_$_condition_$578) { goto anon1477_Then; } else { goto anon1477_Else; }
$branchMerge_189:
	if ($_$_condition_$581) { goto anon1478_Then; } else { goto anon1478_Else; }
$branchMerge_190:
	if ($_$_condition_$583) { goto anon1479_Then; } else { goto anon1479_Else; }
$branchMerge_191:
	if ($_$_condition_$593) { goto anon1731_Then; } else { goto anon1731_Else; }
$branchMerge_192:
	if ($_$_condition_$603) { goto anon1516_Then; } else { goto anon1516_Else; }
$branchMerge_193:
	if ($_$_condition_$649) { goto anon1518_Then; } else { goto anon1518_Else; }
$branchMerge_194:
	if ($_$_condition_$606) { goto anon1736_Then; } else { goto anon1736_Else; }
$branchMerge_195:
	if ($_$_condition_$610) { goto anon1490_Then; } else { goto anon1490_Else; }
$branchMerge_196:
	if ($_$_condition_$612) { goto anon1491_Then; } else { goto anon1491_Else; }
$branchMerge_197:
	if ($_$_condition_$614) { goto anon1492_Then; } else { goto anon1492_Else; }
$branchMerge_198:
	if ($_$_condition_$616) { goto anon1493_Then; } else { goto anon1493_Else; }
$branchMerge_199:
	if ($_$_condition_$626) { goto anon1502_Then; } else { goto anon1502_Else; }
$branchMerge_200:
	if ($_$_condition_$629) { goto anon1504_Then; } else { goto anon1504_Else; }
$branchMerge_201:
	if ($_$_condition_$632) { goto anon1506_Then; } else { goto anon1506_Else; }
$branchMerge_202:
	if ($_$_condition_$635) { goto anon1508_Then; } else { goto anon1508_Else; }
$branchMerge_203:
	if ($_$_condition_$638) { goto anon1510_Then; } else { goto anon1510_Else; }
$branchMerge_204:
	if ($_$_condition_$641) { goto anon1512_Then; } else { goto anon1512_Else; }
$branchMerge_205:
	if ($_$_condition_$644) { goto anon1514_Then; } else { goto anon1514_Else; }
$branchMerge_206:
	if ($_$_condition_$652) { goto anon1520_Then; } else { goto anon1520_Else; }
$branchMerge_207:
	if ($_$_condition_$655) { goto anon1522_Then; } else { goto anon1522_Else; }
$branchMerge_208:
	if ($_$_condition_$658) { goto anon1552_Then; } else { goto anon1552_Else; }
$branchMerge_209:
	if ($_$_condition_$700) { goto anon1554_Then; } else { goto anon1554_Else; }
$branchMerge_210:
	if ($_$_condition_$661) { goto anon1526_Then; } else { goto anon1526_Else; }
$branchMerge_211:
	if ($_$_condition_$663) { goto anon1527_Then; } else { goto anon1527_Else; }
$branchMerge_212:
	if ($_$_condition_$665) { goto anon1528_Then; } else { goto anon1528_Else; }
$branchMerge_213:
	if ($_$_condition_$667) { goto anon1529_Then; } else { goto anon1529_Else; }
$branchMerge_214:
	if ($_$_condition_$677) { goto anon1538_Then; } else { goto anon1538_Else; }
$branchMerge_215:
	if ($_$_condition_$680) { goto anon1540_Then; } else { goto anon1540_Else; }
$branchMerge_216:
	if ($_$_condition_$683) { goto anon1542_Then; } else { goto anon1542_Else; }
$branchMerge_217:
	if ($_$_condition_$686) { goto anon1544_Then; } else { goto anon1544_Else; }
$branchMerge_218:
	if ($_$_condition_$689) { goto anon1546_Then; } else { goto anon1546_Else; }
$branchMerge_219:
	if ($_$_condition_$692) { goto anon1548_Then; } else { goto anon1548_Else; }
$branchMerge_220:
	if ($_$_condition_$695) { goto anon1550_Then; } else { goto anon1550_Else; }
$branchMerge_221:
	if ($_$_condition_$703) { goto anon1556_Then; } else { goto anon1556_Else; }
$branchMerge_222:
	if ($_$_condition_$710) { goto anon1561_Then; } else { goto anon1561_Else; }
$branchMerge_223:
	if ($_$_condition_$714) { goto anon1821_Then; } else { goto anon1821_Else; }
$branchMerge_224:
	if ($_$_condition_$715) { goto anon1739_Then; } else { goto anon1739_Else; }
$branchMerge_225:
	if ($_$_condition_$717) { goto anon1740_Then; } else { goto anon1740_Else; }
$branchMerge_226:
	if ($_$_condition_$719) { goto anon1741_Then; } else { goto anon1741_Else; }
$branchMerge_227:
	if ($_$_condition_$721) { goto anon1742_Then; } else { goto anon1742_Else; }
$branchMerge_228:
	if ($_$_condition_$731) { goto anon1779_Then; } else { goto anon1779_Else; }
$branchMerge_229:
	if ($_$_condition_$773) { goto anon1781_Then; } else { goto anon1781_Else; }
$branchMerge_230:
	if ($_$_condition_$734) { goto anon1753_Then; } else { goto anon1753_Else; }
$branchMerge_231:
	if ($_$_condition_$736) { goto anon1754_Then; } else { goto anon1754_Else; }
$branchMerge_232:
	if ($_$_condition_$738) { goto anon1755_Then; } else { goto anon1755_Else; }
$branchMerge_233:
	if ($_$_condition_$740) { goto anon1756_Then; } else { goto anon1756_Else; }
$branchMerge_234:
	if ($_$_condition_$750) { goto anon1765_Then; } else { goto anon1765_Else; }
$branchMerge_235:
	if ($_$_condition_$753) { goto anon1767_Then; } else { goto anon1767_Else; }
$branchMerge_236:
	if ($_$_condition_$756) { goto anon1769_Then; } else { goto anon1769_Else; }
$branchMerge_237:
	if ($_$_condition_$759) { goto anon1771_Then; } else { goto anon1771_Else; }
$branchMerge_238:
	if ($_$_condition_$762) { goto anon1773_Then; } else { goto anon1773_Else; }
$branchMerge_239:
	if ($_$_condition_$765) { goto anon1775_Then; } else { goto anon1775_Else; }
$branchMerge_240:
	if ($_$_condition_$768) { goto anon1777_Then; } else { goto anon1777_Else; }
$branchMerge_241:
	if ($_$_condition_$776) { goto anon1783_Then; } else { goto anon1783_Else; }
$branchMerge_242:
	if ($_$_condition_$779) { goto anon1785_Then; } else { goto anon1785_Else; }
$branchMerge_243:
	if ($_$_condition_$782) { goto anon1815_Then; } else { goto anon1815_Else; }
$branchMerge_244:
	if ($_$_condition_$824) { goto anon1817_Then; } else { goto anon1817_Else; }
$branchMerge_245:
	if ($_$_condition_$785) { goto anon1789_Then; } else { goto anon1789_Else; }
$branchMerge_246:
	if ($_$_condition_$787) { goto anon1790_Then; } else { goto anon1790_Else; }
$branchMerge_247:
	if ($_$_condition_$789) { goto anon1791_Then; } else { goto anon1791_Else; }
$branchMerge_248:
	if ($_$_condition_$791) { goto anon1792_Then; } else { goto anon1792_Else; }
$branchMerge_249:
	if ($_$_condition_$801) { goto anon1801_Then; } else { goto anon1801_Else; }
$branchMerge_250:
	if ($_$_condition_$804) { goto anon1803_Then; } else { goto anon1803_Else; }
$branchMerge_251:
	if ($_$_condition_$807) { goto anon1805_Then; } else { goto anon1805_Else; }
$branchMerge_252:
	if ($_$_condition_$810) { goto anon1807_Then; } else { goto anon1807_Else; }
$branchMerge_253:
	if ($_$_condition_$813) { goto anon1809_Then; } else { goto anon1809_Else; }
$branchMerge_254:
	if ($_$_condition_$816) { goto anon1811_Then; } else { goto anon1811_Else; }
$branchMerge_255:
	if ($_$_condition_$819) { goto anon1813_Then; } else { goto anon1813_Else; }
$branchMerge_256:
	if ($_$_condition_$827) { goto anon1819_Then; } else { goto anon1819_Else; }
}
