        processor 6502

        include "vcs.h"
        include "macro.h"
        org $f000

BGColor equ $81

Start
        CLEAN_START

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
        dex
        bne LVBlank

        lda #0
        sta VBLANK

        ldx #192
        ldy BGColor
LVScan
        sty COLUBK
        sta WSYNC

        iny
        dex
        bne LVScan

        lda #2
        sta VBLANK
        ldx #30

LVOver
        sta WSYNC
        dex
        bne LVOver

        dec BGColor
        jmp NextFrame


        org $fffc
        .word Start
        .word Start
