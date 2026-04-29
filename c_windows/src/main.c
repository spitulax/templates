#include <stdio.h>
#ifdef _WIN32
#include <windows.h>
#endif

int main(int argc, char *argv[]) {
    printf("Hello, C! fooname version %s\n", PROG_VERSION);

#ifdef _WIN32
    MessageBoxA(NULL, "Success!", "fooname", MB_OK);
#endif

    return 0;
}
