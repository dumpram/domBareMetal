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
	ldr	r3, .L7
	str	r3, [fp, #-12]
	ldr	r2, .L7+4
	mov	r1, #32
	mov	r0, #0
	bl	HYPERVISOR_console_io
@ 23 "src/main.c" 1
	mov r10, #100
@ 0 "" 2
	ldr	r3, [fp, #-12]
	add	r3, r3, #64
	ldr	r2, [fp, #-12]
	add	r2, r2, #64
	ldr	r2, [r2]
	orr	r2, r2, #65536
	str	r2, [r3]
.L6:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L2
.L3:
@ 31 "src/main.c" 1
	mov r9, #100
@ 0 "" 2
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L2:
	ldr	r3, [fp, #-8]
	ldr	r2, .L7+8
	cmp	r3, r2
	ble	.L3
	ldr	r3, [fp, #-12]
	add	r3, r3, #68
	ldr	r2, [fp, #-12]
	add	r2, r2, #68
	ldr	r2, [r2]
	orr	r2, r2, #16
	str	r2, [r3]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L4
.L5:
@ 37 "src/main.c" 1
	mov r9, #100
@ 0 "" 2
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L4:
	ldr	r3, [fp, #-8]
	ldr	r2, .L7+8
	cmp	r3, r2
	ble	.L5
	ldr	r3, [fp, #-12]
	add	r3, r3, #68
	ldr	r2, [fp, #-12]
	add	r2, r2, #68
	ldr	r2, [r2]
	bic	r2, r2, #16
	str	r2, [r3]
	b	.L6
.L8:
	.align	2
.L7:
	.word	1094713344
	.word	.LC0
	.word	9999999
	.size	main, .-main
	.ident	"GCC: (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09) 4.9.2 20140904 (prerelease)"
