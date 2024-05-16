data segment 
no db 10h,10h,10h,10h,10h
data ends

code segment 
assume cs: code, ds: data
start:  mov ax, data
	mov ds, ax
	
	
	
	mov ch, 04h
	mov bl, 05h
	
	mov si, 0000h
	mov al, [no+si]
	inc si
	mov ah,00h
	
back: add al, [no+si]
	jnc down
	inc ah
	
	down: inc si
	dec ch

	jnz back

	mov bl, 05h
	div bl

	mov bh,al

	call display

	mov ah, 4ch
	int 21h

	display proc near
        mov ch, bh ; displaying the first two MSB byte
        and ch, 0f0h
        mov cl, 04h
        rol ch, cl
        cmp ch, 09h
        jbe down4
        add ch, 07h
down4 :
        add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        mov ch, bh
        and ch, 0fh
        cmp ch, 09h
        jbe down5
        add ch, 07h
down5 : add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
 ret
        display endp
code ends
end start



	