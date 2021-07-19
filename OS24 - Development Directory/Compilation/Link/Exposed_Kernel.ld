OUTPUT_FORMAT(binary)

ENTRY(Exposed_Kernel)

INPUT(PostBootSetup.o Exposed_Kernel.o)

OUTPUT(Exposed_Kernel.bin)

SECTIONS
{

    . = 0x1000;

    .text :
    {
        *(.text*);
    }

    .bss :
    {
        *(.bss*);
    }

    .rodata :
    {
        *(.rodata*);
    }

    .data :
    {
        *(.data*);
    }

}