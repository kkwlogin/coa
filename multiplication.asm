data segment

msg2 db 10,13,"Multiplication is : $"
n1 db 10h
n2 db 20h
data ends

code segment
assume cs : code, ds : data

start:
        mov ax,data
        mov ds,ax

        mov al,n1
        mov bl,n2

 lea dx, msg2
        mov ah, 09h
        int 21h

        mul bl
         mul cl
         
        call display
        mov bh,bl
        call display

        mov ah, 4ch ; Terminating the execution of the main program
        int 21h

display proc near ; Start of procedure

        mov ch, bh ; we want to display "2F" . The number is in bh which we are storing in ch="2F"
        and ch, 0f0h ; as we want "2". So will mask the "F" by anding the 2f with "F0" ie 2F and F0= 20h
        mov cl, 04h ; as after amsking the number is 20, but we want "2", so we need to rotate it by 4 location. The rotation count will be always in cl
        rol ch, cl
        cmp ch, 09h ; comparing the ch with 09 to decide 30 or 37h to add ie hex to ASCII conversion
        jbe down4
        add ch, 07h

down4 :
        add ch, 30h ; In oue case 30 will be added to 02 and ch=32h
        mov dl, ch ; the number to be displayed should be in dl. Therefore dl=32h
        mov ah, 02h ; code for displaying the ASCII number on monitor
        int 21h
        mov ch, bh ; Know for the second digit ie "F"
        and ch, 0fh ;as we want "F". So will mask the "2" by anding the 2f with "0F" ie 2F and 0F= 0Fh  
        cmp ch, 09h ;comparing the ch with 09 to decide 30 or 37h to add ie hex to ASCII conversion
        jbe down5
        add ch, 07h

down5 : add ch, 30h ;In oue case 37 will be added to 0F and ch=46h
        mov dl, ch
        mov ah, 02h
        int 21h
       

        ret
        display endp ; End of procedure

code ends
end start