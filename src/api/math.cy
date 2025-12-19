--| Euler's number and the base of natural logarithms; approximately 2.718.
const e = 2.71828182845904523536028747135266249775724709369995

--| Infinity.
const inf = as[f64] 0x7ff0000000000000

--| Base-10 logarithm of E; approximately 0.434.
const log10e = 0.434294481903251827651128918916605082

--| Base-2 logarithm of E; approximately 1.443.
const log2e = 1.442695040888963407359924681001892137

--| Natural logarithm of 10; approximately 2.303.
const ln10 = 2.302585092994045684017991454684364208

--| Natural logarithm of 2; approximately 0.693.
const ln2 = 0.693147180559945309417232121458176568

--| The maximum integer value that can be safely represented as a f64. 2^53-1 or 9007199254740991.
const maxSafeInt = 9007199254740991.0

--| The minumum integer value that can be safely represented as a f64. -(2^53-1) or -9007199254740991.
const minSafeInt = -9007199254740991.0

--| Not a number. Note that nan == nan.
--| However, if a nan came from an arithmetic operation, the comparison is undefined.
--| Use `isNaN` instead.
const nan = as[f64] 0x7ff8000000000000

--| Negative infinity.
const neginf = as[f64] 0xfff0000000000000

--| Ratio of a circle's circumference to its diameter; approximately 3.14159.
const pi = 3.14159265358979323846264338327950288419716939937510

const pi2 = pi * 2
--| Alias for pi2.
const tau = pi2
const piHalf = pi * 0.5

--| Square root of ½; approximately 0.707.
const sqrt1_2 = 0.707106781186547524400844362104849039

--| Square root of 2; approximately 1.414.
const sqrt2 = 1.414213562373095048801688724209698079

--| Returns the absolute value of x.
#[extern="abs_f32"] fn abs(a f32) -> f32
#[extern="abs_f64"] fn abs(a f64) -> f64
#[extern="abs_i8"] fn abs(a i8) -> i8
#[extern="abs_i16"] fn abs(a i16) -> i16
#[extern="abs_i32"] fn abs(a i32) -> i32
#[extern="abs_i64"] fn abs(a i64) -> i64


--| Returns the arccosine (in radians) of x.
#[extern="acos_f32"] fn acos(a f32) -> f32
#[extern="acos_f64"] fn acos(a f64) -> f64

--| Returns the hyperbolic arccosine of x.
#[extern="acosh_f32"] fn acosh(a f32) -> f32
#[extern="acosh_f64"] fn acosh(a f64) -> f64

--| Returns the arcsine (in radians) of x.
#[extern="asin_f32"] fn asin(a f32) -> f32
#[extern="asin_f64"] fn asin(a f64) -> f64

--| Returns the hyperbolic arcsine of x.
#[extern="asinh_f32"] fn asinh(a f32) -> f32
#[extern="asinh_f64"] fn asinh(a f64) -> f64

--| Returns the arctangent (in radians) of x.
#[extern="atan_f32"] fn atan(a f32) -> f32
#[extern="atan_f64"] fn atan(a f64) -> f64

--| Returns the arctangent (in radians) of the quotient of its arguments (y/x).
#[extern="atan2_f32"] fn atan2(y, x f32) -> f32
#[extern="atan2_f64"] fn atan2(y, x f64) -> f64

--| Returns the hyperbolic arctangent of x.
#[extern="atanh_f32"] fn atanh(a f32) -> f32
#[extern="atanh_f64"] fn atanh(a f64) -> f64

--| Returns the cube root of x.
#[extern="cbrt_f32"] fn cbrt(a f32) -> f32
#[extern="cbrt_f64"] fn cbrt(a f64) -> f64

--| Returns the smallest integer greater than or equal to x.
#[extern="ceil_f32"] fn ceil(a f32) -> f32
#[extern="ceil_f64"] fn ceil(a f64) -> f64

