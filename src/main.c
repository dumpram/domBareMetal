#include <hypercall.h>

#define GPIOA_BASE_ADDR ((unsigned int *)0x41400000)
#define GPIOA_CONT_OFFS 0x0040
#define GPIOA_DATA_OFFS 0x0044
#define GPIOA_PUPD_OFFS 0x0048

#define LOOP_CONST 10000000

#define SYSTEM_UP_MSG "domB: Entered main function...\n"
#define SYSTEM_UP_LEN 32

#define GPIO_INFO_LEN 30

int main () {

    volatile unsigned int *gpio = GPIOA_BASE_ADDR;
    int i;

    HYPERVISOR_console_io (HYPERCALL_WRITE, SYSTEM_UP_LEN, SYSTEM_UP_MSG);

    /** We made it to main **/
    __asm("mov r10, #100");

    // Set direction of GPA2.4 configuration register as out.
    *(gpio + (GPIOA_CONT_OFFS >> 2)) |= (0x1 << 16);

    while (1367) {
        /** We are stuck in while loop **/
        for ( i = 0; i < LOOP_CONST; i++ ) {
            __asm("mov r9, #100"); // wait some time
        }
        // GPA2.4 High
        *(gpio + (GPIOA_DATA_OFFS >> 2)) |= (1 << 4);

        for ( i = 0; i < LOOP_CONST; i++ ) {
            __asm("mov r9, #100"); // wait some time
        }
        // GPA2.4 Low
        *(gpio + (GPIOA_DATA_OFFS >> 2)) &= ~(1 << 4);
    }
}
