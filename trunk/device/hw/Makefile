#-----------------------------------------------------------------------------
# Makefile for usb_jtag FX2 firmware
#-----------------------------------------------------------------------------
# Copyright 2007 Kolja Waschk, ixo.de
# Copyright (C) 2017 Alexandru Gagniuc <mr.nuke.me@gmail.com>
#-----------------------------------------------------------------------------
# This code is part of usbjtag. usbjtag is free software; you can redistribute
# it and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version. usbjtag is distributed in the hope
# that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.  You should have received a
# copy of the GNU General Public License along with this program in the file
# COPYING; if not, write to the Free Software Foundation, Inc., 51 Franklin
# St, Fifth Floor, Boston, MA  02110-1301  USA
#-----------------------------------------------------------------------------

LIBDIR=fx2
LIB=libfx2.lib

SHELL := /bin/bash

# Specify a list of targets to build. Each target requires a hw_$target.c file
# to be present, and will produce a usbjtag-$target.hex output file.
TARGETS=basic dj_usb saxo_l xpcu_i xpcu_x nexys opsis

HEX_OUTPUTS=$(TARGETS:%=usbjtag-%.hex)

# Some distros add a prefix to sdcc binaries. For example, in fedora the
# binary is 'sdcc-sdcc'. Allow specifying this prefix via SDCC_PREFIX.
# Usage example: $ make SDCC_PREFIX=sdcc-
SDCC_PREFIX ?=

CC = $(SDCC_PREFIX)sdcc
AS = $(SDCC_PREFIX)asx8051
AR = $(SDCC_PREFIX)sdcclib
PACKIHX=$(SDCC_PREFIX)packihx

CFLAGS+=-mmcs51 --no-xinit-opt -I${LIBDIR}

ASFLAGS+=-plosgff

LDFLAGS=--code-loc 0x0000 --code-size 0x1800
LDFLAGS+=--xram-loc 0x1800 --xram-size 0x0800
LDFLAGS+=-Wl '-b USBDESCSEG = 0xE100'
LDFLAGS+=-L ${LIBDIR}

%.rel : %.a51
	$(AS) $(ASFLAGS) $<

%.rel : %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

default: $(HEX_OUTPUTS)

dscr_%.a51: dscr.a51.in
	set H="hw_$*~~~~~~~~~"; cat $^ | \
	 sed \
          -e"s/\$$H0/$${H:0:1}/" \
          -e"s/\$$H1/$${H:1:1}/" \
          -e"s/\$$H2/$${H:2:1}/" \
          -e"s/\$$H3/$${H:3:1}/" \
          -e"s/\$$H4/$${H:4:1}/" \
          -e"s/\$$H5/$${H:5:1}/" \
          -e"s/\$$H6/$${H:6:1}/" \
          -e"s/\$$H7/$${H:7:1}/" \
          -e"s/\$$H8/$${H:8:1}/" \
          -e"s/\$$H9/$${H:9:1}/" | \
	 sed \
	  -e"s/        .db        '~, 0//" \
	 > $@

#%.iic : %.hex
#	./hex2bix -ir -f 0xC2 -m 0xF000 -c 0x1 -o $@ $<
%.bix: %.hex
	objcopy -I ihex -O binary $< $@

temp-%.hex: vectors.rel usbjtag.rel dscr_%.rel eeprom.rel hw_%.rel startup.rel ${LIBDIR}/${LIB}
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $+

usbjtag-%.hex: temp-%.hex
	$(PACKIHX) $^ > $@
	ls -al $@

${LIBDIR}/${LIB}:
	make -C ${LIBDIR} CC=$(CC) AR=$(AR)

.PHONY: boot
boot: std.hex
	-test -e /dev/usb_jtag    && /sbin/fxload -D /dev/usb_jtag    -I std.hex -t fx2
	-test -e /dev/tracii_xl2  && /sbin/fxload -D /dev/tracii_xl2  -I std.hex -t fx2
	-test -e /dev/xilinx_xpcu && /sbin/fxload -D /dev/xilinx_xpcu -I std.hex -t fx2

REF=/home/kawk/work/xilinx/xtern/xusbdfwu/xusbdfwu-1025.hex

.PHONY: ref
ref: 
	-test -e /dev/usb_jtag    && /sbin/fxload -D /dev/usb_jtag    -I ${REF} -t fx2
	-test -e /dev/tracii_xl2  && /sbin/fxload -D /dev/tracii_xl2  -I ${REF} -t fx2
	-test -e /dev/xilinx_xpcu && /sbin/fxload -D /dev/xilinx_xpcu -I ${REF} -t fx2

dscr_%.rel: dscr_%.a51
eeprom.rel: eeprom.c eeprom.h
usbjtag.rel: usbjtag.c hardware.h eeprom.h
hw_%.rel: hw_%.c hardware.h

.PHONY: clean distclean

clean:
	make -C ${LIBDIR} clean
	del /f *.lst *.asm *.lib *.sym *.rel *.mem *.map *.rst *.lnk *.lk *.hex dscr_%.a51

distclean: clean



