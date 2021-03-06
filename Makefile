
# MCU name
MCU = -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -march=armv7e-m -mtune=cortex-m4 -mfloat-abi=softfp -mlittle-endian -mthumb-interwork

# Output format. (can be srec, ihex, binary)
FORMAT = ihex

# Target file name (without extension).
TARGET = stm32f4_motion_player


# List C source files here. (C dependencies are automatically generated.)
SRC = main.c stm32f4xx_it.c fat.c sd.c dojpeg.c mpool.c lcd.c icon.c pcf_font.c mjpeg.c aac.c mp3.c sound.c fft.c fx.c xpt2046.c settings.c xmodem.c usart.c delay.c

BINARY = music_underbar_320x80.bin music_underbar_320x80_alpha.bin \
music_art_default_74x74.bin \
seek_circle_16x16.bin seek_circle_16x16_alpha.bin \
abort_icon_40x40.bin play_icon_40x40_alpha.bin \
next_right_32x17.bin next_right_32x17_alpha.bin next_left_32x17.bin next_left_32x17_alpha.bin exit_play_20x13.bin exit_play_20x13_alpha.bin \
menubar_320x22.bin menubar_320x22_alpha.bin \
pic_left_arrow_30x30.bin pic_left_arrow_30x30_alpha.bin pic_right_arrow_30x30.bin pic_right_arrow_30x30_alpha.bin \
bass_base_24x18.bin bass_base_24x18_alpha.bin \
bass_level1_24x18.bin bass_level1_24x18_alpha.bin \
bass_level2_24x18.bin bass_level2_24x18_alpha.bin \
bass_level3_24x18.bin bass_level3_24x18_alpha.bin \
reverb_base_24x18.bin  reverb_base_24x18_alpha.bin \
reverb_level1_24x18.bin  reverb_level1_24x18_alpha.bin \
reverb_level2_24x18.bin  reverb_level2_24x18_alpha.bin \
reverb_level3_24x18.bin  reverb_level3_24x18_alpha.bin \
vocal_base_24x18.bin vocal_base_24x18_alpha.bin \
vocal_canceled_24x18.bin vocal_canceled_24x18_alpha.bin \
radiobutton_checked_22x22.bin radiobutton_unchecked_22x22.bin radiobutton_22x22_alpha.bin \
card_22x22.bin card_22x22_alpha.bin \
cpu_22x22.bin cpu_22x22_alpha.bin \
display_22x22.bin display_22x22_alpha.bin \
debug_22x22.bin debug_22x22_alpha.bin \
info_22x22.bin info_22x22_alpha.bin \
parent_arrow_22x22.bin parent_arrow_22x22_alpha.bin \
select_22x22.bin select_22x22_alpha.bin


ASRC =

# Optimization level, can be [0, 1, 2, 3, s]. 
# 0 = turn off optimization. s = optimize for size.
OPT = s

# Debugging format.
DEBUG = #stabs

# List any extra directories to look for include files here.
#     Each directory must be seperated by a space.
EXTRAINCDIRS = lib/CMSIS/Include lib/STM32F4xx_StdPeriph_Driver/inc lib/CMSIS/ST/STM32F4xx/Include /usr/local/arm/arm-none-eabi/include ./jpeg-7 ./aac ./mp3


# Compiler flag to set the C Standard level.
# c89   - "ANSI" C
# gnu89 - c89 plus GCC extensions
# c99   - ISO C99 standard (not yet fully implemented)
# gnu99 - c99 plus GCC extensions
CSTANDARD =

# Place -D or -U options here
CDEFS = -DBUILD=0x`date '+%Y%m%d'` -DARM -DARM_MATH_CM4 -D__FPU_PRESENT

# Place -I options here
CINCS =


