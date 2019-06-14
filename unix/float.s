	.cstring
LC2:
	.ascii "%f\0"
	.literal4
	.align 2
LC0:
	.long	0
	.align 2
LC1:
	.long	981668463
	.text
.globl _main
_main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	L6
"L00000000001$pb":
L6:
	popl	%ebx
	leal	LC0-"L00000000001$pb"(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
	leal	LC1-"L00000000001$pb"(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	$1, -12(%ebp)
	jmp	L2
L3:
	movss	-20(%ebp), %xmm0
	addss	-16(%ebp), %xmm0
	movss	%xmm0, -20(%ebp)
	leal	-12(%ebp), %eax
	incl	(%eax)
L2:
	cmpl	$1000, -12(%ebp)
	jle	L3
	cvtss2sd	-20(%ebp), %xmm0
	movsd	%xmm0, 4(%esp)
	leal	LC2-"L00000000001$pb"(%ebx), %eax
	movl	%eax, (%esp)
	call	L_printf$stub
	movl	$1, %eax
	addl	$36, %esp
	popl	%ebx
	leave
	ret
	.section __IMPORT,__jump_table,symbol_stubs,self_modifying_code+pure_instructions,5
L_printf$stub:
	.indirect_symbol _printf
	hlt ; hlt ; hlt ; hlt ; hlt
	.subsections_via_symbols
