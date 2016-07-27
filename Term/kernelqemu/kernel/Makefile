all: 32bitkernel.s kernel.ld
	/home/ming/CodeSourcery/Sourcery_CodeBench_Lite_for_MIPS_ELF/bin/mips-sde-elf-gcc -mips32 -EL -c 32bitkernel.s -o kernel.o
	/home/ming/CodeSourcery/Sourcery_CodeBench_Lite_for_MIPS_ELF/bin/mips-sde-elf-ld -mips32 -EL -T kernel.ld kernel.o -o kernel
