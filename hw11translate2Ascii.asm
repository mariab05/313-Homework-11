; Maria Bryant, Homework 11, 313 M W 2:30 PM


section .data
    inputBuf db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A  ; a label which points to a series of 8 bytes
    inputLen equ $ - inputBuf           ; calculates the length of inputBuf (8)
    hexChars db '0123456789ABCDEF'      ; a lookup table for hexadecimal digits

section .bss    ; declares uninitialized data
    outputBuf resb 80      ; 80 bytes of memory used to store the translated values

section .text
    global _start

_start:
    mov esi, inputBuf       ; used as a register pointer to inputBuf
    mov edi, outputBuf      ; destination pointer
    mov ecx, inputLen       ; loop counter

next_byte:
    lodsb                   ; loads byte from esi and then increments esi
    call convert_byte_to_hex ; calls subroutine

    dec ecx                 ; decrements the loop counter, one byte processed
    jz done_loop            ; if counter is zero, jumps to done_loop

    mov al, ' '             ; loads space character into AL
    stosb                   ; stores the space after the current hex byte
    jmp next_byte           ; jumps to next_byte, which starts the process again (translates the next byte)

done_loop:
    mov al, 10              ; newline character
    stosb                   ; stores newline character

    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, outputBuf
    mov edx, edi
    sub edx, ecx            ; calculate length
    int 0x80

    ; Exit
    mov eax, 1              ; sys_exit
    xor ebx, ebx
    int 0x80

; subroutine, converts byte to hex

convert_byte_to_hex:
    push ax                 ; saves original byte

    mov ah, al      ; AX contains byte in both halves
    shr ah, 4       ; moves high nibble to lower four bits of AH
    and ah, 0x0F    ; keeps low four bits in AH and clears the rest, for valid index
    movzx edx, ah   ; moves AH to EDX and makes the rest of the 32 bits 0 (so upper 24 are filled with 0)
    mov al, [hexChars + edx] ; loads the ASCII character for the high nibble
    stosb                   ; stores the ASCII character into EDI and increments EDI

    pop ax                  ; reloads original byte
    and al, 0x0F            ; isolates low nibble
    movzx edx, al           ; makes EDX hold 0 extended table
    mov al, [hexChars + edx]    ; loads ASCII characters for low nibble
    stosb                   ; stores the low nibble (second hex digit) into EDI

    ret
