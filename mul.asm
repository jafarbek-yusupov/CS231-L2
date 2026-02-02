; mul.asm (Win64, NASM + GoLink)
;nasm -f win64 mul.asm -o mul.obj
;golink /console /entry Start mul.obj kernel32.dll /fo mul.exe

; OUTPUT: 127

default rel

extern ExitProcess

section .text
global Start
global IntegerMul_

Start:
    sub rsp, 40                  ; shadow space + 16-byte alignment

    ; test values: a=10, b=20, c=3, d=7  => 10*20 + 3*7 = 200 + 21 = 221
    mov ecx, 10                  ; a
    mov edx, 20                  ; b
    mov r8d, 3                   ; c
    mov r9d, 7                   ; d

    call IntegerMul_             ; EAX = a*b + c*d

    mov ecx, eax
    call ExitProcess

; int IntegerMul_(int a,int b,int c,int d)
; returns EAX = a*b + c*d
IntegerMul_:
    ; EAX = a*b
    mov eax, ecx                 ; eax = a
    imul eax, edx                ; eax = a*b   (signed 32-bit)

    ; EDX = c*d  
    mov edx, r8d                 ; edx = c
    imul edx, r9d                ; edx = c*d

    add eax, edx                 ; eax = a*b + c*d
    ret
    