#include "include/compiler/compiler.h"
#include "include/SPU/SPU.h"

int main(int argc, const char *argv[])
{
    if(argc == 1) return 0;

    Processor SPU = SPUCtor();
    Assembler(argv[1]);
    Execute("code.bin", &SPU);

    SPUDtor(&SPU);
}
