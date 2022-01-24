# cblos
BIOS operating system

## how do you compile it
```sh
# Compile bootloader
make -C src/bootloader

# Compile kernel
make -C src/kernel

# Compile both into an image
make
```