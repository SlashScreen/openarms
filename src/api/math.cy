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
#[bind="abs_f32"] fn abs(a f32) -> f32
#[bind="abs_f64"] fn abs(a f64) -> f64
#[bind="abs_i8"] fn abs(a i8) -> i8
#[bind="abs_i16"] fn abs(a i16) -> i16
#[bind="abs_i32"] fn abs(a i32) -> i32
#[bind="abs_i64"] fn abs(a i64) -> i64


--| Returns the arccosine (in radians) of x.
#[bind="acos_f32"] fn acos(a f32) -> f32
#[bind="acos_f64"] fn acos(a f64) -> f64

--| Returns the hyperbolic arccosine of x.
#[bind="acosh_f32"] fn acosh(a f32) -> f32
#[bind="acosh_f64"] fn acosh(a f64) -> f64

--| Returns the arcsine (in radians) of x.
#[bind="asin_f32"] fn asin(a f32) -> f32
#[bind="asin_f64"] fn asin(a f64) -> f64

--| Returns the hyperbolic arcsine of x.
#[bind="asinh_f32"] fn asinh(a f32) -> f32
#[bind="asinh_f64"] fn asinh(a f64) -> f64

--| Returns the arctangent (in radians) of x.
#[bind="atan_f32"] fn atan(a f32) -> f32
#[bind="atan_f64"] fn atan(a f64) -> f64

--| Returns the arctangent (in radians) of the quotient of its arguments (y/x).
#[bind="atan2_f32"] fn atan2(y, x f32) -> f32
#[bind="atan2_f64"] fn atan2(y, x f64) -> f64

--| Returns the hyperbolic arctangent of x.
#[bind="atanh_f32"] fn atanh(a f32) -> f32
#[bind="atanh_f64"] fn atanh(a f64) -> f64

--| Returns the cube root of x.
#[bind="cbrt_f32"] fn cbrt(a f32) -> f32
#[bind="cbrt_f64"] fn cbrt(a f64) -> f64

--| Returns the smallest integer greater than or equal to x.
#[bind="ceil_f32"] fn ceil(a f32) -> f32
#[bind="ceil_f64"] fn ceil(a f64) -> f64

--| Clamps x to the range [min, max].
#[bind="clamp_f32"] fn clamp(x, min, max f32) -> f32
#[bind="clamp_f64"] fn clamp(x, min, max f64) -> f64
#[bind="clamp_u8"] fn clamp(x, min, max r8) -> r8
#[bind="clamp_u16"] fn clamp(x, min, max r16) -> r16
#[bind="clamp_u32"] fn clamp(x, min, max r32) -> r32
#[bind="clamp_u64"] fn clamp(x, min, max r64) -> r64
#[bind="clamp_i8"] fn clamp(x, min, max i8) -> i8
#[bind="clamp_i16"] fn clamp(x, min, max i16) -> i16
#[bind="clamp_i32"] fn clamp(x, min, max i32) -> i32
#[bind="clamp_i64"] fn clamp(x, min, max i64) -> i64

--| Returns the number of leading zero bits in the 32-bit integer representation of x.
#[bind] fn clz32(a f32) -> i32

--| Returns a value with the magnitude of `mag` and the sign of `sign`.
#[bind="copysign_f32"] fn copysign(mag, sign f32) -> f32
#[bind="copysign_f64"] fn copysign(mag, sign f64) -> f64

--| Returns the cosine of x (x is in radians).
#[bind="cos_f32"] fn cos(x f32) -> f32
#[bind="cos_f64"] fn cos(x f64) -> f64

--| Returns the hyperbolic cosine of x.
#[bind="cosh_f32"] fn cosh(a f32) -> f32
#[bind="cosh_f64"] fn cosh(a f64) -> f64

--| Converts degrees to radians. Accepts and returns f32.
#[bind="deg_to_rad_f32"] fn degToRad(deg f32) -> f32
#[bind="deg_to_rad_f64"] fn degToRad(deg f64) -> f64

--| Returns e raised to the power of x (e^x).
#[bind="exp_f32"] fn exp(a f32) -> f32
#[bind="exp_f64"] fn exp(a f64) -> f64

