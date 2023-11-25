	.arch armv8-a
	.file	"main.c"
	.text
	.align	2
	.global	myFMA
	.type	myFMA, %function
myFMA:
.LFB6:	
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	w0, [sp, 28]
	str	x1, [sp, 16]
	str	x2, [sp, 8]
	str	x3, [sp]
	
	# w0 - length
	# x1 - a
	# x2 - b
	# x3 - c
	# w4 - int i
	mov 	w4, #0

	looptop: cmp w4, w0
	bge mydone

	# a[i] = a[i] * b[i] + c[i]
	# a[i] * b[i]
	ld1	{v0.2s}, [x1]
	ld1	{v1.2s}, [x2], 8
	fmul	v0.2s, v0.2s, v1.2s
	# a[i] * b[i] + c[i]
	ld1	{v2.2s}, [x3], 8
	fadd	v0.2s, v0.2s, v2.2s
	st1	{v0.2s}, [x1], 8
	ld1	{v0.2s}, [x1]
	ld1	{v1.2s}, [x2], 8
	fmul	v0.2s, v0.2s, v1.2s
	# a[i] * b[i] + c[i]
	ld1	{v2.2s}, [x3], 8
	fadd	v0.2s, v0.2s, v2.2s
	st1	{v0.2s}, [x1], 8

	# Inside loop body
	add w4, w4, #4

	b looptop	

	mydone:

	nop
	add	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	myFMA, .-myFMA
	.align	2
	.global	main
	.type	main, %function
main:
.LFB7:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	mov	w0, 11520
	movk	w0, 0x131, lsl 16
	str	w0, [sp, 20]
	ldrsw	x0, [sp, 20]
	lsl	x0, x0, 2
	bl	malloc
	str	x0, [sp, 24]
	ldrsw	x0, [sp, 20]
	lsl	x0, x0, 2
	bl	malloc
	str	x0, [sp, 32]
	ldrsw	x0, [sp, 20]
	lsl	x0, x0, 2
	bl	malloc
	str	x0, [sp, 40]
	ldr	x3, [sp, 40]
	ldr	x2, [sp, 32]
	ldr	x1, [sp, 24]
	ldr	w0, [sp, 20]
	bl	myFMA
	ldr	x0, [sp, 24]
	bl	free
	ldr	x0, [sp, 32]
	bl	free
	ldr	x0, [sp, 40]
	bl	free
	mov	w0, 0
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
