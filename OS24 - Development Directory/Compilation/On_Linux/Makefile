# There is no need to use this make file unless you are writing custom processes. 
# Please use the one found in the development directory.
# It will call this when necessary.

# WHY: I set this up so that you don't need to navigate to different locations
# to build the OS. While learning EFI, there were makefiles all over.
# I found it frustrating, and made it so you can do all the compilation from above.
.PHONY: Boot_Setup.flp



Boot_Setup.flp:
	nasm ../../AssemblyLanguageBootloader/Bootloader.asm -f bin -o Bootloader.bin
	nasm ../../AssemblyLanguageBootloader/PostBootSetup.asm -f bin -o PostBootSetup.bin

	cat Bootloader.bin PostBootSetup.bin > Boot_Setup.flp

	mv *.bin ../Binary
	mv *.flp ../Floppy