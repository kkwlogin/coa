data segment
msg db 10,13, "Enter A Number$"
msg1 db 10, 13, "No is:$"
result dw ?
data ends


code segment
assume cs: code, ds: data
start:
	mov ax, data
	mov ds, ax

	call bcdtohex

	mov ah, 4ch
	int 21h

bcdtohex proc near
	  lea dx, msg
	  mov ah, 09h
	  int 21h

	  mov ah, 01h
	  int 21h
	  sub al, 30h
        mov cx, 2710h
        mov ah, 00h
        mul cx
        add [result], ax


        mov ah, 01h
        int 21h
        sub al, 30h
        mov cx, 03E8h
        mov ah, 00h
        mul cx
        add [result], ax

        mov ah, 01h
        int 21h
        sub al, 30h
        mov cx, 0064h
        mov ah, 00h
        mul cx
        add [result], ax

        mov ah, 01h
        int 21h
        sub al, 30h
        mov cx, 000Ah
        mov ah, 00h
        mul cx
        add [result], ax

        mov ah, 01h
        int 21h
        sub al, 30h
        mov ah, 00h
        add [result], ax

        lea dx, msg1
        mov ah, 09h
        int 21h

        mov bx, [result] 
        call display
        ret
        bcdtohex endp


display proc near
        mov ch, bh ;         
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
	mov bh, bl ; displaying the last two LSB byte
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