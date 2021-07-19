[extern Exposed_Kernel]

KernelHost:
    call Exposed_Kernel
                                                ; The kernel is entirely in C. This section is just data defined by the linker
                                                ; If this malfunctions, try adding more sectors.
section .text

section .bss

section .rodata