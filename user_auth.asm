.model tiny
.stack
.data
dsp1 db 'ENTER USER NAME',0Ah,'$'
user db 'qwerty$','zxc$','$'
userlen dw 0006H,0003H
max1 db 16
act1 db ?
inp1 db 16 dup(0)

dsp2 db 'ENTER PASSWORD',0Ah,'$'
passwd db 'asdfgh$','uiop','$'
passlen dw 0006H,0004H
max2 db 16
act2 db ?
inp2 db 32 dup(0)

dsp3 db 'HELLO USER',0Ah,'$'

.code
.startup
		lea dx, dsp1
		mov ah, 09h
		int 21h
		LEA DX,max1
		MOV AH, 0Ah
		INT21h			; Input username
		lea bx,userlen
		lea si, user
	usrep:	lea di, inp1
		mov cx,[bx]
		REPE cmpsb		; Verify username
		jnz nxt1
		

		lea dx, dsp2
		mov ah, 09h
		int 21h
		LEA DX,max2
		MOV AH, 0Ah
		INT21h			; Input password
		lea bx,passlen
		lea si, passwd
	psrep:	lea di, inp2
		mov cx,[bx]
		REPE cmpsb		; Verify password
		jnz nxt2
		jmp nxt

	nxt1:	add si,cx
		inc bx
		inc bx
		inc si
		mov al,[si]
		cmp al,'$'
		jz myexit
		jmp usrep

	nxt2:	add si,cx
		inc bx
		inc bx
		inc si
		mov al,[si]
		cmp al,'$'
		jz myexit
		jmp psrep

	nxt:	lea dx, dsp3
		mov ah, 09h
		int 21h			; Display success and welcome user

	myexit:	mov ah,4ch
		int 21h
.exit
end