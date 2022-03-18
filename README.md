# MOOT16
A simple universal bootloader for 16bit kernels.

### Currently a work in progress

### How to build

```
nasm maseBOOT.asm -f bin -o maseBOOT.bin
cat maseBOOT.bin 'YourKernel.bin' > OS16.bin
sudo qemu-system-x86 -fda OS16.bin
```

Start  | End    | Type
-------|--------|-------------
0x7c00 | 0x7e00 | Bootloader
0x0000 | ?????? | Kernel

![MBOOT16](https://github.com/masen-f/maseBOOT/blob/main/maseBOOT.png)
