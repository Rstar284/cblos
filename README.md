# cblos

Minimal BIOS operating system.

## Prerequisite
* [Make](https://github.com/gnu-mirror-unofficial/make)

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
