#==- MACROS -==#

# Directories and names
OUT_NAME	?= qr_binary

OUT_DIR	:= bin
INT_DIR	:= $(OUT_DIR)/int

SRC_DIR	:= src
INC_DIR	:= $(SRC_DIR)/includes

# Build flags
ASFLAGS	:= -f elf64 -I $(INC_DIR)
LDFLAGS	:= -Os -s -nodefaultlibs --gc-sections -m elf_x86_64 -e _entry
QEFLAGS	:= -t PNG -s 7 -8 --verbose

# Build commands
AS	= nasm $(ASFLAGS) -o $@ $<
LD	= ld $(LDFLAGS) -o $@ $^
QE	= uuencode $< $< | qrencode $(QEFLAGS) -o $@


#==- BUILDING -==#

# Binary to QR Code
$(OUT_DIR)/$(OUT_NAME).png : $(OUT_DIR)/$(OUT_NAME)
	$(QE)

# Linking
$(OUT_DIR)/$(OUT_NAME) : $(INT_DIR)/init.o $(INT_DIR)/main.o $(INT_DIR)/print.o
	$(LD)
	chmod +x $@
	wc -c $@

# Assembling
$(INT_DIR)/init.o : $(SRC_DIR)/init.s
	$(AS)

$(INT_DIR)/main.o : $(SRC_DIR)/main.s
	$(AS)

$(INT_DIR)/print.o : $(SRC_DIR)/print.s
	$(AS)


#==- TOOLS -==#

# Clean/reset the output directory
clean :
	rm -r $(OUT_DIR)
	mkdir $(OUT_DIR) $(INT_DIR)
