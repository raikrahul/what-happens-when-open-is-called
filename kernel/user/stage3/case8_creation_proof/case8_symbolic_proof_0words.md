ffff888893e6e180 -> y ✓
0 -> x ✓
0x6e6f697461657263 -> a1 ✓
x ^ a1 -> x_a1 ✓
y ^ x_a1 -> y_a1 ✓
rol64(x_a1, 12) -> x_rot1 ✓
x_rot1 + y_a1 -> x_sum1 ✓
rol64(y_a1, 45) -> y_rot1 ✓
y_rot1 * 9 -> y1 ✓
x_sum1 -> x1 ✓
0x325f666f6f72705f -> a2 ✓
x1 ^ a2 -> x_a2 ✓
y1 ^ x_a2 -> y_a2 ✓
rol64(x_a2, 12) -> x_rot2 ✓
x_rot2 + y_a2 -> x_sum2 ✓
rol64(y_a2, 45) -> y_rot2 ✓
y_rot2 * 9 -> y2 ✓
x_sum2 -> x2 ✓
0x7478742e39383634 -> a3 ✓
x2 ^ a3 -> x_a3 ✓
y2 ^ x_a3 -> y_a3 ✓
rol64(x_a3, 12) -> x_rot3 ✓
x_rot3 + y_a3 -> x_sum3 ✓
rol64(y_a3, 45) -> y_rot3 ✓
y_rot3 * 9 -> y3 ✓
x_sum3 -> x3 ✓
0x61C8864680B583EB -> G ✓
y3 ^ (x3 * G) -> fold1 ✓
fold1 * G -> fold2 ✓
fold2 >> 32 -> 0xf421df87 ✓
0xf421df87 == 0xf421df87 ✓
∴ ✓
