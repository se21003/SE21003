section .data
    datoA db 10
    datoB db 5
    texto db "Resultado: "
    longitud_texto equ $ - texto
    cadena db "   ", 10
    longitud_cadena equ $ - cadena

section .text
    global _start

_start:
    mov al, [datoA]
    mov bl, [datoB]
    mul bl

    mov bx, 10
    mov cx, 3
    mov edi, cadena+2

ciclo_ascii:
    xor dx, dx
    div bx
    add dl, '0'
    mov [edi], dl
    dec edi
    test ax, ax
    jz fin_ascii
    loop ciclo_ascii

fin_ascii:
    mov eax, 4
    mov ebx, 1
    mov ecx, texto
    mov edx, longitud_texto
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, cadena
    mov edx, longitud_cadena
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
