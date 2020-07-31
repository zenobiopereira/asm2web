ASM_FILES=$(shell find . -name "*.asm")
OBJECT_FILES=$(ASM_FILES:%.asm=%.o)

NASM_OPTS =-f elf64 -F dwarf -g
LD_OPTS =-m elf_x86_64

all: helloworld

%.o: %.asm
	@echo "Assembling file $< -> $@"
	@nasm $(NASM_OPTS) -o $@ $<

clean:
	@echo "Cleaning object files and executable helloworld"
	@rm -rf *.o helloworld

link: $(OBJECT_FILES)
	@echo "Linking Objects $(OBJECT_FILES)"
	@ld $(LD_OPTS) -o helloworld $(OBJECT_FILES)

helloworld: link
	@echo "DONE"

.PHONY: clean
