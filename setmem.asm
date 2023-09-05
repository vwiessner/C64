/*
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

.const zp_byte=$02
.const zp_addr_1=$fb
.const zp_addr_2=$fd

// BASIC subroutines
.const CHKCOM = $aefd // test for comma
.const FRMNUM = $ad8a // get numerical value as floating point (stored in FAC)
.const ADRFOR = $b7f7 // part of POKE, will take value in FAC and convert to 16 bit INT (stored in $14/$15)
.const GETBYT = $b79e // gets a one byte value (stored in X register)



*=$c000                         // program starts at $C000 (49152)

get_values:
// get start address
        jsr CHKCOM
        jsr FRMNUM
        jsr ADRFOR
        lda $14                 // save in zeropage
        sta zp_addr_1
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
setmem:     
        ldx zp_addr_2+1         // put hh of loopcount in x
        beq loopcount_lt_256    // if loopcount is < 256 skip to the loop that handles loopcount % 256
    loop2:
        ldy #$00
    loop1:
        sta (zp_addr_1),Y       // write fill-byte to memory
        dey                     // decrement Y (rolls over to 255 on first run)
        bne loop1               // if y != 0 jump to loop1
        inc zp_addr_1+1         // increment hh of memory addresses that get overwritten
        dex                     // decrement hh of loopcount
        bne loop2               // as long as hh of loopcount is >= 0 jump to loop2
    loopcount_lt_256:           // loopcount % 256
        ldy zp_addr_2           // put ll of loopcount in y
        beq end                 // if 0 end
    loop3:                
        dey
        sta (zp_addr_1),Y
        bne loop3
    end:
        rts
