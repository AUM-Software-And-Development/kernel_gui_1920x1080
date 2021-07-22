#define mode_info_block_address 0x6028 // TODO: This needs to be changed to be handled by the linking phase
#define blue 0x000000FF
#define red  0x00FF0000
#define white 0xFFFFFFFF
#define test 0x12243648
// TODO: Need to be stored and passed from boot
#define display_height 1080
#define display_width 1920

typedef unsigned char uint8_t;
typedef char int8_t;
typedef unsigned short uint16_t;
typedef short int16_t;
typedef unsigned int uint32_t;
typedef int int32_t;
typedef unsigned long long uint64_t;
typedef long long int64_t;

void Clear_Display()
{
    uint32_t* modeInfoBlockFramebuffer = (uint32_t*)*(uint32_t*)mode_info_block_address;
    
    for (uint32_t i = 0; i < 1920*1080; i++)
    {
        modeInfoBlockFramebuffer[i] = test;
    }

    return;
}

typedef struct points
{
    uint16_t X, Y;
} Points;

void Draw_Pixel(Points pointsStruct)
{
    uint32_t* modeInfoBlockFramebuffer = (uint32_t*)*(uint32_t*)mode_info_block_address;
    modeInfoBlockFramebuffer += (pointsStruct.Y * 1920 + pointsStruct.X);
    // Each row has a block of 1920 pixels (that's how long it is)
    // For every Y column up you go, there is 1920 x 32bpp of space
    // Therefore, each Y location as a sectional row must be multiplied by 1920
    // To find its location in linear space (memory array)
    // To further dereference the pixel itself, it needs to be broken down by 32bpp
    // The mode info block is 32 bits, and the point struct is 16 per point axes
    // in order to reatain its data (prevent overflow)
    *modeInfoBlockFramebuffer = red;

    return;
}

void Draw_Line(Points pointsStruct)
{
    uint32_t* modeInfoBlockFramebuffer = (uint32_t*)*(uint32_t*)mode_info_block_address;

    for (uint32_t i = 0; i < display_width; i++)
    {
    modeInfoBlockFramebuffer[i] = white;
    }

    return;
}

void Draw_Sticky_Box_For_Display(Points pointsStruct)
{
    uint32_t* modeInfoBlockFramebuffer = (uint32_t*)*(uint32_t*)mode_info_block_address;

    for (uint32_t i = 0; i < display_width; i++)
    {
        modeInfoBlockFramebuffer[i] = white;
    }

    pointsStruct.Y = 24;

    for (uint32_t i = 0; i < display_width; i++)
    {
        modeInfoBlockFramebuffer[i + pointsStruct.Y * 1920] = white;
    }

    pointsStruct.X = 0;

    for (pointsStruct.Y = 0; pointsStruct.Y < 24; pointsStruct.Y++)
    {
        modeInfoBlockFramebuffer[pointsStruct.Y * 1920 + pointsStruct.X] = white;
    }

    pointsStruct.X = display_width - 1;

    for (pointsStruct.Y = 0; pointsStruct.Y < 24; pointsStruct.Y++)
    {
        modeInfoBlockFramebuffer[pointsStruct.Y * 1920 + pointsStruct.X] = white;
    }

    return;
}