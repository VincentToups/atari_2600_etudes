        processor 6502

        include "vcs.h"
        include "macro.h"
        
        seg Code
        org $f000

Start   sei
        cld
        ldx $ff
        txs

        lda #0
        ldx #$ff
ZeroZP  sta $0,X
        dex
        bne ZeroZP

        lda #$30
        sta COLUBK
        jmp Start

        org $fffc
        .word Start
        .word Start
        
        

