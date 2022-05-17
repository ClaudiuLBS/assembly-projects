// x 1 let 2 x add y 3 let x y add mul
.data
    formatScan: .asciz "%300[^\n]"
    formatPrint: .asciz "%d\n"

    add_op: .byte 97        #a
    div_op: .byte 100       #d
    let_op: .byte 108       #l
    mul_op: .byte 109       #m
    sub_op: .byte 115       #s
    
    separator: .asciz " "
    multiplier: .long 10
    instructiune: .space 300
    variabile: .space 120
    cuvant: .space 10

.text

.global main

main:
    xorl %eax, %eax
    pushl $instructiune
    pushl $formatScan
    call scanf
    popl %ebx
    popl %ebx
    movl $variabile, %esi

get_first_word:
    pushl $separator
    pushl $instructiune
    call strtok
    popl %ebx
    popl %ebx

    movl %eax, cuvant

testare_cuvant:
    movl cuvant, %edi
    xorl %edx, %edx
    xorl %ecx, %ecx
    xorl %ebx, %ebx

    movb (%edi, %ecx, 1), %bl
    incl %ecx
    movb (%edi, %ecx, 1), %dl
    
    cmp $0, %edx
    je numar_sau_variabila

    cmp add_op, %bl
    je if_add
    cmp sub_op, %bl
    je if_sub
    cmp mul_op, %bl
    je if_mul
    cmp div_op, %bl
    je if_div
    cmp let_op, %bl
    je if_let
    jmp if_pozitiv

get_next_word:
    pushl $separator
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    cmp $0, %eax
    je et_exit

goto_test:
    movl %eax, cuvant
    jmp testare_cuvant

if_let:
    popl %eax
    popl %ecx
    movl %eax, (%esi, %ecx, 4)
    jmp get_next_word

if_add:
    popl %ebx
    popl %eax
    addl %ebx, %eax
    pushl %eax
    jmp get_next_word

if_sub:
    popl %ebx
    popl %eax
    subl %ebx, %eax
    pushl %eax
    jmp get_next_word

if_mul:
    popl %ebx
    popl %eax
    mull %ebx
    pushl %eax
    jmp get_next_word

if_div:
    xorl %edx, %edx
    popl %ebx
    popl %eax
    divl %ebx
    pushl %eax
    jmp get_next_word

if_pozitiv:
    xorl %ecx, %ecx
    xorl %eax, %eax
    xorl %ebx, %ebx
    calcul_pozitiv:
        movb (%edi, %ecx, 1), %bl
        cmp $0, %bl
        je push_pozitiv

        mull multiplier
        subl $48, %ebx
        addl %ebx, %eax
        incl %ecx
        jmp calcul_pozitiv
        
    push_pozitiv:
        pushl %eax
        jmp get_next_word

if_variabila:
    xorl %ecx, %ecx
    xorl %ebx, %ebx
    xorl %eax, %eax
    movb (%edi, %ecx, 1), %bl
    subl $97, %ebx
    movl %ebx, %ecx
    movl (%esi, %ecx, 4), %eax
    cmp $0, %eax
    je baga_variabila_pe_stiva
    jg baga_valoare_pe_stiva

numar_sau_variabila:
    cmp $60, %ebx
    jl if_pozitiv
    jg if_variabila

baga_variabila_pe_stiva:
    pushl %ebx
    jmp get_next_word

baga_valoare_pe_stiva:
    pushl %eax
    jmp get_next_word    

et_exit:
    pushl $formatPrint
    call printf
    popl %ebx

    pushl $0
    call fflush
    popl %ebx
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