--| Clamps x to the range [min, max].
#[extern="clamp_f32"] fn clamp(x, min, max f32) -> f32
#[extern="clamp_f64"] fn clamp(x, min, max f64) -> f64
#[extern="clamp_u8"] fn clamp(x, min, max r8) -> r8
#[extern="clamp_u16"] fn clamp(x, min, max r16) -> r16
#[extern="clamp_u32"] fn clamp(x, min, max r32) -> r32
#[extern="clamp_u64"] fn clamp(x, min, max r64) -> r64
#[extern="clamp_i8"] fn clamp(x, min, max i8) -> i8
#[extern="clamp_i16"] fn clamp(x, min, max i16) -> i16
#[extern="clamp_i32"] fn clamp(x, min, max i32) -> i32
#[extern="clamp_i64"] fn clamp(x, min, max i64) -> i64

--| Returns the number of leading zero bits in the 32-bit integer representation of x.
#[extern] fn clz32(a f32) -> i32

--| Returns a value with the magnitude of `mag` and the sign of `sign`.
#[extern="copysign_f32"] fn copysign(mag, sign f32) -> f32
#[extern="copysign_f64"] fn copysign(mag, sign f64) -> f64

--| Returns the cosine of x (x is in radians).
#[extern="cos_f32"] fn cos(x f32) -> f32
#[extern="cos_f64"] fn cos(x f64) -> f64

--| Returns the hyperbolic cosine of x.
#[extern="cosh_f32"] fn cosh(a f32) -> f32
#[extern="cosh_f64"] fn cosh(a f64) -> f64

--| Converts degrees to radians. Accepts and returns f32.
#[extern="deg_to_rad_f32"] fn degToRad(deg f32) -> f32
#[extern="deg_to_rad_f64"] fn degToRad(deg f64) -> f64

--| Returns e raised to the power of x (e^x).
#[extern="exp_f32"] fn exp(a f32) -> f32
#[extern="exp_f64"] fn exp(a f64) -> f64

--| Returns exp(x) - 1 with increased precision for small x.
#[extern="expm1_f32"] fn expm1(a f32) -> f32
#[extern="expm1_f64"] fn expm1(a f64) -> f64

--| Returns the largest integer less than or equal to x.
#[extern="floor_f32"] fn floor(a f32) -> f32
#[extern="floor_f64"] fn floor(a f64) -> f64

--| Returns the fractional part of x.
#[extern="frac_f32"] fn frac(a f32) -> f32
#[extern="frac_f64"] fn frac(a f64) -> f64

--| Returns sqrt(a*a + b*b) — the square root of the sum of squares of its arguments.
#[extern="hypot_f32"] fn hypot(a f32, b f32) -> f32
#[extern="hypot_f64"] fn hypot(a f64, b f64) -> f64

--| Returns true if a is infinite.
#[extern="is_inf_f32"] fn isInf(a f32) -> bool
#[extern="is_inf_f64"] fn isInf(a f64) -> bool

--| Returns true if the f64 has no fractional part (is an integer value).
#[extern="is_inf_f32"] fn isInt(a f32) -> bool
#[extern="is_inf_f64"] fn isInt(a f64) -> bool

--| Returns true if x is not a number (NaN).
#[extern="is_nan_f32"] fn isNaN(a f32) -> bool
#[extern="is_nan_f64"] fn isNaN(a f64) -> bool

--| Linear interpolation between `low` and `high` by parameter `t` (0..1).
#[extern="lerp_f32"] fn lerp(low, high, t f32) -> f32
#[extern="lerp_f64"] fn lerp(low, high, t f64) -> f64
#[extern="lerp_vec2"] fn lerp(low, high Vector2, t f32) -> Vector2
#[extern="lerp_vec3"] fn lerp(low, high Vector3, t f32) -> Vector3
#[extern="lerp_vec4"] fn lerp(low, high Vector4, t f32) -> Vector4
#[extern="lerp_quat"] fn lerp(low, high Quaternion, t f32) -> Quaternion

--| Returns the natural logarithm (base e) of x.
#[extern="ln_f32"] fn ln(a f32) -> f32
#[extern="ln_f64"] fn ln(a f64) -> f64

--| Returns the logarithm of `y` with base `x`.
#[extern="log_f32"] fn log(x, y f32) -> f32
#[extern="log_f64"] fn log(x, y f64) -> f64

