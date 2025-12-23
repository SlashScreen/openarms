use meta

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
#[bind='abs_f32'] fn abs(a f32) -> f32
#[bind='abs_f64'] fn abs(a f64) -> f64
#[bind='abs_i8'] fn abs(a i8) -> i8
#[bind='abs_i16'] fn abs(a i16) -> i16
#[bind='abs_i32'] fn abs(a i32) -> i32
#[bind='abs_i64'] fn abs(a i64) -> i64


--| Returns the arccosine (in radians) of x.
#[bind='acos_f32'] fn acos(a f32) -> f32
#[bind='acos_f64'] fn acos(a f64) -> f64

--| Returns the hyperbolic arccosine of x.
#[bind='acosh_f32'] fn acosh(a f32) -> f32
#[bind='acosh_f64'] fn acosh(a f64) -> f64

--| Returns the arcsine (in radians) of x.
#[bind='asin_f32'] fn asin(a f32) -> f32
#[bind='asin_f64'] fn asin(a f64) -> f64

--| Returns the hyperbolic arcsine of x.
#[bind='asinh_f32'] fn asinh(a f32) -> f32
#[bind='asinh_f64'] fn asinh(a f64) -> f64

--| Returns the arctangent (in radians) of x.
#[bind='atan_f32'] fn atan(a f32) -> f32
#[bind='atan_f64'] fn atan(a f64) -> f64

--| Returns the arctangent (in radians) of the quotient of its arguments (y/x).
#[bind='atan2_f32'] fn atan2(y, x f32) -> f32
#[bind='atan2_f64'] fn atan2(y, x f64) -> f64

--| Returns the hyperbolic arctangent of x.
#[bind='atanh_f32'] fn atanh(a f32) -> f32
#[bind='atanh_f64'] fn atanh(a f64) -> f64

--| Returns the cube root of x.
#[bind='cbrt_f32'] fn cbrt(a f32) -> f32
#[bind='cbrt_f64'] fn cbrt(a f64) -> f64

--| Returns the smallest integer greater than or equal to x.
#[bind='ceil_f32'] fn ceil(a f32) -> f32
#[bind='ceil_f64'] fn ceil(a f64) -> f64

--| Clamps x to the range [min, max].
#[bind='clamp_f32'] fn clamp(x, min, max f32) -> f32
#[bind='clamp_f64'] fn clamp(x, min, max f64) -> f64
#[bind='clamp_u8'] fn clamp(x, min, max r8) -> r8
#[bind='clamp_u16'] fn clamp(x, min, max r16) -> r16
#[bind='clamp_u32'] fn clamp(x, min, max r32) -> r32
#[bind='clamp_u64'] fn clamp(x, min, max r64) -> r64
#[bind='clamp_i8'] fn clamp(x, min, max i8) -> i8
#[bind='clamp_i16'] fn clamp(x, min, max i16) -> i16
#[bind='clamp_i32'] fn clamp(x, min, max i32) -> i32
#[bind='clamp_i64'] fn clamp(x, min, max i64) -> i64

--| Returns the number of leading zero bits in the 32-bit integer representation of x.
#[bind='clz_f32'] fn clz32(a f32) -> i32

--| Returns a value with the magnitude of `mag` and the sign of `sign`.
#[bind='copysign_f32'] fn copysign(mag, sign f32) -> f32
#[bind='copysign_f64'] fn copysign(mag, sign f64) -> f64

--| Returns the cosine of x (x is in radians).
#[bind='cos_f32'] fn cos(x f32) -> f32
#[bind='cos_f64'] fn cos(x f64) -> f64

--| Returns the hyperbolic cosine of x.
#[bind='cosh_f32'] fn cosh(a f32) -> f32
#[bind='cosh_f64'] fn cosh(a f64) -> f64

--| Converts degrees to radians. Accepts and returns f32.
#[bind='deg_to_rad_f32'] fn degToRad(deg f32) -> f32
#[bind='deg_to_rad_f64'] fn degToRad(deg f64) -> f64

--| Returns e raised to the power of x (e^x).
#[bind='exp_f32'] fn exp(a f32) -> f32
#[bind='exp_f64'] fn exp(a f64) -> f64

