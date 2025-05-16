AUTHORING: Maria Bryant, 313, 2:30 M/W 
PURPOSE OF SOFTWARE: Takes in a number of bytes of data and prints data to the screen
FILES: Only one file, main file where assembly code to translate and output data is
BUILD INSTRUCTIONS: To assemble: nasm -f elf32 -g -F dwarf hw11translate2Ascii.asm
To link and load: ld -m elf_i386 -o hw11translate2Ascii hw11translate2Ascii.o
