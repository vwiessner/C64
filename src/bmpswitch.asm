/*
 *
 * Copyright (c) 2023 Veit Wiessner <veitwiessner+6502@gmail.com>
 * Published under MIT License (https://opensource.org/license/mit/)
 *
 * bmpswitch: switch bitmap mode on/off
 * memory map: $c000-$c037
 *
 * Usage:
 * sys49152
 * first call will switch bitmap mode on, second call will switch it off
 *
 * syntax for Kick Assembler (http://www.theweb.dk/KickAssembler/Main.html#frontpage)
 *
 */

#import "header.asm"

#importonce

.filenamespace bmpswitch
.segment code "bmpswitch"

.const VIC = $D000
.const VIC_CTRL = VIC+17
.const VIC_MEM_CTRL = VIC+24

.const VIC_CTRL_SWITCH = %00100000
.const VIC_MEM_CTRL_SWITCH = %00001000

//.watch $d011


bmpswitch:
        lda BMP_ON
        bne switchoff
switchon:
        lda VIC_CTRL
        sta VIC_CTRL_STORE
        ora #VIC_CTRL_SWITCH
        sta VIC_CTRL

        lda VIC_MEM_CTRL
        sta VIC_MEM_CTRL_STORE
        ora #VIC_MEM_CTRL_SWITCH
        sta VIC_MEM_CTRL
        
        lda #$01
        sta BMP_ON
        jmp end
switchoff:
        lda VIC_CTRL_STORE
        sta VIC_CTRL

        lda VIC_MEM_CTRL_STORE
        sta VIC_MEM_CTRL

        lda #$00
        sta BMP_ON
end:
        rts


VIC_CTRL_STORE:
        .byte $00
VIC_MEM_CTRL_STORE:
        .byte $00
BMP_ON:
        .byte $00