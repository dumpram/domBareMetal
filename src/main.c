int main () {
    
    /** We made it to main **/
    __asm("mov r10, #100");
    
    while (1367) {
        /** We are stuck in for loop **/
        __asm("mov r9, #100");
    }
}