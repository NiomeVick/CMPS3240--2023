	.arch armv8-a
	.file	"main.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	mov	x29, sp
	str	w0, [sp, 28]
	str	x1, [sp, 16]
	mov	w0, 49664
	movk	w0, 0xbeb, lsl 16
	str	w0, [sp, 44]
	ldrsw	x0, [sp, 44]
	lsl	x0, x0, 2
	bl	malloc
	str	x0, [sp, 48]
	ldrsw	x0, [sp, 44]
	lsl	x0, x0, 2
	bl	malloc
	str	x0, [sp, 56]
	str	wzr, [sp, 40]
	b	.L2
.L3:
	ldrsw	x0, [sp, 40]
	lsl	x0, x0, 2
	ldr	x1, [sp, 56]
	add	x0, x1, x0
	ldr 	w2, [x0]
	ldr	w9, [x0, 4]
	ldr	w1, [x0]
	ldrsw	x0, [sp, 40]
	lsl	x0, x0, 2
	ldr	x3, [sp, 48]
	add	x0, x3, x0
	mul	w1, w2, w2
	str	w1, [x0]
	mul 	w10, w9, w9
	str 	w1, [x0]
	ldr	w0, [sp, 40]
	add	w0, w0, 2
	str	w0, [sp, 40]
.L2:
	ldr	w1, [sp, 40]
	ldr	w0, [sp, 44]
	cmp	w1, w0
	cset	w0, lt
	and	w0, w0, 255
	cmp	w0, 0
	bne	.L3
	ldr	x0, [sp, 48]
	bl	free
	ldr	x0, [sp, 56]
	bl	free
	mov	w0, 0
	ldp	x29, x30, [sp], 64
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
