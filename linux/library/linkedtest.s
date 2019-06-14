	.file	"linkedtest.c"
	.section	.rodata
	.align 4
.LC0:
	.string	"Calling functions made in assembly language"
	.text
.globl main
	.type	main, @function
main:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ecx
	subl	$20, %esp
	movl	$.LC0, (%esp)
	call	printf
	call	printtable
	call	myfunction
	movl	$3, 4(%esp)
	movl	$2, (%esp)
	call	myfunctionparameters
	call	myfunction
	call	printtable
	movl	$0, %eax
	addl	$20, %esp
	popl	%ecx
	popl	%ebp
	leal	-4(%ecx), %esp
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 4.2.4 (Ubuntu 4.2.4-1ubuntu3)"
	.section	.note.GNU-stack,"",@progbits
