#include "lib.h"

status_t lib_add(int a, int b, int *out) {
    if (!out) return STATUS_ERR;
    *out = a + b;
    return STATUS_OK;
}
