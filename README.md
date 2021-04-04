# QR Code Demo
 A demo Linux x86 ELF binary inside a QR code



### How to decode
 The binary is stored as uu-encoded text in the QR Code.  A QRCode reader and uu-decoder are required.
 To decode, scan the QR Code into any QR Code reader that can output plain text.  Then run the text through a uu-decoder and save the result to anywhere.

 Here is the way I decode the QR Code via the Linux CLI (This assumes you have zbar-tools and sharutils installed)

For an image file:
```
zbarimg --raw filename.png | uudecode -o output_name
```
For a printed out image through the webcam:
```
zbarcam --raw | uudecode -o output_name
```

If you want a quick command that immediately runs and discards the executable after running it, here's a 1-line command to do that:
```
zbarcam --raw | uudecode -o X && chmod +x X && ./X && rm X
```

### Build requirements
 - GNU Binary Utilities
 - make
 - NASM
 - qrencode

