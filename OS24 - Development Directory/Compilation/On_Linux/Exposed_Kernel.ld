SECTIONS
{

    .text 0x7E00 :
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

}