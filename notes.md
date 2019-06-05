So the issue I'm working on now is when to set the X position of my sprites. One kind of nice thing about the book I'm working with is that it sucks:  it doesn't give whole code listings for its examples, so when it introduces the idea of sprite horizontal positioning, it just gives a code fragment without much of an indication of the "right" or conventional place to do such.

![24%20AM|531x500](upload://2qNxT0vhjxDjaezsqUFh8Mn7HLa.png) 

On the 2600 you draw line by line. Above is a schematic of each frame the 2600's television chip (the TIA) outputs. The big rectangle in the middle labeled "VISIBLE FRAME" is what the player sees. The other parts of the diagram are conceptually the same (virtual or real lines the electron beam scans).

To _draw_ a sprite you have to twiddle the appropriate bits during the HBLANK part of the line for each visible line on the screen. So you have to figure out what pixels should be turned on for each line and tell the TIA about it during that little HBLank period. Since you only do this for certain lines, this also determines the y coordinate of the sprite on the screen. (In fact, a sprite can occupy every line if you just set pixels for each line. And you can set any pixels you want, they don't even need to be drawn from contiguous memory locations or anything).

To set the horizontal position you have to wait for the electron beam to be at the appropriate horizontal position and then strobe the right register. Its impossible to avoid counting cycles here.

```
        ldx XPos
        inx 
        sta WSYNC
P1P
        dex
        bne P1P
        sta RESP0

```

The above fragment kind does what we want. Here is how to read it:

`ldx XPos` loads the value at memory location `XPos` (which represents our X position) into the X register. Its just a coincidence that the X register is named `X` here, there isn't anything fundamental about that name that relates to position. 

We will be using the X register as our loop index, though. We add one to it so that, when XPos is 0 we don't underflow and run the loop 255 times. Then we `sta WSYNC` which tells the processor to wait for the next scanline to start.

Once that happens we decrement x, compare it to zero, `dex; bne P1P`. If it is not zero, we jump up to the label `P1P`. If it is zero, we move through. Each pass through the loop takes five 6502 cycles, and thus corresponds to 15 pixels.  (The pixels are drawn during each 6502 cycle).

There is also a fine positioning register we need to set, to account for the fact that we can only set coarse resolution using time in increments of 15.
