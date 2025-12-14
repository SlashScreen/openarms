--| Euler's number and the base of natural logarithms; approximately 2.718.
const e = 2.71828182845904523536028747135266249775724709369995

--| Infinity.
const inf = as[float] 0x7ff0000000000000

--| Base-10 logarithm of E; approximately 0.434.
const log10e = 0.434294481903251827651128918916605082

--| Base-2 logarithm of E; approximately 1.443.
const log2e = 1.442695040888963407359924681001892137

--| Natural logarithm of 10; approximately 2.303.
const ln10 = 2.302585092994045684017991454684364208

--| Natural logarithm of 2; approximately 0.693.
const ln2 = 0.693147180559945309417232121458176568

--| The maximum integer value that can be safely represented as a float. 2^53-1 or 9007199254740991.
const maxSafeInt = 9007199254740991.0

--| The minumum integer value that can be safely represented as a float. -(2^53-1) or -9007199254740991.
const minSafeInt = -9007199254740991.0

--| Not a number. Note that nan == nan.
--| However, if a nan came from an arithmetic operation, the comparison is undefined.
--| Use `isNaN` instead.
const nan = as[float] 0x7ff8000000000000

--| Negative infinity.
const neginf = as[float] 0xfff0000000000000

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
#[bind] fn abs(a float) -> float

--| Returns the arccosine (in radians) of x.
#[bind] fn acos(a float) -> float

--| Returns the hyperbolic arccosine of x.
#[bind] fn acosh(a float) -> float

--| Returns the arcsine (in radians) of x.
#[bind] fn asin(a float) -> float

--| Returns the hyperbolic arcsine of x.
#[bind] fn asinh(a float) -> float

--| Returns the arctangent (in radians) of x.
#[bind] fn atan(a float) -> float

--| Returns the arctangent (in radians) of the quotient of its arguments (y/x).
#[bind] fn atan2(y float, x float) -> float

--| Returns the hyperbolic arctangent of x.
#[bind] fn atanh(a float) -> float

--| Returns the cube root of x.
#[bind] fn cbrt(a float) -> float

--| Returns the smallest integer greater than or equal to x.
#[bind] fn ceil(a float) -> float

--| Returns the number of leading zero bits in the 32-bit integer representation of x.
#[bind] fn clz32(a float) -> i32

--| Returns a value with the magnitude of `mag` and the sign of `sign`.
#[bind] fn copysign(mag float, sign float) -> float

--| Returns the cosine of x (x is in radians).
#[bind] fn cos(x float) -> float

--| Generic cosine overload for compatible numeric types.
#[bind] fn cos(x %T) -> T

--| Returns the hyperbolic cosine of x.
#[bind] fn cosh(a float) -> float

--| Converts degrees to radians. Accepts and returns f32.
#[bind] fn degToRad(deg f32) -> f32

--| Returns e raised to the power of x (e^x).
#[bind] fn exp(a float) -> float

--| Returns exp(x) - 1 with increased precision for small x.
#[bind] fn expm1(a float) -> float

--| Returns the largest integer less than or equal to x.
#[bind] fn floor(a float) -> float

--| Returns the fractional part of x.
#[bind] fn frac(a float) -> float

--| Returns sqrt(a*a + b*b) — the square root of the sum of squares of its arguments.
#[bind] fn hypot(a float, b float) -> float

--| Returns true if a is infinite.
#[bind] fn isInf(a float) -> bool

--| Returns true if the float has no fractional part (is an integer value).
#[bind] fn isInt(a float) -> bool

--| Returns true if x is not a number (NaN).
#[bind] fn isNaN(a float) -> bool

--| Linear interpolation between `low` and `high` by parameter `t` (0..1).
#[bind] fn lerp(low, high, t f32) -> f32

--| Returns the natural logarithm (base e) of x.
#[bind] fn ln(a float) -> float

--| Returns the logarithm of `y` with base `x`.
#[bind] fn log(x float, y float) -> float

--| Returns the base-10 logarithm of x.
#[bind] fn log10(a float) -> float

--| Returns the natural logarithm of 1 + x with increased precision for small x.
#[bind] fn log1p(a float) -> float

--| Returns the base-2 logarithm of x.
#[bind] fn log2(a float) -> float

--| Returns the larger of two values (generic).
#[bind] fn max(a %T, b T) -> T

--| Returns the larger of two f64 values.
#[bind] fn max_f64(a float, b float) -> float

--| Returns the smaller of two values (generic).
#[bind] fn min(a %T, b T) -> T

--| Returns the smaller of two f64 values.
#[bind] fn min_f64(a float, b float) -> float

--| Performs 32-bit integer multiplication semantics on the float inputs (integer overflow allowed).
#[bind] fn mul32(a float, b float) -> float

--| Returns x raised to the power y (x^y).
#[bind] fn pow(a float, b float) -> float

--| Returns a pseudo-random number between 0 (inclusive) and 1 (exclusive).
#[bind] fn random() -> float
#[bind] fn rand_int(min i32, max i32) -> i32
fn rand_choice(arr []%T) -> T:
	idx := rand_int(0, arr.len() - 1)
	return arr[idx]
fn rand_choice(arr [%N]%T) -> T:
	idx := rand_int(0, N - 1)
	return arr[idx]

--| Remap `value` from the input range [low1, high1] to the output range [low2, high2].
#[bind] fn remap(value, low1, high1, low2, high2 f32) -> f32

--| Returns the value of x rounded to the nearest integer.
#[bind] fn round(a float) -> float

--| Returns the sign of x: positive, negative or zero.
#[bind] fn sign(a float) -> float

--| Returns the sine of x (x is in radians).
#[bind] fn sin(x float) -> float

--| Generic sine overload for compatible numeric types.
#[bind] fn sin(x %T) -> T

--| Returns the hyperbolic sine of x.
#[bind] fn sinh(a float) -> float

--| Returns the positive square root of x.
#[bind] fn sqrt(a float) -> float

--| Returns the tangent of x (x is in radians).
#[bind] fn tan(x float) -> float

--| Generic tangent overload for compatible numeric types.
#[bind] fn tan(x %T) -> T

--| Returns the hyperbolic tangent of x.
#[bind] fn tanh(a float) -> float

--| Returns the integer portion of x, removing any fractional digits.
#[bind] fn trunc(a float) -> float
