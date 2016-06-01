	.cpu arm7tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"main.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"domB: Entered main function...\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r3, .L3
	str	r3, [fp, #-8]
	ldr	r2, .L3+4
	mov	r1, #32
	mov	r0, #0
	bl	HYPERVISOR_console_io
@ 21 "src/main.c" 1
	mov r10, #100
@ 0 "" 2
	ldr	r3, [fp, #-8]
	add	r3, r3, #3104
	ldr	r2, [fp, #-8]
	add	r2, r2, #3104
	ldr	r2, [r2]
	orr	r2, r2, #256
	str	r2, [r3]
.L2:
@ 28 "src/main.c" 1
	mov r9, #100
@ 0 "" 2
	ldr	r3, [fp, #-8]
	add	r3, r3, #3104
	add	r3, r3, #4
	ldr	r2, [fp, #-8]
	add	r2, r2, #3104
	add	r2, r2, #4
	ldr	r2, [r2]
	orr	r2, r2, #4
	str	r2, [r3]
	b	.L2
.L4:
	.align	2
.L3:
	.word	1094713344
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09) 4.9.2 20140904 (prerelease)"