--| Returns exp(x) - 1 with increased precision for small x.
#[bind="expm1_f32"] fn expm1(a f32) -> f32
#[bind="expm1_f64"] fn expm1(a f64) -> f64

--| Returns the largest integer less than or equal to x.
#[bind="floor_f32"] fn floor(a f32) -> f32
#[bind="floor_f64"] fn floor(a f64) -> f64

--| Returns the fractional part of x.
#[bind="frac_f32"] fn frac(a f32) -> f32
#[bind="frac_f64"] fn frac(a f64) -> f64

--| Returns sqrt(a*a + b*b) — the square root of the sum of squares of its arguments.
#[bind="hypot_f32"] fn hypot(a f32, b f32) -> f32
#[bind="hypot_f64"] fn hypot(a f64, b f64) -> f64

--| Returns true if a is infinite.
#[bind="is_inf_f32"] fn isInf(a f32) -> bool
#[bind="is_inf_f64"] fn isInf(a f64) -> bool

--| Returns true if the f64 has no fractional part (is an integer value).
#[bind="is_inf_f32"] fn isInt(a f32) -> bool
#[bind="is_inf_f64"] fn isInt(a f64) -> bool

--| Returns true if x is not a number (NaN).
#[bind="is_nan_f32"] fn isNaN(a f32) -> bool
#[bind="is_nan_f64"] fn isNaN(a f64) -> bool

--| Linear interpolation between `low` and `high` by parameter `t` (0..1).
#[bind="lerp_f32"] fn lerp(low, high, t f32) -> f32
#[bind="lerp_f64"] fn lerp(low, high, t f64) -> f64
#[bind="lerp_vec2"] fn lerp(low, high Vector2, t f32) -> Vector2
#[bind="lerp_vec3"] fn lerp(low, high Vector3, t f32) -> Vector3
#[bind="lerp_vec4"] fn lerp(low, high Vector4, t f32) -> Vector4
#[bind="lerp_quat"] fn lerp(low, high Quaternion, t f32) -> Quaternion

--| Returns the natural logarithm (base e) of x.
#[bind="ln_f32"] fn ln(a f32) -> f32
#[bind="ln_f64"] fn ln(a f64) -> f64

--| Returns the logarithm of `y` with base `x`.
#[bind="log_f32"] fn log(x, y f32) -> f32
#[bind="log_f64"] fn log(x, y f64) -> f64

--| Returns the base-10 logarithm of x.
#[bind="log10_f32"] fn log10(a f32) -> f32
#[bind="log10_f64"] fn log10(a f64) -> f64

--| Returns the natural logarithm of 1 + x with increased precision for small x.
#[bind="log1p_f32"] fn log1p(a f32) -> f32
#[bind="log1p_f64"] fn log1p(a f64) -> f64

--| Returns the base-2 logarithm of x.
#[bind="log2_f32"] fn log2(a f32) -> f32
#[bind="log2_f64"] fn log2(a f64) -> f64

--| Returns the larger of two values.
#[bind="max_f32"] fn max(a, b f32) -> f32
#[bind="max_f64"] fn max(a, b f64) -> f64
#[bind="max_i8"] fn max(a, b i8) -> i8
#[bind="max_i16"] fn max(a, b i16) -> i16
#[bind="max_i32"] fn max(a, b i32) -> i32
#[bind="max_i64"] fn max(a, b i64) -> i64
#[bind="max_u8"] fn max(a, b r8) -> r8
#[bind="max_u16"] fn max(a, b r16) -> r16
#[bind="max_u32"] fn max(a, b r32) -> r32
#[bind="max_u64"] fn max(a, b r64) -> r64
#[bind="max_vec2"] fn max(a, b Vector2) -> Vector2
#[bind="max_vec3"] fn max(a, b Vector3) -> Vector3
#[bind="max_vec4"] fn max(a, b Vector4) -> Vector4