# Compiler flags.
#  -g*:          generate debugging information
#  -O*:          optimization level
#  -f...:        tuning, see GCC manual
#  -Wall...:     warning level
#  -Wa,...:      tell GCC to pass this to the assembler.
#    -adhlns...: create assembler listing
CFLAGS = -g$(DEBUG)
CFLAGS += $(CDEFS) $(CINCS)
CFLAGS += -O$(OPT)
#CFLAGS += -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums
CFLAGS += -fno-strict-aliasing#-Wall -Wstrict-prototypes
#CFLAGS += -Wa,-adhlns=$(<:.c=.lst)
CFLAGS += $(patsubst %,-I%,$(EXTRAINCDIRS))
CFLAGS += $(CSTANDARD)


STARTUP = lib/CMSIS/ST/STM32F4xx/Source/Templates/startup_stm32f4xx.o


# Assembler flags.
#  -Wa,...:   tell GCC to pass this to the assembler.
#  -ahlms:    create listing
#  -gstabs:   have the assembler create line number information
#ASFLAGS = -Wa,-adhlns=$(<:.S=.lst),-gstabs 
ASFLAGS = -Wa,-gstabs



#Additional libraries.

# Minimalistic printf version
PRINTF_LIB_MIN = -Wl,-u,vfprintf -lprintf_min

# Floating point printf version (requires MATH_LIB = -lm below)
PRINTF_LIB_FLOAT = -Wl,-u,vfprintf -lprintf_flt

PRINTF_LIB = 

# Minimalistic scanf version
SCANF_LIB_MIN = -Wl,-u,vfscanf -lscanf_min

# Floating point + %[ scanf version (requires MATH_LIB = -lm below)
SCANF_LIB_FLOAT = -Wl,-u,vfscanf -lscanf_flt

SCANF_LIB = 

MATH_LIB = #-lm

# Linker flags.
#  -Wl,...:     tell GCC to pass this to linker.
#    -Map:      create map file
#    --cref:    add cross reference to  map file
LDFLAGS = -T stm32_flash.ld
#LDFLAGS += -Wl,-Map=$(TARGET).map,--cref
LDFLAGS += $(PRINTF_LIB) $(SCANF_LIB) $(MATH_LIB) $(GCC_LIB) $(patsubst %,-L%,$(DIRLIB)) -lcm4 -lstd -ldsp -lc -ljpeg -laac -lmp3

# ---------------------------------------------------------------------------

# Define directories, if needed.
DIRINC = .
#DIRLIB = ./lib/STM32F4xx_StdPeriph_Driver ./lib/CMSIS/ST/STM32F4xx ./lib/CMSIS/DSP_Lib/Source /usr/local/arm/arm-none-eabi/lib/thumb2 /usr/local/arm/lib/gcc/arm-none-eabi/4.4.1/thumb2 ./jpeg-7 ./aac ./mp3
DIRLIB = ./lib/STM32F4xx_StdPeriph_Driver ./lib/CMSIS/ST/STM32F4xx ./lib/CMSIS/DSP_Lib/Source /usr/local/arm/arm-none-eabi/lib/thumb/cortex-m4 /usr/local/arm/lib/gcc/arm-none-eabi/4.6.2/thumb/cortex-m4 ./jpeg-7 ./aac ./mp3
#DIRLIB = ./lib/STM32F4xx_StdPeriph_Driver ./lib/CMSIS/ST/STM32F4xx ./lib/CMSIS/DSP_Lib/Source /usr/local/arm/arm-none-eabi/lib/thumb/cortex-m4/float-abi-hard/fpuv4-sp-d16 /usr/local/arm/lib/gcc/arm-none-eabi/4.6.2/thumb/cortex-m4/float-abi-hard/fpuv4-sp-d16 ./jpeg-7 ./aac ./mp3

# Define programs and commands.
SHELL = sh
CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy
OBJDUMP = arm-none-eabi-objdump
SIZE = arm-none-eabi-size
NM = arm-none-eabi-nm
REMOVE = rm -f
COPY = cp
YACC = bison
LEX = flex

# Define all object files.
OBJ = $(SRC:.c=.o) $(ASRC:.s=.o) $(BINARY:.bin=.o)

# Define all listing files.
LST = $(ASRC:.s=.lst) $(SRC:.c=.lst)

