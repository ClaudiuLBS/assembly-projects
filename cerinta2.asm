// 49 10 mul 5 div 7 -6 sub add
.data
    formatScan: .asciz "%300[^\n]"
    formatPrint: .asciz "%d\n"

    add_op: .byte 97        #a
    sub_op: .byte 115       #s
    mul_op: .byte 109       #m
    div_op: .byte 100       #d
    negativ: .byte 45       #-
    
    separator: .asciz " "
    multiplier: .long 10
    instructiune: .space 300
    cuvant: .space 10
    numar: .space 4

.text

.global main

main:
    xorl %eax, %eax
    pushl $instructiune
    pushl $formatScan
    call scanf
    popl %ebx
    popl %ebx

get_first_word:
    pushl $separator
    pushl $instructiune
    call strtok
    popl %ebx
    popl %ebx

    movl %eax, cuvant

testare_cuvant:
    xorl %ecx, %ecx
    movl cuvant, %edi

    movb (%edi, %ecx, 1), %bl

    cmp add_op, %bl
    je if_add
    cmp sub_op, %bl
    je if_sub
    cmp mul_op, %bl
    je if_mul
    cmp div_op, %bl
    je if_div

    jmp if_pozitiv      #daca nu e niciuna de mai sus

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
