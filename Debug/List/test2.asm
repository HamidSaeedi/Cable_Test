
;CodeVisionAVR C Compiler V3.14 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16A
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _port_vlaue=R5
	.DEF _Menue_Main_Num=R4
	.DEF _Menu_Cable_Define_Prof=R7
	.DEF _Menu_Cable_Define_Index_In=R6
	.DEF _Menu_Cable_Define_Index_Out=R9
	.DEF _Menu_Cable_Define_Index_In_Num=R8
	.DEF _Menu_Cable_Define_Index_Out_Num=R11
	.DEF _Read_Pin_B=R12
	.DEF _Read_Pin_B_msb=R13
	.DEF __lcd_x=R10

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _ext_int2_isr
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x20003:
	.DB  0x54,0x65,0x73,0x74,0x20,0x52,0x75,0x6E
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x43,0x61,0x62,0x6C,0x65,0x20,0x53,0x65
	.DB  0x6C,0x65,0x63,0x74,0x0,0x0,0x0,0x0
	.DB  0x43,0x61,0x62,0x6C,0x65,0x20,0x64,0x65
	.DB  0x66,0x69,0x6E,0x65,0x0,0x0,0x0,0x0
	.DB  0x41,0x62,0x6F,0x75,0x74,0x20,0x4D,0x65
_0x20000:
	.DB  0x2D,0x3E,0x25,0x73,0x0,0x2D,0x3E,0x20
	.DB  0x63,0x61,0x62,0x6C,0x65,0x25,0x30,0x32
	.DB  0x64,0x0,0x25,0x30,0x32,0x64,0x2D,0x3E
	.DB  0x25,0x30,0x32,0x64,0x20,0x20,0x20,0x50
	.DB  0x72,0x6F,0x66,0x3D,0x25,0x30,0x32,0x64
	.DB  0x0,0x20,0x5E,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x0,0x20,0x20,0x20,0x20,0x20
	.DB  0x5E,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x0,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x5E,0x0,0x20,0x43
	.DB  0x61,0x62,0x6C,0x65,0x20,0x54,0x65,0x73
	.DB  0x74,0x20,0x56,0x25,0x30,0x32,0x64,0x20
	.DB  0x0,0x20,0x20,0x20,0x20,0x20,0x20,0x4E
	.DB  0x53,0x43,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2060003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x38
	.DW  _Menue_Main_Srting
	.DW  _0x20003*2

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

	.DW  0x02
	.DW  __base_y_G103
	.DW  _0x2060003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;#include "cable.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <mega16a.h>
