# cblos

Minimal BIOS operating system.

## Prerequisites
* [Git](https://github.com/git/git)
* [Make](https://github.com/mirror/make)
* [NASM](https://github.com/netwide-assembler/nasm)

## Build
```sh
$ # Build the bootloader
$ make -C src/bootloader
$
$ # Build the kernel
$ make -C src/kernel
$
$ # Build eveything into a single `.iso` image
$ make
```
> NOTE: The `$` in this context means running in your terminal.
