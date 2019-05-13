.equ SWI_Exit, 0x11
	.global L3, expression, term, constant	

.text
	
L3:
stmdb sp!,{lr}
mov r0,#0 @value till now
mov r2,#0 @x for term()
ldrb r5,[r1,#0]
bl expression
b L0

expression:
stmdb sp!,{lr}
ldrb r5,[r1,#0]
@sub sp,sp,#4
bl term
@add sp,sp,#4
mov r0,r2
@mov r2,r4

L:
ldrb r5,[r1,#0]
@mov r2,#0
cmp r5,#42
bne L1
add r1,r1,#1
bl term
mul r0,r2,r0
b L

L1:
cmp r5,#43
bne L2
add r1,r1,#1
bl term
add r0,r0,r2
b L

L2:
cmp r5,#45
bne ret2
add r1,r1,#1
bl term
sub r0,r0,r2

b L
ret2:
ldmia sp!,{lr}
mov pc,lr

term:
ldrb r8,[r1,#0]
stmdb sp!,{r0,lr}
cmp r8,#40
bne J1
add r1,r1,#1
@sub sp,sp,#4
bl expression
@add sp,sp,#4
add r1,r1,#1
mov r2,r0
b ret

J1:
ldrb r5,[r1,#0]
@sub sp,sp,#4
bl constant
@add sp,sp,#4
mov r2,r3 @r3=x for constant

ret:
ldmia sp!,{r0,lr}
mov pc,lr

constant:
mov r3,#0
mov r10,#0
mov r11,#10

K:
ldrb r9,[r1,#0]
cmp r9,#48
blt ret1
sub r9,r9,#48
mul r10,r3,r11
add r3,r10,r9
add r1,r1,#1
b K

ret1:
mov pc,lr

L0:
ldmia sp!,{lr}
mov pc,lr
swi   SWI_Exit

.end
