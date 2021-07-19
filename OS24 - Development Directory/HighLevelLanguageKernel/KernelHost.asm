[extern Exposed_Kernel]

KernelHost:
    call Exposed_Kernel
                                                ; The kernel is entirely in C. This section is just data defined by the linker
                                                ; All of the voids are linked, so you can add them to the assembly using extern
                                                ; like above [extern Exposed_Kernel]. This is calling the C method void Exposed_Kernel(){}
                                                ; If this malfunctions, try adding more sectors.
    ret

section .text

section .bss

section .rodata

section .data