--| Returns exp(x) - 1 with increased precision for small x.
#[bind='expm1_f32'] fn expm1(a f32) -> f32
#[bind='expm1_f64'] fn expm1(a f64) -> f64

--| Returns the largest integer less than or equal to x.
#[bind='floor_f32'] fn floor(a f32) -> f32
#[bind='floor_f64'] fn floor(a f64) -> f64

--| Returns the fractional part of x.
#[bind='frac_f32'] fn frac(a f32) -> f32
#[bind='frac_f64'] fn frac(a f64) -> f64

--| Returns sqrt(a*a + b*b) — the square root of the sum of squares of its arguments.
#[bind='hypot_f32'] fn hypot(a f32, b f32) -> f32
#[bind='hypot_f64'] fn hypot(a f64, b f64) -> f64

--| Returns true if a is infinite.
#[bind='is_inf_f32'] fn isInf(a f32) -> bool
#[bind='is_inf_f64'] fn isInf(a f64) -> bool

--| Returns true if the f64 has no fractional part (is an integer value).
#[bind='is_inf_f32'] fn isInt(a f32) -> bool
#[bind='is_inf_f64'] fn isInt(a f64) -> bool

--| Returns true if x is not a number (NaN).
#[bind='is_nan_f32'] fn isNaN(a f32) -> bool
#[bind='is_nan_f64'] fn isNaN(a f64) -> bool

--| Linear interpolation between `low` and `high` by parameter `t` (0..1).
#[bind='lerp_f32'] fn lerp(low, high, t f32) -> f32
#[bind='lerp_f64'] fn lerp(low, high, t f64) -> f64
#[bind='lerp_vec2'] fn lerp(low, high Vector2, t f32) -> Vector2
#[bind='lerp_vec3'] fn lerp(low, high Vector3, t f32) -> Vector3
#[bind='lerp_vec4'] fn lerp(low, high Vector4, t f32) -> Vector4
#[bind='lerp_quat'] fn lerp(low, high Quaternion, t f32) -> Quaternion

--| Returns the natural logarithm (base e) of x.
#[bind='ln_f32'] fn ln(a f32) -> f32
#[bind='ln_f64'] fn ln(a f64) -> f64

--| Returns the logarithm of `y` with base `x`.
#[bind='log_f32'] fn log(x, y f32) -> f32
#[bind='log_f64'] fn log(x, y f64) -> f64

--| Returns the base-10 logarithm of x.
#[bind='log10_f32'] fn log10(a f32) -> f32
#[bind='log10_f64'] fn log10(a f64) -> f64

--| Returns the natural logarithm of 1 + x with increased precision for small x.
#[bind='log1p_f32'] fn log1p(a f32) -> f32
#[bind='log1p_f64'] fn log1p(a f64) -> f64

--| Returns the base-2 logarithm of x.
#[bind='log2_f32'] fn log2(a f32) -> f32
#[bind='log2_f64'] fn log2(a f64) -> f64

--| Returns the larger of two values.
#[bind='max_f32'] fn max(a, b f32) -> f32
#[bind='max_f64'] fn max(a, b f64) -> f64
#[bind='max_i8'] fn max(a, b i8) -> i8
#[bind='max_i16'] fn max(a, b i16) -> i16
#[bind='max_i32'] fn max(a, b i32) -> i32
#[bind='max_i64'] fn max(a, b i64) -> i64
#[bind='max_u8'] fn max(a, b r8) -> r8
#[bind='max_u16'] fn max(a, b r16) -> r16
#[bind='max_u32'] fn max(a, b r32) -> r32
#[bind='max_u64'] fn max(a, b r64) -> r64
#[bind='max_vec2'] fn max(a, b Vector2) -> Vector2
#[bind='max_vec3'] fn max(a, b Vector3) -> Vector3
#[bind='max_vec4'] fn max(a, b Vector4) -> Vector4

