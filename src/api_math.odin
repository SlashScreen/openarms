#+private file
package main

import "base:intrinsics"
import "core:c"
import "core:math"
import "core:math/bits"
import "core:math/linalg"
import "core:math/rand"
import "core:mem"
import "core:reflect"
import "core:slice"
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

cy_abs_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

cy_abs_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

cy_abs_i8 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i8
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

cy_abs_i16 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i16
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

cy_abs_i32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i32
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

cy_abs_i64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i64
	return u_op(T, proc "contextless" (x : T) -> T {return abs(x)}, t)
}

// Acos

cy_acos_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.acos(x)}, t)
}

cy_acos_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.acos(x)}, t)
}

// Acosh

cy_acosh_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.acosh(x)}, t)
}

cy_acosh_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.acosh(x)}, t)
}

// Asin

cy_asin_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.asin(x)}, t)
}

cy_asin_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.asin(x)}, t)
}

// Asinh

cy_asinh_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.asinh(x)}, t)
}

cy_asinh_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.asinh(x)}, t)
}

// Atan

cy_atan_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.atan(x)}, t)
}

cy_atan_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.atan(x)}, t)
}

// Atan2

cy_atan2_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	y := cy.get_prim(t, f32)
	x := cy.get_prim(t, f32)
	res^ = math.atan2(y, x)
	return .Ok
}

cy_atan2_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f64)
	y := cy.get_prim(t, f64)
	x := cy.get_prim(t, f64)
	res^ = math.atan2(y, x)
	return .Ok
}

// Atanh

cy_atanh_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.atanh(x)}, t)
}

cy_atanh_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.atanh(x)}, t)
}

// cbrt (cube root)

cy_cbrt_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.pow(x, 1.0 / 3.0)}, t)
}

cy_cbrt_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.pow(x, 1.0 / 3.0)}, t)
}

// Ceil

cy_ceil_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.ceil(x)}, t)
}

cy_ceil_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.ceil(x)}, t)
}

// Clamp

cy_clamp_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	x := cy.get_prim(t, f32)
	min := cy.get_prim(t, f32)
	max := cy.get_prim(t, f32)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f64)
	x := cy.get_prim(t, f64)
	min := cy.get_prim(t, f64)
	max := cy.get_prim(t, f64)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_u8 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, u8)
	x := cy.get_prim(t, u8)
	min := cy.get_prim(t, u8)
	max := cy.get_prim(t, u8)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_u16 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, u16)
	x := cy.get_prim(t, u16)
	min := cy.get_prim(t, u16)
	max := cy.get_prim(t, u16)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_u32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, u32)
	x := cy.get_prim(t, u32)
	min := cy.get_prim(t, u32)
	max := cy.get_prim(t, u32)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_u64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, u64)
	x := cy.get_prim(t, u64)
	min := cy.get_prim(t, u64)
	max := cy.get_prim(t, u64)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_i8 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i8)
	x := cy.get_prim(t, i8)
	min := cy.get_prim(t, i8)
	max := cy.get_prim(t, i8)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_i16 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i16)
	x := cy.get_prim(t, i16)
	min := cy.get_prim(t, i16)
	max := cy.get_prim(t, i16)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_i32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i32)
	x := cy.get_prim(t, i32)
	min := cy.get_prim(t, i32)
	max := cy.get_prim(t, i32)
	res^ = math.clamp(x, min, max)
	return .Ok
}

cy_clamp_i64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i64)
	x := cy.get_prim(t, i64)
	min := cy.get_prim(t, i64)
	max := cy.get_prim(t, i64)
	res^ = math.clamp(x, min, max)
	return .Ok
}

// Clz (count leading zeros)

cy_clz_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i32)
	x := cy.get_prim(t, f32)
	res^ = bits.leading_zeros(transmute(i32)x)
	return .Ok
}

// Copysign

copy_sign :: proc($T : typeid, mag : T, sign : T) -> T {
	return abs(x) * math.sign(sign)
}

cy_copysign_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(T, copy_sign, t)
}

cy_copysign_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return bin_op(T, copy_sign, t)
}

// Cos

cy_cos_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.cos(x)}, t)
}

cy_cos_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.cos(x)}, t)
}

// Cosh

cy_cosh_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.cosh(x)}, t)
}

cy_cosh_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.cosh(x)}, t)
}

// degToRad

cy_deg_to_rad_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.to_radians(x)}, t)
}

