#include <limits.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "../../include/SPU/SPU.h"

Processor SPUCtor(void)
{
    Processor SPU = {};

    SPU.STEIN = (char *)calloc(RAM_SIZE, sizeof(char));
    ASSERT(SPU.STEIN, return {});

    memset(SPU.STEIN, ' ', RAM_SIZE);

    SPU.SPU_stack   = StackCtor(4);
    SPU.CALLS_stack = StackCtor(4);

    ASSERT(SPU.SPU_stack.data && SPU.CALLS_stack.data, free(SPU.STEIN);
                                                       return {});

    return SPU;
}

int SPUDtor(Processor *SPU)
{
    SPU_VER(SPU, EXIT_FAILURE);

    free(SPU->STEIN);
    SPU->STEIN = NULL;

    free(SPU->name);
    SPU->name = NULL;
    SPU->size = 0;

    return (StackDtor(&SPU->SPU_stack) || StackDtor(&SPU->CALLS_stack));
}

static int ExecInstruction(char *instructions, size_t *pos, Processor *SPU)
{
    SPU_VER(SPU, EXIT_FAILURE);

    SPU_DUMP(SPU);
    Command cmd = {};

    GetVal(&cmd, instructions, pos, sizeof(Command));

#define DEF_CMD(name, code, n_args, ...) case CMD_##name:\
                                         __VA_ARGS__
    switch(cmd.code)
    {
        #include "../../include/general/commands.h"
        default:
        {
            LOG("Error: Unknown command:\t %d\n", cmd.code);

            return EXIT_FAILURE;
        }
    }
#undef DEF_CMD

    return EXIT_FAILURE;
}

int Execute(const char *const path, Processor *SPU)
{
    ASSERT(path, return EXIT_FAILURE);

    SPU_VER(SPU, EXIT_FAILURE);

    char *instructions = GetInst(path, &SPU->size);
    ASSERT(instructions, return EXIT_FAILURE);

    SPU->name = strdup(path);

    size_t pos      = 0;
    int exit_status = 0;
    while(!exit_status)
    {
        exit_status = ExecInstruction(instructions, &pos, SPU);
    }

    free(instructions);

    if(exit_status != EOF)
    {
        LOG("Error: %s exec error.\n", path);

        SPUDump(SPU);
    }
    else exit_status = EXIT_SUCCESS;

    ClearStack(&SPU->SPU_stack  );
    ClearStack(&SPU->CALLS_stack);

    free(SPU->name);
    SPU->name = NULL;
    SPU->size = 0;

    return exit_status;
}

void SPUDump(Processor *SPU)
{
    ASSERT(SPU, return);

    LOG("Executing \'%s\'(%zu bytes total).\n", SPU->name, SPU->size);

    STACK_DUMP(&SPU->SPU_stack  );
    STACK_DUMP(&SPU->CALLS_stack);

    ASSERT(SPU->registers, return);

    LOG("\n""registers:\n");
    for(int i = 0; i < REG_COUNT; i++) LOG("r%cx:\t[" DTS "]\n", (char)('a' + i), SPU->registers[i]);
    LOG("\n\n\n");
}

#ifdef PROTECT
int SPUVer(Processor *SPU)
{
    ASSERT(SPU && SPU->STEIN, return EXIT_FAILURE);

    return (StackVer(&SPU->SPU_stack) || StackVer(&SPU->CALLS_stack));
}
#endif