--| Returns the smaller of two values.
#[bind='min_f32'] fn min(a, b f32) -> f32
#[bind='min_f64'] fn min(a, b f64) -> f64
#[bind='min_i8'] fn min(a, b i8) -> i8
#[bind='min_i16'] fn min(a, b i16) -> i16
#[bind='min_i32'] fn min(a, b i32) -> i32
#[bind='min_i64'] fn min(a, b i64) -> i64
#[bind='min_u8'] fn min(a, b r8) -> r8
#[bind='min_u16'] fn min(a, b r16) -> r16
#[bind='min_u32'] fn min(a, b r32) -> r32
#[bind='min_u64'] fn min(a, b r64) -> r64
#[bind='min_vec2'] fn min(a, b Vector2) -> Vector2
#[bind='min_vec3'] fn min(a, b Vector3) -> Vector3
#[bind='min_vec4'] fn min(a, b Vector4) -> Vector4

--| Performs 32-bit integer multiplication semantics on the f64 inputs (integer overflow allowed).
#[bind='mul_f32'] fn mul32(a, b f32) -> f32

--| Returns x raised to the power y (x^y).
#[bind='pow_f32'] fn pow(x, y f32) -> f32
#[bind='pow_f64'] fn pow(x, y f64) -> f64

--| Returns a pseudo-random number between 0 (inclusive) and 1 (exclusive).
#[bind='random'] fn random() -> f64
#[bind='randint'] fn rand_int(min i32, max i32) -> i32
fn rand_choice(arr [%N]%T) -> T:
	-- TODO: Compile time check for slice
	idx := rand_int(0, N - 1)
	return arr[idx]

--| Remap `value` from the input range [low1, high1] to the output range [low2, high2].
#[bind='remap_f32'] fn remap(value, low1, high1, low2, high2 f32) -> f32
#[bind='remap_f64'] fn remap(value, low1, high1, low2, high2 f64) -> f64
#[bind='remap_vec2'] fn remap(value, low1, high1, low2, high2 Vector2) -> Vector2
#[bind='remap_vec3'] fn remap(value, low1, high1, low2, high2 Vector3) -> Vector3
#[bind='remap_vec4'] fn remap(value, low1, high1, low2, high2 Vector4) -> Vector4

--| Returns the value of x rounded to the nearest integer.
#[bind='round_f32'] fn round(a f32) -> f32
#[bind='round_f64'] fn round(a f64) -> f64

--| Rounds x down to the nearest integer.
#[bind='round_to_int_f32'] fn roundToInt(a f32) -> f32
#[bind='round_to_int_f64'] fn roundToInt(a f64) -> f64

--| Returns the sign of x: positive, negative or zero.
#[bind='sign_f32'] fn sign(a f32) -> f32
#[bind='sign_f64'] fn sign(a f64) -> f64
#[bind='sign_i8'] fn sign(a i8) -> i8
#[bind='sign_i16'] fn sign(a i16) -> i16
#[bind='sign_i32'] fn sign(a i32) -> i32
#[bind='sign_i64'] fn sign(a i64) -> i64

--| Returns the sine of x (x is in radians).
#[bind='sin_f32'] fn sin(x f32) -> f32
#[bind='sin_f64'] fn sin(x f64) -> f64

--| Returns the hyperbolic sine of x.
#[bind='sinh_f32'] fn sinh(a f32) -> f32
#[bind='sinh_f64'] fn sinh(a f64) -> f64

--| Returns the positive square root of x.
#[bind='sqrt_f32'] fn sqrt(a f32) -> f32
#[bind='sqrt_f64'] fn sqrt(a f64) -> f64

--| Returns the tangent of x (x is in radians).
#[bind='tan_f32'] fn tan(x f32) -> f32
#[bind='tan_f64'] fn tan(x f64) -> f64

--| Returns the hyperbolic tangent of x.
#[bind='tanh_f32'] fn tanh(a f32) -> f32
#[bind='tanh_f64'] fn tanh(a f64) -> f64

--| Returns the integer portion of x, removing any fractional digits.
#[bind='trunc_f32'] fn trunc(a f32) -> f32
#[bind='trunc_f64'] fn trunc(a f64) -> f64

-- Matrix

type Matrix4[T Any]:
	-internal [16]T

