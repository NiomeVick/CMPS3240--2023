.text
.global _start
_start:
	mov x0, 0xffffffffffffffff
	mov w1, 0xffffffff
_a1:
	mov x3, #12
	mov x4, 0xfffffffffffffffe
	add x5, x3, x4
_a2:
	ldr x0, =badger
_b1:
	ldr w2, [x0]
	add w2, w2, 3
_b2:
	str w2, [x0]
_b3:
	ldr x1, =coyote
	ldr x6, =fox
	ldr w2, [x1]
	str w2, [x6]
	ldr w2, [x1,#4]
	str w2, [x6,#4]
	ldr w2, [x1,#8]
	str w2, [x6,#8]
	ldr w2, [x1,#12]
	str w2, [x6,#12]
	ldr w2, [x1,#16]
	str w2, [x6,#16]
	ldr w2, [x1,#20]
	str w2, [x6,#20]
_b4:
	mov x8, #93
	mov x0, #0
	svc #0

.data
.global badger
badger:
	.word	7
.global eagle
eagle:
	.word 0

.global coyote
coyote:
	.word	0
	.word	2
	.word	4
	.word	6
	.word	8
	.word	10

.global fox
.comm fox, 200, 4
