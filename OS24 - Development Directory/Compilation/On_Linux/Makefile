# There is no need to use this make file unless you are writing custom processes. 
# Please use the one found in the development directory.
# It will call this when necessary.

# WHY: I set this up so that you don't need to navigate to different locations
# to build the OS. While learning EFI, there were makefiles all over.
# I found it frustrating, and made it so you can do all the compilation from above.



Boot_Setup_Directory = ../../AssemblyLanguageBootloader/
Boot_Setup_ASM_Files = Bootloader PostBootSetup
# Stores the directory of these ASM files
# Stores the general file names in a variable array



.PHONY: Boot_Setup.flp
# If there are any files named this already, then don't try to open them.
# instead run the label.



# Link the label to the recursive function defined by the variable "Boot_Setup_ASM_Files".
Boot_Setup.flp: $(Boot_Setup_ASM_Files)
	cat Bootloader.bin PostBootSetup.bin > Boot_Setup.flp

	mv *.bin ../Binary
	mv *.flp ../Floppy
# Move all of the binary and floppy files to their designated folders.

# For each file name in the array labeled "Boot_Setup_ASM_Files", run NASM, and append the file name ($@.asm ; $@.bin).
# to the following file type.
$(Boot_Setup_ASM_Files):
	nasm $(Boot_Setup_Directory)$@.asm -f bin -o $@.bin