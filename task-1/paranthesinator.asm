section .text
global check_parantheses

check_parantheses:
    push ebp
    mov ebp, esp

    ; sa-nceapa concursul
    ; eu sunt ursul(nush daca citeste cnv asta)
    push ebx
    push esi
    push edi

    ;iau sirul de paranteze
    mov esi, [ebp + 8]
    xor ecx, ecx
    xor ebx, ebx
    xor eax, eax
    xor edx, edx

while:
    ;verific daca am ajuns la finalul sirului
    cmp byte[esi + edx], 0
    je inchei

    ;pun pe stiva parantezele deschise
    cmp byte[esi + edx], '('
    je pun_stiva
    cmp byte[esi + edx], '['
    je pun_stiva
    cmp byte[esi + edx], '{'
    je pun_stiva

    cmp byte[esi + edx], ')'
    je scot_stiva_rotund
    cmp byte[esi + edx], ']'
    je scot_stiva_patrat
    cmp byte[esi + edx], '}'
    je scot_stiva_acolada

pun_stiva:
    xor ebx, ebx
    mov bl, byte[esi + edx]
    push ebx
    inc ecx
    inc edx
    jmp while

scot_stiva_rotund:
    ;verific daca stiva este goala
    cmp ecx, 0
    je inchei_fara_stiva
    xor ebx, ebx
    pop ebx
    dec ecx
    inc edx
    cmp ebx, '('
    je while
    jmp final_incorect

scot_stiva_patrat:
    ;verific daca stiva e goala
    cmp ecx, 0
    je inchei_fara_stiva
    xor ebx, ebx
    pop ebx
    dec ecx
    inc edx
    cmp ebx, '['
    je while
    jmp final_incorect

scot_stiva_acolada:
    ;verific daca stiva e goala
    cmp ecx, 0
    je inchei_fara_stiva
    xor ebx, ebx
    pop ebx
    dec ecx
    inc edx
    cmp ebx, '{'
    je while
    jmp final_incorect

final_incorect:
    pop ebx
    loop final_incorect

inchei_fara_stiva:
    ;transmit valoarea de retur pt gresit
    mov eax, 1

inchei:
    pop edi
    pop esi
    pop ebx
    leave
    ret
