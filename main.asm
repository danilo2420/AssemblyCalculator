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

    msg3 db "You chose substraction"
    len3 equ $ - msg3

    msg4 db "The input you entered was not valid"
    len4 equ $ - msg4

    msg5 db "Doing addition..."
    len5 equ $ - msg5

    msg6 db "Doing substraction..."
    len6 equ $ - msg6

    ; others
    nl db 10

section .bss
    input resb 1

section .text
_start:
    call getoperationmsg
    call getoperationinput
    call decideoperation

    ; if input is not valid:
    call invalidinput
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

    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, len2
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, 1
    syscall

    call jumpline
    ret

; operation functions
decideoperation:
    mov bl, [input]

    mov al, [operationadd]
    cmp al, bl
    je doaddition

    mov al, [operationsub]
    cmp al, bl
    je dosubstraction

    ret

doaddition:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg5
    mov rdx, len5
    syscall
    call jumpline
    jmp endprogram

dosubstraction:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg6
    mov rdx, len6
    syscall
    call jumpline
    jmp endprogram


; end program function
endprogram:
    mov rax, 60
    mov rdi, 0
    syscall

; extra functions
invalidinput:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg4
    mov rdx, len4
    syscall

    call jumpline
    ret

jumpline:
    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall
    ret