--| Returns the base-10 logarithm of x.
#[extern="log10_f32"] fn log10(a f32) -> f32
#[extern="log10_f64"] fn log10(a f64) -> f64

--| Returns the natural logarithm of 1 + x with increased precision for small x.
#[extern="log1p_f32"] fn log1p(a f32) -> f32
#[extern="log1p_f64"] fn log1p(a f64) -> f64

--| Returns the base-2 logarithm of x.
#[extern="log2_f32"] fn log2(a f32) -> f32
#[extern="log2_f64"] fn log2(a f64) -> f64

--| Returns the larger of two values.
#[extern="max_f32"] fn max(a, b f32) -> f32
#[extern="max_f64"] fn max(a, b f64) -> f64
#[extern="max_i8"] fn max(a, b i8) -> i8
#[extern="max_i16"] fn max(a, b i16) -> i16
#[extern="max_i32"] fn max(a, b i32) -> i32
#[extern="max_i64"] fn max(a, b i64) -> i64
#[extern="max_u8"] fn max(a, b r8) -> r8
#[extern="max_u16"] fn max(a, b r16) -> r16
#[extern="max_u32"] fn max(a, b r32) -> r32
#[extern="max_u64"] fn max(a, b r64) -> r64
#[extern="max_vec2"] fn max(a, b Vector2) -> Vector2
#[extern="max_vec3"] fn max(a, b Vector3) -> Vector3
#[extern="max_vec4"] fn max(a, b Vector4) -> Vector4

--| Returns the smaller of two values.
#[extern="min_f32"] fn min(a, b f32) -> f32
#[extern="min_f64"] fn min(a, b f64) -> f64
#[extern="min_i8"] fn min(a, b i8) -> i8
#[extern="min_i16"] fn min(a, b i16) -> i16
#[extern="min_i32"] fn min(a, b i32) -> i32
#[extern="min_i64"] fn min(a, b i64) -> i64
#[extern="min_u8"] fn min(a, b r8) -> r8
#[extern="min_u16"] fn min(a, b r16) -> r16
#[extern="min_u32"] fn min(a, b r32) -> r32
#[extern="min_u64"] fn min(a, b r64) -> r64
#[extern="min_vec2"] fn min(a, b Vector2) -> Vector2
#[extern="min_vec3"] fn min(a, b Vector3) -> Vector3
#[extern="min_vec4"] fn min(a, b Vector4) -> Vector4

--| Performs 32-bit integer multiplication semantics on the f64 inputs (integer overflow allowed).
#[extern] fn mul32(a, b f32) -> f32

--| Returns x raised to the power y (x^y).
#[extern="pow_f32"] fn pow(x, y f32) -> f32
#[extern="pow_f64"] fn pow(x, y f64) -> f64

--| Returns a pseudo-random number between 0 (inclusive) and 1 (exclusive).
#[extern] fn random() -> f64
#[extern] fn rand_int(min i32, max i32) -> i32
fn rand_choice(arr [%N]%T) -> T:
	-- TODO: Compile time check for slice
	idx := rand_int(0, N - 1)
	return arr[idx]

--| Remap `value` from the input range [low1, high1] to the output range [low2, high2].
#[extern="remap_f32"] fn remap(value, low1, high1, low2, high2 f32) -> f32
#[extern="remap_f64"] fn remap(value, low1, high1, low2, high2 f64) -> f64
#[extern="remap_vec2"] fn remap(value, low1, high1, low2, high2 Vector2) -> Vector2
#[extern="remap_vec3"] fn remap(value, low1, high1, low2, high2 Vector3) -> Vector3
#[extern="remap_vec4"] fn remap(value, low1, high1, low2, high2 Vector4) -> Vector4

--| Returns the value of x rounded to the nearest integer.
#[extern="round_f32"] fn round(a f32) -> f32
#[extern="round_f64"] fn round(a f64) -> f64

--| Rounds x down to the nearest integer.
#[extern="round_to_int_f32"] fn roundToInt(a f32) -> f32
#[extern="round_to_int_f64"] fn roundToInt(a f64) -> f64

