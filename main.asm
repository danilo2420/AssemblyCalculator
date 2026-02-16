global _start

section .data
    ; operations
    operationsub db "-"
    operationadd db "+"
    
    ; messages
    msg1 db "Choose an operation: +, -"
    len1 equ $ - msg1

    msg2 db "You entered operation "
    len2 equ $ - msg2

    ; others
    nl db 10

section .bss
    input resb 1

section .text
_start:
    call getoperationmsg
    call getoperationinput
    ; rest of the program

    call endprogram


getoperationmsg:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, len1
    syscall
    call jumpline
    ret

getoperationinput:
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 1
    syscall

    mov rsi, msg2
    mov rdx, len2
    syscall

    mov rsi, input
    mov rdx, 1
    syscall

    call jumpline

    ret

; end program function
endprogram:
    mov rax, 60
    mov rdi, 0
    syscall

; extra functions
jumpline:
    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall
    ret