#[bind='mat4f32_mul'] -fn mat4f32_mul(a Matrix4[f32], b Matrix4[f32]) -> Matrix4[f32]
#[bind='mat4f64_mul'] -fn mat4f64_mul(a Matrix4[f64], b Matrix4[f64]) -> Matrix4[f64]
#[bind='mat4u8_mul'] -fn mat4u8_mul(a Matrix4[r8], b Matrix4[r8]) -> Matrix4[r8]
#[bind='mat4u16_mul'] -fn mat4u16_mul(a Matrix4[r16], b Matrix4[r16]) -> Matrix4[r16]
#[bind='mat4u32_mul'] -fn mat4u32_mul(a Matrix4[r32], b Matrix4[r32]) -> Matrix4[r32]
#[bind='mat4u64_mul'] -fn mat4u64_mul(a Matrix4[r64], b Matrix4[r64]) -> Matrix4[r64]
#[bind='mat4i8_mul'] -fn mat4i8_mul(a Matrix4[i8], b Matrix4[i8]) -> Matrix4[i8]
#[bind='mat4i16_mul'] -fn mat4i16_mul(a Matrix4[i16], b Matrix4[i16]) -> Matrix4[i16]
#[bind='mat4i32_mul'] -fn mat4i32_mul(a Matrix4[i32], b Matrix4[i32]) -> Matrix4[i32]
#[bind='mat4i64_mul'] -fn mat4i64_mul(a Matrix4[i64], b Matrix4[i64]) -> Matrix4[i64]

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

#[bind='mat3f32_mul'] -fn mat3f32_mul(a Matrix3[f32], b Matrix3[f32]) -> Matrix3[f32]
#[bind='mat3f64_mul'] -fn mat3f64_mul(a Matrix3[f64], b Matrix3[f64]) -> Matrix3[f64]
#[bind='mat3u8_mul'] -fn mat3u8_mul(a Matrix3[r8], b Matrix3[r8]) -> Matrix3[r8]
#[bind='mat3u16_mul'] -fn mat3u16_mul(a Matrix3[r16], b Matrix3[r16]) -> Matrix3[r16]
#[bind='mat3u32_mul'] -fn mat3u32_mul(a Matrix3[r32], b Matrix3[r32]) -> Matrix3[r32]
#[bind='mat3u64_mul'] -fn mat3u64_mul(a Matrix3[r64], b Matrix3[r64]) -> Matrix3[r64]
#[bind='mat3i8_mul'] -fn mat3i8_mul(a Matrix3[i8], b Matrix3[i8]) -> Matrix3[i8]
#[bind='mat3i16_mul'] -fn mat3i16_mul(a Matrix3[i16], b Matrix3[i16]) -> Matrix3[i16]
#[bind='mat3i32_mul'] -fn mat3i32_mul(a Matrix3[i32], b Matrix3[i32]) -> Matrix3[i32]
#[bind='mat3i64_mul'] -fn mat3i64_mul(a Matrix3[i64], b Matrix3[i64]) -> Matrix3[i64]

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

#[bind='mat2f32_mul'] -fn mat2f32_mul(a Matrix2[f32], b Matrix2[f32]) -> Matrix2[f32]
#[bind='mat2f64_mul'] -fn mat2f64_mul(a Matrix2[f64], b Matrix2[f64]) -> Matrix2[f64]
#[bind='mat2u8_mul'] -fn mat2u8_mul(a Matrix2[r8], b Matrix2[r8]) -> Matrix2[r8]
#[bind='mat2u16_mul'] -fn mat2u16_mul(a Matrix2[r16], b Matrix2[r16]) -> Matrix2[r16]
#[bind='mat2u32_mul'] -fn mat2u32_mul(a Matrix2[r32], b Matrix2[r32]) -> Matrix2[r32]
#[bind='mat2u64_mul'] -fn mat2u64_mul(a Matrix2[r64], b Matrix2[r64]) -> Matrix2[r64]
#[bind='mat2i8_mul'] -fn mat2i8_mul(a Matrix2[i8], b Matrix2[i8]) -> Matrix2[i8]
#[bind='mat2i16_mul'] -fn mat2i16_mul(a Matrix2[i16], b Matrix2[i16]) -> Matrix2[i16]
#[bind='mat2i32_mul'] -fn mat2i32_mul(a Matrix2[i32], b Matrix2[i32]) -> Matrix2[i32]
#[bind='mat2i64_mul'] -fn mat2i64_mul(a Matrix2[i64], b Matrix2[i64]) -> Matrix2[i64]

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

