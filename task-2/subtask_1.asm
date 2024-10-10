; subtask 1 - qsort
section .text
    global quick_sort
    ;; no extern functions allowed
    global swap
    global partition

swap:
    ;functia da switch la doua valori
    enter 0,0
    pusha
    ;prima valoare
    mov eax, dword[ebp + 8]
    ;a doua valoare
    mov edx, dword[ebp + 12]
    mov ebx, [eax]
    mov ecx, [edx]
    mov [eax], ecx
    mov [edx], ebx
    popa
    leave
    ret

partition:
    ;functia face partitionarea in functie de pivot
    enter 0,0
    push esi
    push edi
    push ebx
    ;array
    mov esi, [ebp + 8]
    ;low
    mov edi, [ebp + 12]
    ;high
    mov edx, [ebp + 16]

    ;alegem pivotul
    mov ebx, [esi + edx * 4]
    dec edi
    ;i-ul
    mov eax, edi
    inc edi
    ;j-ul
    mov ecx, edi

for:
    cmp ecx, edx
    jg done
    ;verific daca elementul curent este mai mic decat pivotul
    cmp dword[esi + ecx * 4], ebx
    jl schimb
    jmp cont

schimb:
    inc eax
    push eax
    push ecx
    ;iau adresa primului element
    lea eax, [esi + eax * 4]
    ;iau adresa celui de-al doilea element
    lea ecx, [esi + ecx * 4]
    push eax
    push ecx
    call swap
    ;schimb elementele
    add esp, 8
    pop ecx
    pop eax
cont:
    inc ecx
    jmp for

done:
    inc eax
    push eax
    push ecx
    ;iau adresa primului element
    lea eax, [esi + eax * 4]
    ;iau adresa celui de-al doilea element
    lea ecx, [esi + edx * 4]
    push eax
    push ecx
    call swap
    ;schimb elementele
    add esp, 8
    pop ecx
    pop eax
    pop ebx
    pop edi
    pop esi
    leave
    ret

quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    pusha
    ;; recursive qsort implementation goes here
    ;array
    mov esi, [ebp + 8]
    ;low
    mov edi, [ebp + 12]
    ;high
    mov ebx, [ebp + 16]
    cmp edi, ebx
    jge finish
    push ebx
    push edi
    push esi
    call partition
    ;apelez functia partition
    add esp, 12

    dec eax
    push eax
    push eax
    push edi
    push esi
    call quick_sort
    ;apelez recursiv functia quick_sort
    add esp, 12
    pop eax

    ;eu momentan am pivot-1 si vreau sa ajung la pivot+1
    add eax, 2
    push ebx
    push eax
    push esi
    call quick_sort
    ;apelez recursiv functia quick_sort
    add esp, 12

    ;; restore the preserved registers
finish:
    popa
    leave
    ret
