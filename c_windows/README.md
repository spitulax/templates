# How to compile for Windows in Linux

```bash
cross/gensysrootini.sh
# `-buildtype debug` compiles but does not run on Wine
meson setup build --cross-file cross/windows-x64.ini --cross-file cross/winsysroot.ini --buildtype release
meson compile -C build
```