--| Returns the smaller of two values.
#[bind="min_f32"] fn min(a, b f32) -> f32
#[bind="min_f64"] fn min(a, b f64) -> f64
#[bind="min_i8"] fn min(a, b i8) -> i8
#[bind="min_i16"] fn min(a, b i16) -> i16
#[bind="min_i32"] fn min(a, b i32) -> i32
#[bind="min_i64"] fn min(a, b i64) -> i64
#[bind="min_u8"] fn min(a, b r8) -> r8
#[bind="min_u16"] fn min(a, b r16) -> r16
#[bind="min_u32"] fn min(a, b r32) -> r32
#[bind="min_u64"] fn min(a, b r64) -> r64
#[bind="min_vec2"] fn min(a, b Vector2) -> Vector2
#[bind="min_vec3"] fn min(a, b Vector3) -> Vector3
#[bind="min_vec4"] fn min(a, b Vector4) -> Vector4

--| Performs 32-bit integer multiplication semantics on the f64 inputs (integer overflow allowed).
#[bind] fn mul32(a, b f32) -> f32

--| Returns x raised to the power y (x^y).
#[bind="pow_f32"] fn pow(x, y f32) -> f32
#[bind="pow_f64"] fn pow(x, y f64) -> f64

--| Returns a pseudo-random number between 0 (inclusive) and 1 (exclusive).
#[bind] fn random() -> f64
#[bind] fn rand_int(min i32, max i32) -> i32
fn rand_choice(arr []%T) -> T:
	idx := rand_int(0, arr.len() - 1)
	return arr[idx]
fn rand_choice(arr [%N]%T) -> T:
	idx := rand_int(0, N - 1)
	return arr[idx]

--| Remap `value` from the input range [low1, high1] to the output range [low2, high2].
#[bind="remap_f32"] fn remap(value, low1, high1, low2, high2 f32) -> f32
#[bind="remap_f64"] fn remap(value, low1, high1, low2, high2 f64) -> f64
#[bind="remap_vec2"] fn remap(value, low1, high1, low2, high2 Vector2) -> Vector2
#[bind="remap_vec3"] fn remap(value, low1, high1, low2, high2 Vector3) -> Vector3
#[bind="remap_vec4"] fn remap(value, low1, high1, low2, high2 Vector4) -> Vector4

--| Returns the value of x rounded to the nearest integer.
#[bind="round_f32"] fn round(a f32) -> f32
#[bind="round_f64"] fn round(a f64) -> f64

--| Rounds x down to the nearest integer.
#[bind="round_to_int_f32"] fn roundToInt(a f32) -> f32
#[bind="round_to_int_f64"] fn roundToInt(a f64) -> f64

--| Returns the sign of x: positive, negative or zero.
#[bind="sign_f32"] fn sign(a f32) -> f32
#[bind="sign_f64"] fn sign(a f64) -> f64
#[bind="sign_i8"] fn sign(a i8) -> i8
#[bind="sign_i16"] fn sign(a i16) -> i16
#[bind="sign_i32"] fn sign(a i32) -> i32
#[bind="sign_i64"] fn sign(a i64) -> i64

--| Returns the sine of x (x is in radians).
#[bind="sin_f32"] fn sin(x f32) -> f32
#[bind="sin_f64"] fn sin(x f64) -> f64

--| Returns the hyperbolic sine of x.
#[bind="sinh_f32"] fn sinh(a f32) -> f32
#[bind="sinh_f64"] fn sinh(a f64) -> f64

--| Returns the positive square root of x.
#[bind="sqrt_f32"] fn sqrt(a f32) -> f32
#[bind="sqrt_f64"] fn sqrt(a f64) -> f64

--| Returns the tangent of x (x is in radians).
#[bind="tan_f32"] fn tan(x f32) -> f32
#[bind="tan_f64"] fn tan(x f64) -> f64

--| Returns the hyperbolic tangent of x.
#[bind="tanh_f32"] fn tanh(a f32) -> f32
#[bind="tanh_f64"] fn tanh(a f64) -> f64

--| Returns the integer portion of x, removing any fractional digits.
#[bind="trunc_f32"] fn trunc(a f32) -> f32
#[bind="trunc_f64"] fn trunc(a f64) -> f64
