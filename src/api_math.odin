#+private file
package main

import "base:intrinsics"
import "base:runtime"
import "core:math"
import "core:math/bits"
import "core:math/linalg"
import "core:math/rand"
import cy "cyber"

u_op :: proc "contextless" (
	$T : typeid,
	$fn : proc "contextless" (_ : T) -> T,
	t : ^cy.Thread,
) -> cy.Ret {
	res := cy.get_ret(t, T)
	x := cy.get_prim(t, T)
	res^ = fn(x)
	return .Ok
}

bin_op :: proc "contextless" (
	$T : typeid,
	$fn : proc "contextless" (_ : T, _ : T) -> T,
	t : ^cy.Thread,
) -> cy.Ret {
	res := cy.get_ret(t, T)
	x := cy.get_prim(t, T)
	y := cy.get_prim(t, T)
	res^ = fn(x, y)
	return .Ok
}

// Abs

cy_abs_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

cy_abs_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

cy_abs_i8 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i8
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

cy_abs_i16 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i16
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

cy_abs_i32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i32
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

cy_abs_i64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i64
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

// Acos

cy_acos_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.acos(x)}, t)
}

cy_acos_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.acos(x)}, t)
}

// Acosh

cy_acosh_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.acosh(x)}, t)
}

cy_acosh_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.acosh(x)}, t)
}

// Asin

cy_asin_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.asin(x)}, t)
}

cy_asin_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.asin(x)}, t)
}

// Asinh

cy_asinh_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.asinh(x)}, t)
}

cy_asinh_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.asinh(x)}, t)
}

// Atan

cy_atan_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.atan(x)}, t)
}

cy_atan_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.atan(x)}, t)
}

// Atan2

cy_atan2_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	y := cy.get_prim(t, f32)
	x := cy.get_prim(t, f32)
	res^ = math.atan2(y, x)
	return .Ok
}

cy_atan2_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f64)
	y := cy.get_prim(t, f64)
	x := cy.get_prim(t, f64)
	res^ = math.atan2(y, x)
	return .Ok
}

// Atanh

cy_atanh_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.atanh(x)}, t)
}

cy_atanh_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.atanh(x)}, t)
}

// cbrt (cube root)

cy_cbrt_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.pow(x, 1.0 / 3.0)}, t)
}

cy_cbrt_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.pow(x, 1.0 / 3.0)}, t)
}

// Ceil

cy_ceil_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.ceil(x)}, t)
}

cy_ceil_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.ceil(x)}, t)
}

// Clamp

cy_clamp_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	x := cy.get_prim(t, f32)
	min := cy.get_prim(t, f32)
	max := cy.get_prim(t, f32)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f64)
	x := cy.get_prim(t, f64)
	min := cy.get_prim(t, f64)
	max := cy.get_prim(t, f64)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_u8 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, u8)
	x := cy.get_prim(t, u8)
	min := cy.get_prim(t, u8)
	max := cy.get_prim(t, u8)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_u16 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, u16)
	x := cy.get_prim(t, u16)
	min := cy.get_prim(t, u16)
	max := cy.get_prim(t, u16)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_u32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, u32)
	x := cy.get_prim(t, u32)
	min := cy.get_prim(t, u32)
	max := cy.get_prim(t, u32)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_u64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, u64)
	x := cy.get_prim(t, u64)
	min := cy.get_prim(t, u64)
	max := cy.get_prim(t, u64)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_i8 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i8)
	x := cy.get_prim(t, i8)
	min := cy.get_prim(t, i8)
	max := cy.get_prim(t, i8)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_i16 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i16)
	x := cy.get_prim(t, i16)
	min := cy.get_prim(t, i16)
	max := cy.get_prim(t, i16)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_i32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i32)
	x := cy.get_prim(t, i32)
	min := cy.get_prim(t, i32)
	max := cy.get_prim(t, i32)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_i64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i64)
	x := cy.get_prim(t, i64)
	min := cy.get_prim(t, i64)
	max := cy.get_prim(t, i64)
	res^ = math.clamp(x, min, max)
	return .Ok
}

// Clz (count leading zeros)

