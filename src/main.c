#include <hypercall.h>

#define GPIOX_BASE_ADDR 0x13400000
#define GPIOX_OFFS_ADDR 0x0C20


#define SYSTEM_UP_MSG "domB: Entered main function...\n"
#define SYSTEM_UP_LEN 32

int main () {

//    unsigned int *gpio_base = GPIOX_BASE_ADDR;

    HYPERVISOR_console_io (HYPERCALL_WRITE, SYSTEM_UP_LEN, SYSTEM_UP_MSG);

   // HYPERVISOR_console_io(0, 5, "hello");

    /** We made it to main **/
    __asm("mov r10, #100");

    while (1367) {
        /** We are stuck in for loop **/
        __asm("mov r9, #100");
    }
}
