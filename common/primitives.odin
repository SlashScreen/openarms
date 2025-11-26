package common

import la "core:math/linalg"

Vec2i :: [2]int

m4_get_translation :: proc(mat: matrix[4,4]f32) -> la.Vector3f32 {
    return mat[3].xyz;
}