--| Returns the sign of x: positive, negative or zero.
#[extern="sign_f32"] fn sign(a f32) -> f32
#[extern="sign_f64"] fn sign(a f64) -> f64
#[extern="sign_i8"] fn sign(a i8) -> i8
#[extern="sign_i16"] fn sign(a i16) -> i16
#[extern="sign_i32"] fn sign(a i32) -> i32
#[extern="sign_i64"] fn sign(a i64) -> i64

--| Returns the sine of x (x is in radians).
#[extern="sin_f32"] fn sin(x f32) -> f32
#[extern="sin_f64"] fn sin(x f64) -> f64

--| Returns the hyperbolic sine of x.
#[extern="sinh_f32"] fn sinh(a f32) -> f32
#[extern="sinh_f64"] fn sinh(a f64) -> f64

--| Returns the positive square root of x.
#[extern="sqrt_f32"] fn sqrt(a f32) -> f32
#[extern="sqrt_f64"] fn sqrt(a f64) -> f64

--| Returns the tangent of x (x is in radians).
#[extern="tan_f32"] fn tan(x f32) -> f32
#[extern="tan_f64"] fn tan(x f64) -> f64

--| Returns the hyperbolic tangent of x.
#[extern="tanh_f32"] fn tanh(a f32) -> f32
#[extern="tanh_f64"] fn tanh(a f64) -> f64

--| Returns the integer portion of x, removing any fractional digits.
#[extern="trunc_f32"] fn trunc(a f32) -> f32
#[extern="trunc_f64"] fn trunc(a f64) -> f64

-- Matrix

type Matrix4[T Any]:
	-internal [16]T

#[extern="mat4f32_mul"] -fn mat4f32_mul(a Matrix4[f32], b Matrix4[f32]) -> Matrix4[f32]
#[extern="mat4f64_mul"] -fn mat4f64_mul(a Matrix4[f64], b Matrix4[f64]) -> Matrix4[f64]
#[extern="mat4u8_mul"] -fn mat4u8_mul(a Matrix4[r8], b Matrix4[r8]) -> Matrix4[r8]
#[extern="mat4u16_mul"] -fn mat4u16_mul(a Matrix4[r16], b Matrix4[r16]) -> Matrix4[r16]
#[extern="mat4u32_mul"] -fn mat4u32_mul(a Matrix4[r32], b Matrix4[r32]) -> Matrix4[r32]
#[extern="mat4u64_mul"] -fn mat4u64_mul(a Matrix4[r64], b Matrix4[r64]) -> Matrix4[r64]
#[extern="mat4i8_mul"] -fn mat4i8_mul(a Matrix4[i8], b Matrix4[i8]) -> Matrix4[i8]
#[extern="mat4i16_mul"] -fn mat4i16_mul(a Matrix4[i16], b Matrix4[i16]) -> Matrix4[i16]
#[extern="mat4i32_mul"] -fn mat4i32_mul(a Matrix4[i32], b Matrix4[i32]) -> Matrix4[i32]
#[extern="mat4i64_mul"] -fn mat4i64_mul(a Matrix4[i64], b Matrix4[i64]) -> Matrix4[i64]

fn Matrix4[] :: @init(elements [16]T) -> Self:
	return {
		internal = elements
	}

fn Matrix4[] :: identity() -> Self:
	return Self({
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1
	})

fn Matrix4[] :: zero() -> Self:
	return {
		internal = [16]T{}
	}

fn (&Matrix4[]) @get(row, col int) -> T:
	return self.internal[row * 4 + col]

fn (&Matrix4[]) @set(row, col int, value T):
	self.internal[row * 4 + col] = value

fn (Matrix4[]) `*` (other Self) -> Self:
	#switch T:
		#case f32:
			return mat4f32_mul(self, other)
		#case f64:
			return mat4f64_mul(self, other)
		#case r8:
			return mat4u8_mul(self, other)
		#case r16:
			return mat4u16_mul(self, other)
		#case r32:
			return mat4u32_mul(self, other)
		#case r64:
			return mat4u64_mul(self, other)
		#case i8:
			return mat4i8_mul(self, other)
		#case i16:
			return mat4i16_mul(self, other)
		#case i32:
			return mat4i32_mul(self, other)
		#case i64:
			return mat4i64_mul(self, other)
		#else:
			return mat4_cyber_mul(self, other)