-- Functions for common vector operations.
-- The most common vector types are accelerated with native SIMD instructions.

-- Accelerated add
#[bind] -fn vec2_add_f32(a Vector2, b f32) -> Vector2
#[bind] -fn vec2_add_vec2(a, b Vector2) -> Vector2
#[bind] -fn vec3_add_f32(a Vector3, b f32) -> Vector3
#[bind] -fn vec3_add_vec3(a, b Vector3) -> Vector3
#[bind] -fn vec4_add_f32(a Vector4, b f32) -> Vector4
#[bind] -fn vec4_add_vec4(a, b Vector4) -> Vector4
-- Accelerated sub
#[bind] -fn vec2_sub_f32(a Vector2, b f32) -> Vector2
#[bind] -fn vec2_sub_vec2(a, b Vector2) -> Vector2
#[bind] -fn vec3_sub_f32(a Vector3, b f32) -> Vector3
#[bind] -fn vec3_sub_vec3(a, b Vector3) -> Vector3
#[bind] -fn vec4_sub_f32(a Vector4, b f32) -> Vector4
#[bind] -fn vec4_sub_vec4(a, b Vector4) -> Vector4
-- Accelerated mul
#[bind] -fn vec2_mul_f32(a Vector2, b f32) -> Vector2
#[bind] -fn vec2_mul_vec2(a, b Vector2) -> Vector2
#[bind] -fn vec3_mul_f32(a Vector3, b f32) -> Vector3
#[bind] -fn vec3_mul_vec3(a, b Vector3) -> Vector3
#[bind] -fn vec4_mul_f32(a Vector4, b f32) -> Vector4
#[bind] -fn vec4_mul_vec4(a, b Vector4) -> Vector4
-- Accelerated div
#[bind] -fn vec2_div_f32(a Vector2, b f32) -> Vector2
#[bind] -fn vec2_div_vec2(a, b Vector2) -> Vector2
#[bind] -fn vec3_div_f32(a Vector3, b f32) -> Vector3
#[bind] -fn vec3_div_vec3(a, b Vector3) -> Vector3
#[bind] -fn vec4_div_f32(a Vector4, b f32) -> Vector4
#[bind] -fn vec4_div_vec4(a, b Vector4) -> Vector4
-- Accelerated neg
#[bind] -fn vec2_neg(a Vector2) -> Vector2
#[bind] -fn vec3_neg(a Vector3) -> Vector3
#[bind] -fn vec4_neg(a Vector4) -> Vector4

type Vector[T Any, const N int]:
	-internal [N]T

fn Vector[] :: @init(elements [N]T) -> Self:
	return {
		internal = elements
	}

fn Vector[] :: zero() -> Self:
	return {
		internal = [N]T{}
	}

fn (Vector[]) `+` (scale T) -> Self:
	cy_add := fn(a Vector[T, N], s T) -> Vector[T, N]:
		res := [N]T{}
		#for 0..N |i|:
			res[i] = a.internal[i] + s
		return {
			internal = res
		}

	#switch T:
		#case f32:
			#switch N:
				#case 2:
					return vec2_add_f32(self, scale)
				#case 3:
					return vec3_add_f32(self, scale)
				#case 4:
					return vec4_add_f32(self, scale)
				#else:
					return cy_add(self, scale)
		#else:
			return cy_add(self, scale)

fn (Vector[]) `+` (other Self) -> Self:
	cy_add := fn(a, b Vector[T, N]) -> Vector[T, N]:
		res := [N]T{}
		#for 0..N |i|:
			res[i] = a.internal[i] + b.internal[i]
		return {
			internal = res
		}

	#switch T:
		#case f32:
			#switch N:
				#case 2:
					return vec2_add_vec2(self, other)
				#case 3:
					return vec3_add_vec3(self, other)
				#case 4:
					return vec4_add_vec4(self, other)
				#else:
					return cy_add(self, other)
		#else:
			return cy_add(self, other)

