//x 2 3 1 2 3 4 5 6 let x 69 add
//x 2 3 10 20 30 40 50 60 let x 3 div

.data
    scanDigit: .asciz "%d "
    printDigit: .asciz "%d "
    printString: .asciz "%s "
    scanLinie: .asciz "%300[^\n]"
    scanString: .asciz "%s"
    final: .asciz "\n"

    add_op: .long 97        #a
    div_op: .long 100       #d
    let_op: .long 108       #l
    mul_op: .long 109       #m
    sub_op: .long 115       #s
    
    sign: .long 0

    separator: .asciz " "
    linii: .space 4
    coloane: .space 4
    matrice: .space 400
    nr_elemente: .space 4
    variabila: .space 15
    element: .space 4
    cuvant: .space 10

.text

.global main

main:

scan_useless_var:
    pushl $variabila
    pushl $scanString
    call scanf
    popl %ebx
    popl %ebx

get_matrix_size:
    pushl $linii
    pushl $scanDigit
    call scanf
    popl %ebx
    popl %ebx

    pushl $coloane
    pushl $scanDigit
    call scanf
    popl %ebx
    popl %ebx

    movl linii, %eax
    mull coloane
    movl %eax, nr_elemente
    xorl %ecx, %ecx
    
    movl $matrice, %edi

read_matrix:
    cmp nr_elemente, %ecx
    je scan_useless_var_again

    pushl %ecx
    pushl $element
    pushl $scanDigit
    call scanf
    popl %ebx
    popl %ebx
    popl %ecx

add_to_matrix:
    movl element, %eax
    movl %eax, (%edi, %ecx, 4)
    incl %ecx
    jmp read_matrix

scan_useless_var_again:
    pushl $variabila
    pushl $scanString
    call scanf
    popl %ebx
    popl %ebx

    pushl $variabila
    pushl $scanString
    call scanf
    popl %ebx
    popl %ebx


testing:
    movl $variabila, %esi
    xorl %eax, %eax
    movl $1, %ecx
    
    movb (%esi, %ecx, 1), %al
    cmp $0, %eax
    je get_number
    cmp $111, %eax  #daca a 2a litera e 'o'
    je if_rot90d 


get_number:
    pushl $element
    pushl $scanDigit
    call scanf
    popl %ebx
    popl %ebx

get_operation:
    pushl $variabila
    pushl $scanString
    call scanf
    popl %ebx
    popl %ebx
    movl $variabila, %esi
    xorl %eax, %eax
    xorl %ecx, %ecx
    movb (%esi, %ecx, 1), %al
caca:
    cmp add_op, %eax
    je if_add
    cmp sub_op, %eax
    je if_sub
    cmp mul_op, %eax
    je if_mul
    cmp div_op, %eax
    je if_div


if_add:
    xorl %ecx, %ecx
    add_loop:
        cmp nr_elemente, %ecx
        je show_matrix
        movl (%edi, %ecx, 4), %eax
        addl element, %eax
        movl %eax, (%edi, %ecx, 4) 
        incl %ecx
        jmp add_loop

if_sub:
    xorl %ecx, %ecx
    sub_loop:
        cmp nr_elemente, %ecx
        je show_matrix

        movl (%edi, %ecx, 4), %eax
        subl element, %eax
        movl %eax, (%edi, %ecx, 4) 
        
        incl %ecx
        jmp sub_loop
if_mul:
    xorl %ecx, %ecx
    mul_loop:
        cmp nr_elemente, %ecx
        je show_matrix
        movl (%edi, %ecx, 4), %eax
        mull element
        movl %eax, (%edi, %ecx, 4) 
        
        incl %ecx
        jmp mul_loop

if_div:
    xorl %ecx, %ecx
    xorl %edx, %edx
    movl element, %eax

    cmp $0, %eax
    jge div_loop

    notl %eax
    add $1, %eax
    movl %eax, element          #impartim la elementul pozitiv
    movl $1, %eax
    movl %eax, sign

    div_loop:
        cmp nr_elemente, %ecx
        je show_matrix

        movl (%edi, %ecx, 4), %eax

        cmp $0, %eax
        jl numarator_negativ

    continue_div_loop:
        xorl %edx, %edx
        divl element
        movl sign, %ebx
        cmp $1, %ebx
        je set_eax_negative
        movl %eax, (%edi, %ecx, 4) 
        incl %ecx
        jmp div_loop

    numarator_negativ:
        xorl %edx, %edx
        notl %eax
        addl $1, %eax

        divl element

        movl sign, %ebx
        cmp $0, %ebx
        je set_eax_negative
        movl %eax, (%edi, %ecx, 4) 
        incl %ecx
        jmp div_loop

    set_eax_negative:
        notl %eax
        addl $1, %eax
        movl %eax, (%edi, %ecx, 4) 
        incl %ecx
        jmp div_loop


if_rot90d:
    movl coloane, %eax
    movl nr_elemente, %ecx
    subl coloane, %ecx

    movl linii, %edx
    movl %eax, linii
    movl %edx, coloane

    pushl %ecx
    pushl linii
    pushl $printDigit
    call printf
    popl %ebx
    popl %ebx
    popl %ecx

    pushl %ecx
    pushl coloane
    pushl $printDigit
    call printf
    popl %ebx
    popl %ebx
    popl %ecx


    rot90d_loop:
        cmpl nr_elemente, %ecx
        je et_exit

        pushl %ecx
        second_rot90d_loop:
            pushl %ecx
            pushl (%edi, %ecx, 4)
            pushl $printDigit
            call printf
            popl %ebx
            popl %ebx
            popl %ecx
            subl linii, %ecx
            cmp $0, %ecx
            jge second_rot90d_loop
        popl %ecx
        incl %ecx
        jmp rot90d_loop

show_matrix:
    pushl linii
    pushl $printDigit
    call printf
    popl %ebx
    popl %ebx

    pushl coloane
    pushl $printDigit
    call printf
    popl %ebx
    popl %ebx

    xorl %ecx, %ecx
    loop_matrix_elements:
        cmp nr_elemente, %ecx
        je et_exit

        pushl %ecx
        pushl (%edi, %ecx, 4)
        pushl $printDigit
        call printf
        popl %ebx
        popl %ebx
        popl %ecx

        incl %ecx
        jmp loop_matrix_elements

        
et_exit:
    pushl $final
    call printf
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
