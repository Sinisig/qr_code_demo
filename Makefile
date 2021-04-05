output.png : bin/qr_binary
	uuencode bin/qr_binary bin/qr_binary | qrencode -o output.png -s 7 -8 --verbose

bin/qr_binary : src/qr_code.s
	nasm src/qr_code.s -o bin/qr_binary -f bin
	chmod +x bin/qr_binary
	wc -c bin/qr_binary