cy_deg_to_rad_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.to_radians(x)}, t)
}

// Exp

cy_exp_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.exp(x)}, t)
}

cy_exp_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.exp(x)}, t)
}

// Expm1

cy_expm1_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.exp(x) - 1.0}, t)
}

cy_expm1_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.exp(x) - 1.0}, t)
}

// Floor

cy_floor_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.floor(x)}, t)
}

cy_floor_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.floor(x)}, t)
}

// Frac

cy_frac_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return linalg.fract(x)}, t)
}

cy_frac_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return linalg.fract(x)}, t)
}

// Hypot

cy_hypot_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	x := cy.get_prim(t, f32)
	y := cy.get_prim(t, f32)
	res^ = math.hypot(x, y)
	return .Ok
}

cy_hypot_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f64)
	x := cy.get_prim(t, f64)
	y := cy.get_prim(t, f64)
	res^ = math.hypot(x, y)
	return .Ok
}

// isInf

cy_is_inf_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f32)
	res^ = x == math.inf_f32(int(math.sign(x)))
	return .Ok
}

cy_is_inf_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f64)
	res^ = x == math.inf_f64(int(math.sign(x)))
	return .Ok
}

// isInt

cy_is_int_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f32)
	res^ = linalg.fract(x) == 0.0
	return .Ok
}

cy_is_int_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f64)
	res^ = linalg.fract(x) == 0.0
	return .Ok
}

// isNaN

cy_is_nan_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f32)
	res^ = math.is_nan(x)
	return .Ok
}

cy_is_nan_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, bool)
	x := cy.get_prim(t, f64)
	res^ = math.is_nan(x)
	return .Ok
}

// Lerp

cy_lerp_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	a := cy.get_prim(t, f32)
	b := cy.get_prim(t, f32)
	alpha := cy.get_prim(t, f32)
	res^ = math.lerp(a, b, alpha)
	return .Ok
}

cy_lerp_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f64)
	a := cy.get_prim(t, f64)
	b := cy.get_prim(t, f64)
	alpha := cy.get_prim(t, f64)
	res^ = math.lerp(a, b, alpha)
	return .Ok
}

cy_lerp_vec2 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector2f32)
	a := cy.get_prim(t, linalg.Vector2f32)
	b := cy.get_prim(t, linalg.Vector2f32)
	alpha := cy.get_prim(t, f32)
	res^ = linalg.lerp(a, b, alpha)
	return .Ok
}

cy_lerp_vec3 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector3f32)
	a := cy.get_prim(t, linalg.Vector3f32)
	b := cy.get_prim(t, linalg.Vector3f32)
	alpha := cy.get_prim(t, f32)
	res^ = linalg.lerp(a, b, alpha)
	return .Ok
}

cy_lerp_vec4 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector4f32)
	a := cy.get_prim(t, linalg.Vector4f32)
	b := cy.get_prim(t, linalg.Vector4f32)
	alpha := cy.get_prim(t, f32)
	res^ = linalg.lerp(a, b, alpha)
	return .Ok
}

cy_lerp_quat :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Quaternionf32)
	a := cy.get_prim(t, linalg.Quaternionf32)
	b := cy.get_prim(t, linalg.Quaternionf32)
	alpha := cy.get_prim(t, f32)
	res^ = linalg.lerp(a, b, alpha)
	return .Ok
}

// Ln

cy_ln_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.ln(x)}, t)
}

cy_ln_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.ln(x)}, t)
}

// Log

cy_log_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(T, proc "contextless" (base : T, x : T) -> T {return math.log(x, base)}, t)
}

cy_log_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return bin_op(T, proc "contextless" (base : T, x : T) -> T {return math.log(x, base)}, t)
}

// Log10

cy_log10_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.log10(x)}, t)
}

cy_log10_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.log10(x)}, t)
}

// Log1p

cy_log1p_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.ln(1.0 + x)}, t)
}

cy_log1p_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.ln(1.0 + x)}, t)
}

// Log2

cy_log2_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.log2(x)}, t)
}

cy_log2_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.log2(x)}, t)
}

// Max

cy_max_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_i8 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i8
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_i16 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i16
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_i32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_i64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_u8 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: u8
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_u16 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: u16
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_u32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: u32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_u64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: u64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.max(a, b)}, t)
}

cy_max_vec2 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector2f32)
	a := cy.get_prim(t, linalg.Vector2f32)
	b := cy.get_prim(t, linalg.Vector2f32)
	res^ = linalg.max(a, b)
	return .Ok
}

