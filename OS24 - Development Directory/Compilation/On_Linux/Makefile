# There is no need to use this make file unless you are writing custom processes. 
# Please use the one found in the development directory.
# It will call this when necessary.

# WHY: I set this up so that you don't need to navigate to different locations
# to build the OS. While learning EFI, there were makefiles all over.
# I found it frustrating, and made it so you can do all the compilation from above.



Boot_Setup_Directory = ../../AssemblyLanguageBootloader/
Kernel_Setup_Directory = ../../HighLevelLanguageKernel/

Boot_Setup_ASM_Binary_Out = Bootloader
Boot_Setup_ASM_Object_Out = PostBootSetup

Kernel_Setup_C_Files = Exposed_Kernel

ASMCompiler = nasm

CCompiler = clang
CCompiler_Flags = -std=c17 -m32 -march=i386 -ffreestanding -fno-builtin -nostdinc -O1
# Stores the directory of these ASM files
# Stores the general file names in a variable array



.PHONY: Boot_Setup.flp
# If there are any files named this already, then don't try to open them.
# instead run the label.



# Link the label to the recursive function defined by the variable "Boot_Setup_ASM_Files".
# NOTE: Makefile conventions require the recursive link to be on the same line as the label.
# If the recursive link isn't placed on the label, the makefile will fail with an error saying the command wasn't found.
# If that happens, then just move the recursive link up to the same line as the label.
Boot_Setup.flp: $(Boot_Setup_ASM_Binary_Out) $(Boot_Setup_ASM_Object_Out) $(Kernel_Setup_C_Files)
	ld -m elf_i386 -o Exposed_Kernel.tmp -Ttext 0x7E00 PostBootSetup.o Exposed_Kernel.o

	objcopy -O binary Exposed_Kernel.tmp Exposed_Kernel.bin

	cat Bootloader.bin Exposed_Kernel.bin > Boot_Setup.flp

	mv *.bin ../Binary
	mv *.flp ../Floppy
# Move all of the binary and floppy files to their designated folders.

# For each file name in the array labeled "Boot_Setup_ASM_Files", run NASM, and append the file name ($@.asm ; $@.bin).
# to the following file type.
$(Boot_Setup_ASM_Binary_Out):
	$(ASMCompiler) $(Boot_Setup_Directory)$@.asm -f bin -o $@.bin

$(Boot_Setup_ASM_Object_Out):
	$(ASMCompiler) $(Boot_Setup_Directory)$@.asm -f elf32 -o $@.o

$(Kernel_Setup_C_Files):
	$(CCompiler) -c $(CCompiler_Flags) -o $@.o $(Kernel_Setup_Directory)$@.c
# ld -m elf_i386 -T$@.ld $@.o --oformat binary -o $@.bin