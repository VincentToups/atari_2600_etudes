        processor 6502

        include "vcs.h"
        include "macro.h"
        org $f000

BGColor equ $81
TColor  equ $82

SH      equ 9
YPos    equ $83

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

NextFrame
        lda #2
        sta VBLANK
        sta VSYNC

        sta WSYNC
        sta WSYNC
        sta WSYNC

        lda #0
        sta VSYNC

        ldx #37
LVBlank
        sta WSYNC
        sta RESP0       
        dex
        bne LVBlank

        lda #0
        ldy BGColor             
        sty TColor              ; initialize color for scans
        sta VBLANK
       
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
