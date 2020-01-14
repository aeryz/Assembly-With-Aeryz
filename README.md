# AssemblySamples
Functions/programs written in Assembly

# Build 

Each assembly file is a seperate program. You can build and run it or use some parts
of the code. 

```sh
# assemble & link
nasm -felf32 strcmp.asm && ld -m elf_i386 strcmp.o
# run
./a.out 
```
