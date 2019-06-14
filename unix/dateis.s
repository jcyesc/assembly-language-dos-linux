	.cstring
LC0:
	.ascii "The date is : %s\0"
	.text
.globl _main
_main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	L3
"L00000000001$pb":
L3:
	popl	%ebx
	leal	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	L_time$stub
	leal	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	L_ctime$stub
	movl	%eax, 4(%esp)
	leal	LC0-"L00000000001$pb"(%ebx), %eax
	movl	%eax, (%esp)
	call	L_printf$stub
	movl	$0, (%esp)
	call	L_exit$stub
	.section __IMPORT,__jump_table,symbol_stubs,self_modifying_code+pure_instructions,5
L_ctime$stub:
	.indirect_symbol _ctime
	hlt ; hlt ; hlt ; hlt ; hlt
L_printf$stub:
	.indirect_symbol _printf
	hlt ; hlt ; hlt ; hlt ; hlt
L_exit$stub:
	.indirect_symbol _exit
	hlt ; hlt ; hlt ; hlt ; hlt
L_time$stub:
	.indirect_symbol _time
	hlt ; hlt ; hlt ; hlt ; hlt
	.subsections_via_symbols
