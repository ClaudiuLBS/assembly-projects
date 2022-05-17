//A78801C00A7890EC04
.data
    scanFormat: .asciz "%s"

    printPozitiv: .asciz "%d "
    printNegativ: .asciz "-%d "
    printValoare: .asciz "%s "
    printLet: .asciz "let "
    printAdd: .asciz "add "
    printSub: .asciz "sub "
    printMul: .asciz "mul "
    printDiv: .asciz "div "
    printAll: .asciz "\n"

    forNumber: .long 48
    forLetter: .long 55
    x16: .long 16

    litera: .asciz "a"
    codHexa: .space 10000
    identificator: .space 1

.text

.global main

main:
    pushl $codHexa
    pushl $scanFormat   
    call scanf
    popl %ebx
    popl %ebx
    movl $codHexa, %edi
    xorl %ecx, %ecx

et_loop:
    movb (%edi, %ecx, 1), %al
    cmp $0, %al
    je et_exit
    movl %eax, identificator

generate_code_value:
    pushl %ecx
    xorl %eax, %eax #aici se va crea valoarea
    xorl %ebx, %ebx

    add $1, %ecx
    movb (%edi, %ecx, 1), %al   #primul caracter din nr hexa
    cmpl $60, %eax #daca codu ascii e mai mic decat 60 e cifra / mai mare = litera
    jl if_number_al
    jg if_letter_al
    
second_step:
    mull x16
    incl %ecx
    movb (%edi, %ecx, 1), %bl
    cmpl $60, %ebx  
    jl if_number_bl
    jg if_letter_bl
    
last_step:
    addb %bl, %al
    popl %ecx

compare_value:
    xorl %edx, %edx
    movb identificator, %dl
    cmp $56, %dl
    je if_pozitiv
    cmp $57, %dl
    je if_negativ
    cmp $65, %dl
    je if_variabila
    cmp $67, %dl
    je if_operatie

if_number_al:
    subl forNumber, %eax 
    jmp second_step
if_letter_al:
    subl forLetter, %eax
    jmp second_step
if_number_bl:
    subl forNumber, %ebx
    jmp last_step
if_letter_bl:
    subl forLetter, %ebx
    jmp last_step

continue_loop:
    add $3, %ecx
    xorl %eax, %eax
    jmp et_loop

if_pozitiv:
    pushl %ecx
    pushl %eax
    pushl $printPozitiv
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    jmp continue_loop
if_negativ:
    pushl %ecx
    pushl %eax
    pushl $printNegativ
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    jmp continue_loop
if_variabila:
    pushl %ecx
    xorl %ecx, %ecx
    movl $litera, %esi
    movb %al, (%esi, %ecx, 1)
    pushl $litera
    pushl $printValoare
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    jmp continue_loop
if_operatie:
    cmp $0, %al
    je if_let
    cmp $1, %al
    je if_add
    cmp $2, %al
    je if_sub
    cmp $3, %al
    je if_mul
    cmp $4, %al
    je if_div
    jmp continue_loop

if_let:
    pushl %ecx
    pushl $printLet
    call printf
    popl %ebx
    popl %ecx
    jmp continue_loop 
if_add:
    pushl %ecx
    pushl $printAdd
    call printf
    popl %ebx
    popl %ecx
    jmp continue_loop
if_sub:
    pushl %ecx
    pushl $printSub
    call printf
    popl %ebx
    popl %ecx
    jmp continue_loop
if_mul:
    pushl %ecx
    pushl $printMul
    call printf
    popl %ebx
    popl %ecx
    jmp continue_loop
if_div:
    pushl %ecx
    pushl $printDiv
    call printf
    popl %ebx
    popl %ecx
    jmp continue_loop

et_exit:
    pushl $printAll
    call printf
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