# Compiler flags to generate dependency files.
#GENDEPFLAGS = -Wp,-M,-MP,-MT,$(*F).o,-MF,.dep/$(@F).d


# Combine all necessary flags and optional flags.
# Add target processor to flags.
ALL_CFLAGS = $(MCU) -I. $(CFLAGS) $(GENDEPFLAGS)
ALL_ASFLAGS = $(MCU) -I. -x assembler-with-cpp $(ASFLAGS)



# Default target.
all: gccversion build sizeafter

build: cm4lib stdlib elf hex lss sym

elf: $(TARGET).elf
hex: $(TARGET).hex
lss: $(TARGET).lss 
sym: $(TARGET).sym


cm4lib:
	$(MAKE) -C ./lib/CMSIS/ST/STM32F4xx

stdlib:	lib
	$(MAKE) -C ./lib/STM32F4xx_StdPeriph_Driver

dsplib:
	$(MAKE) -C ./lib/CMSIS/DSP_Lib/Source

mp3:	
	$(MAKE) -C ./mp3	

jpeg:	
	$(MAKE) -C ./jpeg-7
		

# Display size of file.
HEXSIZE = $(SIZE) --target=$(FORMAT) $(TARGET).hex
ELFSIZE = $(SIZE) -A -x $(TARGET).elf
sizebefore:
	@if [ -f $(TARGET).elf ]; then echo; echo $(MSG_SIZE_BEFORE); $(ELFSIZE); echo; fi

sizeafter:
	@if [ -f $(TARGET).elf ]; then echo; echo $(MSG_SIZE_AFTER); $(ELFSIZE); echo; fi



# Display compiler version information.
gccversion : 
	$(CC) --version


# Create final output files (.hex, .eep) from ELF output file.
%.hex: %.elf
	$(OBJCOPY) -O $(FORMAT) $< $@


# Create extended listing file from ELF output file.
%.lss: %.elf
	$(OBJDUMP) -h -D $< > $@

# Create a symbol table from ELF output file.
%.sym: %.elf
	$(NM) -n $< > $@



# Link: create ELF output file from object files.
.SECONDARY : $(TARGET).elf
.PRECIOUS : $(OBJ)
%.elf : $(OBJ)
	$(LD) $(STARTUP) $(OBJ) -o $@ $(LDFLAGS) 


# Compile: create object files from C source files.
%.o : %.c
	@echo
	@echo $(MSG_COMPILING) $<
	$(CC) -c $(ALL_CFLAGS) $< -o $@ 


# Compile: create assembler files from C source files.
%.s : %.c
	$(CC) -S $(ALL_CFLAGS) $< -o $@


# Assemble: create object files from assembler source files.
%.o : %.S
	@echo
	@echo $(MSG_ASSEMBLING) $<
	$(CC) -c $(ALL_ASFLAGS) $< -o $@

%.o : %.bin
	$(OBJCOPY) -I binary -O elf32-littlearm -B armv5 --rename-section .data=.rodata,alloc,load,readonly,data,contents $< $@

distclean: clean
	$(MAKE) -C lib clean


# Target: clean project.
clean:
	$(REMOVE) $(TARGET).hex
	$(REMOVE) $(TARGET).elf
	$(REMOVE) $(TARGET).map
	$(REMOVE) $(TARGET).obj
	$(REMOVE) $(TARGET).a90
	$(REMOVE) $(TARGET).sym
	$(REMOVE) $(TARGET).lnk
	$(REMOVE) $(TARGET).lss
	$(REMOVE) $(OBJ)
	$(REMOVE) $(LST)
	$(REMOVE) $(SRC:.c=.s)
	$(REMOVE) $(SRC:.c=.d)
	$(REMOVE) .dep/*


# Include the dependency files.
#-include $(shell mkdir .dep 2>/dev/null) $(wildcard .dep/*)


# Listing of phony targets.
.PHONY : all sizebefore sizeafter gccversion \
build elf hex eep lss sym \
clean clean_list program

