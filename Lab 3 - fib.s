# Code to print the first 10 numbers of the Fibonacci sequence
.text
.extern printf

# 'gcc' starts at 'main'
.global main
main:
### Initialize variables ###
# Initialize a (n=0)
mov x19, 0x0
# Initialize b (n=1)
mov x20, #1
# Initialize i (n=2)
mov x21, #2
# Initialize n = 11 so 10 terms print
mov x23, #11

### Code Start ###
# Start pretest loop
_looptop:
cmp x21, x23
bgt _bottom
ldr x0, =string1
add x24, x19, x20
mov x1, x24
bl printf
mov x19, x20
mov x20, x24
add x21, x21, 1
b _looptop
# End loop

_bottom:
# Exit - 'svc' w/ code 93. Return 0-x0
mov x8, #93
mov x0, #0
svc #0

### Static variable section
.data
# Printf string for printing a single character. %d is a single integer
.global string1
string1:
	.ascii "%d\n"
