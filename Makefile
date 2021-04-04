output.png : bin/qr_binary
	uuencode bin/qr_binary bin/qr_binary | qrencode -o output.png -s 7 -8 --verbose

bin/qr_binary : bin/init.o bin/main.o bin/print.o
	ld bin/init.o bin/main.o bin/print.o -o bin/qr_binary -Nns -m elf_i386 -e _entry -static --no-export-dynamic -nostdlib
	wc -c bin/qr_binary

bin/init.o : src/init.s
	nasm src/init.s -o bin/init.o -f elf -I src/includes/

bin/main.o : src/main.s
	nasm src/main.s -o bin/main.o -f elf -I src/includes/

bin/print.o : src/print.s
	nasm src/print.s -o bin/print.o -f elf -I src/includes/
