; add.asm (Win64, NASM + GoLink)
;nasm -f win64 add.asm -o add.obj
;golink /console /entry _start add.obj kernel32.dll /fo add.exe
default rel

extern ExitProcess

section .text
global _start
global IntegerAaddSub_

; -------------------------
; Program entry point
; -------------------------
_start:
    sub rsp, 40          ; 32-byte shadow space + alignment (Win64 ABI)

    ; Put test values into arg registers (a,b,c,d)
    mov ecx, 10          ; a
    mov edx, 20          ; b
    mov r8d, 30          ; c
    mov r9d, 18          ; d

    call IntegerAddSub_  ; EAX = a + b + c - d  (should be 42)

    mov ecx, eax         ; ExitProcess(exit_code = result)
    call ExitProcess     ; end program

; -------------------------
; int IntegerAddSub_(int a,int b,int c,int d)
; a=ECX, b=EDX, c=R8D, d=R9D, return EAX
; -------------------------
IntegerAddSub_:
    mov eax, ecx
    add eax, edx
    add eax, r8d
    sub eax, r9d
    ret
