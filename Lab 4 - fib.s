.data
.global string1
string1:
	.ascii	"The fibonacci of %d is %d!\n\0"
string2:
	.ascii	"Entering fib() with n=%d\n\0"

.text
.extern printf
.global main
main:
### SET UP FRAME RECORD ###
# Save FP and LR with pre-indexing, allocated another 16 bytes for temp.
stp	x29, x30, [sp, -16]!
# Set FP
add	x29, sp, 0

### MAIN() LOGIC ###
# Call fib(13)
mov	x0, 13
bl	fib
# Respond with prompt
add	x2, x0, 0
mov	x1, 13
ldr	x0, =string1
bl	printf

### TAKE DOWN FRAME RECORD ###
ldp	x29, x30, [sp], 16
mov	w0, 0
ret

.global fib
fib:
### SET UP FRAME RECORD ###
# Save FP and LR with pre-indexing, allocated another 16 bytes for temp.
stp	x29, x30, [sp, -64]!
# Set FP
add	x29, sp, 0
# Shadow input argument
str	x0, [sp, 16]

### SOME PROMPTS ###
ldr	x0, =string2
ldr	x1, [sp, 16]
bl printf

### LOGIC FOR FIB() ###
# Load N and compare with 1
ldr	x0, [sp, 16]
cmp	x0, 1
# If n <= 1, return 1 ... jump to block that returns 1
ble 	return1

# Logic for calc. fact(n-1) here. At this instruction the value for x0 
# should still hold arg1 for this call. Calculate n-1, note it's set up in x0 
# which is the argument register
sub	x0, x0, 1
# This is the call to fib(n-1). NON-LEAF FUNCTION
bl	fib
# At this point x0 contains the return value for fib(n-1). Refresh value for
# arg1.
# Push fib(n-1) value to stack in prep for fib(n-2) call
str x0, [sp, 24]
# Refresh N and calc n-2
ldr	x0, [sp, 16]
sub	x0, x0, 2
# Call fib(n-2). LEAF FUNCTION
bl	fib
# x0 should contain return value for fib(n-2)
# Now do the addition op, set it up to place result in return register.
ldr	x1, [sp, 24]
add	x0, x0, x1
b 	return

return1:
mov	x0, 1
# return1 block falls through to the return code

return:
ldp	x29, x30, [sp], 64
ret
