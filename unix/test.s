	.cstring
LC0:
	.ascii "\12Hola a todos\0"
	.align 2
LC1:
	.ascii "\12Este programa va a ser debugeado\0"
LC2:
	.ascii "\12 i = %d\0"
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
	movl	%eax, (%esp)
	call	L_printf$stub
	leal	LC1-"L00000000001$pb"(%ebx), %eax
	movl	%eax, (%esp)
	call	L_printf$stub
	movl	$0, -12(%ebp)
	jmp	L2
L3:
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	LC2-"L00000000001$pb"(%ebx), %eax
	movl	%eax, (%esp)
	call	L_printf$stub
	leal	-12(%ebp), %eax
	incl	(%eax)
L2:
	cmpl	$9, -12(%ebp)
	jle	L3
	movl	$10, (%esp)
	call	L_putchar$stub
	addl	$36, %esp
	popl	%ebx
	leave
	ret
	.section __IMPORT,__jump_table,symbol_stubs,self_modifying_code+pure_instructions,5
L_putchar$stub:
	.indirect_symbol _putchar
	hlt ; hlt ; hlt ; hlt ; hlt
L_printf$stub:
	.indirect_symbol _printf
	hlt ; hlt ; hlt ; hlt ; hlt
	.subsections_via_symbols
