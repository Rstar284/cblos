# cblos

Minimal BIOS operating system.

## Prerequisites
* [Git](https://github.com/git/git)
* [Make](https://github.com/mirror/make)
* [NASM](https://github.com/netwide-assembler/nasm)

## Build
```sh
$ # Build the bootloader
$ make -C bootloader
$
$ # Build the kernel
$ make -C kernel cblkern
$
$ # Link kernel
$ make -C kernel linkcbl
$
$ # Test in qemu
$ make -C kernel test-qemu
```
> NOTE: The `$` in this context means running in your terminal.
