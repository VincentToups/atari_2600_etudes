        processor 6502

        include "vcs.h"
        include "macro.h"
        org $f000

BGColor equ $81
TColor  equ $82

SH      equ 9
YPos    equ $83
XPos    equ $84
XPosC   equ $85        
XPosF   equ $86       
        

Frame0
        .byte #%00000000;$40
        .byte #%01001000;$40
        .byte #%00100000;$40
        .byte #%00000000;$94
        .byte #%00110000;$94
        .byte #%00110000;$94
        .byte #%00000100;$40
        .byte #%00010010;$40
        .byte #%00000000;$40        
        
Start
        CLEAN_START
        lda #10
        sta YPos
        lda #0
        sta XPos

NextFrame
        lda #2
        sta VBLANK
        sta VSYNC

        sta WSYNC
        sta WSYNC
        sta WSYNC

        lda #0
        sta VSYNC

        ldx #35                 ; skip all but the last two v blank line
LVBlank
        sta WSYNC
        dex
        bne LVBlank
        
        ldx XPosC
        sta WSYNC
P1P
        dex
        bne P1P
        sta RESP0
        lda XPosF        
        sta HMP0
        sta WSYNC
        sta HMOVE

        lda #0
        sta VBLANK

        ldy BGColor             
        sty TColor              ; initialize color for scans
       
        ldx #192
LVScan
        sta WSYNC
        ldy TColor
        sty COLUBK
        iny
        sty TColor              ; store color for next frame

        txa
        sec
        sbc YPos
        cmp #SH
        bcc InSprite
        lda #0
        sta GRP0

Rt
        dex        
        bne LVScan

        sta WSYNC
        lda #2
        sta VBLANK
        ldx #30

LVOver
        sta WSYNC
        dex
        bne LVOver

        inc XPos
        lda XPos
        tax
        cmp #159
        bne Hop
        lda #0
        sta XPos
Hop
        txa
        adc #68
        clc     
        ldx #0
        sec
PDiv    sbc #15
        inx
        bcs PDiv
        dex
        eor #7
        asl
        asl
        asl
        asl
        sta XPosF
        txa
        sta XPosC
        
        inc YPos
        dec BGColor
        jmp NextFrame

InSprite
        tay
        lda Frame0,Y
        sta GRP0
        jmp Rt
        

        org $fffc
        .word Start
        .word Start
