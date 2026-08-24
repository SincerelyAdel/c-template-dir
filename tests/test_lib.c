#include <stdio.h>
#include "lib.h"

static int all_ok = 1;

static void check_int(const char *name, int got, int want) {
    int ok = got == want;
    if (!ok) all_ok = 0;
    printf("%-40s got=%-8d want=%-8d %s\n", name, got, want, ok ? "PASS" : "FAIL");
}

int main(void) {
    int result = 0;
    status_t rc = lib_add(2, 3, &result);

    check_int("lib_add: 2 + 3", result, 5);
    check_int("lib_add: return status", rc, STATUS_OK);
    check_int("lib_add: null out returns error", lib_add(1, 1, NULL), STATUS_ERR);

    return all_ok ? 0 : 1;
}
