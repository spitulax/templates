#include <iostream>

#ifdef _WIN32
    #include <windows.h>
#endif

int main(int argc, char *argv[]) {
    std::cout << "Hello, C++! fooname version " << PROG_VERSION << '\n';

#ifdef _WIN32
    MessageBoxA(NULL, "Success!", "fooname", MB_OK);
#endif

    return 0;
}
