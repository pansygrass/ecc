# ecc

Matthew Markwell
Joseph Crowe

Verilog for a SECDED Hsaio ECC and a Naseer DEC ECC. 
Power, delay, and area are compared for Berkeley MASIC EEW241B - Advanced Digital Integrated Circuits.

Instructions for use:

There are 12 total designs in this repository. The SEC DED is in the folder sec_ded, and the DEC is in bch_dec. i

There are six subfolders in each of these two folders containing the source and build files for the encoder and decoder for each algorithm, in 32, 64, and 128 bit varieties. The source files are in src, and the Makefiles and build scripts are in build-rvt. 

To simulate or synthesize each design using the Synopsys tools, go into build-rvt and run make. 