cy_clz_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i32)
	x := cy.get_prim(t, f32)
	res^ = bits.leading_zeros(transmute(i32)x)
	return .Ok
}

// Copysign

copy_sign :: proc "c" ($T : typeid, mag : T, sign : T) -> T {
	return abs(x) * math.sign(sign)
}

cy_copysign_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(T, copy_sign, t)
}

cy_copysign_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return bin_op(T, copy_sign, t)
}

// Cos

cy_cos_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.cos(x)}, t)
}

cy_cos_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.cos(x)}, t)
}

// Cosh

cy_cosh_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.cosh(x)}, t)
}

cy_cosh_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.cosh(x)}, t)
}

// degToRad

cy_deg_to_rad_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.to_radians(x)}, t)
}

cy_deg_to_rad_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.to_radians(x)}, t)
}

// Exp

cy_exp_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.exp(x)}, t)
}

cy_exp_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.exp(x)}, t)
}

// Expm1

cy_expm1_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.exp(x) - 1.0}, t)
}

cy_expm1_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.exp(x) - 1.0}, t)
}

// Floor

cy_floor_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.floor(x)}, t)
}

cy_floor_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.floor(x)}, t)
}

// Frac

cy_frac_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return linalg.fract(x)}, t)
}

cy_frac_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return linalg.fract(x)}, t)
}

// Hypot

cy_hypot_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	x := cy.get_prim(t, f32)
	y := cy.get_prim(t, f32)
	res^ = math.hypot(x, y)
	return .Ok
}

cy_hypot_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f64)
	x := cy.get_prim(t, f64)
	y := cy.get_prim(t, f64)
	res^ = math.hypot(x, y)
	return .Ok
}

// isInf

cy_is_inf_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f32)
	res^ = x == math.inf_f32(int(math.sign(x)))
	return .Ok
}

cy_is_inf_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f64)
	res^ = x == math.inf_f64(int(math.sign(x)))
	return .Ok
}

// isInt

cy_is_int_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f32)
	res^ = linalg.fract(x) == 0.0
	return .Ok
}

cy_is_int_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f64)
	res^ = linalg.fract(x) == 0.0
	return .Ok
}

// isNaN

cy_is_nan_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f32)
	res^ = math.is_nan(x)
	return .Ok
}

cy_is_nan_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f64)
	res^ = math.is_nan(x)
	return .Ok
}

// Lerp

cy_lerp_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	a := cy.get_prim(t, f32)
	b := cy.get_prim(t, f32)
	alpha := cy.get_prim(t, f32)
	res^ = math.lerp(a, b, alpha)
	return .Ok
}

cy_lerp_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f64)
	a := cy.get_prim(t, f64)
	b := cy.get_prim(t, f64)
	alpha := cy.get_prim(t, f64)
	res^ = math.lerp(a, b, alpha)
	return .Ok
}

cy_lerp_vec2 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector2f32)
	a := cy.get(t, linalg.Vector2f32)
	b := cy.get(t, linalg.Vector2f32)
	alpha := cy.get_prim(t, f32)
	res^ = linalg.lerp(a^, b^, alpha)
	return .Ok
}

cy_lerp_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector3f32)
	a := cy.get(t, linalg.Vector3f32)
	b := cy.get(t, linalg.Vector3f32)
	alpha := cy.get_prim(t, f32)
	res^ = linalg.lerp(a^, b^, alpha)
	return .Ok
}

cy_lerp_vec4 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector4f32)
	a := cy.get(t, linalg.Vector4f32)
	b := cy.get(t, linalg.Vector4f32)
	alpha := cy.get_prim(t, f32)
	res^ = linalg.lerp(a^, b^, alpha)
	return .Ok
}

cy_lerp_quat :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Quaternionf32)
	a := cy.get(t, linalg.Quaternionf32)
	b := cy.get(t, linalg.Quaternionf32)
	alpha := cy.get_prim(t, f32)
	res^ = linalg.lerp(a^, b^, alpha)
	return .Ok
}

// Ln

cy_ln_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.ln(x)}, t)
}

cy_ln_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.ln(x)}, t)
}