-fn mat4_cyber_mul[T Any](a, b Matrix4[T]) -> Matrix4[T]:
	stride := 4
	r0 := 0 * stride
	r1 := 1 * stride
	r2 := 2 * stride
	r3 := 3 * stride
	a00 := b.internal[r0 + 0]
	a01 := b.internal[r0 + 1]
	a02 := b.internal[r0 + 2]
	a03 := b.internal[r0 + 3]
	a10 := b.internal[r1 + 0]
	a11 := b.internal[r1 + 1]
	a12 := b.internal[r1 + 2]
	a13 := b.internal[r1 + 3]
	a20 := b.internal[r2 + 0]
	a21 := b.internal[r2 + 1]
	a22 := b.internal[r2 + 2]
	a23 := b.internal[r2 + 3]
	a30 := b.internal[r3 + 0]
	a31 := b.internal[r3 + 1]
	a32 := b.internal[r3 + 2]
	a33 := b.internal[r3 + 3]
	b00 := a.internal[r0 + 0]
	b01 := a.internal[r0 + 1]
	b02 := a.internal[r0 + 2]
	b03 := a.internal[r0 + 3]
	b10 := a.internal[r1 + 0]
	b11 := a.internal[r1 + 1]
	b12 := a.internal[r1 + 2]
	b13 := a.internal[r1 + 3]
	b20 := a.internal[r2 + 0]
	b21 := a.internal[r2 + 1]
	b22 := a.internal[r2 + 2]
	b23 := a.internal[r2 + 3]
	b30 := a.internal[r3 + 0]
	b31 := a.internal[r3 + 1]
	b32 := a.internal[r3 + 2]
	b33 := a.internal[r3 + 3]
	return Self({
		-- First row.
		a00 * b00 + a01 * b10 + a02 * b20 + a03 * b30,
		a00 * b01 + a01 * b11 + a02 * b21 + a03 * b31,
		a00 * b02 + a01 * b12 + a02 * b22 + a03 * b32,
		a00 * b03 + a01 * b13 + a02 * b23 + a03 * b33,

		a10 * b00 + a11 * b10 + a12 * b20 + a13 * b30,
		a10 * b01 + a11 * b11 + a12 * b21 + a13 * b31,
		a10 * b02 + a11 * b12 + a12 * b22 + a13 * b32,
		a10 * b03 + a11 * b13 + a12 * b23 + a13 * b33,

		a20 * b00 + a21 * b10 + a22 * b20 + a23 * b30,
		a20 * b01 + a21 * b11 + a22 * b21 + a23 * b31,
		a20 * b02 + a21 * b12 + a22 * b22 + a23 * b32,
		a20 * b03 + a21 * b13 + a22 * b23 + a23 * b33,

		a30 * b00 + a31 * b10 + a32 * b20 + a33 * b30,
		a30 * b01 + a31 * b11 + a32 * b21 + a33 * b31,
		a30 * b02 + a31 * b12 + a32 * b22 + a33 * b32,
		a30 * b03 + a31 * b13 + a32 * b23 + a33 * b33,
	})

type Matrix3[T Any]:
	-internal [9]T

#[extern="mat3f32_mul"] -fn mat3f32_mul(a Matrix3[f32], b Matrix3[f32]) -> Matrix3[f32]
#[extern="mat3f64_mul"] -fn mat3f64_mul(a Matrix3[f64], b Matrix3[f64]) -> Matrix3[f64]
#[extern="mat3u8_mul"] -fn mat3u8_mul(a Matrix3[r8], b Matrix3[r8]) -> Matrix3[r8]
#[extern="mat3u16_mul"] -fn mat3u16_mul(a Matrix3[r16], b Matrix3[r16]) -> Matrix3[r16]
#[extern="mat3u32_mul"] -fn mat3u32_mul(a Matrix3[r32], b Matrix3[r32]) -> Matrix3[r32]
#[extern="mat3u64_mul"] -fn mat3u64_mul(a Matrix3[r64], b Matrix3[r64]) -> Matrix3[r64]
#[extern="mat3i8_mul"] -fn mat3i8_mul(a Matrix3[i8], b Matrix3[i8]) -> Matrix3[i8]
#[extern="mat3i16_mul"] -fn mat3i16_mul(a Matrix3[i16], b Matrix3[i16]) -> Matrix3[i16]
#[extern="mat3i32_mul"] -fn mat3i32_mul(a Matrix3[i32], b Matrix3[i32]) -> Matrix3[i32]
#[extern="mat3i64_mul"] -fn mat3i64_mul(a Matrix3[i64], b Matrix3[i64]) -> Matrix3[i64]

