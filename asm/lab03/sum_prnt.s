section .data
    array1  dd 10, 20, 30, 40, 50
    array2  dd 1, 2, 3, 4, 5
    count   equ 5
    msg1    db "Array 1: ", 0
    msg2    db 10, "Array 2: ", 0
    msg3    db 10, "Result:  ", 0
    format  db "%d ", 0
    newline db 10, 0

section .bss
    res_array resd 5

section .text
    global main
    extern printf

main:
    ; --- 1. Сначала считаем сумму (логика остается прежней) ---
    mov ecx, 0
.loop_sum:
    cmp ecx, count
    je .print_all
    mov eax, [array1 + ecx*4]
    add eax, [array2 + ecx*4]
    mov [res_array + ecx*4], eax
    inc ecx
    jmp .loop_sum

    ; --- 2. Печать всех массивов по очереди ---
.print_all:
    ; Печать массива 1
    push msg1
    call printf
    add esp, 4
    mov ebx, array1
    call print_array_func

    ; Печать массива 2
    push msg2
    call printf
    add esp, 4
    mov ebx, array2
    call print_array_func

    ; Печать результата
    push msg3
    call printf
    add esp, 4
    mov ebx, res_array
    call print_array_func

    push newline
    call printf
    add esp, 4
    ret

; --- Вспомогательная функция печати (чтобы не дублировать код) ---
print_array_func:
    mov esi, 0
.loop:
    cmp esi, count
    je .done
    pushad
    push dword [ebx + esi*4]
    push format
    call printf
    add esp, 8
    popad
    inc esi
    jmp .loop
.done:
    ret