// Log

cy_log_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(T, proc "contextless" (base : T, x : T) -> T {return math.log(x, base)}, t)
}

cy_log_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return bin_op(T, proc "contextless" (base : T, x : T) -> T {return math.log(x, base)}, t)
}

// Log10

cy_log10_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.log10(x)}, t)
}

cy_log10_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.log10(x)}, t)
}

// Log1p

cy_log1p_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.ln(1.0 + x)}, t)
}

cy_log1p_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.ln(1.0 + x)}, t)
}

// Log2

cy_log2_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.log2(x)}, t)
}

cy_log2_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.log2(x)}, t)
}

// Max

cy_max_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_i8 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i8
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_i16 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i16
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_i32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_i64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_u8 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: u8
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_u16 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: u16
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_u32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: u32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_u64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: u64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_vec2 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector2f32)
	a := cy.get(t, linalg.Vector2f32)
	b := cy.get(t, linalg.Vector2f32)
	res^ = linalg.max(a^, b^)
	return .Ok
}

cy_max_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector3f32)
	a := cy.get(t, linalg.Vector3f32)
	b := cy.get(t, linalg.Vector3f32)
	res^ = linalg.max(a^, b^)
	return .Ok
}

cy_max_vec4 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector4f32)
	a := cy.get(t, linalg.Vector4f32)
	b := cy.get(t, linalg.Vector4f32)
	res^ = linalg.max(a^, b^)
	return .Ok
}

// Min

cy_min_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_i8 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i8
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_i16 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i16
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_i32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_i64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_u8 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: u8
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_u16 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: u16
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_u32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: u32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_u64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: u64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_vec2 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector2f32)
	a := cy.get(t, linalg.Vector2f32)
	b := cy.get(t, linalg.Vector2f32)
	res^ = linalg.min(a^, b^)
	return .Ok
}

cy_min_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector3f32)
	a := cy.get(t, linalg.Vector3f32)
	b := cy.get(t, linalg.Vector3f32)
	res^ = linalg.min(a^, b^)
	return .Ok
}

cy_min_vec4 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector4f32)
	a := cy.get(t, linalg.Vector4f32)
	b := cy.get(t, linalg.Vector4f32)
	res^ = linalg.min(a^, b^)
	return .Ok
}

// Mul32

cy_mul_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(
		T,
		proc "contextless" (a : T, b : T) -> T {return(
				transmute(f32)(transmute(i32)a * transmute(i32)b) \
			)},
		t,
	)
}

// Pow

cy_pow_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(T, proc "contextless" (a : T, y : T) -> T {return math.pow(a, y)}, t)
}

cy_pow_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return bin_op(T, proc "contextless" (a : T, y : T) -> T {return math.pow(a, y)}, t)
}

// radToDeg

cy_rad_to_deg_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.to_degrees(x)}, t)
}

// Random

cy_random :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	res := cy.get_ret(t, f32)
	res^ = rand.float32()
	return .Ok
}

cy_randint :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	res := cy.get_ret(t, i32)
	min := cy.get_prim(t, i32)
	max := cy.get_prim(t, i32)
	res^ = i32(rand.int_range(int(min), int(max)))
	return .Ok
}

// Remap

cy_remap_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	x := cy.get_prim(t, f32)
	in_min := cy.get_prim(t, f32)
	in_max := cy.get_prim(t, f32)
	out_min := cy.get_prim(t, f32)
	out_max := cy.get_prim(t, f32)
	res^ = math.remap(x, in_min, in_max, out_min, out_max)
	return .Ok
}

cy_remap_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f64)
	x := cy.get_prim(t, f64)
	in_min := cy.get_prim(t, f64)
	in_max := cy.get_prim(t, f64)
	out_min := cy.get_prim(t, f64)
	out_max := cy.get_prim(t, f64)
	res^ = math.remap(x, in_min, in_max, out_min, out_max)
	return .Ok
}

