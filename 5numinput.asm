data segment
msg1 db 10,13,"Enter 5 numbers : $"
msg2 db 10,13,"No $:"
msg3 db 10,13,"Number is : $"
no dw 05h dup(0) 
n db 30h
n1 db 30h
data ends

code segment
assume cs : code, ds : data
start: mov ax, data
	 mov ds,ax
       mov si,0000h 
back12 : lea dx, msg2
        mov ah, 09h
        int 21h
        mov dl, [n] 
        mov ah, 02h
        int 21h
        call take 
        mov [no + si], bx 
        inc si 
        inc si
        inc [n] 
        cmp [n], 34h 
        jbe back12
      mov si, 0000h 
       
  back13: lea dx, msg3
        mov ah, 09h
        int 21h
        mov bx, [no+si] 
        call display
        inc [n1] 
  	  inc si
	  inc si
        cmp [n1], 34h 
        jbe back13
       mov ah, 4ch
        int 21h
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