data segment
msg3 db 10,13,"Enter hexadecimal number : $"
msg4 db 10,13,"BCD equivalent : $"
no dw 05h dup(0) 
final db 05h dup(0)
data ends


code segment
assume cs : code, ds : data
start:mov ax, data
	mov ds,ax
	
	 

	call hextobcd
	
	mov ah,4ch
	int 21h
	

hextobcd proc near
	lea dx,msg3
	mov ah,09h
	int 21h
	call take

	mov si,0000h
	mov ax,bx
	mov dx,0000h
	mov bx,000Ah
	mov cl,00h
up:		
	div bx
	mov [final+si],dl
	inc si
	inc cl
	mov dx,0000h
	cmp ax, 04h
	jnc up
	
	mov [final+si],al
	inc cl
	
	lea dx,msg4
	mov ah,09h
	int 21h
	
up1: mov dx,0000h
	mov dl,[final+si]
	add dl,30h
	mov ah,02h
	int 21h
	dec si
	dec cl
	
	jnz up1

	ret
      hextobcd endp

take proc near
        mov ah, 01h
        int 21h
        cmp al, 39h
        jbe down
        sub al, 07h
down : sub al, 30h
        mov cl, 04h
        rol al, cl
        mov bh, al
        mov ah, 01h
        int 21h
        cmp al, 39h
        jbe down1
        sub al, 07h
down1 : sub al, 30h
        add bh, al 
        mov ah, 01h
        int 21h
        cmp al, 39h
        jbe down2
        sub al, 07h
down2 : sub al, 30h
        mov cl, 04
        rol al, cl
        mov bl, al
        mov ah, 01h
        int 21h
        cmp al, 39h
        jbe down3
        sub al, 07h
down3 : sub al, 30h
        add bl, al 
        ret
        take endp
display proc near
        mov ch, bh 
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
        mov bh, bl 
        mov ch, bh
        and ch, 0f0h
        mov cl, 04h
        rol ch, cl
        cmp ch, 09h
        jbe down6
        add ch, 07h
down6 :
        add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        mov ch, bh
        and ch, 0fh
        cmp ch, 09h
        jbe down7
        add ch, 07h
down7 : add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        ret
        display endp
code ends
end start