cy_remap_vec2 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector2f32)
	x := cy.get(t, linalg.Vector2f32)
	in_min := cy.get(t, linalg.Vector2f32)
	in_max := cy.get(t, linalg.Vector2f32)
	out_min := cy.get(t, linalg.Vector2f32)
	out_max := cy.get(t, linalg.Vector2f32)
	res^ = linalg.Vector2f32 {
		math.remap(x.x, in_min.x, in_max.x, out_min.x, out_max.x),
		math.remap(x.y, in_min.y, in_max.y, out_min.y, out_max.y),
	}
	return .Ok
}

cy_remap_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector3f32)
	x := cy.get(t, linalg.Vector3f32)
	in_min := cy.get(t, linalg.Vector3f32)
	in_max := cy.get(t, linalg.Vector3f32)
	out_min := cy.get(t, linalg.Vector3f32)
	out_max := cy.get(t, linalg.Vector3f32)
	res^ = linalg.Vector3f32 {
		math.remap(x.x, in_min.x, in_max.x, out_min.x, out_max.x),
		math.remap(x.y, in_min.y, in_max.y, out_min.y, out_max.y),
		math.remap(x.z, in_min.z, in_max.z, out_min.z, out_max.z),
	}
	return .Ok
}

cy_remap_vec4 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector4f32)
	x := cy.get(t, linalg.Vector4f32)
	in_min := cy.get(t, linalg.Vector4f32)
	in_max := cy.get(t, linalg.Vector4f32)
	out_min := cy.get(t, linalg.Vector4f32)
	out_max := cy.get(t, linalg.Vector4f32)
	res^ = linalg.Vector4f32 {
		math.remap(x.x, in_min.x, in_max.x, out_min.x, out_max.x),
		math.remap(x.y, in_min.y, in_max.y, out_min.y, out_max.y),
		math.remap(x.z, in_min.z, in_max.z, out_min.z, out_max.z),
		math.remap(x.w, in_min.w, in_max.w, out_min.w, out_max.w),
	}
	return .Ok
}

// Round

cy_round_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.round(x)}, t)
}

cy_round_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.round(x)}, t)
}

cy_round_to_int_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i32)
	x := cy.get_prim(t, f32)
	res^ = i32(math.round(x))
	return .Ok
}

cy_round_to_int_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i64)
	x := cy.get_prim(t, f64)
	res^ = i64(math.round(x))
	return .Ok
}

// Sign

cy_sign_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.sign(x)}, t)
}

cy_sign_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.sign(x)}, t)
}

cy_sign_i8 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i8
	return u_op(T, proc "contextless" (x : T) -> T {
			if x > 0 {
				return 1
			} else if x < 0 {
				return -1
			} else {
				return 0
			}
		}, t)
}

cy_sign_i16 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i16
	return u_op(T, proc "contextless" (x : T) -> T {
			if x > 0 {
				return 1
			} else if x < 0 {
				return -1
			} else {
				return 0
			}
		}, t)
}

cy_sign_int32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i32
	return u_op(T, proc "contextless" (x : T) -> T {
			if x > 0 {
				return 1
			} else if x < 0 {
				return -1
			} else {
				return 0
			}
		}, t)
}

cy_sign_i64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: i64
	return u_op(T, proc "contextless" (x : T) -> T {
			if x > 0 {
				return 1
			} else if x < 0 {
				return -1
			} else {
				return 0
			}
		}, t)
}


// Sin

cy_sin_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.sin(x)}, t)
}

cy_sin_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.sin(x)}, t)
}

// Sinh

cy_sinh_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.sinh(x)}, t)
}

cy_sinh_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.sinh(x)}, t)
}

// Sqrt

cy_sqrt_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.sqrt(x)}, t)
}

cy_sqrt_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.sqrt(x)}, t)
}

// Tan

cy_tan_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.tan(x)}, t)
}

cy_tan_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.tan(x)}, t)
}

// Tanh

cy_tanh_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.tanh(x)}, t)
}

cy_tanh_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.tanh(x)}, t)
}

// Trunc

cy_trunc_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.trunc(x)}, t)
}

cy_trunc_f64 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.trunc(x)}, t)
}

// Matrix stuff

