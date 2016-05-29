#include "stack.s"
#include "bss.s"

    .section ".start", "x"
    .align
    .globl    _start

_start:
    @ zImage header
.rept   8
    mov     r0, r0
.endr
    b       setup
    .word   0x016f2818      @ Magic numbers to help the loader
    .word   _start          @ absolute load/run zImage address
    .word   _end - _start   @ zImage size
    @ end of zImage header

setup:
    zero_bss
    setup_stacks

    @ Install exception vector table address
    ldr    r0, =exception_vector_table
    mcr    p15, 0, r0, c12, c0, 0
    

    cpsid  i            @ Disable interrupts
    
    mov r12, #18        @ 18 is console_io identifier
	mov r0, #0          @ 0 is write
	mov r1, #5          @ message length
	ldr r2, =msg        @ address of hello message
	.long 0xe140ea71    @ hvc 

__main:
    ldr lr,=__exit      @ go to exit after main
    b main
    
__exit:
    b   .
    
.align 4
msg:
    .asciz "hello"
    

