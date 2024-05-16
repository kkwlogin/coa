
#include <conio.h>
#include <stdio.h>
#include <dos.h>
#include <string.h>
union REGS reg;
int main(){
int handle;

char fname[25],f1name[25];
printf("Enter the name of Directory");
gets(fname);
reg.h.ah=0x39;

reg.x.dx=&fname;
int86(0x21,&reg,&reg);
asm jnc l2
printf("DIR not created");
getch();
l2: printf("dir Created");






printf("Enter the name of File");
gets(f1name);
reg.h.ah=0x3c;
reg.x.cx=0;
reg.x.dx=&f1name;
int86(0x21,&reg,&reg);
asm jnc l1
printf("File not created");
getch();
l1: printf("File Created");



printf("Enter the Path of file to be deleted");
gets(f1name);
reg.h.ah=0x41;
reg.x.dx=&f1name;
int86(0x21,&reg,&reg);
asm jnc l3
printf("File not deledted");
getch();
l3: printf("File Deledted");

printf("Enter the Path of directory to be deleted");
gets(f1name);
reg.h.ah=0x3a;
reg.x.dx=&f1name;
int86(0x21,&reg,&reg);
asm jnc l4
printf("Dir not deledted");
getch();
l4: printf("Dir deledted");



return 0;
}