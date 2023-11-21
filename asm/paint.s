push 1
pop rax

push 3
pop rbx

push 1
pop rex

push 1
pop rfx

Back:
    push rax
    push 1
    sub
    push 38
    push rax
    sub
    mul
    push 0
    jae L1

    push rex
    neg
    pop rex
    push rax
    push rex
    add
    pop rax

L1:
    push rbx
    push 3
    sub
    push 97
    push rbx
    sub
    mul
    push 0
    jae L2

    push rfx
    neg
    pop rfx
    push rbx
    push rfx
    add
    pop rbx

L2:
    call Draw_Circle
    call Draw_Circle
    call Draw_Circle
    call Draw_Circle
    call Draw_Circle
    call Draw_Circle


    rst

    push rax
    push rex
    add
    pop rax

    push rbx
    push rfx
    add
    pop rbx
jmp Back

hlt

Get_Pos:
    push rax
    push 100
    mul
    push rbx
    add
    pop rcx
ret

Draw_Circle:
    call Get_Pos
    pt [rcx]

    push rcx
    push 1
    sub
    pop rcx
    pt [rcx]

    push rcx
    push 1
    sub
    pop rcx
    pt [rcx]

    push rcx
    push 1
    sub
    pop rcx
    pt [rcx]

    push rcx
    push 4
    add
    pop rcx
    pt [rcx]

    push rcx
    push 1
    add
    pop rcx
    pt [rcx]

    push rcx
    push 1
    add
    pop rcx
    pt [rcx]

    push rcx
    push 101
    sub
    pop rcx
    pt [rcx]

    push rcx
    push 1
    sub
    pop rcx
    pt [rcx]

    push rcx
    push 1
    sub
    pop rcx
    pt [rcx]

    push rcx
    push 1
    sub
    pop rcx
    pt [rcx]

    push rcx
    push 1
    sub
    pop rcx
    pt [rcx]

    push rcx
    push 200
    add
    pop rcx
    pt [rcx]

    push rcx
    push 1
    add
    pop rcx
    pt [rcx]

    push rcx
    push 1
    add
    pop rcx
    pt [rcx]

    push rcx
    push 1
    add
    pop rcx
    pt [rcx]

    push rcx
    push 1
    add
    pop rcx
    pt [rcx]

    draw

    ret