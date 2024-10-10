%include "../include/io.mac"

; The `expand` function returns an address to the following type of data
; structure.
struc neighbours_t
    .num_neighs resd 1 ; The number of neighbours returned.
    .neighs resd 1 ; Address of the vector containing the `num_neighs` neighbours.
    ; A neighbour is represented by an unsigned int (dword).
endstruc

section .bss
    ; Vector for keeping track of visited nodes.
    visited resd 10000
    global visited

section .data
    ; Format string for printf.
    fmt_str db "%u", 10, 0

section .text
    global dfs
    extern printf

; C function signiture:
; void dfs(uint32_t node, neighbours_t *(*expand)(uint32_t node))
; where:
; - node -> the id of the source node for dfs.
; - expand -> pointer to a function that takes a node id and returns a structure
; populated with the neighbours of the node (see struc neighbours_t above).
; 
; note: uint32_t is an unsigned int, stored on 4 bytes (dword).
dfs:
    push ebp
    mov ebp, esp
    pusha
    ;nod sursa
    mov esi, [ebp + 8]
    ;functia expand
    mov edi, [ebp + 12]
    ;iau adresa lui visited[i]
    lea eax, [visited + esi * 4]
    ;verific daca nodul este deja vizitat
    cmp dword[eax], 1
    je final
    ;marchez nodul ca vizitat
    mov dword[eax], 1

    push esi
    push fmt_str
    call printf
    ;apelez functia printf(afisez nodul curent)
    add esp, 8

    push esi
    call edi
    ;apelez functia expand
    add esp, 4
    ;numar vecini
    mov ecx, [eax + neighbours_t.num_neighs]
    ;vector vecini
    mov ebx, [eax + neighbours_t.neighs]
    ;daca nu are niciun fiu, sar direct la final
    cmp ecx, 0
    je final

    xor edx,edx

while:

    cmp edx, ecx
    jge final

    ;vecin
    mov eax, dword[ebx + edx * 4]
    inc edx
    ;verific daca copilul a fost deja vizitat
    cmp dword[visited + eax * 4], 1
    je continue

    push edi
    push eax
    call dfs
    ;apelez recursiv functia dfs pt fiecare copil in parte
    add esp, 8

continue:
    jmp while

    ; TODO: Implement the depth first search algorith, using the `expand`
    ; function to get the neighbours. When a node is visited, print it by
    ; calling `printf` with the format string in section .data.
final:
    popa
    leave
    ret

