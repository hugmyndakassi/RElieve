Scripts used for reverse engineering, troubleshooting etc.

| Tool/Script | Description |
|-------------|-------------|
| `elfie.py` | display (basic) info about an ELF, similar to `readelf` |
| `elforensics.py` | check ELF for entry point hooks, RWX sections, CTORS & GOT & PLT hooks, function prologue trampolines |
| `dololi` | unfinished, the idea is to automatically generate an executable that calls exports from DLL(s) |
| `kaslr-addr2line.sh` | convert kernel addresses with KASLR to vmlinux addresses for debugging with addr2line |