fn (Vector[]) `-` (scale T) -> Self:
	cy_sub := fn(a Vector[T, N], s T) -> Vector[T, N]:
		res := [N]T{}
		#for 0..N |i|:
			res[i] = a.internal[i] - s
		return {
			internal = res
		}

	#switch T:
		#case f32:
			#switch N:
				#case 2:
					return vec2_sub_f32(self, scale)
				#case 3:
					return vec3_sub_f32(self, scale)
				#case 4:
					return vec4_sub_f32(self, scale)
				#else:
					return cy_sub(self, scale)
		#else:
			return cy_sub(self, scale)

fn (Vector[]) `-` (other Self) -> Self:
	cy_sub := fn(a, b Vector[T, N]) -> Vector[T, N]:
		res := [N]T{}
		#for 0..N |i|:
			res[i] = a.internal[i] - b.internal[i]
		return {
			internal = res
		}

	#switch T:
		#case f32:
			#switch N:
				#case 2:
					return vec2_sub_vec2(self, other)
				#case 3:
					return vec3_sub_vec3(self, other)
				#case 4:
					return vec4_sub_vec4(self, other)
				#else:
					return cy_sub(self, other)
		#else:
			return cy_sub(self, other)

fn (Vector[]) `*` (scale T) -> Self:
	cy_mul := fn(a Vector[T, N], s T) -> Vector[T, N]:
		res := [N]T{}
		for 0..N |i|:
			res[i] = (a.internal[i] * s)
		return {
			internal = res
		}

	#switch T:
		#case f32:
			#switch N:
				#case 2:
					return vec2_mul_f32(self, scale)
				#case 3:
					return vec3_mul_f32(self, scale)
				#case 4:
					return vec4_mul_f32(self, scale)
				#else:
					return cy_mul(self, scale)
		#else:
			return cy_mul(self, scale)

fn (Vector[]) `*` (other Self) -> Self:
	cy_mul := fn(a, b Vector[T, N]) -> Vector[T, N]:
		res := [N]T{}
		#for 0..N |i|:
			res[i] = a.internal[i] * b.internal[i]
		return {
			internal = res
		}

	#switch T:
		#case f32:
			#switch N:
				#case 2:
					return vec2_mul_vec2(self, other)
				#case 3:
					return vec3_mul_vec3(self, other)
				#case 4:
					return vec4_mul_vec4(self, other)
				#else:
					return cy_mul(self, other)
		#else:
			return cy_mul(self, other)

fn (Vector[]) `/` (scale T) -> Self:
	cy_div := fn(a Vector[T, N], s T) -> Vector[T, N]:
		res := [N]T{}
		#for 0..N |i|:
			res[i] = a.internal[i] / s
		return {
			internal = res
		}

	#switch T:
		#case f32:
			#switch N:
				#case 2:
					return vec2_div_f32(self, scale)
				#case 3:
					return vec3_div_f32(self, scale)
				#case 4:
					return vec4_div_f32(self, scale)
				#else:
					return cy_div(self, scale)
		#else:
			return cy_div(self, scale)

fn (Vector[]) `/` (other Self) -> Self:
	cy_div := fn(a, b Vector[T, N]) -> Vector[T, N]:
		res := [N]T{}
		#for 0..N |i|:
			res[i] = a.internal[i] / b.internal[i]
		return {
			internal = res
		}

	#switch T:
		#case f32:
			#switch N:
				#case 2:
					return vec2_div_vec2(self, other)
				#case 3:
					return vec3_div_vec3(self, other)
				#case 4:
					return vec4_div_vec4(self, other)
				#else:
					return cy_div(self, other)
		#else:
			return cy_div(self, other)

fn (Vector[]) `-` () -> Self:
	cy_neg := fn(a Vector[T, N]) -> Vector[T, N]:
		res := [N]T{}
		#for 0..N |i|:
			res[i] = -a.internal[i]
		return {
			internal = res
		}

	#switch T:
		#case f32:
			#switch N:
				#case 2:
					return vec2_neg(self)
				#case 3:
					return vec3_neg(self)
				#case 4:
					return vec4_neg(self)
				#else:
					return cy_neg(self)
		#else:
			return cy_neg(self)

