.data
  lungime: .long 3
  
  print_minus_1: .asciz "-1\n"
  printFormat: .asciz "%d "
  scan_number: .asciz "%d"
  scan_n_m: .asciz "%d %d"
  endl: .asciz "\n"
  vModel: .space 364
  stiva: .space 364
  freq: .space 4
  n: .space 4
  m: .space 4
	el: .space 4
.text

.global main

tipar:
  movl $stiva, %esi
  movl $1, %ecx
  for_item_in_stiva:
    cmp lungime, %ecx
    jg end_tipar
    movl (%esi, %ecx, 4), %eax

    pushl %ecx
    pushl %eax
    pushl $printFormat
    call printf
    popl %ebx
    popl %ebx
    popl %ecx

    incl %ecx
    jmp for_item_in_stiva
  
  end_tipar:
    pushl $endl
    call printf
    popl %ebx
    jmp et_exit


validare:
  pushl %ebp
  movl %esp, %ebp
  pushl %ebx
  pushl %ecx
  pushl %edx
  pushl %edi
  pushl %esi
  
  movl $vModel, %edi
  movl $stiva, %esi

  movl 8(%ebp), %edx            # K
  movl (%esi, %edx, 4), %ebx    # stiva[K]
  movl $1, %ecx

  conditia_2:
    movl %edx, %ecx
    subl m, %ecx

    loop_conditia_2:
      cmp %edx, %ecx
      je conditia_3

      movl (%esi, %ecx, 4), %eax  # stiva[i]
      cmp %eax, %ebx
      je invalid

      incl %ecx
      jmp loop_conditia_2

  conditia_3:
    movl $1, %ecx
    movl %ecx, freq
    loop_conditia_3:
      cmp %ecx, %edx
      je conditia_4
      
      movl (%esi, %ecx, 4), %eax  # stiva[i]
      cmp %eax, %ebx
      jne continue_loop_3

      incl freq
      continue_loop_3:
        incl %ecx
        jmp loop_conditia_3
    
	conditia_4: 
		movl %edx, %ecx
		incl %ecx
		loop_conditia_4:
			cmp lungime, %ecx
			jg check_freq

			movl (%edi, %ecx, 4), %eax
			cmp %eax, %ebx
			jne continue_loop_4

			incl freq
			continue_loop_4:
				incl %ecx
				jmp loop_conditia_4
			
	check_freq:
		movl $3, %eax
		cmp freq, %eax
		jl invalid
  
  valid:
    movl $1, %eax
    jmp end_validare
    
  invalid:
    movl $0, %eax
    jmp end_validare

  end_validare:
    popl %esi
    popl %edi
    popl %edx
    popl %ecx
    popl %ebx
    popl %ebp
    ret


backtrack:
  pushl %ebp
  movl %esp, %ebp
  pushl %ecx
  pushl %edi
  pushl %esi

  movl $vModel, %edi
  movl $stiva, %esi

	movl $1, %ecx

  movl 8(%ebp), %edx
	movl (%edi, %edx, 4), %eax
	cmp $0, %eax
	je loop_bkt
	
	movl %eax, (%esi, %edx, 4)
	pushl %edx
	call validare
	popl %edx

	cmp $0, %eax
	je end_loop_bkt
	
	cmp lungime, %edx
	je tipar

	incl %edx
	pushl %edx
	call backtrack
	popl %edx
	subl $1, %edx

	jmp end_loop_bkt

  loop_bkt:
    cmp n, %ecx
    jg end_loop_bkt

    movl %ecx, (%esi, %edx, 4)

    pushl %edx
    call validare
    popl %edx
    cmp $0, %eax
    je cont_loop_bkt

    cmp lungime, %edx
    je tipar

    incl %edx
    pushl %edx
    call backtrack
    popl %edx
    subl $1, %edx

    cont_loop_bkt:
      incl %ecx
      jmp loop_bkt
  
end_loop_bkt:
  popl %esi
  popl %edi
	popl %ecx
	popl %ebp
	ret



main:
  movl $vModel, %edi

scanare:
  pushl $m
  pushl $n
  pushl $scan_n_m
  call scanf
  popl %ebx
  popl %ebx
  popl %ebx

  movl n, %eax
  mull lungime
  movl %eax, lungime

  movl $1, %ecx
  scan_elements:
    cmp lungime, %ecx
    jg stop_scanare

    pushl %ecx
    pushl $el
    pushl $scan_number
    call scanf
    popl %ebx
    popl %ebx
    popl %ecx
		movl el, %ebx
    movl %ebx, (%edi, %ecx, 4)

    incl %ecx
    jmp scan_elements

stop_scanare:
  pushl $vModel
  pushl $stiva
  pushl $1
  call backtrack
  popl %ebx

nu_exista:
  pushl $print_minus_1
  call printf
  popl %ebx

et_exit:
  xorl %ebx, %ebx
  movl $1, %eax
  int $0x80