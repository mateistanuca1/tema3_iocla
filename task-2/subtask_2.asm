; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    push esi
    push edi
    push ebx


    ;; recursive bsearch implementation goes here
    ;ecx contine buff
    ;edx contine needle
    ;inceput
    mov esi, [ebp + 8]
    ;final
    mov edi, [ebp + 12]
    ;valoarea de retur daca nu am gasit elementul
    mov eax, -1

    cmp esi, edi
    jg final

    mov eax, edi
    sub eax, esi
    ;calculez mijlocul array-ului
    shr eax, 1
    add eax, esi

    ;verific daca am gasit elementul
    cmp edx, [ecx + eax * 4]
    je final

    ;caut in dreapta sau in stanga
    cmp edx, [ecx + eax * 4]
    jg dreapta
    jmp stanga

dreapta:
    inc eax
    push edi
    push eax
    call binary_search
    ;apelez recursiv functia b_search pt dreapta
    add esp, 8
    jmp final
stanga:
    dec eax
    push eax    
    push esi
    call binary_search
    ;apelez recursiv fct b_search pt stanga
    add esp, 8
    ;; restore the preserved registers
final:
    pop ebx
    pop edi
    pop esi
    leave
    ret
