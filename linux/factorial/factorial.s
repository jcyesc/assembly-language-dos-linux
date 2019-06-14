	.file	"factorial.c"
	.section	.rodata
	.align 4
.LC0:
	.string	"Iterative and Recursive Factorial Functions"
.LC1:
	.string	"\nFactorial(%d) = %d"
.LC2:
	.string	"\nFactorial(%d) = %d\n"
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
	subl	$36, %esp
	movl	$.LC0, (%esp)
	call	puts
	movl	$5, (%esp)
	call	factorialIterativo
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$5, 4(%esp)
	movl	$.LC1, (%esp)
	call	printf
	movl	$6, (%esp)
	call	factorialRecursivo
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$6, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	addl	$36, %esp
	popl	%ecx
	popl	%ebp
	leal	-4(%ecx), %esp
	ret
	.size	main, .-main
.globl factorialIterativo
	.type	factorialIterativo, @function
factorialIterativo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
	cmpl	$1, 8(%ebp)
	jg	.L7
	movl	$1, -20(%ebp)
	jmp	.L6
.L8:
	subl	$1, 8(%ebp)
	movl	-4(%ebp), %eax
	imull	8(%ebp), %eax
	movl	%eax, -4(%ebp)
.L7:
	cmpl	$1, 8(%ebp)
	jne	.L8
	movl	-4(%ebp), %eax
	movl	%eax, -20(%ebp)
.L6:
	movl	-20(%ebp), %eax
	leave
	ret
	.size	factorialIterativo, .-factorialIterativo
.globl factorialRecursivo
	.type	factorialRecursivo, @function
factorialRecursivo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$1, 8(%ebp)
	jg	.L12
	movl	$1, -4(%ebp)
	jmp	.L14
.L12:
	movl	8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, (%esp)
	call	factorialRecursivo
	movl	%eax, %edx
	imull	8(%ebp), %edx
	movl	%edx, -4(%ebp)
.L14:
	movl	-4(%ebp), %eax
	leave
	ret
	.size	factorialRecursivo, .-factorialRecursivo
	.ident	"GCC: (GNU) 4.2.4 (Ubuntu 4.2.4-1ubuntu3)"
	.section	.note.GNU-stack,"",@progbits