;#include "Menu_Functions.h"
;#include "button_function.h"
;#include <delay.h>
;
;
;
;//Declare your global variables here
;void write_port(uint8_t);
;uint8_t port_vlaue;
;void Delay(uint32_t);
;void Cable_Check(void);
;void Menu(void);
;uint8_t read_PIN(void);
;
;
;
;
;
;
;
;
;
;
;
;
;interrupt [EXT_INT2] void ext_int2_isr(void)
; 0000 001D {

	.CSEG
_ext_int2_isr:
; .FSTART _ext_int2_isr
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 001E 
; 0000 001F   if(PINB.3==1)
	SBIS 0x16,3
	RJMP _0x3
; 0000 0020   {
; 0000 0021     flags_b.enter=1;
	LDS  R30,_flags_b
	ORI  R30,1
	STS  _flags_b,R30
; 0000 0022   }
; 0000 0023 
; 0000 0024   if(PINB.5==1)
_0x3:
	SBIS 0x16,5
	RJMP _0x4
; 0000 0025   {
; 0000 0026     flags_b.up=1;
	LDS  R30,_flags_b
	ORI  R30,2
	STS  _flags_b,R30
; 0000 0027   }
; 0000 0028   if(PINB.4==1)
_0x4:
	SBIS 0x16,4
	RJMP _0x5
; 0000 0029   {
; 0000 002A     flags_b.down=1;
	LDS  R30,_flags_b
	ORI  R30,4
	STS  _flags_b,R30
; 0000 002B   }
; 0000 002C 
; 0000 002D }
_0x5:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	RETI
; .FEND
;
;
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 0033 {
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0034 // Reinitialize Timer 0 value
; 0000 0035 TCNT0=0x64;
	LDI  R30,LOW(100)
	OUT  0x32,R30
; 0000 0036 // Place your code here
; 0000 0037 switch (page)
	LDS  R30,_page
	LDI  R31,0
; 0000 0038 {
; 0000 0039     case MAIN_PAGE:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x9
; 0000 003A         Menu_Main();
	RCALL _Menu_Main
; 0000 003B         break;
	RJMP _0x8
; 0000 003C     case RUN_TEST_PAGE:
_0x9:
	SBIW R30,0
	BRNE _0xA
; 0000 003D         Menu_Cable_Select();
	RCALL _Menu_Cable_Select
; 0000 003E         break;
	RJMP _0x8
; 0000 003F     case CABLE_SELSECT_PAGE:
_0xA:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0xB
; 0000 0040         Menu_Cable_Define();
	RCALL _Menu_Cable_Define
; 0000 0041         break;
	RJMP _0x8
; 0000 0042     case ABOUT_ME_PAGE:
_0xB:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x8
; 0000 0043         Menu_About_Me();
	RCALL _Menu_About_Me
; 0000 0044         break;
; 0000 0045 }
_0x8:
; 0000 0046 
; 0000 0047 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;
;void main(void)
; 0000 004B 
; 0000 004C {
_main:
; .FSTART _main
; 0000 004D // Declare your local variables here
; 0000 004E 
; 0000 004F In_profile[1][0] = 0x01;
	LDI  R30,LOW(1)
	__PUTB1MN _In_profile,8
; 0000 0050 In_profile[1][1] = 0x02;
	LDI  R30,LOW(2)
	__PUTB1MN _In_profile,9
; 0000 0051 In_profile[1][2] = 0x04;
	LDI  R30,LOW(4)
	__PUTB1MN _In_profile,10
; 0000 0052 In_profile[1][3] = 0x08;
	LDI  R30,LOW(8)
	__PUTB1MN _In_profile,11
; 0000 0053 In_profile[1][4] = 0x10;
	LDI  R30,LOW(16)
	__PUTB1MN _In_profile,12
; 0000 0054 In_profile[1][5] = 0x20;
	LDI  R30,LOW(32)
	__PUTB1MN _In_profile,13
; 0000 0055 In_profile[1][6] = 0x40;
	LDI  R30,LOW(64)
	__PUTB1MN _In_profile,14
; 0000 0056 In_profile[1][7] = 0x80;
	LDI  R30,LOW(128)
	__PUTB1MN _In_profile,15
; 0000 0057 
; 0000 0058 Out_profile[1][0] = 0x01;
	LDI  R30,LOW(1)
	__PUTB1MN _Out_profile,8
; 0000 0059 Out_profile[1][0] = 0x02;
	LDI  R30,LOW(2)
	__PUTB1MN _Out_profile,8
; 0000 005A Out_profile[1][0] = 0x04;
	LDI  R30,LOW(4)
	__PUTB1MN _Out_profile,8
; 0000 005B Out_profile[1][0] = 0x08;
	LDI  R30,LOW(8)
	__PUTB1MN _Out_profile,8
; 0000 005C Out_profile[1][0] = 0x10;
	LDI  R30,LOW(16)
	__PUTB1MN _Out_profile,8
; 0000 005D Out_profile[1][0] = 0x20;
	LDI  R30,LOW(32)
	__PUTB1MN _Out_profile,8
; 0000 005E Out_profile[1][0] = 0x40;
	LDI  R30,LOW(64)
	__PUTB1MN _Out_profile,8
; 0000 005F Out_profile[1][0] = 0x80;
	LDI  R30,LOW(128)
	__PUTB1MN _Out_profile,8
; 0000 0060 
; 0000 0061 
; 0000 0062 
; 0000 0063 
; 0000 0064 
; 0000 0065 
; 0000 0066 
; 0000 0067 //Out_profile[1] = {0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
; 0000 0068 // Input/Output Ports initialization
; 0000 0069 // Port A initialization
; 0000 006A // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 006B DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 006C // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 006D PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 006E 
; 0000 006F // Port B initialization
; 0000 0070 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0071 DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 0072 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0073 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 0074 
; 0000 0075 // Port C initialization
; 0000 0076 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0077 DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 0078 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0079 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 007A 
; 0000 007B // Port D initialization
; 0000 007C // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 007D DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 007E // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 007F PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 0080  // External Interrupt(s) initialization
; 0000 0081 // INT0: Off
; 0000 0082 // INT1: Off
; 0000 0083 // INT2: On
; 0000 0084 // INT2 Mode: Falling Edge
; 0000 0085 GICR|=(0<<INT1) | (0<<INT0) | (1<<INT2);
	IN   R30,0x3B
	ORI  R30,0x20
	OUT  0x3B,R30
; 0000 0086 MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(0)
	OUT  0x35,R30
; 0000 0087 MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 0088 GIFR=(0<<INTF1) | (0<<INTF0) | (1<<INTF2);
	LDI  R30,LOW(32)
	OUT  0x3A,R30
; 0000 0089 
; 0000 008A 
; 0000 008B 
; 0000 008C // Timer/Counter 0 initialization
; 0000 008D // Clock source: System Clock
; 0000 008E // Clock value: 31.250 kHz
; 0000 008F // Mode: Normal top=0xFF
; 0000 0090 // OC0 output: Disconnected
; 0000 0091 // Timer Period: 4.992 ms
; 0000 0092 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (0<<CS00);
	LDI  R30,LOW(4)
	OUT  0x33,R30
; 0000 0093 TCNT0=0x64;
	LDI  R30,LOW(100)
	OUT  0x32,R30
; 0000 0094 OCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x3C,R30
; 0000 0095 
; 0000 0096 
; 0000 0097 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0098 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
	LDI  R30,LOW(1)
	OUT  0x39,R30
; 0000 0099 DDRB.0=1;
	SBI  0x17,0
; 0000 009A lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 009B // Global enable interrupts
; 0000 009C #asm("sei")
	sei
; 0000 009D while (1)
_0xF:
; 0000 009E {
; 0000 009F 
; 0000 00A0 }
	RJMP _0xF
; 0000 00A1 }
_0x12:
	RJMP _0x12
; .FEND
;
;void write_port(uint8_t In_value){
; 0000 00A3 void write_port(uint8_t In_value){
; 0000 00A4 
; 0000 00A5 
; 0000 00A6 PORTC = In_value;
;	In_value -> Y+0
; 0000 00A7 
; 0000 00A8 }
;
;void Delay(uint32_t T){
; 0000 00AA void Delay(uint32_t T){
; 0000 00AB 
; 0000 00AC delay_ms(T);
;	T -> Y+0
; 0000 00AD 
; 0000 00AE }
;
;uint8_t read_PIN(void){
; 0000 00B0 uint8_t read_PIN(void){
; 0000 00B1 
; 0000 00B2 return PIND;
; 0000 00B3 
; 0000 00B4 }
;
;
;
;
;
;
;
;
;#include "Menu_Functions.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include "cable.h"
;char Menue_Main_Srting[4][16]={"Test Run" , "Cable Select" , "Cable define" , "About Me"};

	.DSEG
;char lcd_buffer[16];
;uint8_t Menue_Main_Num=0;
;int8_t Menue_Cable_Select_Num=0;
;uint8_t Menu_Cable_Define_Prof=0;
;uint8_t Menu_Cable_Define_Index_In=0;
;uint8_t Menu_Cable_Define_Index_Out=0;
;uint8_t Menu_Cable_Define_Index_In_Num=0;
;uint8_t Menu_Cable_Define_Index_Out_Num=0;
;struct FLAGS_MENU flags_menu;
;uint8_t page=0;
;int8_t Menu_Main (void)
; 0001 000F {

	.CSEG
_Menu_Main:
; .FSTART _Menu_Main
; 0001 0010 	lcd_gotoxy(0,0);
	CALL SUBOPT_0x0
; 0001 0011 	sprintf(lcd_buffer,"->%s",Menue_Main_Srting[Menue_Main_Num]);
	__POINTW1FN _0x20000,0
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R4
	LDI  R31,0
	CALL SUBOPT_0x1
; 0001 0012 	lcd_puts(lcd_buffer);
; 0001 0013 	lcd_gotoxy(0,1);
	CALL SUBOPT_0x2
; 0001 0014 	sprintf(lcd_buffer,"%s",Menue_Main_Srting[Menue_Main_Num+1]);
	__POINTW1FN _0x20000,2
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R4
	LDI  R31,0
	ADIW R30,1
	CALL SUBOPT_0x1
; 0001 0015 	lcd_puts(lcd_buffer);
; 0001 0016 	memset(lcd_buffer,0,sizeof(lcd_buffer));
	CALL SUBOPT_0x3
; 0001 0017 	if(flag.enter_button==1)
	BRNE _0x20004
; 0001 0018 	{
; 0001 0019 		flag.enter_button=0;
	LDS  R30,_flag
	ANDI R30,0XF7
	STS  _flag,R30
; 0001 001A 		return Menue_Main_Num;
	MOV  R30,R4
	RET
; 0001 001B 	}
; 0001 001C 	return -1;
_0x20004:
	RJMP _0x20C0005
; 0001 001D }
; .FEND
;
;int8_t  Menu_Cable_Select(void)
; 0001 0020 {
_Menu_Cable_Select:
; .FSTART _Menu_Cable_Select
; 0001 0021 	lcd_gotoxy(0,0);
	CALL SUBOPT_0x0
; 0001 0022 	sprintf(lcd_buffer,"-> cable%02d",Menue_Cable_Select_Num);
	__POINTW1FN _0x20000,5
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_Menue_Cable_Select_Num
	CALL __CBD1
	CALL SUBOPT_0x4
; 0001 0023 	lcd_puts(lcd_buffer);
; 0001 0024 	lcd_gotoxy(0,1);
	CALL SUBOPT_0x2
; 0001 0025 	sprintf(lcd_buffer,"cable%02d",Menue_Cable_Select_Num+1);
	__POINTW1FN _0x20000,8
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_Menue_Cable_Select_Num
	LDI  R31,0
	SBRC R30,7
	SER  R31
	ADIW R30,1
	CALL __CWD1
	CALL SUBOPT_0x4
; 0001 0026 	lcd_puts(lcd_buffer);
; 0001 0027 	memset(lcd_buffer,0,sizeof(lcd_buffer));
	CALL SUBOPT_0x3
; 0001 0028 	if(flag.enter_button==1)
	BRNE _0x20005
; 0001 0029 	{
; 0001 002A 		flag.enter_button=0;
	LDS  R30,_flag
	ANDI R30,0XF7
	STS  _flag,R30
; 0001 002B 		return Menue_Cable_Select_Num;
	LDS  R30,_Menue_Cable_Select_Num
	RET
; 0001 002C 	}
; 0001 002D 	return -1;
_0x20005:
_0x20C0005:
	LDI  R30,LOW(255)
	RET
; 0001 002E }
; .FEND
;
;void Menu_Cable_Define(void)
; 0001 0031 {
_Menu_Cable_Define:
; .FSTART _Menu_Cable_Define
; 0001 0032 	lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
; 0001 0033 	In_profile[Menu_Cable_Define_Prof][Menu_Cable_Define_Index_In]=Menu_Cable_Define_Index_In_Num;
	CALL SUBOPT_0x5
	SUBI R30,LOW(-_In_profile)
	SBCI R31,HIGH(-_In_profile)
	MOVW R26,R30
	MOV  R30,R6
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R8
; 0001 0034 	Out_profile[Menu_Cable_Define_Prof][Menu_Cable_Define_Index_Out]=Menu_Cable_Define_Index_Out_Num;
	CALL SUBOPT_0x5
	SUBI R30,LOW(-_Out_profile)
	SBCI R31,HIGH(-_Out_profile)
	MOVW R26,R30
	MOV  R30,R9
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R11
; 0001 0035 	sprintf(lcd_buffer,"%02d->%02d   Prof=%02d",In_profile[Menu_Cable_Define_Prof][Menu_Cable_Define_Index_In],Out_profile[ ...
	CALL SUBOPT_0x6
	__POINTW1FN _0x20000,18
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x5
	SUBI R30,LOW(-_In_profile)
	SBCI R31,HIGH(-_In_profile)
	MOVW R26,R30
	CLR  R30
	ADD  R26,R6
	ADC  R27,R30
	CALL SUBOPT_0x7
	CALL SUBOPT_0x5
	SUBI R30,LOW(-_Out_profile)
	SBCI R31,HIGH(-_Out_profile)
	MOVW R26,R30
	CLR  R30
	ADD  R26,R9
	ADC  R27,R30
	CALL SUBOPT_0x7
	MOV  R30,R7
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,12
	CALL _sprintf
	ADIW R28,16
; 0001 0036 	lcd_puts(lcd_buffer);
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	CALL _lcd_puts
; 0001 0037 	memset(lcd_buffer,0,sizeof(lcd_buffer));
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
; 0001 0038 	lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
; 0001 0039 	switch (flags_menu.subpage)
	LDS  R30,_flags_menu
	LDI  R31,0
	ANDI R30,LOW(0x7)
	ANDI R31,HIGH(0x7)
	SBRS R30,2
	RJMP _0x20009
	ORI  R30,LOW(0xFFF8)
	ORI  R31,HIGH(0xFFF8)
_0x20009:
; 0001 003A 	{
; 0001 003B 	case IN_SELECT:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2000A
; 0001 003C 		sprintf(lcd_buffer," ^               ");
	CALL SUBOPT_0x6
	__POINTW1FN _0x20000,41
	CALL SUBOPT_0x9
; 0001 003D 		break;
	RJMP _0x20008
; 0001 003E 	case OUT_SELECT:
_0x2000A:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x2000B
; 0001 003F 		lcd_gotoxy(0,1);
	CALL SUBOPT_0x2
; 0001 0040 		sprintf(lcd_buffer,"     ^           ");
	__POINTW1FN _0x20000,59
	CALL SUBOPT_0x9
; 0001 0041 	    break;
	RJMP _0x20008
; 0001 0042 	case PROF_SELECT:
_0x2000B:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x2000D
; 0001 0043 		sprintf(lcd_buffer,"               ^");
	CALL SUBOPT_0x6
	__POINTW1FN _0x20000,77
	CALL SUBOPT_0x9
; 0001 0044 		break;
; 0001 0045 	default:
_0x2000D:
; 0001 0046 		break;
; 0001 0047 	}
_0x20008:
; 0001 0048 	lcd_puts(lcd_buffer);
	RJMP _0x20C0004
; 0001 0049 
; 0001 004A 
; 0001 004B 	memset(lcd_buffer,0,sizeof(lcd_buffer));
; 0001 004C }
; .FEND
;
;void Menu_About_Me(void)
; 0001 004F {
_Menu_About_Me:
; .FSTART _Menu_About_Me
; 0001 0050 	lcd_gotoxy(0,0);
	CALL SUBOPT_0x0
; 0001 0051 	sprintf(lcd_buffer," Cable Test V%02d ",Version);
	__POINTW1FN _0x20000,94
	ST   -Y,R31
	ST   -Y,R30
	__GETD1N 0x1
	CALL SUBOPT_0x4
; 0001 0052 	lcd_puts(lcd_buffer);
; 0001 0053 	lcd_gotoxy(0,1);
	CALL SUBOPT_0x2
; 0001 0054 	sprintf(lcd_buffer,"      NSC      ");
	__POINTW1FN _0x20000,113
	CALL SUBOPT_0x9
; 0001 0055 	lcd_puts(lcd_buffer);
_0x20C0004:
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	CALL _lcd_puts
; 0001 0056 	memset(lcd_buffer,0,sizeof(lcd_buffer));
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
; 0001 0057 }
	RET
; .FEND
;
;#include "cable.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;uint8_t Input[MAX_CABLE_PINS];
;uint8_t Output[MAX_CABLE_PINS];
;
;uint8_t In_profile[MAX_NUMBER_PROFILE][MAX_CABLE_PINS];
;uint8_t Out_profile[MAX_NUMBER_PROFILE][MAX_CABLE_PINS];
;struct FUNC_HANDLE cable_func_handle;
;struct FLAG flag;
;uint8_t Cable_ID=0;
;uint8_t Error_Cable[8];
;char Error_Symbol[8];
;
;uint8_t (*Read_Pin)(void) = NULL;
;void (*Port_Set)(uint8_t) = NULL;
;void (*sleep_ms)(uint32_t) = NULL;
;uint8_t (*profile_lcd_menu)(void) = NULL;
;
;
;struct FUNC_HANDLE Profile_ID(void)
; 0002 0015 {

	.CSEG
; 0002 0016     uint8_t Cable_ID;
; 0002 0017     Cable_ID=(*profile_lcd_menu)();
;	Cable_ID -> R17
; 0002 0018     if(Cable_ID>MAX_NUMBER_PROFILE)
; 0002 0019     {
; 0002 001A         cable_func_handle.e_state=1;
; 0002 001B         cable_func_handle.e_code=5;
; 0002 001C         return cable_func_handle;
; 0002 001D     }
; 0002 001E     cable_func_handle.e_state=0;
; 0002 001F     cable_func_handle.func_return_val=Cable_ID;
; 0002 0020     return cable_func_handle;
; 0002 0021 
; 0002 0022 }
;
;void Cable_Check(void)
; 0002 0025 {
; 0002 0026     uint8_t i=0,j=0;
; 0002 0027     memcpy(Input,In_profile[Cable_ID],sizeof(In_profile[Cable_ID]));
;	i -> R17
;	j -> R16
; 0002 0028     memcpy(Output,Out_profile[Cable_ID],sizeof(Out_profile[Cable_ID]));
; 0002 0029     for(i=0;i<sizeof(Output);i++)
; 0002 002A     {
; 0002 002B         (*Port_Set)(Output[i]);
; 0002 002C         for(j=0;j<sizeof(Input);j++)
; 0002 002D         {
; 0002 002E             //(*sleep_ms)(1);
; 0002 002F             if((*Read_Pin)()==Input[j])
; 0002 0030             {
; 0002 0031                 if(i!=j)
; 0002 0032                 {
; 0002 0033                     Error_Cable[i]=2+i;
; 0002 0034                     flag.connect=1;
; 0002 0035                 }
; 0002 0036                 else if(i==j)
; 0002 0037                 {
; 0002 0038                     flag.connect=1;
; 0002 0039                     Error_Cable[i]=0;
; 0002 003A                 }
; 0002 003B 
; 0002 003C             }
; 0002 003D             if((*Read_Pin)()>Input[j])
; 0002 003E             {
; 0002 003F                flag.connect=1;
; 0002 0040                Error_Cable[i]=3+i;
; 0002 0041             }
; 0002 0042         }
; 0002 0043         if(flag.connect==1)
; 0002 0044         {
; 0002 0045             flag.connect=0;
; 0002 0046         }
; 0002 0047         else if(flag.connect==0)
; 0002 0048         {
; 0002 0049              Error_Cable[i]=1;
; 0002 004A              flag.notconnect=1;
; 0002 004B         }
; 0002 004C     }
; 0002 004D 
; 0002 004E }
;
;struct FUNC_HANDLE Cable_Error_Check(void)
; 0002 0051 {
; 0002 0052     uint8_t i=0;
; 0002 0053     for(i=0;i<MAX_CABLE_PINS;i++)
;	i -> R17
; 0002 0054     {
; 0002 0055         if(Error_Cable[i]==i+3)
; 0002 0056         {
; 0002 0057             Error_Symbol[i]='C';
; 0002 0058         }
; 0002 0059         else if(Error_Cable[i]==i+2)
; 0002 005A         {
; 0002 005B              Error_Symbol[i]= 'W';
; 0002 005C         }
; 0002 005D         else if(Error_Cable[i]==0)
; 0002 005E         {
; 0002 005F              Error_Symbol[i]= 'G';
; 0002 0060         }
; 0002 0061         else if(Error_Cable[i]==1)
; 0002 0062         {
; 0002 0063              Error_Symbol[i]= 'N';
; 0002 0064         }
; 0002 0065     }
; 0002 0066     for(i=0;i<MAX_CABLE_PINS;i++)
; 0002 0067     {
; 0002 0068         if(Error_Symbol[i]!='G')
; 0002 0069         {
; 0002 006A             flag.test_result=0;
; 0002 006B             cable_func_handle.e_state=1;
; 0002 006C             cable_func_handle.e_code=6;
; 0002 006D             cable_func_handle.func_return_val=0;
; 0002 006E             return cable_func_handle;
; 0002 006F         }
; 0002 0070     }
; 0002 0071     cable_func_handle.e_state=0;
; 0002 0072     cable_func_handle.func_return_val=0;
; 0002 0073     cable_func_handle.e_code=0;
; 0002 0074     return cable_func_handle;
; 0002 0075 }
;
;
;
;
;
;
;
;
;#include "button_function.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;
;struct FLAGS_B flags_b;
;
;uint8_t (*Read_Pin_B)(uint8_t,uint8_t)=NULL;
;
;
;
;void main_menu_button_manager_func(void)
; 0003 000B {

	.CSEG
; 0003 000C     if(ENTER_BUTTON_PUSHED==1)
; 0003 000D     {
; 0003 000E         flags_b.enter=0;
; 0003 000F         switch (Menue_Cable_Select_Num)
; 0003 0010         {
; 0003 0011         case RUN_TEST_PAGE:
; 0003 0012             page=RUN_TEST_PAGE;
; 0003 0013             break;
; 0003 0014         case CABLE_SELSECT_PAGE:
; 0003 0015             page=CABLE_SELSECT_PAGE;
; 0003 0016             break;
; 0003 0017         case CABLE_DEFINE_PAGE:
; 0003 0018             page=CABLE_DEFINE_PAGE;
; 0003 0019             break;
; 0003 001A         case ABOUT_ME_PAGE:
; 0003 001B             page=ABOUT_ME_PAGE;
; 0003 001C             break;
; 0003 001D         default:
; 0003 001E             break;
; 0003 001F         }
; 0003 0020     }
; 0003 0021     else if(UP_BUTTON_PUSHED==1)
; 0003 0022     {
; 0003 0023         flags_b.up=0;
; 0003 0024         Menue_Cable_Select_Num++;
; 0003 0025         if(Menue_Cable_Select_Num>=(MAX_MAIN_MENU_ITEM-1))
; 0003 0026             Menue_Cable_Select_Num=0;
; 0003 0027     }
; 0003 0028     else if(DOWN_BUTTON_PUSHED==1)
; 0003 0029     {
; 0003 002A         flags_b.down=0;
; 0003 002B         Menue_Cable_Select_Num--;
; 0003 002C         if(Menue_Cable_Select_Num<0)
; 0003 002D             Menue_Cable_Select_Num=(MAX_MAIN_MENU_ITEM-1);
; 0003 002E     }
; 0003 002F 
; 0003 0030 }
;
;void cable_select_button_manager_func(void)
; 0003 0033 {
; 0003 0034     if(ENTER_BUTTON_PUSHED==1)
; 0003 0035     {
; 0003 0036         flags_b.enter=0;
; 0003 0037         page=MAIN_PAGE;
; 0003 0038     }
; 0003 0039     else if(UP_BUTTON_PUSHED==1)
; 0003 003A     {
; 0003 003B         flags_b.up=0;
; 0003 003C         Menue_Cable_Select_Num++;
; 0003 003D         if(Menue_Cable_Select_Num>MAX_NUMBER_PROFILE)
; 0003 003E            Menue_Cable_Select_Num=0;
; 0003 003F     }
; 0003 0040     else if(DOWN_BUTTON_PUSHED==1)
; 0003 0041     {
; 0003 0042         flags_b.down=0;
; 0003 0043         Menue_Cable_Select_Num--;
; 0003 0044         if(Menue_Cable_Select_Num<0)
; 0003 0045             Menue_Cable_Select_Num=MAX_NUMBER_PROFILE;
; 0003 0046     }
; 0003 0047 }
;
;void cable_define_button_manager_func(void)
; 0003 004A {
; 0003 004B     if(ENTER_BUTTON_PUSHED==1)
; 0003 004C     {
; 0003 004D         flags_b.enter=0;
; 0003 004E         if (flags_menu.subpage==IN_SELECT)
; 0003 004F         {
; 0003 0050            flags_menu.subpage=OUT_SELECT;
; 0003 0051         }
; 0003 0052         else if (flags_menu.subpage==OUT_SELECT)
; 0003 0053         {
; 0003 0054             flags_menu.subpage=PROF_SELECT;
; 0003 0055         }
; 0003 0056         else if(flags_menu.subpage==PROF_SELECT)
; 0003 0057         {
; 0003 0058             flags_menu.subpage=IN_SELECT;
; 0003 0059         }
; 0003 005A 
; 0003 005B     }
; 0003 005C     else if(UP_BUTTON_PUSHED==1)
; 0003 005D     {
; 0003 005E         flags_b.up=0;
; 0003 005F         Menue_Cable_Select_Num++;
; 0003 0060         if(Menue_Cable_Select_Num>MAX_NUMBER_PROFILE)
; 0003 0061            Menue_Cable_Select_Num=0;
; 0003 0062     }
; 0003 0063     else if(DOWN_BUTTON_PUSHED==1)
; 0003 0064     {
; 0003 0065         flags_b.down=0;
; 0003 0066         Menue_Cable_Select_Num--;
; 0003 0067         if(Menue_Cable_Select_Num<0)
; 0003 0068             Menue_Cable_Select_Num=MAX_NUMBER_PROFILE;
; 0003 0069     }
; 0003 006A     else if(EXIT_BUTTON_PUSHED==1)
; 0003 006B     {
; 0003 006C          flags_b.up=0;
; 0003 006D           flags_b.down=0;
; 0003 006E           page=MAIN_PAGE;
; 0003 006F     }
; 0003 0070 }
;
;void about_me_button_manager_func(void)
; 0003 0073 {
; 0003 0074     if(ENTER_BUTTON_PUSHED==1)
; 0003 0075     {
; 0003 0076          flags_b.enter=0;
; 0003 0077         page=MAIN_PAGE;
; 0003 0078     }
; 0003 0079     else if(UP_BUTTON_PUSHED==1)
; 0003 007A     {
; 0003 007B          flags_b.up=0;
; 0003 007C         page=MAIN_PAGE;
; 0003 007D     }
; 0003 007E     else if(DOWN_BUTTON_PUSHED==1)
; 0003 007F     {
; 0003 0080          flags_b.down=0;
; 0003 0081         page=MAIN_PAGE;
; 0003 0082     }
; 0003 0083 
; 0003 0084 
; 0003 0085 }
;
;
;/*
;int8_t button_read(struct BUTTON_PORTS_PINS port)
;{
;    if((*Read_Pin_B)(port.b1_port,port.b1_pin)==PUSHED)
;    {
;         flags_b.enter=1;
;    }
;    if((*Read_Pin_B)(port.b2_port,port.b2_pin)==PUSHED)
;    {
;         flags_b.up=1;
;    }
;    if((*Read_Pin_B)(port.b3_port,port.b3_pin)==PUSHED)
;    {
;         flags_b.down=1;
;    }
;
;}
;*/
;
;
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_buff_G100:
; .FSTART _put_buff_G100
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2000010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2000012
	__CPWRN 16,17,2
	BRLO _0x2000013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2000012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2000013:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2000014
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2000014:
	RJMP _0x2000015
_0x2000010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2000015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20C0002
; .FEND
__print_G100:
; .FSTART __print_G100
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	CALL SUBOPT_0xA
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	CALL SUBOPT_0xA
	RJMP _0x20000CC
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R20,LOW(43)
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R20,LOW(32)
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x200001B
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x200002F
	CALL SUBOPT_0xB
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0xC
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	CALL SUBOPT_0xB
	CALL SUBOPT_0xD
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	CALL SUBOPT_0xB
	CALL SUBOPT_0xD
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x64)
	BREQ _0x2000039
	CPI  R30,LOW(0x69)
	BRNE _0x200003A
_0x2000039:
	ORI  R16,LOW(4)
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x75)
	BRNE _0x200003C
_0x200003B:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x58)
	BRNE _0x200003F
	ORI  R16,LOW(8)
	RJMP _0x2000040
_0x200003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2000071
_0x2000040:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x200003D:
	SBRS R16,2
	RJMP _0x2000042
	CALL SUBOPT_0xB
	CALL SUBOPT_0xE
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000043:
	CPI  R20,0
	BREQ _0x2000044
	SUBI R17,-LOW(1)
	RJMP _0x2000045
_0x2000044:
	ANDI R16,LOW(251)
_0x2000045:
	RJMP _0x2000046
_0x2000042:
	CALL SUBOPT_0xB
	CALL SUBOPT_0xE
_0x2000046:
_0x2000036:
	SBRC R16,0
	RJMP _0x2000047
_0x2000048:
	CP   R17,R21
	BRSH _0x200004A
	SBRS R16,7
	RJMP _0x200004B
	SBRS R16,2
	RJMP _0x200004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x200004D
_0x200004C:
	LDI  R18,LOW(48)
_0x200004D:
	RJMP _0x200004E
_0x200004B:
	LDI  R18,LOW(32)
_0x200004E:
	CALL SUBOPT_0xA
	SUBI R21,LOW(1)
	RJMP _0x2000048
_0x200004A:
_0x2000047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x200004F
_0x2000050:
	CPI  R19,0
	BREQ _0x2000052
	SBRS R16,3
	RJMP _0x2000053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2000054
_0x2000053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000054:
	CALL SUBOPT_0xA
	CPI  R21,0
	BREQ _0x2000055
	SUBI R21,LOW(1)
_0x2000055:
	SUBI R19,LOW(1)
	RJMP _0x2000050
_0x2000052:
	RJMP _0x2000056
_0x200004F:
_0x2000058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x200005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x200005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x200005A
_0x200005C:
	CPI  R18,58
	BRLO _0x200005D
	SBRS R16,3
	RJMP _0x200005E
	SUBI R18,-LOW(7)
	RJMP _0x200005F
_0x200005E:
	SUBI R18,-LOW(39)
_0x200005F:
_0x200005D:
	SBRC R16,4
	RJMP _0x2000061
	CPI  R18,49
	BRSH _0x2000063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000062
_0x2000063:
	RJMP _0x20000CD
_0x2000062:
	CP   R21,R19
	BRLO _0x2000067
	SBRS R16,0
	RJMP _0x2000068
_0x2000067:
	RJMP _0x2000066
_0x2000068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000069
	LDI  R18,LOW(48)
_0x20000CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0xC
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	CALL SUBOPT_0xA
	CPI  R21,0
	BREQ _0x200006C
	SUBI R21,LOW(1)
_0x200006C:
_0x2000066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2000059
	RJMP _0x2000058
_0x2000059:
_0x2000056:
	SBRS R16,0
	RJMP _0x200006D
_0x200006E:
	CPI  R21,0
	BREQ _0x2000070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0xC
	RJMP _0x200006E
_0x2000070:
_0x200006D:
_0x2000071:
_0x2000030:
_0x20000CC:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0xF
	SBIW R30,0
	BRNE _0x2000072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0003
_0x2000072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0xF
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G100)
	LDI  R31,HIGH(_put_buff_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x20C0003:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND

	.CSEG

	.DSEG

	.CSEG

	.CSEG
_memset:
; .FSTART _memset
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
_0x20C0002:
	ADIW R28,5
	RET
; .FEND
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G103:
; .FSTART __lcd_write_nibble_G103
	ST   -Y,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 13
	SBI  0x1B,2
	__DELAY_USB 13
	CBI  0x1B,2
	__DELAY_USB 13
	RJMP _0x20C0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G103
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G103
	__DELAY_USB 133
	RJMP _0x20C0001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G103)
	SBCI R31,HIGH(-__base_y_G103)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R10,Y+1
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x10
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x10
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	MOV  R10,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2060005
	LDS  R30,__lcd_maxx
	CP   R10,R30
	BRLO _0x2060004
_0x2060005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2060007
	RJMP _0x20C0001
_0x2060007:
_0x2060004:
	INC  R10
	SBI  0x1B,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x20C0001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2060008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x206000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2060008
_0x206000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G103,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G103,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x11
	CALL SUBOPT_0x11
	CALL SUBOPT_0x11
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G103
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20C0001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_In_profile:
	.BYTE 0x60
_Out_profile:
	.BYTE 0x60
_cable_func_handle:
	.BYTE 0x2
_flag:
	.BYTE 0x2
_Cable_ID:
	.BYTE 0x1
_Error_Cable:
	.BYTE 0x8
_Error_Symbol:
	.BYTE 0x8
_Input:
	.BYTE 0x8
_Output:
	.BYTE 0x8
_profile_lcd_menu:
	.BYTE 0x2
_Port_Set:
	.BYTE 0x2
_Read_Pin:
	.BYTE 0x2
_Menue_Cable_Select_Num:
	.BYTE 0x1
_flags_menu:
	.BYTE 0x1
_page:
	.BYTE 0x1
_flags_b:
	.BYTE 0x1
_Menue_Main_Srting:
	.BYTE 0x40
_lcd_buffer:
	.BYTE 0x10
__seed_G101:
	.BYTE 0x4
__base_y_G103:
	.BYTE 0x4
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
	LDI  R30,LOW(_lcd_buffer)
	LDI  R31,HIGH(_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1:
	CALL __LSLW4
	SUBI R30,LOW(-_Menue_Main_Srting)
	SBCI R31,HIGH(-_Menue_Main_Srting)
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
	LDI  R30,LOW(_lcd_buffer)
	LDI  R31,HIGH(_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3:
	LDI  R30,LOW(_lcd_buffer)
	LDI  R31,HIGH(_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	CALL _memset
	LDS  R30,_flag
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x4:
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	MOV  R30,R7
	LDI  R31,0
	CALL __LSLW3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(_lcd_buffer)
	LDI  R31,HIGH(_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	JMP  _memset

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x9:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xA:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xB:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xD:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xE:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x11:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G103
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__CBD1:
	MOV  R31,R30
	ADD  R31,R31
	SBC  R31,R31
	MOV  R22,R31
	MOV  R23,R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
