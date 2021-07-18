nasm ../AssemblyLanguageBootloader/Bootloader.asm -f bin -o Bootloader.bin
nasm ../AssemblyLanguageBootloader/PostBootSetup.asm -f bin -o PostBootSetup.bin
@echo off

copy /b Bootloader.bin+PostBootSetup.bin Boot_Setup.flp
move *.bin Binary
move *.flp Floppy

pause