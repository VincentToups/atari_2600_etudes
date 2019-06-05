.PHONY: clean
.SECONDARY: sprite2.bin

%.run: %.bin
	Stella -tia.zoom 0 -format ntsc $*.bin

clean:
	rm *.lst *.sym *.bin

%.bin: %.asm
	dasm $*.asm -l$*.lst -s$*.sym -f3 -v5 -o$*.bin
