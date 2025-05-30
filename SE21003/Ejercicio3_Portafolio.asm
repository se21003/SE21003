section .data
    numero_dividendo dd 50
    numero_divisor dd 7
    valor_cociente dd 0
    valor_residuo dd 0

    texto_cociente db "Resultado del cociente: "
    tam_texto_cociente equ $ - texto_cociente

    texto_residuo db "Resultado del residuo: "
    tam_texto_residuo equ $ - texto_residuo

    salto_de_linea db 10
    zona_de_conversion times 11 db 0

section .text
    global _start

_start:
    mov eax, [numero_dividendo]
    xor edx, edx
    div dword [numero_divisor]
    mov [valor_cociente], eax
    mov [valor_residuo], edx

    mov eax, 4
    mov ebx, 1
    mov ecx, texto_cociente
    mov edx, tam_texto_cociente
    int 0x80

    mov eax, [valor_cociente]
    call mostrar_entero

    mov eax, 4
    mov ebx, 1
    mov ecx, texto_residuo
    mov edx, tam_texto_residuo
    int 0x80

    mov eax, [valor_residuo]
    call mostrar_entero

    mov eax, 1
    mov ebx, 0
    int 0x80

mostrar_entero:
    mov edi, zona_de_conversion + 10
    mov byte [edi], 0
    mov ecx, 10

.bucle_conversion:
    dec edi
    xor edx, edx
    div ecx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz .bucle_conversion

    mov edx, zona_de_conversion + 11
    sub edx, edi

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, salto_de_linea
    mov edx, 1
    int 0x80

    ret
