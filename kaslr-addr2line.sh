#!/bin/bash

set -xeuo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <kallsyms_address>"
    exit 1
fi

KALLSYMS_ADDR="$1"
VMLINUX="/usr/lib/debug/boot/vmlinux-$(uname -r)"

KALLSYMS_ADDR=${KALLSYMS_ADDR#0x}

KASLR_BASE=$(grep " _text$" /proc/kallsyms | cut -d' ' -f1)
VMLINUX_BASE=$(nm "$VMLINUX" | grep " _text$" | cut -d' ' -f1)

if [ -z "$KASLR_BASE" ] || [ -z "$VMLINUX_BASE" ]; then
    echo "Error: Could not find _text symbol"
    exit 1
fi

KASLR_OFFSET=$((KASLR_BASE - VMLINUX_BASE))
VMLINUX_ADDR=$(printf "%x" $((KALLSYMS_ADDR - KASLR_OFFSET)))

echo "KASLR offset: 0x$(printf "%x" $KASLR_OFFSET)"
echo "Converting kallsyms 0x$KALLSYMS_ADDR to vmlinux 0x$VMLINUX_ADDR"
echo ""

addr2line -e "$VMLINUX" -f -i -p "0x$VMLINUX_ADDR"
