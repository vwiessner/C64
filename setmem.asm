/*
 *
 * Copyright (c) 2023 Veit Wiessner <veitwiessner+6502@gmail.com>
 * Published under MIT License (https://opensource.org/license/mit/)
 *
 * setmem: write specified byte x times to memory, start at given address
 * memory map: $c000-$c042
 *
 * Usage:
 * sys49152,<startaddress>,<number of runs>,<byte that will be written>
 * example: sys49152,8192,8000,0 will clear hires graphics memory
 *
 * syntax for Kick Assembler (http://www.theweb.dk/KickAssembler/Main.html#frontpage)
 *
 */ 

#import "header.asm"

#importonce

.filenamespace setmem
.segment code "setmem-cli"

setmem:
get_values:
// get start address
        jsr CHKCOM
        jsr FRMNUM
        jsr ADRFOR
        lda $14
        sta zp_addr_1          // save in zeropage
        lda $15
        sta zp_addr_1+1

// get number of repetitions
        jsr CHKCOM
        jsr FRMNUM
        jsr ADRFOR
        lda $14
        sta zp_addr_2
        lda $15
        sta zp_addr_2+1

// get value of byte that will be written
        jsr CHKCOM
        jsr GETBYT
        txa

.segment code "setmem-main"
main:     
{
        ldx zp_addr_2+1         // put hh of loopcount in x
        beq loopcount_lt_256    // if loopcount is < 256 skip to the loop that handles loopcount % 256
    loop:
        ldy #$00
    {
    loop:
        sta (zp_addr_1),Y       // write fill-byte to memory
        dey                     // decrement Y (rolls over to 255 on first run)
        bne loop               // if y != 0 jump to loop1
    }
        inc zp_addr_1+1         // increment hh of memory addresses that get overwritten
        dex                     // decrement hh of loopcount
        bne loop               // as long as hh of loopcount is >= 0 jump to loop2
}
    loopcount_lt_256:           // loopcount % 256
{
        ldy zp_addr_2           // put ll of loopcount in y
        beq end                 // if 0 end
    loop:
        dey
        sta (zp_addr_1),Y
        bne loop
}
    end:
        rts