-- TODO: Also SIMD these?...
fn (Vector[]) `>` (other Self) -> bool:
	#for 0..N |i|:
		if self.internal[i] <= other.internal[i]:
			return false
	return true

fn (Vector[]) `>=` (other Self) -> bool:
	#for 0..N |i|:
		if self.internal[i] < other.internal[i]:
			return false
	return true

fn (Vector[]) `<` (other Self) -> bool:
	#for 0..N |i|:
		if self.internal[i] >= other.internal[i]:
			return false
	return true

fn (Vector[]) `<=` (other Self) -> bool:
	#for 0..N |i|:
		if self.internal[i] > other.internal[i]:
			return false
	return true

fn (&Vector[]) @index(idx int) -> T:
	if idx < 0 || idx >= N:
		meta.error("Index out of bounds: %{idx}")
	return self.internal[idx]

fn (&Vector[]) @set_index(idx int, value T):
	if idx < 0 || idx >= N:
		meta.error("Index out of bounds: %{idx}")
	self.internal[idx] = value

fn (&Vector[]) @set(%swizzle EvalStr, value vector_get_type(T, swizzle.len())):
	#if swizzle.len() == 1:
		idx := axis_to_index(swizzle[i])
		#if idx == -99:
			meta.error("Invalid swizzle axis (Unknown component): " + swizzle[i])
		#else idx < 0 or idx >= N:
			meta.error("Invalid swizzle axis (Component outside of vector length): " + swizzle[i])
		#else:
			self.internal[a] = value
	#else:
		#for 0..swizzle.len() |i|:
			idx := axis_to_index(swizzle[i])
			#if idx == -99:
				meta.error("Invalid swizzle axis (Unknown component): " + swizzle[i])
			#else idx < 0 or idx >= N:
				meta.error("Invalid swizzle axis (Component outside of vector length): " + swizzle[i])
			#else:
				self.internal[idx] = value.internal[i]

