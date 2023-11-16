call Solver
hlt



GetCoefficients:
    in
    in
    in
    pop rcx
    pop rbx
    pop rax
    ret

Solver:
    call GetCoefficients

    push rax
    push 0
    je Linear

    push rbx
    push 0
    je Q_ac

    push rcx
    push 0
    je Q_ab

    push rbx
    push rbx
    mul
    push 4
    push rax
    push rcx
    mul
    mul
    sub
    pop rdx

    push rdx
    push 0
    je D_0

    push rdx
    push 0
    jb N_roots

    push rdx
    sqrt
    pop rdx

    push rbx
    neg
    push rdx
    add
    push 2
    push rax
    mul
    div
    out


    push rbx
    neg
    push rdx
    sub
    push 2
    push rax
    mul
    div
    out

    ret

Linear:
    push rbx
    push 0
    je L_c

    push rcx
    push 0
    je X_0

    push rcx
    neg
    push rbx
    div
    out

    ret
L_c:
    push rcx
    push 0
    jne N_roots

    push inf
    out

    ret
X_0:
    push 0
    out

    ret
Q_ac:
    push rcx
    push 0
    je X_0

    push rcx
    neg
    push rax
    div
    pop rax

    push rax
    push 0
    jb N_roots

    push rax
    sqrt
    pop rax

    push rax
    out

    push rax
    neg
    out

    ret

Q_ab:
    push 0
    out

    push rbx
    neg
    push rax
    div
    out

    ret

D_0:
    push rbx
    neg
    push 2
    push rax
    mul
    div
    out

    ret

N_roots:
    push 1
    push 0
    div
    out

    ret