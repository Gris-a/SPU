CFLAGS = -D _DEBUG -ggdb3 -std=c++20 -O0 -Wall -Wextra -Weffc++ -Waggressive-loop-optimizations -Wc++14-compat -Wmissing-declarations -Wcast-align -Wcast-qual -Wchar-subscripts -Wconditionally-supported -Wconversion -Wctor-dtor-privacy -Wempty-body -Wfloat-equal -Wformat-nonliteral -Wformat-security -Wformat-signedness -Wformat=2 -Winline -Wlogical-op -Wnon-virtual-dtor -Wopenmp-simd -Woverloaded-virtual -Wpacked -Wpointer-arith -Winit-self -Wredundant-decls -Wshadow -Wsign-conversion -Wsign-promo -Wstrict-null-sentinel -Wstrict-overflow=2 -Wsuggest-attribute=noreturn -Wsuggest-final-methods -Wsuggest-final-types -Wsuggest-override -Wswitch-default -Wswitch-enum -Wsync-nand -Wundef -Wunreachable-code -Wunused -Wuseless-cast -Wvariadic-macros -Wno-literal-suffix -Wno-missing-field-initializers -Wno-narrowing -Wno-old-style-cast -Wno-varargs -Wstack-protector -fcheck-new -fsized-deallocation -fstack-protector -fstrict-overflow -flto-odr-type-merging -fno-omit-frame-pointer -Wlarger-than=8192 -Wstack-usage=8192 -pie -fPIE -Werror=vla -fsanitize=address,alignment,bool,bounds,enum,float-cast-overflow,float-divide-by-zero,integer-divide-by-zero,leak,nonnull-attribute,null,object-size,return,returns-nonnull-attribute,shift,signed-integer-overflow,undefined,unreachable,vla-bound,vptr

all: obj a.out

obj:
	@mkdir obj

a.out: obj/main.o obj/log.o obj/compiler.o obj/SPU.o obj/stack.o obj/general.o
	@g++ $(CFLAGS)  $^ -o $@

obj/main.o: main.cpp include/compiler/compiler.h include/SPU/SPU.h include/general/general.h include/general/commands.h include/stack/stack.h include/general/log.h
	@g++ $(CFLAGS)  -c $< -o $@

obj/general.o: source/general/general.cpp include/general/general.h include/general/commands.h include/general/log.h
	@g++ $(CFLAGS)  -c $< -o $@

obj/log.o: source/general/log.cpp include/general/log.h
	@g++ $(CFLAGS)  -c $< -o $@

obj/compiler.o: source/compiler/compiler.cpp include/compiler/compiler.h include/general/general.h include/general/commands.h include/general/log.h
	@g++ $(CFLAGS)  -c $< -o $@

obj/SPU.o: source/SPU/SPU.cpp include/SPU/SPU.h include/stack/stack.h include/general/general.h include/general/commands.h include/general/log.h
	@g++ $(CFLAGS)  -c $< -o $@

obj/stack.o: source/stack/stack.cpp include/stack/stack.h include/general/log.h
	@g++ $(CFLAGS)  -c $< -o $@