;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.5.5 #1236 (Apr  6 2006)
; This file generated Tue Jul 18 06:44:16 2006
;--------------------------------------------------------
	.module FIFO_RD_XD
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _FIFO_Read_xdata_PARM_3
	.globl _FIFO_Read_xdata_PARM_2
	.globl _FIFO_Read_xdata

	.globl _USB0DAT
	.globl _USB0ADR
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (DATA)
G$USB0ADR$0$0 == 0x0096
_USB0ADR	=	0x0096
G$USB0DAT$0$0 == 0x0097
_USB0DAT	=	0x0097
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
LFIFO_Read_xdata$n$1$1==.
_FIFO_Read_xdata_PARM_2::
	.ds 1
LFIFO_Read_xdata$ptr$1$1==.
_FIFO_Read_xdata_PARM_3::
	.ds 2
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'FIFO_Read_xdata'
;------------------------------------------------------------
;n                         Allocated with name '_FIFO_Read_xdata_PARM_2'
;ptr                       Allocated with name '_FIFO_Read_xdata_PARM_3'
;fifo_adr                  Allocated to registers r2 
;------------------------------------------------------------
	G$FIFO_Read_xdata$0$0 ==.
	C$FIFO_RD_XD.c$11$0$0 ==.
;C:/working/SDCC_FIFO_RW/C/FIFO_RD_XD.c:11: void FIFO_Read_xdata( BYTE fifo_adr, BYTE n, BYTE xdata * ptr )


_FIFO_Read_xdata:
	mov	r2,dpl
	mov	r4,_FIFO_Read_xdata_PARM_2
	mov	a,r4
	jz	00117$
	mov	dpl,_FIFO_Read_xdata_PARM_3
	mov	dph,(_FIFO_Read_xdata_PARM_3 + 1)
	djnz	r4,00105$
	mov	a,#0x80
	orl	a,r2
	mov	_USB0ADR,a
00101$:
	mov	a,_USB0ADR
	jb	acc.7,00101$
	mov	a,_USB0DAT
	movx	@dptr,a
	ret

00105$:
	mov	a,#0xC0
	orl	a,r2
	mov	_USB0ADR,a
00106$:
	mov	a,_USB0ADR
	jb	acc.7,00106$
	mov	a,_USB0DAT
	movx	@dptr,a
	inc	dptr
	djnz	r4,00106$
00112$:
	mov	a,_USB0ADR
	jb	acc.7,00112$
	mov	_USB0ADR,#0x00
	mov	a,_USB0DAT
	movx	@dptr,a
00117$:
	ret


	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