fn Matrix3[] :: @init(elements [9]T) -> Self:
	return {
		internal = elements
	}

fn Matrix3[] :: identity() -> Self:
	return ({
		1, 0, 0,
		0, 1, 0,
		0, 0, 1,
	})

fn Matrix3[] :: zero() -> Self:
	return {
		internal = [9]T{}
	}

fn (&Matrix3[]) @get(row, col int) -> T:
	return self.internal[row * 3 + col]

fn (&Matrix3[]) @set(row, col int, value T):
	self.internal[row * 3 + col] = value

fn (Matrix3[]) `*` (other Self) -> Self:
	#switch T:
		#case f32:
			return mat3f32_mul(self, other)
		#case f64:
			return mat3f64_mul(self, other)
		#case r8:
			return mat3u8_mul(self, other)
		#case r16:
			return mat3u16_mul(self, other)
		#case r32:
			return mat3u32_mul(self, other)
		#case r64:
			return mat3u64_mul(self, other)
		#case i8:
			return mat3i8_mul(self, other)
		#case i16:
			return mat3i16_mul(self, other)
		#case i32:
			return mat3i32_mul(self, other)
		#case i64:
			return mat3i64_mul(self, other)
		#else:
			return mat3_cyber_mul(self, other)

-fn mat3_cyber_mul[T Any](a, b Matrix3[T]) -> Matrix3[T]:
	stride := 3
	r0 := 0 * stride
	r1 := 1 * stride
	r2 := 2 * stride
	a00 := b.internal[r0 + 0]
	a01 := b.internal[r0 + 1]
	a02 := b.internal[r0 + 2]
	a10 := b.internal[r1 + 0]
	a11 := b.internal[r1 + 1]
	a12 := b.internal[r1 + 2]
	a20 := b.internal[r2 + 0]
	a21 := b.internal[r2 + 1]
	a22 := b.internal[r2 + 2]
	b00 := a.internal[r0 + 0]
	b01 := a.internal[r0 + 1]
	b02 := a.internal[r0 + 2]
	b10 := a.internal[r1 + 0]
	b11 := a.internal[r1 + 1]
	b12 := a.internal[r1 + 2]
	b20 := a.internal[r2 + 0]
	b21 := a.internal[r2 + 1]
	b22 := a.internal[r2 + 2]
	return Self({
		-- First row.
		a00 * b00 + a01 * b10 + a02 * b20,
		a00 * b01 + a01 * b11 + a02 * b21,
		a00 * b02 + a01 * b12 + a02 * b22,

		a10 * b00 + a11 * b10 + a12 * b20,
		a10 * b01 + a11 * b11 + a12 * b21,
		a10 * b02 + a11 * b12 + a12 * b22,

		a20 * b00 + a21 * b10 + a22 * b20,
		a20 * b01 + a21 * b11 + a22 * b21,
		a20 * b02 + a21 * b12 + a22 * b22,
	})

type Matrix2[T Any]:
	-internal [4]T

