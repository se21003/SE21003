section .data
    valorA dw 50
    valorB dw 20
    valorC dw 5
    total dw 0

    texto db "El resultado es: "
    texto_len equ $ - texto

    salida db "00", 10
    salida_len equ $ - salida

section .text
    global _start

_start:
    mov ax, [valorA]
    sub ax, [valorB]
    sub ax, [valorC]
    mov [total], ax

    mov bl, 10
    xor dx, dx
    div bl

    add al, '0'
    add ah, '0'
    mov [salida], ah
    mov [salida+1], al

    mov eax, 4
    mov ebx, 1
    mov ecx, texto
    mov edx, texto_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, salida
    mov edx, salida_len
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