mat_mul :: proc "c" ($N : int, $T : typeid, t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, matrix[N, N]T)
	a := cy.get(t, matrix[N, N]T)
	b := cy.get(t, matrix[N, N]T)
	res^ = a^ * b^
	return .Ok
}

// mat 2

cy_mat2f32_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(2, f32, t)
}

cy_mat2f64_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(2, f64, t)
}

cy_mat2u8_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(2, u8, t)
}

cy_mat2u16_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(2, u16, t)
}

cy_mat2u32_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(2, u32, t)
}

cy_mat2u64_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(2, u64, t)
}

cy_mat2i8_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(2, i8, t)
}

cy_mat2i16_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(2, i16, t)
}

cy_mat2i32_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(2, i32, t)
}

cy_mat2i64_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(2, i64, t)
}

// mat 3

cy_mat3f32_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(3, f32, t)
}

cy_mat3f64_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(3, f64, t)
}

cy_mat3u8_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(3, u8, t)
}

cy_mat3u16_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(3, u16, t)
}

cy_mat3u32_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(3, u32, t)
}

cy_mat3u64_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(3, u64, t)
}

cy_mat3i8_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(3, i8, t)
}

cy_mat3i16_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(3, i16, t)
}

cy_mat3i32_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(3, i32, t)
}

cy_mat3i64_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(3, i64, t)
}

// mat 4

cy_mat4f32_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(4, f32, t)
}

cy_mat4f64_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(4, f64, t)
}

cy_mat4u8_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(4, u8, t)
}

cy_mat4u16_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(4, u16, t)
}

cy_mat4u32_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(4, u32, t)
}

cy_mat4u64_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(4, u64, t)
}

cy_mat4i8_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(4, i8, t)
}

cy_mat4i16_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(4, i16, t)
}

cy_mat4i32_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(4, i32, t)
}

cy_mat4i64_mul :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return mat_mul(4, i64, t)
}

// Vector stuff

vector_add_f32 :: proc "c" ($N : int, t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, [N]f32)

	vec := cy.get(t, [N]f32)
	scal := cy.get_prim(t, f32)
	res^ = vec^ + scal

	return .Ok
}

vector_add_vec :: proc "c" ($N : int, t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, [N]f32)

	vec := cy.get(t, [N]f32)
	b := cy.get(t, [N]f32)
	res^ = vec^ + b^

	return .Ok
}

vector_sub_f32 :: proc "c" ($N : int, t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, [N]f32)

	vec := cy.get(t, [N]f32)
	scal := cy.get_prim(t, f32)
	res^ = vec^ - scal

	return .Ok
}

vector_sub_vec :: proc "c" ($N : int, t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, [N]f32)

	vec := cy.get(t, [N]f32)
	b := cy.get(t, [N]f32)
	res^ = vec^ - b^

	return .Ok
}

vector_mul_f32 :: proc "c" ($N : int, t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, [N]f32)

	vec := cy.get(t, [N]f32)
	scal := cy.get_prim(t, f32)
	res^ = vec^ * scal

	return .Ok
}

vector_mul_vec :: proc "c" ($N : int, t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, [N]f32)

	vec := cy.get(t, [N]f32)
	b := cy.get(t, [N]f32)
	res^ = vec^ * b^

	return .Ok
}

vector_div_f32 :: proc "c" ($N : int, t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, [N]f32)

	vec := cy.get(t, [N]f32)
	scal := cy.get_prim(t, f32)
	res^ = vec^ / scal

	return .Ok
}

vector_div_vec :: proc "c" ($N : int, t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, [N]f32)

	vec := cy.get(t, [N]f32)
	b := cy.get(t, [N]f32)
	res^ = vec^ / b^

	return .Ok
}

vector_neg :: proc "c" ($N : int, t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, [N]f32)

	vec := cy.get(t, [N]f32)
	res^ = -vec^

	return .Ok
}

cy_vec2_add_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_add_f32(2, t)
}

cy_vec2_add_vec2 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_add_vec(2, t)
}

cy_vec2_sub_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_sub_f32(2, t)
}

cy_vec2_sub_vec2 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_sub_vec(2, t)
}

cy_vec2_mul_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_mul_f32(2, t)
}

