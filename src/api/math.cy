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
#[bind] fn abs(x f32) -> f32
--| Returns the arccosine of x.
#[bind] dn acos(x f32) -> f32

#[bind] fn remap(value, low1, high1, low2, high2 f32) -> f32

#[bind] fn lerp(low, high, t f32) -> f32
