.text
.global _start
_start:	mov x1, #7
	add x2, x1, x1

b2:	mov x8, #64
	mov x0, #1
	ldr x1, =msg
	ldr x2, =len
	svc #0

b1:	mov x8, #93
	mov x0, #0
	svc #0

.data
.global msg
msg: .ascii "Hello world\n"
len = . - msg

