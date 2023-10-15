	.arch armv8-a
	.file	"ex1.c"
	.text
	.comm	x,8000,8
	.comm	y,8000,8
	.comm	result,8000,8
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.cfi_startproc
	sub	sp, sp, #12
	.cfi_def_cfa_offset 16
	str	wzr, [sp, 8]
	ldr 	x5, =x
	ldr 	x6, =y
	ldr	x7, =result 
	mov	w8, #13
	b	.L2
.L3:
	ldr 	w0, [x5], 4
	ldr	w1, [x6], 4	

	mul	w0, w0, w8
	add	w0, w1, w0
	str	w0, [x7], 4

	ldr 	w0, [sp, 8]
	add	w0, w0, 1
	str	w0, [sp, 8]

.L2:
	ldr	w0, [sp, 8]
	cmp	w0, 1999
	ble	.L3
	mov	w0, 0
	add	sp, sp, 12
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
