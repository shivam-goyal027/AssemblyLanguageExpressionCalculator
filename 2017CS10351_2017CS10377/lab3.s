.equ SWI_EXIT,0x11
.equ SWI_Open,0x66
	.extern L3, expression, term, constant, itoa
.data
InFileName:	.asciz	"kile1.txt"
	.align
InFileHandle:	.word	0 
CharArray:  .skip 80
MyString:	.asciz	"\n"

.text
	.extern L3, expression, term, constant, itoa
ldr r0,=InFileName
mov r1,#0
swi SWI_Open
@bcs InFileError
ldr r1,=InFileHandle
str r0,[r1]
P:
ldr r0,=InFileHandle
ldr r0,[r0]
ldr r1,=CharArray
mov r2,#80
swi 0x6a
mov r4,r0
add r4,r4,#1
cmp r0,#0
beq L0
bl L3
bl itoa
@bcs ReadError
swi 0x02
ldr r0,=MyString
swi 0x02
bal P
@ReadError:	.asciz	"Unable to read string\n"
@InFileError:	.asciz	"Unable to open file\n"
L0:	
swi 0x68 @close the file
swi 0x11 @exit program
.end
