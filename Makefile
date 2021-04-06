bin/qr_binary.png : temp_bin
	uuencode bin/qr_binary bin/qr_binary | qrencode -o bin/qr_binary.png -t PNG -s 7 -8 --verbose
	rm temp_bin

temp_bin : qr_binary.s
	nasm qr_binary.s -o bin/qr_binary -f bin -I src/
	chmod +x bin/qr_binary
	wc -c bin/qr_binary
	cp bin/qr_binary temp_bin