#[extern="mat2f32_mul"] -fn mat2f32_mul(a Matrix2[f32], b Matrix2[f32]) -> Matrix2[f32]
#[extern="mat2f64_mul"] -fn mat2f64_mul(a Matrix2[f64], b Matrix2[f64]) -> Matrix2[f64]
#[extern="mat2u8_mul"] -fn mat2u8_mul(a Matrix2[r8], b Matrix2[r8]) -> Matrix2[r8]
#[extern="mat2u16_mul"] -fn mat2u16_mul(a Matrix2[r16], b Matrix2[r16]) -> Matrix2[r16]
#[extern="mat2u32_mul"] -fn mat2u32_mul(a Matrix2[r32], b Matrix2[r32]) -> Matrix2[r32]
#[extern="mat2u64_mul"] -fn mat2u64_mul(a Matrix2[r64], b Matrix2[r64]) -> Matrix2[r64]
#[extern="mat2i8_mul"] -fn mat2i8_mul(a Matrix2[i8], b Matrix2[i8]) -> Matrix2[i8]
#[extern="mat2i16_mul"] -fn mat2i16_mul(a Matrix2[i16], b Matrix2[i16]) -> Matrix2[i16]
#[extern="mat2i32_mul"] -fn mat2i32_mul(a Matrix2[i32], b Matrix2[i32]) -> Matrix2[i32]
#[extern="mat2i64_mul"] -fn mat2i64_mul(a Matrix2[i64], b Matrix2[i64]) -> Matrix2[i64]

fn Matrix2[] :: @init(elements [4]T) -> Self:
	return {
		internal = elements
	}

fn Matrix2[] :: identity() -> Self:
	return Self({
		1, 0,
		0, 1,
	})

fn Matrix2[] :: zero() -> Self:
	return {
		internal = [4]T{}
	}

fn (&Matrix2[]) @get(row, col int) -> T:
	return self.internal[row * 2 + col]

fn (&Matrix2[]) @set(row, col int, value T):
	self.internal[row * 2 + col] = value

fn (Matrix2[]) `*` (other Self) -> Matrix2[T]:
	#switch T:
		#case f32:
			return mat2f32_mul(self, other)
		#case f64:
			return mat2f64_mul(self, other)
		#case r8:
			return mat2u8_mul(self, other)
		#case r16:
			return mat2u16_mul(self, other)
		#case r32:
			return mat2u32_mul(self, other)
		#case r64:
			return mat2u64_mul(self, other)
		#case i8:
			return mat2i8_mul(self, other)
		#case i16:
			return mat2i16_mul(self, other)
		#case i32:
			return mat2i32_mul(self, other)
		#case i64:
			return mat2i64_mul(self, other)
		#else:
			return mat2_cyber_mul(self, other)

-fn mat2_cyber_mul[T Any](a, b Matrix2[T]) -> Matrix2[T]:
	stride := 2
	r0 := 0 * stride
	r1 := 1 * stride
	a00 := b.internal[r0 + 0]
	a01 := b.internal[r0 + 1]
	a10 := b.internal[r1 + 0]
	a11 := b.internal[r1 + 1]
	b00 := a.internal[r0 + 0]
	b01 := a.internal[r0 + 1]
	b10 := a.internal[r1 + 0]
	b11 := a.internal[r1 + 1]
	return Matrix2[T]({
		-- First row.
		a00 * b00 + a01 * b10,
		a00 * b01 + a01 * b11,

		a10 * b00 + a11 * b10,
		a10 * b01 + a11 * b11,
	})

-- Vector

-type Vector[T Any, const N len]:
	internal [len]T

-fn axis_to_index(a str) -> ?int:
	switch a:
		case 'x', 'r':
			return 0
		case 'y', 'g':
			return 1
		case 'z', 'b':
			return 2
		case 'w', 'a':
			return 3
		case '0':
			return -1
		else:
			return none

-fn vector_get_type(T type, swizzle_len int) -> type:
	if swizzle_len == 1:
		return T
	else:
		return [swizzle_len]T

fn (Vector[]) @get(%swizzle string) -> vector_get_type(f32, swizzle.len()):
	#if N == 1:
		idx := axis_to_index(swizzle[0])
		#if a |idx|:
			#if a == -1:
				return T{}
			#else:
				return self.internal[a]
		#else:
			meta.error("Unsupported swizzle #{swizzle}")
	#else:
		res := [swizzle.len()]T{}
		#for 0..swizzle.len() |i|:
			idx := axis_to_index(swizzle[i])
			#if a |idx|:
				#if a == -1:
					res[i] = T{}
				#else:
					res[i] = self.internal[a]
			#else:
				meta.error("Unsupported swizzle #{swizzle[i]}")
		return res

