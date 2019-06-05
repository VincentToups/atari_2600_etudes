Doodles on the Atari 2600
=========================

This repo contains some Atari 2600 assembly files I'm working on. 
See detailed About section below.

Getting Started
===============

This repo assumes you've got Make,
[dasm](https://github.com/munsie/dasm), and
[Stella](https://stella-emu.github.io/) installed in a Unix-like
environment.

To run one of the examples, for instance `rainbows.asm`, simply run:

    > make rainbows.run
    
This will compile the rom and run Stella. Make will delete the rom
afterward (as an intermediate file). To build the rom, just run:

    > make rainbows.bin
    
About
=====

This is some work I'm doing with the book "Making Games for the Atari
2600."

Things that might interest people:

1. That book uses [8BitWorkshop](https://8bitworkshop.com/) which is
   an amazing tool for learning to program the Atari 2600 and other
   6502 based systems.
   
   However, I'm a lifelong emacs user and I wanted to assemble and run
   my roms locally. This repo shows you how to do that (see the
   Makefile).
   
2. "Making Games for the Atari 2600" is full of useful information,
   but it doesn't always contextualize its code fragments. I'm trying
   to write up a series of runnable examples for each major introduced
   idea. So you might find looking at these ASM files more useful than 
   just reading the text or seeing the examples on the website.

Warnings:
---------

I'm just learning to program the 6502/2600. Probably I'm doing some
weird things (sometimes for didactic purposes, sometimes because I
don't know any better). Don't take my examples as being idiomatic or
even correct!

