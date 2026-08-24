#include <stdio.h>
#include "lib.h"

int main(void) {
    int result;
    if (lib_add(2, 3, &result) != STATUS_OK) {
        return 1;
    }
    printf("2 + 3 = %d\n", result);
    return 0;
}