fn (Vector[]) @set(%swizzle string, value vector_get_type(f32, swizzle.len())):
	#if N == 1:
		idx := axis_to_index(swizzle[0])
		#if a |idx|:
			#if a == -1:
				meta.error("Cannot set a zero axis in a vector")
			#else:
				internal[a] = value
		#else:
			meta.error("Unsupported swizzle #{swizzle}")
	#else:
		#for 0..swizzle.len() |i|:
			idx := axis_to_index(swizzle[i])
			#if a |idx|:
				#if a == -1:
					meta.error("Cannot set a zero axis in a vector")
				#else:
					internal[a] = value[i]
			#else:
				meta.error("Unsupported swizzle #{swizzle[i]}")

type Vector4:
	-internal [4]f32
#[bind="vec4_add_f32"] fn (&Vector4) `+` (scale f32) -> Self
#[bind="vec4_add_vec4"] fn (&Vector4) `+` (other Vector4) -> Self
#[bind="vec4_sub_f32"] fn (&Vector4) `-` (scale f32) -> Self
#[bind="vec4_sub_vec4"] fn (&Vector4) `-` (other Vector4) -> Self
#[bind="vec4_mul_f32"] fn (&Vector4) `*` (scale f32) -> Self
#[bind="vec4_mul_vec4"] fn (&Vector4) `*` (other Vector4) -> Self
#[bind="vec4_div_f32"] fn (&Vector4) `/` (scale f32) -> Self
#[bind="vec4_div_vec4"] fn (&Vector4) `/` (other Vector4) -> Self
#[bind="vec4_neg"] fn (&Vector4) `-` () -> Self
fn Vector4 :: @init(x, y, z, w f32) -> Self:
	return {
		internal = {x, y, z, w}
	}
fn Vector4 :: zero() -> Self:
	return {
		internal = {0.0, 0.0, 0.0, 0.0}
	}

type Vector3:
	-intenral [3]f32
#[bind="vec3_add_f32"] fn (&Vector3) `+` (scale f32) -> Self
#[bind="vec3_add_vec3"] fn (&Vector3) `+` (other Vector3) -> Self
#[bind="vec3_sub_f32"] fn (&Vector3) `-` (scale f32) -> Self
#[bind="vec3_sub_vec3"] fn (&Vector3) `-` (other Vector3) -> Self
#[bind="vec3_mul_f32"] fn (&Vector3) `*` (scale f32) -> Self
#[bind="vec3_mul_vec3"] fn (&Vector3) `*` (other Vector3) -> Self
#[bind="vec3_div_f32"] fn (&Vector3) `/` (scale f32) -> Self
#[bind="vec3_div_vec3"] fn (&Vector3) `/` (other Vector3) -> Self
#[bind="vec3_neg"] fn (&Vector3) `-` () -> Self
fn Vector3 :: @init(x, y, z f32) -> Self:
	return {
		internal = {x, y, z}
	}
fn Vector3 :: zero() -> Self:
	return {
		internal = {0.0, 0.0, 0.0}
	}

type Vector2:
	-internal [2]f32
#[bind="vec2_add_f32"] fn (&Vector2) `+` (scale f32) -> Self
#[bind="vec2_add_vec2"] fn (&Vector2) `+` (other Vector2) -> Self
#[bind="vec2_sub_f32"] fn (&Vector2) `-` (scale f32) -> Self
#[bind="vec2_sub_vec2"] fn (&Vector2) `-` (other Vector2) -> Self
#[bind="vec2_mul_f32"] fn (&Vector2) `*` (scale f32) -> Self
#[bind="vec2_mul_vec2"] fn (&Vector2) `*` (other Vector2) -> Self
#[bind="vec2_div_f32"] fn (&Vector2) `/` (scale f32) -> Self
#[bind="vec2_div_vec2"] fn (&Vector2) `/` (other Vector2) -> Self
#[bind="vec2_neg"] fn (&Vector2) `-` () -> Self
fn Vector2 :: @init(x, y f32) -> Self:
	return {
		internal = {x, y}
	}
fn Vector2 :: zero() -> Self:
	return {
		internal = {0.0, 0.0}
	}

-- Quaternion

type Quaternion:
	-internal [4]f32
