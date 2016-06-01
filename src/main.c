#include <hypercall.h>

#define GPIOX_BASE_ADDR ((unsigned int *)0x41400000)
#define GPIOX_OFFS_ADDR 0x0C20


#define SYSTEM_UP_MSG "domB: Entered main function...\n"
#define SYSTEM_UP_LEN 32

#define GPIO_INFO_LEN 30

int main () {

    volatile unsigned int *gpio = GPIOX_BASE_ADDR;

    HYPERVISOR_console_io (HYPERCALL_WRITE, SYSTEM_UP_LEN, SYSTEM_UP_MSG);

   // HYPERVISOR_console_io(0, 5, "hello");

    /** We made it to main **/
    __asm("mov r10, #100");

    // Set direction of GPX1.2 configuration register as out.
    *(gpio + (0x0c20 >> 2)) |= (0x1 << 8);

    while (1367) {
        /** We are stuck in for loop **/
        __asm("mov r9, #100");
        // GPX1.2 High
        *(gpio + (0x0c24 >> 2)) |= (1 << 2);
    }
}