cy_vec2_mul_vec2 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_mul_vec(2, t)
}

cy_vec2_div_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_div_f32(2, t)
}

cy_vec2_div_vec2 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_div_vec(2, t)
}

cy_vec2_neg :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_neg(2, t)
}

cy_vec3_add_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_add_f32(3, t)
}

cy_vec3_add_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_add_vec(3, t)
}

cy_vec3_sub_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_sub_f32(3, t)
}

cy_vec3_sub_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_sub_vec(3, t)
}

cy_vec3_mul_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_mul_f32(3, t)
}

cy_vec3_mul_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_mul_vec(3, t)
}

cy_vec3_div_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_div_f32(3, t)
}

cy_vec3_div_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_div_vec(3, t)
}

cy_vec3_neg :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_neg(3, t)
}

cy_vec4_add_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_add_f32(4, t)
}

cy_vec4_add_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_add_vec(4, t)
}

cy_vec4_sub_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_sub_f32(4, t)
}

cy_vec4_sub_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_sub_vec(4, t)
}

cy_vec4_mul_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_mul_f32(4, t)
}

cy_vec4_mul_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_mul_vec(4, t)
}

cy_vec4_div_f32 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_div_f32(4, t)
}

cy_vec4_div_vec3 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_div_vec(4, t)
}

cy_vec4_neg :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return vector_neg(4, t)
}

// Mod

