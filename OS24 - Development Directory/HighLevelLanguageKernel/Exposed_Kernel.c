#define MODEINFOBLOCK_ADDRESS 0x6028
#define BLUE 0x000000FF
#define RED  0x00FF0000

extern void Exposed_Kernel()
{
    typedef unsigned char uint8_t;
    typedef char int8_t;
    typedef unsigned short uint16_t;
    typedef short int16_t;
    typedef unsigned int uint32_t;
    typedef int int32_t;
    typedef unsigned long long uint64_t;
    typedef long long int64_t;

    uint32_t* modeInfoBlock_Framebuffer = (uint32_t*)*(uint32_t*)MODEINFOBLOCK_ADDRESS;
    
    for (uint32_t i = 0; i < 1920*1080; i++)
    {
        modeInfoBlock_Framebuffer[i] = RED;
    }

    __asm("cli");
    __asm("hlt");
}