cy_max_vec3 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector3f32)
	a := cy.get_prim(t, linalg.Vector3f32)
	b := cy.get_prim(t, linalg.Vector3f32)
	res^ = linalg.max(a, b)
	return .Ok
}

cy_max_vec4 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector4f32)
	a := cy.get_prim(t, linalg.Vector4f32)
	b := cy.get_prim(t, linalg.Vector4f32)
	res^ = linalg.max(a, b)
	return .Ok
}

// Min

cy_min_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_i8 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i8
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_i16 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i16
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_i32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_i64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: i64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_u8 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: u8
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_u16 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: u16
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_u32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: u32
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_u64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: u64
	return bin_op(T, proc "contextless" (a : T, b : T) -> T {return math.min(a, b)}, t)
}

cy_min_vec2 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector2f32)
	a := cy.get_prim(t, linalg.Vector2f32)
	b := cy.get_prim(t, linalg.Vector2f32)
	res^ = linalg.min(a, b)
	return .Ok
}

cy_min_vec3 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector3f32)
	a := cy.get_prim(t, linalg.Vector3f32)
	b := cy.get_prim(t, linalg.Vector3f32)
	res^ = linalg.min(a, b)
	return .Ok
}

cy_min_vec4 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector4f32)
	a := cy.get_prim(t, linalg.Vector4f32)
	b := cy.get_prim(t, linalg.Vector4f32)
	res^ = linalg.min(a, b)
	return .Ok
}

// Mul32

cy_mul_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
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

cy_pow_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return bin_op(T, proc "contextless" (a : T, y : T) -> T {return math.pow(a, y)}, t)
}

cy_pow_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return bin_op(T, proc "contextless" (a : T, y : T) -> T {return math.pow(a, y)}, t)
}

// radToDeg

cy_rad_to_deg_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.to_degrees(x)}, t)
}

// Random

cy_random :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	res^ = rand.float32()
	return .Ok
}

cy_randint :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i32)
	min := cy.get_prim(t, i32)
	max := cy.get_prim(t, i32)
	res^ = i32(rand.int_range(int(min), int(max)))
	return .Ok
}

// Remap

cy_remap_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f32)
	x := cy.get_prim(t, f32)
	in_min := cy.get_prim(t, f32)
	in_max := cy.get_prim(t, f32)
	out_min := cy.get_prim(t, f32)
	out_max := cy.get_prim(t, f32)
	res^ = math.remap(x, in_min, in_max, out_min, out_max)
	return .Ok
}

cy_remap_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, f64)
	x := cy.get_prim(t, f64)
	in_min := cy.get_prim(t, f64)
	in_max := cy.get_prim(t, f64)
	out_min := cy.get_prim(t, f64)
	out_max := cy.get_prim(t, f64)
	res^ = math.remap(x, in_min, in_max, out_min, out_max)
	return .Ok
}

cy_remap_vec2 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector2f32)
	x := cy.get_prim(t, linalg.Vector2f32)
	in_min := cy.get_prim(t, linalg.Vector2f32)
	in_max := cy.get_prim(t, linalg.Vector2f32)
	out_min := cy.get_prim(t, linalg.Vector2f32)
	out_max := cy.get_prim(t, linalg.Vector2f32)
	res^ = linalg.Vector2f32 {
		math.remap(x.x, in_min.x, in_max.x, out_min.x, out_max.x),
		math.remap(x.y, in_min.y, in_max.y, out_min.y, out_max.y),
	}
	return .Ok
}

cy_remap_vec3 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector3f32)
	x := cy.get_prim(t, linalg.Vector3f32)
	in_min := cy.get_prim(t, linalg.Vector3f32)
	in_max := cy.get_prim(t, linalg.Vector3f32)
	out_min := cy.get_prim(t, linalg.Vector3f32)
	out_max := cy.get_prim(t, linalg.Vector3f32)
	res^ = linalg.Vector3f32 {
		math.remap(x.x, in_min.x, in_max.x, out_min.x, out_max.x),
		math.remap(x.y, in_min.y, in_max.y, out_min.y, out_max.y),
		math.remap(x.z, in_min.z, in_max.z, out_min.z, out_max.z),
	}
	return .Ok
}