FUNCS :: [?]struct {
	n : string,
	p : proc "c" (t : ^cy.Thread) -> cy.Ret,
} {
	{"abs_f32", cy_abs_f32},
	{"abs_f64", cy_abs_f64},
	{"abs_i8", cy_abs_i8},
	{"abs_i16", cy_abs_i16},
	{"abs_i32", cy_abs_i32},
	{"abs_i64", cy_abs_i64},
	{"acos_f32", cy_acos_f32},
	{"acos_f64", cy_acos_f64},
	{"acosh_f32", cy_acosh_f32},
	{"acosh_f64", cy_acosh_f64},
	{"asin_f32", cy_asin_f32},
	{"asin_f64", cy_asin_f64},
	{"asinh_f32", cy_asinh_f32},
	{"asinh_f64", cy_asinh_f64},
	{"atan_f32", cy_atan_f32},
	{"atan_f64", cy_atan_f64},
	{"atan2_f32", cy_atan2_f32},
	{"atan2_f64", cy_atan2_f64},
	{"atanh_f32", cy_atanh_f32},
	{"atanh_f64", cy_atanh_f64},
	{"cbrt_f32", cy_cbrt_f32},
	{"cbrt_f64", cy_cbrt_f64},
	{"ceil_f32", cy_ceil_f32},
	{"ceil_f64", cy_ceil_f64},
	{"clamp_f32", cy_clamp_f32},
	{"clamp_f64", cy_clamp_f64},
	{"clamp_u8", cy_clamp_u8},
	{"clamp_u16", cy_clamp_u16},
	{"clamp_u32", cy_clamp_u32},
	{"clamp_u64", cy_clamp_u64},
	{"clamp_i8", cy_clamp_i8},
	{"clamp_i16", cy_clamp_i16},
	{"clamp_i32", cy_clamp_i32},
	{"clamp_i64", cy_clamp_i64},
	{"clz_f32", cy_clz_f32},
	{"copysign_f32", cy_copysign_f32},
	{"copysign_f64", cy_copysign_f64},
	{"cos_f32", cy_cos_f32},
	{"cos_f64", cy_cos_f64},
	{"cosh_f32", cy_cosh_f32},
	{"cosh_f64", cy_cosh_f64},
	{"deg_to_rad_f32", cy_deg_to_rad_f32},
	{"deg_to_rad_f64", cy_deg_to_rad_f64},
	{"exp_f32", cy_exp_f32},
	{"exp_f64", cy_exp_f64},
	{"expm1_f32", cy_expm1_f32},
	{"expm1_f64", cy_expm1_f64},
	{"floor_f32", cy_floor_f32},
	{"floor_f64", cy_floor_f64},
	{"frac_f32", cy_frac_f32},
	{"frac_f64", cy_frac_f64},
	{"hypot_f32", cy_hypot_f32},
	{"hypot_f64", cy_hypot_f64},
	{"is_inf_f32", cy_is_inf_f32},
	{"is_inf_f64", cy_is_inf_f64},
	{"is_int_f32", cy_is_int_f32},
	{"is_int_f64", cy_is_int_f64},
	{"is_nan_f32", cy_is_nan_f32},
	{"is_nan_f64", cy_is_nan_f64},
	{"lerp_f32", cy_lerp_f32},
	{"lerp_f64", cy_lerp_f64},
	{"lerp_vec2", cy_lerp_vec2},
	{"lerp_vec3", cy_lerp_vec3},
	{"lerp_vec4", cy_lerp_vec4},
	{"lerp_quat", cy_lerp_quat},
	{"ln_f32", cy_ln_f32},
	{"ln_f64", cy_ln_f64},
	{"log_f32", cy_log_f32},
	{"log_f64", cy_log_f64},
	{"log10_f32", cy_log10_f32},
	{"log10_f64", cy_log10_f64},
	{"log1p_f32", cy_log1p_f32},
	{"log1p_f64", cy_log1p_f64},
	{"log2_f32", cy_log2_f32},
	{"log2_f64", cy_log2_f64},
	{"max_f32", cy_max_f32},
	{"max_f64", cy_max_f64},
	{"max_i8", cy_max_i8},
	{"max_i16", cy_max_i16},
	{"max_i32", cy_max_i32},
	{"max_i64", cy_max_i64},
	{"max_u8", cy_max_u8},
	{"max_u16", cy_max_u16},
	{"max_u32", cy_max_u32},
	{"max_u64", cy_max_u64},
	{"max_vec2", cy_max_vec2},
	{"max_vec3", cy_max_vec3},
	{"max_vec4", cy_max_vec4},
	{"min_f32", cy_min_f32},
	{"min_f64", cy_min_f64},
	{"min_i8", cy_min_i8},
	{"min_i16", cy_min_i16},
	{"min_i32", cy_min_i32},
	{"min_i64", cy_min_i64},
	{"min_u8", cy_min_u8},
	{"min_u16", cy_min_u16},
	{"min_u32", cy_min_u32},
	{"min_u64", cy_min_u64},
	{"min_vec2", cy_min_vec2},
	{"min_vec3", cy_min_vec3},
	{"min_vec4", cy_min_vec4},
	{"mul_f32", cy_mul_f32},
	{"pow_f32", cy_pow_f32},
	{"pow_f64", cy_pow_f64},
	{"rad_to_deg_f32", cy_rad_to_deg_f32},
	{"random", cy_random},
	{"randint", cy_randint},
	{"remap_f32", cy_remap_f32},
	{"remap_f64", cy_remap_f64},
	{"remap_vec2", cy_remap_vec2},
	{"remap_vec3", cy_remap_vec3},
	{"remap_vec4", cy_remap_vec4},
	{"round_f32", cy_round_f32},
	{"round_f64", cy_round_f64},
	{"round_to_int_f32", cy_round_to_int_f32},
	{"round_to_int_f64", cy_round_to_int_f64},
	{"sign_f32", cy_sign_f32},
	{"sign_f64", cy_sign_f64},
	{"sign_i8", cy_sign_i8},
	{"sign_i16", cy_sign_i16},
	{"sign_int32", cy_sign_int32},
	{"sign_i64", cy_sign_i64},
	{"sin_f32", cy_sin_f32},
	{"sin_f64", cy_sin_f64},
	{"sinh_f32", cy_sinh_f32},
	{"sinh_f64", cy_sinh_f64},
	{"sqrt_f32", cy_sqrt_f32},
	{"sqrt_f64", cy_sqrt_f64},
	{"tan_f32", cy_tan_f32},
	{"tan_f64", cy_tan_f64},
	{"tanh_f32", cy_tanh_f32},
	{"tanh_f64", cy_tanh_f64},
	{"trunc_f32", cy_trunc_f32},
	{"trunc_f64", cy_trunc_f64},
	// Vector operations
	{"vec2_add_f32", cy_vec2_add_f32},
	{"vec2_add_vec2", cy_vec2_add_vec2},
	{"vec2_sub_f32", cy_vec2_sub_f32},
	{"vec2_sub_vec2", cy_vec2_sub_vec2},
	{"vec2_mul_f32", cy_vec2_mul_f32},
	{"vec2_mul_vec2", cy_vec2_mul_vec2},
	{"vec2_div_f32", cy_vec2_div_f32},
	{"vec2_div_vec2", cy_vec2_div_vec2},
	{"vec2_neg", cy_vec2_neg},
	{"vec3_add_f32", cy_vec3_add_f32},
	{"vec3_add_vec3", cy_vec3_add_vec3},
	{"vec3_sub_f32", cy_vec3_sub_f32},
	{"vec3_sub_vec3", cy_vec3_sub_vec3},
	{"vec3_mul_f32", cy_vec3_mul_f32},
	{"vec3_mul_vec3", cy_vec3_mul_vec3},
	{"vec3_div_f32", cy_vec3_div_f32},
	{"vec3_div_vec3", cy_vec3_div_vec3},
	{"vec3_neg", cy_vec3_neg},
	{"vec4_add_f32", cy_vec4_add_f32},
	{"vec4_add_vec3", cy_vec4_add_vec3},
	{"vec4_sub_f32", cy_vec4_sub_f32},
	{"vec4_sub_vec3", cy_vec4_sub_vec3},
	{"vec4_mul_f32", cy_vec4_mul_f32},
	{"vec4_mul_vec3", cy_vec4_mul_vec3},
	{"vec4_div_f32", cy_vec4_div_f32},
	{"vec4_div_vec3", cy_vec4_div_vec3},
	{"vec4_neg", cy_vec4_neg},
	// Matrix operations
	{"mat2f32_mul", cy_mat2f32_mul},
	{"mat2f64_mul", cy_mat2f64_mul},
	{"mat2u8_mul", cy_mat2u8_mul},
	{"mat2u16_mul", cy_mat2u16_mul},
	{"mat2u32_mul", cy_mat2u32_mul},
	{"mat2u64_mul", cy_mat2u64_mul},
	{"mat2i8_mul", cy_mat2i8_mul},
	{"mat2i16_mul", cy_mat2i16_mul},
	{"mat2i32_mul", cy_mat2i32_mul},
	{"mat2i64_mul", cy_mat2i64_mul},
	{"mat3f32_mul", cy_mat3f32_mul},
	{"mat3f64_mul", cy_mat3f64_mul},
	{"mat3u8_mul", cy_mat3u8_mul},
	{"mat3u16_mul", cy_mat3u16_mul},
	{"mat3u32_mul", cy_mat3u32_mul},
	{"mat3u64_mul", cy_mat3u64_mul},
	{"mat3i8_mul", cy_mat3i8_mul},
	{"mat3i16_mul", cy_mat3i16_mul},
	{"mat3i32_mul", cy_mat3i32_mul},
	{"mat3i64_mul", cy_mat3i64_mul},
	{"mat4f32_mul", cy_mat4f32_mul},
	{"mat4f64_mul", cy_mat4f64_mul},
	{"mat4u8_mul", cy_mat4u8_mul},
	{"mat4u16_mul", cy_mat4u16_mul},
	{"mat4u32_mul", cy_mat4u32_mul},
	{"mat4u64_mul", cy_mat4u64_mul},
	{"mat4i8_mul", cy_mat4i8_mul},
	{"mat4i16_mul", cy_mat4i16_mul},
	{"mat4i32_mul", cy_mat4i32_mul},
	{"mat4i64_mul", cy_mat4i64_mul},
}

@(private)
load_math_api :: proc(vm : ^cy.VM, mod : ^cy.Sym, res : ^cy.LoaderResult) -> bool {
	for f in FUNCS {
		cy.mod_add_func(mod, cy.alias_string_to_bytes(f.n), cy.bind_func(f.p))
	}

	res.src = cy.alias_string_to_bytes(#load("api/math.cy", string))

	return true
}

