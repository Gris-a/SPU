in

pop rax
push rax
push rax
push 0
jb Err ;negative input


pop rax
push 1
push rax
call Factorial_Main
out
hlt


Factorial_Main:
    pop rax
    push rax
    push 1

    ja Recursion

    ret
Recursion:
    push rax
    mul
    push rax
    push 1
    sub
    call Factorial_Main
    ret



Err: ;negative input
    push 0
    div
    hlt