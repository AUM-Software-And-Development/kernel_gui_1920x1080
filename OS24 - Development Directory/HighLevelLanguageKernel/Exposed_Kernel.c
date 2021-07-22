// Needs headers

#include "DisplayInstructions/DisplayArrays.c"

void Exposed_Kernel()
{
    Points KernelDisplayPoints = {.X = display_height/2, .Y = display_width/2};

    Clear_Display();
    Draw_Sticky_Box_For_Display(KernelDisplayPoints);

    return;
}