#importonce
.file [name="%o.prg", segments="code"]
.segmentdef code [start=$c000]

// pointers to unused Zero Page locations
.const zp_byte=$02
.const zp_addr_1=$fb
.const zp_addr_2=$fd

// BASIC subroutines
.const CHKCOM = $aefd // test for comma
.const FRMNUM = $ad8a // get numerical value as floating point (stored in FAC)
.const ADRFOR = $b7f7 // part of POKE, will take value in FAC and convert to 16 bit INT (stored in $14/$15)
.const GETBYT = $b79e // gets a one byte value (stored in X register)