cy_remap_vec4 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, linalg.Vector4f32)
	x := cy.get_prim(t, linalg.Vector4f32)
	in_min := cy.get_prim(t, linalg.Vector4f32)
	in_max := cy.get_prim(t, linalg.Vector4f32)
	out_min := cy.get_prim(t, linalg.Vector4f32)
	out_max := cy.get_prim(t, linalg.Vector4f32)
	res^ = linalg.Vector4f32 {
		math.remap(x.x, in_min.x, in_max.x, out_min.x, out_max.x),
		math.remap(x.y, in_min.y, in_max.y, out_min.y, out_max.y),
		math.remap(x.z, in_min.z, in_max.z, out_min.z, out_max.z),
		math.remap(x.w, in_min.w, in_max.w, out_min.w, out_max.w),
	}
	return .Ok
}

// Round

cy_round_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.round(x)}, t)
}

cy_round_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.round(x)}, t)
}

cy_round_to_int_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i32)
	x := cy.get_prim(t, f32)
	res^ = i32(math.round(x))
	return .Ok
}

cy_round_to_int_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, i64)
	x := cy.get_prim(t, f64)
	res^ = i64(math.round(x))
	return .Ok
}

// Sign

cy_sign_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.sign(x)}, t)
}

cy_sign_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.sign(x)}, t)
}

cy_sign_i8 :: proc(t : ^cy.Thread) -> cy.Ret {
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

cy_sign_i16 :: proc(t : ^cy.Thread) -> cy.Ret {
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

cy_sign_int32 :: proc(t : ^cy.Thread) -> cy.Ret {
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

cy_sign_i64 :: proc(t : ^cy.Thread) -> cy.Ret {
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

cy_sin_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.sin(x)}, t)
}

cy_sin_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.sin(x)}, t)
}

// Sinh

cy_sinh_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.sinh(x)}, t)
}

cy_sinh_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.sinh(x)}, t)
}

// Sqrt

cy_sqrt_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.sqrt(x)}, t)
}

cy_sqrt_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.sqrt(x)}, t)
}

// Tan

cy_tan_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.tan(x)}, t)
}

cy_tan_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.tan(x)}, t)
}

// Tanh

cy_tanh_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.tanh(x)}, t)
}

cy_tanh_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.tanh(x)}, t)
}

// Trunc

cy_trunc_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f32
	return u_op(T, proc "contextless" (x : T) -> T {return math.trunc(x)}, t)
}

cy_trunc_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
	T :: f64
	return u_op(T, proc "contextless" (x : T) -> T {return math.trunc(x)}, t)
}

// Matrix stuff

// matrix_type :: proc($N : int, id : cy.TypeId) -> (typeid, bool) {
// 	#partial switch id {
// 	case .I8:
// 		return matrix[N, N]i8, true
// 	case .I16:
// 		return matrix[N, N]i16, true
// 	case .I32:
// 		return matrix[N, N]i32, true
// 	case .I64:
// 		return matrix[N, N]i64, true
// 	case .R8:
// 		return matrix[N, N]u8, true
// 	case .R16:
// 		return matrix[N, N]u16, true
// 	case .R32:
// 		return matrix[N, N]u32, true
// 	case .R64:
// 		return matrix[N, N]u64, true
// 	case .F32:
// 		return matrix[N, N]f32, true
// 	case .F64:
// 		return matrix[N, N]f64, true
// 	case:
// 		return matrix[N, N]u8, false
// 	}
// }

// matrix_4_type :: proc(id : cy.TypeId) -> (typeid, bool) {
// 	return matrix_type(4, id)
// }

// matrix_3_type :: proc(id : cy.TypeId) -> (typeid, bool) {
// 	return matrix_type(3, id)
// }

// matrix_2_type :: proc(id : cy.TypeId) -> (typeid, bool) {
// 	return matrix_type(2, id)
// }

// cy_init_mat :: proc(t : ^cy.Thread) -> cy.Ret {
// 	i := cy.get_prim(t, u8)
// 	kind := cy.get_prim(t, i32)

// 	type_id := cy.type_id_to_type(kind)

// 	mat_t : typeid
// 	ok : bool
// 	switch i {
// 	case 2:
// 		mat_t, ok = matrix_2_type(type_id)
// 	case 3:
// 		mat_t, ok = matrix_3_type(type_id)
// 	case 4:
// 		mat_t, ok = matrix_4_type(type_id)
// 	case:
// 		log_err("Invalid matrix dimensions. This shouldn't happen.")
// 		return .Ok
// 	}