fn (&Vector[]) @get(%swizzle EvalStr) -> vector_get_type(T, swizzle.len()):
	#switch swizzle:
		#case "x":
			return 0.0
		#case "y":
			return 0.0
		#case "z":
			return 0.0
		#case "xz":
			return Vector[T, 2]({0.0, 0.0})
		#else:
			meta.error("dklsjalkgfl;fhgklsjdhjkls " + swizzle)
	-- TODO: FIgure out how much of this I can do at compile time
	--s_l := swizzle.len()
	--if s_l == 1:
	--	idx := axis_to_index(swizzle[0])
	--	#var dbg Raw[64] = swizzle[0]
	--	meta.error("Swizzle is 1 somehow in string " + #{swizzle[0].fmt()})
	--	if idx == -1:
	--		return 0
	--	else idx == -99:
	--		meta.error("Invalid swizzle axis (Unknown component): " + swizzle[0].fmt())
	--	else idx < N:
	--		return self.internal[idx]
	--	else:
	--		meta.error("Invalid swizzle axis (Component outside of vector length): " + swizzle[i])
	--else:
	--	res := [s_l]T{}
	--	if s_l == 0:
	--		meta.error("What on earth happened here")

	--	for 0..s_l |i|:
	--		idx := axis_to_index(swizzle[i])
	--		if idx == -1:
	--			res[i] = 0
	--		else idx == -99:
	--			meta.error("Invalid swizzle axis (Unknown component): " + swizzle)
	--		else idx < N:
	--			res[i] = self.internal[idx]
	--		else:
	--			meta.error("Invalid swizzle axis (Component outside of vector length): " + swizzle)

	--	return {
	--		internal = res
	--	}

fn (Vector[]) len() -> T:
	sum := 0
	#for 0..N |i|:
		sum += self.internal[i] ** 2
	return sqrt(sum)

fn (Vector[]) len_squared() -> T:
	sum := 0
	#for 0..N |i|:
		sum += self.internal[i] ** 2
	return sum

fn (Vector[]) normalize() -> Self:
	length := self.len()
	if length == 0.0: -- TODO: Approx equals?
		return self
	inv_len := 1.0 / length
	return self * inv_len

fn (Vector[]) dot(other Self) -> T:
	sum := 0
	#for 0..N |i|:
		sum += self.internal[i] * other.internal[i]
	return sum

fn (Vector[]) scale_to(new_length T) -> Self:
	current_length := self.len()
	if current_length == 0.0: -- TODO: Approx equals?
		return self
	scale := new_length / current_length
	return self * scale

fn (Vector[]) distance_to(other Self) -> T:
	diff := self - other
	return diff.len()

fn (Vector[]) distance_squared_to(other Self) -> T:
	diff := self - other
	return diff.len_squared()

fn (Vector[]) cross(other Self) -> Self:
	if N != 3:
		meta.error("Cross product is only defined for 3D vectors.")
	x := self.internal[1] * other.internal[2] - self.internal[2] * other.internal[1]
	y := self.internal[2] * other.internal[0] - self.internal[0] * other.internal[2]
	z := self.internal[0] * other.internal[1] - self.internal[1] * other.internal[0]
	return {
		internal = [3]T{x, y, z}
	}

fn (Vector[]) rotate_axis(axis Self, rad T) -> Self:
	if N != 3:
		meta.error("Axis-angle rotation is only defined for 3D vectors.")
	cos_theta := cos(angle_rad)
	sin_theta := sin(angle_rad)
	u := axis.normalize()
	x := self.internal[0]
	y := self.internal[1]
	z := self.internal[2]
	ux := u.internal[0]
	uy := u.internal[1]
	uz := u.internal[2]

	rotated_x := (cos_theta + (1 - cos_theta) * ux * ux) * x +
	             ((1 - cos_theta) * ux * uy - uz * sin_theta) * y +
	             ((1 - cos_theta) * ux * uz + uy * sin_theta) * z

	rotated_y := ((1 - cos_theta) * uy * ux + uz * sin_theta) * x +
	             (cos_theta + (1 - cos_theta) * uy * uy) * y +
	             ((1 - cos_theta) * uy * uz - ux * sin_theta) * z

	rotated_z := ((1 - cos_theta) * uz * ux - uy * sin_theta) * x +
	             ((1 - cos_theta) * uz * uy + ux * sin_theta) * y +
	             (cos_theta + (1 - cos_theta) * uz * uz) * z

	return {
		internal = [3]T{rotated_x, rotated_y, rotated_z}
	}

fn (Vector[]) rotate_y(angle_rad T) -> Self:
	if N != 3:
		meta.error("Y-axis rotation is only defined for 3D vectors.")
	cos_theta := cos(angle_rad)
	sin_theta := sin(angle_rad)
	x := self.internal[0]
	y := self.internal[1]
	z := self.internal[2]

	rotated_x := cos_theta * x + sin_theta * z
	rotated_y := y
	rotated_z := -sin_theta * x + cos_theta * z

	return {
		internal = [3]T{rotated_x, rotated_y, rotated_z}
	}

fn (Vector[]) reflect(normal Self) -> Self:
	dot_product := self.dot(normal)
	return self - normal * (2 * dot_product)

fn (Vector[]) div_w() -> Self:
	if N != 4:
		meta.error("div_w is only defined for 4D vectors.")
	w := self.internal[3]
	if w == 0.0: -- TODO: Approx equals?
		meta.error("Cannot divide by zero in div_w.")
	inv_w := 1.0 / w
	return {
		internal = [4]T{
			self.internal[0] * inv_w,
			self.internal[1] * inv_w,
			self.internal[2] * inv_w,
			1.0
		}
	}

-fn vector_get_type (T type, N int) -> type:
	switch N:
		case 1:
			return T
		else:
			return Vector[T, N]

-fn axis_to_index(a byte) -> int:
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
			return -99 -- Sentinel for invalid axis.

type Vector4 = Vector[f32, 4]
type Vector3 = Vector[f32, 3]
type Vector2 = Vector[f32, 2]

-- Quaternion

type Quaternion:
	-internal [4]f32