// 	if !ok {
// 		log_err("Invalid matrix type. This shouldn't happen.")
// 		return .Ok
// 	}

// 	// TODO: Optional
// 	res := cy.thread_param(t, uint(reflect.size_of_typeid(mat_t)))
// 	// Copy the raw vector data into the matrix
// 	stride := reflect.size_of_typeid(cy.type_to_odin_type(type_id))
// 	buff_len := i * i * u8(stride)
// 	arr := cy.thread_param(t, uint(buff_len))

// 	mem.copy(res, arr, int(buff_len))

// 	return .Ok
// }

// mat_mul_internal :: proc($T : typeid, t : ^cy.Thread) -> cy.Ret {
// 	n := cy.get_prim(t, int)
// 	switch n {
// 	case 2:
// 		res := cy.get_ret(t, matrix[2, 2]T)
// 		a := cy.get_prim(t, matrix[2, 2]T)
// 		b := cy.get_prim(t, matrix[2, 2]T)
// 		res^ = a * b
// 	case 3:
// 		res := cy.get_ret(t, matrix[3, 3]T)
// 		a := cy.get_prim(t, matrix[3, 3]T)
// 		b := cy.get_prim(t, matrix[3, 3]T)
// 		res^ = a * b
// 	case 4:
// 		res := cy.get_ret(t, matrix[4, 4]T)
// 		a := cy.get_prim(t, matrix[4, 4]T)
// 		b := cy.get_prim(t, matrix[4, 4]T)
// 		res^ = a * b
// 	}

// 	return .Ok
// }

// cy_mat_mul_f32 :: proc(t : ^cy.Thread) -> cy.Ret {
// 	return mat_mul_internal(f32, t)
// }

// cy_mat_mul_f64 :: proc(t : ^cy.Thread) -> cy.Ret {
// 	return mat_mul_internal(f64, t)
// }

// cy_mat_mul_i8 :: proc(t : ^cy.Thread) -> cy.Ret {
// 	return mat_mul_internal(i8, t)
// }

// cy_mat_mul_i16 :: proc(t : ^cy.Thread) -> cy.Ret {
// 	return mat_mul_internal(i16, t)
// }

// cy_mat_mul_i32 :: proc(t : ^cy.Thread) -> cy.Ret {
// 	return mat_mul_internal(i32, t)
// }

// cy_mat_mul_i64 :: proc(t : ^cy.Thread) -> cy.Ret {
// 	return mat_mul_internal(i64, t)
// }

// cy_mat_mul_u8 :: proc(t : ^cy.Thread) -> cy.Ret {
// 	return mat_mul_internal(u8, t)
// }

// cy_mat_mul_u16 :: proc(t : ^cy.Thread) -> cy.Ret {
// 	return mat_mul_internal(u16, t)
// }

// cy_mat_mul_u32 :: proc(t : ^cy.Thread) -> cy.Ret {
// 	return mat_mul_internal(u32, t)
// }

// cy_mat_mul_u64 :: proc(t : ^cy.Thread) -> cy.Ret {
// 	return mat_mul_internal(u64, t)
// }

cy_transform_init_euler :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, matrix[4, 4]f32)

	pos := cy.get(t, [3]f32)
	mat := linalg.MATRIX4F32_IDENTITY
	mat *= linalg.matrix4_translate(pos^)

	euler := cy.get(t, [3]f32)
	quat := linalg.quaternion_from_euler_angles_f32(euler.z, euler.y, euler.x, .ZYX)
	mat *= linalg.matrix4_rotate_f32(
		linalg.angle_from_quaternion_f32(quat),
		linalg.axis_from_quaternion_f32(quat),
	)

	res^ = mat

	return .Ok
}

cy_transform_init_quaternion :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, matrix[4, 4]f32)

	pos := cy.get(t, [3]f32)
	mat := linalg.MATRIX4F32_IDENTITY
	mat *= linalg.matrix4_translate(pos^)

	euler := cy.get(t, [3]f32)
	quat := cy.get(t, quaternion128)
	mat *= linalg.matrix4_rotate_f32(
		linalg.angle_from_quaternion_f32(quat^),
		linalg.axis_from_quaternion_f32(quat^),
	)

	res^ = mat

	return .Ok
}

cy_transform_translate :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, matrix[4, 4]f32)

	pos := cy.get(t, [3]f32)
	mat := cy.get(t, matrix[4, 4]f32)
	res^ = mat^ * linalg.matrix4_translate(pos^)

	return .Ok
}

