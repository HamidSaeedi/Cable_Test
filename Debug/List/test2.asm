
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
	.DEF __lcd_x=R5
	.DEF __lcd_y=R4
	.DEF __lcd_maxx=R7

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

_0x3:
	.DB  LOW(_Menu_Cable_Select),HIGH(_Menu_Cable_Select)
_0x4:
	.DB  LOW(_write_port),HIGH(_write_port)
_0x5:
	.DB  LOW(___read_PIN__),HIGH(___read_PIN__)
_0x6:
	.DB  LOW(_Delay),HIGH(_Delay)
_0x20003:
	.DB  0x54,0x65,0x73,0x74,0x20,0x52,0x75,0x6E
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x43,0x61,0x62
	.DB  0x6C,0x65,0x20,0x53,0x65,0x6C,0x65,0x63
	.DB  0x74,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x41,0x62,0x6F,0x75,0x74,0x20
	.DB  0x4D,0x65
_0x20004:
	.DB  0x20,0x20,0x0,0x2D,0x3E
_0x20005:
	.DB  0x4
_0x20000:
	.DB  0x25,0x73,0x25,0x73,0x0,0x25,0x73,0x43
	.DB  0x61,0x62,0x6C,0x65,0x25,0x30,0x32,0x64
	.DB  0x0,0x2D,0x2D,0x3E,0x20,0x25,0x73,0x0
	.DB  0x20,0x63,0x61,0x62,0x6C,0x65,0x25,0x30
	.DB  0x32,0x64,0x20,0x50,0x41,0x53,0x53,0x21
	.DB  0x20,0x20,0x20,0x0,0x63,0x61,0x62,0x6C
	.DB  0x65,0x25,0x30,0x32,0x64,0x20,0x46,0x61
	.DB  0x69,0x6C,0x65,0x64,0x21,0x0,0x25,0x30
	.DB  0x32,0x64,0x2D,0x3E,0x25,0x30,0x32,0x64
	.DB  0x20,0x20,0x20,0x50,0x72,0x6F,0x66,0x3D
	.DB  0x25,0x30,0x32,0x64,0x0,0x20,0x5E,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x0,0x20
	.DB  0x20,0x20,0x20,0x20,0x5E,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x0,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x5E,0x0,0x20,0x43,0x61,0x62,0x6C,0x65
	.DB  0x20,0x54,0x65,0x73,0x74,0x20,0x56,0x25
	.DB  0x30,0x32,0x64,0x20,0x0,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x4E,0x53,0x43,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2060003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  _profile_lcd_menu
	.DW  _0x3*2

	.DW  0x02
	.DW  _Port_Set
	.DW  _0x4*2

	.DW  0x02
	.DW  _Read_Pin
	.DW  _0x5*2

	.DW  0x32
	.DW  _Menue_Main_Srting
	.DW  _0x20003*2

	.DW  0x05
	.DW  _Menue_Main_Arrow_String
	.DW  _0x20004*2

	.DW  0x01
	.DW  _page
	.DW  _0x20005*2

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
;void Delay(uint32_t);
;void Cable_Check(void);
;uint8_t __read_PIN__(void);
; int8_t (*profile_lcd_menu)() = &Menu_Cable_Select;

	.DSEG
; void (*Port_Set)(uint8_t ) = write_port;
; uint8_t (*Read_Pin)() = __read_PIN__;
; void (*sleep_ms)(uint32_t) = Delay;
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
; 0000 001E {

	.CSEG
_ext_int2_isr:
; .FSTART _ext_int2_isr
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 001F 
; 0000 0020   if(PINB.3==0)
	SBIC 0x16,3
	RJMP _0x7
; 0000 0021   {
; 0000 0022     flags_b.enter=1;
	LDS  R30,_flags_b
	ORI  R30,1
	STS  _flags_b,R30
; 0000 0023   }
; 0000 0024 
; 0000 0025   if(PINB.5==0)
_0x7:
	SBIC 0x16,5
	RJMP _0x8
; 0000 0026   {
; 0000 0027     flags_b.up=1;
	LDS  R30,_flags_b
	ORI  R30,2
	STS  _flags_b,R30
; 0000 0028   }
; 0000 0029   if(PINB.4==0)
_0x8:
	SBIC 0x16,4
	RJMP _0x9
; 0000 002A   {
; 0000 002B     flags_b.down=1;
	LDS  R30,_flags_b
	ORI  R30,4
	STS  _flags_b,R30
; 0000 002C   }
; 0000 002D 
; 0000 002E }
_0x9:
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
; 0000 0034 {
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
; 0000 0035 // Reinitialize Timer 0 value
; 0000 0036 TCNT0=0x64;
	LDI  R30,LOW(100)
	OUT  0x32,R30
; 0000 0037 // Place your code here
; 0000 0038 switch (page)
	LDS  R30,_page
	LDI  R31,0
; 0000 0039 {
; 0000 003A     case MAIN_PAGE:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xD
; 0000 003B         Menu_Main();
	RCALL _Menu_Main
; 0000 003C         main_menu_button_manager_func();
	CALL _main_menu_button_manager_func
; 0000 003D         break;
	RJMP _0xC
; 0000 003E     case RUN_TEST_PAGE:
_0xD:
	SBIW R30,0
	BRNE _0xE
; 0000 003F         Menu_Run_Test();
	RCALL _Menu_Run_Test
; 0000 0040         run_test_button_manager_func();
	CALL _run_test_button_manager_func
; 0000 0041         break;
	RJMP _0xC
; 0000 0042     case CABLE_SELSECT_PAGE:
_0xE:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0xF
; 0000 0043         Menu_Cable_Select();
	RCALL _Menu_Cable_Select
; 0000 0044         cable_select_button_manager_func();
	CALL _cable_select_button_manager_func
; 0000 0045         break;
	RJMP _0xC
; 0000 0046      case CABLE_DEFINE_PAGE:
_0xF:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x10
; 0000 0047         Menu_Cable_Define();
	RCALL _Menu_Cable_Define
; 0000 0048         cable_define_button_manager_func();
	CALL _cable_define_button_manager_func
; 0000 0049         break;
	RJMP _0xC
; 0000 004A     case ABOUT_ME_PAGE:
_0x10:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0xC
; 0000 004B         Menu_About_Me();
	RCALL _Menu_About_Me
; 0000 004C         about_me_button_manager_func();
	CALL _about_me_button_manager_func
; 0000 004D         break;
; 0000 004E }
_0xC:
; 0000 004F 
; 0000 0050 }
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
; 0000 0054 {
_main:
; .FSTART _main
; 0000 0055 // Declare your local variables here
; 0000 0056 
; 0000 0057 
; 0000 0058 In_profile[0][0] = 0x01;
	LDI  R30,LOW(1)
	STS  _In_profile,R30
; 0000 0059 In_profile[0][1] = 0x02;
	LDI  R30,LOW(2)
	__PUTB1MN _In_profile,1
; 0000 005A In_profile[0][2] = 0x04;
	LDI  R30,LOW(4)
	__PUTB1MN _In_profile,2
; 0000 005B In_profile[0][3] = 0x08;
	LDI  R30,LOW(8)
	__PUTB1MN _In_profile,3
; 0000 005C In_profile[0][4] = 0x10;
	LDI  R30,LOW(16)
	__PUTB1MN _In_profile,4
; 0000 005D In_profile[0][5] = 0x20;
	LDI  R30,LOW(32)
	__PUTB1MN _In_profile,5
; 0000 005E In_profile[0][6] = 0x40;
	LDI  R30,LOW(64)
	__PUTB1MN _In_profile,6
; 0000 005F In_profile[0][7] = 0x80;
	LDI  R30,LOW(128)
	__PUTB1MN _In_profile,7
; 0000 0060 
; 0000 0061 Out_profile[0][0] = 0x01;
	LDI  R30,LOW(1)
	STS  _Out_profile,R30
; 0000 0062 Out_profile[0][1] = 0x02;
	LDI  R30,LOW(2)
	__PUTB1MN _Out_profile,1
; 0000 0063 Out_profile[0][2] = 0x04;
	LDI  R30,LOW(4)
	__PUTB1MN _Out_profile,2
; 0000 0064 Out_profile[0][3] = 0x08;
	LDI  R30,LOW(8)
	__PUTB1MN _Out_profile,3
; 0000 0065 Out_profile[0][4] = 0x10;
	LDI  R30,LOW(16)
	__PUTB1MN _Out_profile,4
; 0000 0066 Out_profile[0][5] = 0x20;
	LDI  R30,LOW(32)
	__PUTB1MN _Out_profile,5
; 0000 0067 Out_profile[0][6] = 0x40;
	LDI  R30,LOW(64)
	__PUTB1MN _Out_profile,6
; 0000 0068 Out_profile[0][7] = 0x80;
	LDI  R30,LOW(128)
	__PUTB1MN _Out_profile,7
; 0000 0069 
; 0000 006A 
; 0000 006B 
; 0000 006C 
; 0000 006D 
; 0000 006E //Out_profile[1] = {0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
; 0000 006F // Input/Output Ports initialization
; 0000 0070 // Port A initialization
; 0000 0071 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0072 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 0073 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0074 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 0075 
; 0000 0076 // Port B initialization
; 0000 0077 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0078 DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 0079 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 007A PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 007B 
; 0000 007C // Port C initialization
; 0000 007D // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 007E DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 007F // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0080 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0081 
; 0000 0082 // Port D initialization
; 0000 0083 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0084 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 0085 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0086 PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 0087  // External Interrupt(s) initialization
; 0000 0088 // INT0: Off
; 0000 0089 // INT1: Off
; 0000 008A // INT2: On
; 0000 008B // INT2 Mode: Falling Edge
; 0000 008C GICR|=(0<<INT1) | (0<<INT0) | (1<<INT2);
	IN   R30,0x3B
	ORI  R30,0x20
	OUT  0x3B,R30
; 0000 008D MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(0)
	OUT  0x35,R30
; 0000 008E MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 008F GIFR=(0<<INTF1) | (0<<INTF0) | (1<<INTF2);
	LDI  R30,LOW(32)
	OUT  0x3A,R30
; 0000 0090 
; 0000 0091 
; 0000 0092 
; 0000 0093 // Timer/Counter 0 initialization
; 0000 0094 // Clock source: System Clock
; 0000 0095 // Clock value: 31.250 kHz
; 0000 0096 // Mode: Normal top=0xFF
; 0000 0097 // OC0 output: Disconnected
; 0000 0098 // Timer Period: 4.992 ms
; 0000 0099 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (0<<CS00);
	LDI  R30,LOW(4)
	OUT  0x33,R30
; 0000 009A TCNT0=0x64;
	LDI  R30,LOW(100)
	OUT  0x32,R30
; 0000 009B OCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x3C,R30
; 0000 009C 
; 0000 009D 
; 0000 009E // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 009F TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
	LDI  R30,LOW(1)
	OUT  0x39,R30
; 0000 00A0 DDRB.0=1;
	SBI  0x17,0
; 0000 00A1 lcd_init(20);
	LDI  R26,LOW(20)
	CALL _lcd_init
; 0000 00A2 // Global enable interrupts
; 0000 00A3 #asm("sei")
	sei
; 0000 00A4 while (1)
_0x14:
; 0000 00A5 {
; 0000 00A6 
; 0000 00A7 }
	RJMP _0x14
; 0000 00A8 }
_0x17:
	RJMP _0x17
; .FEND
;
;void write_port(uint8_t In_value){
; 0000 00AA void write_port(uint8_t In_value){
_write_port:
; .FSTART _write_port
; 0000 00AB 
; 0000 00AC 
; 0000 00AD PORTC = In_value;
	ST   -Y,R26
;	In_value -> Y+0
	LD   R30,Y
	OUT  0x15,R30
; 0000 00AE 
; 0000 00AF }
	ADIW R28,1
	RET
; .FEND
;
;void Delay(uint32_t T){
; 0000 00B1 void Delay(uint32_t T){
_Delay:
; .FSTART _Delay
; 0000 00B2 
; 0000 00B3 delay_ms(T);
	CALL __PUTPARD2
;	T -> Y+0
	LD   R26,Y
	LDD  R27,Y+1
	CALL _delay_ms
; 0000 00B4 
; 0000 00B5 }
	RJMP _0x20C0009
; .FEND
;
;uint8_t __read_PIN__(void){
; 0000 00B7 uint8_t __read_PIN__(void){
___read_PIN__:
; .FSTART ___read_PIN__
; 0000 00B8 
; 0000 00B9 return PIND;
	IN   R30,0x10
	RET
; 0000 00BA 
; 0000 00BB }
; .FEND
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
;//char Menue_Main_Srting[4][NUM_COLUMN+1]={"Test Run" , "Cable Select" , "Cable define" , "About Me"};
;char Menue_Main_Srting[4][NUM_COLUMN+1]={"Test Run" , "Cable Select"  , "About Me"};

	.DSEG
;char Menue_Main_Arrow_String[2][3]={"  ","->"};
;char lcd_buffer[NUM_COLUMN];
;int8_t Menue_Main_Num=0;
;int8_t Menue_Main_Select_Num=0; //0 .. NUM_ROW
;
;int8_t Menue_Cable_Select_Num=0;
;int8_t Menue_Cable_Select_Select_Num=0;  //0 .. NUM_ROW
;
;uint8_t Menu_Cable_Define_Prof=0;
;uint8_t Menu_Cable_Define_Index_In=0;
;uint8_t Menu_Cable_Define_Index_Out=0;
;uint8_t Menu_Cable_Define_Index_In_Num=0;
;uint8_t Menu_Cable_Define_Index_Out_Num=0;
;struct FLAGS_MENU flags_menu;
;uint8_t page=MAIN_PAGE;
;
;void Menu_Main (void)
; 0001 0016 {

	.CSEG
_Menu_Main:
; .FSTART _Menu_Main
; 0001 0017 	int byteWrite=0;
; 0001 0018 	uint8_t i=0; //just a simple loop counter.
; 0001 0019 	for(i=0;(i<NUM_ROW) && (i<MAX_MAIN_MENU_ITEM);i++)
	CALL SUBOPT_0x0
;	byteWrite -> R16,R17
;	i -> R19
_0x20007:
	CPI  R19,4
	BRSH _0x20009
	CPI  R19,3
	BRLO _0x2000A
_0x20009:
	RJMP _0x20008
_0x2000A:
; 0001 001A 	{
; 0001 001B 		lcd_gotoxy(0,i);
	CALL SUBOPT_0x1
; 0001 001C 		memset(lcd_buffer,' ',sizeof(lcd_buffer));
; 0001 001D 
; 0001 001E 		byteWrite=snprintf(lcd_buffer, sizeof(lcd_buffer), "%s%s",Menue_Main_Arrow_String[(i==Menue_Main_Select_Num)] ,Menue_M ...
	__POINTW1FN _0x20000,0
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R19
	CLR  R27
	LDS  R30,_Menue_Main_Select_Num
	CALL SUBOPT_0x2
	LDS  R26,_Menue_Main_Num
	CALL SUBOPT_0x3
	LDI  R26,LOW(21)
	LDI  R27,HIGH(21)
	CALL __MULW12U
	SUBI R30,LOW(-_Menue_Main_Srting)
	SBCI R31,HIGH(-_Menue_Main_Srting)
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x4
; 0001 001F 		/*We just fill the remainnig part of the lcd_buffer with null to insure clean update
; 0001 0020 		we did not use the lcd_clear becuse it cuse blinking in the lcd.
; 0001 0021 		*/
; 0001 0022 		// Fill remaining space with spaces
; 0001 0023         if(byteWrite < NUM_COLUMN && byteWrite >= 0)
	BRGE _0x2000C
	TST  R17
	BRPL _0x2000D
_0x2000C:
	RJMP _0x2000B
_0x2000D:
; 0001 0024 		{
; 0001 0025            memset(lcd_buffer + byteWrite, ' ', NUM_COLUMN - byteWrite);
	CALL SUBOPT_0x5
; 0001 0026         }
; 0001 0027 
; 0001 0028         // Ensure null termination at LCD width
; 0001 0029         lcd_buffer[NUM_COLUMN] = '\0';
_0x2000B:
	CALL SUBOPT_0x6
; 0001 002A 	    lcd_puts(lcd_buffer);
; 0001 002B 	}
	SUBI R19,-1
	RJMP _0x20007
_0x20008:
; 0001 002C 
; 0001 002D }
	RJMP _0x20C0008
; .FEND
;
;int8_t  Menu_Cable_Select(void)
; 0001 0030 {
_Menu_Cable_Select:
; .FSTART _Menu_Cable_Select
; 0001 0031 	int byteWrite=0;
; 0001 0032 	uint8_t i=0; //just a simple loop counter.
; 0001 0033 	for(i=0;i<NUM_ROW;i++)
	CALL SUBOPT_0x0
;	byteWrite -> R16,R17
;	i -> R19
_0x2000F:
	CPI  R19,4
	BRSH _0x20010
; 0001 0034 	{
; 0001 0035 		lcd_gotoxy(0,i);
	CALL SUBOPT_0x1
; 0001 0036 		memset(lcd_buffer,' ',sizeof(lcd_buffer));
; 0001 0037 
; 0001 0038 		byteWrite=snprintf(lcd_buffer, sizeof(lcd_buffer), "%sCable%02d",Menue_Main_Arrow_String[(i==Menue_Cable_Select_Select ...
	__POINTW1FN _0x20000,5
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R19
	CLR  R27
	LDS  R30,_Menue_Cable_Select_Select_Num
	CALL SUBOPT_0x2
	LDS  R26,_Menue_Cable_Select_Num
	CALL SUBOPT_0x3
	CALL __CWD1
	CALL SUBOPT_0x4
; 0001 0039 		/*We just fill the remainnig part of the lcd_buffer with null to insure clean update
; 0001 003A 		we did not use the lcd_clear becuse it cuse blinking in the lcd.
; 0001 003B 		*/
; 0001 003C 		// Fill remaining space with spaces
; 0001 003D         if(byteWrite < NUM_COLUMN && byteWrite >= 0)
	BRGE _0x20012
	TST  R17
	BRPL _0x20013
_0x20012:
	RJMP _0x20011
_0x20013:
; 0001 003E 		{
; 0001 003F            memset(lcd_buffer + byteWrite, ' ', NUM_COLUMN - byteWrite);
	CALL SUBOPT_0x5
; 0001 0040         }
; 0001 0041 
; 0001 0042         // Ensure null termination at LCD width
; 0001 0043         lcd_buffer[NUM_COLUMN] = '\0';
_0x20011:
	CALL SUBOPT_0x6
; 0001 0044 	    lcd_puts(lcd_buffer);
; 0001 0045 	}
	SUBI R19,-1
	RJMP _0x2000F
_0x20010:
; 0001 0046 	/*
; 0001 0047 	lcd_gotoxy(0,0);
; 0001 0048 	sprintf(lcd_buffer,"-> cable%02d     ",Menue_Cable_Select_Num);
; 0001 0049 	lcd_puts(lcd_buffer);
; 0001 004A 	lcd_gotoxy(0,1);
; 0001 004B 	sprintf(lcd_buffer,"   cable%02d    ",Menue_Cable_Select_Num+1);
; 0001 004C 	lcd_puts(lcd_buffer);
; 0001 004D 	memset(lcd_buffer,0,sizeof(lcd_buffer));
; 0001 004E 	*/
; 0001 004F 	if(flag.enter_button==1)
	LDS  R30,_flag
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0x20014
; 0001 0050 	{
; 0001 0051 		flag.enter_button=0;
	LDS  R30,_flag
	ANDI R30,0XF7
	STS  _flag,R30
; 0001 0052 		cable_func_handle.cable_id=Menue_Cable_Select_Num+Menue_Cable_Select_Select_Num;
	LDS  R30,_Menue_Cable_Select_Select_Num
	LDS  R26,_Menue_Cable_Select_Num
	ADD  R30,R26
	__PUTB1MN _cable_func_handle,17
; 0001 0053 		return Menue_Cable_Select_Num+Menue_Cable_Select_Select_Num;
	LDS  R30,_Menue_Cable_Select_Select_Num
	ADD  R30,R26
	RJMP _0x20C0008
; 0001 0054 	}
; 0001 0055 	return -1;
_0x20014:
	LDI  R30,LOW(255)
_0x20C0008:
	CALL __LOADLOCR4
_0x20C0009:
	ADIW R28,4
	RET
; 0001 0056 }
; .FEND
;
;int8_t Menu_Run_Test(void)
; 0001 0059 {
_Menu_Run_Test:
; .FSTART _Menu_Run_Test
; 0001 005A 	//Profile_ID();
; 0001 005B 	if( cable_func_handle.error_other==MAXPROFILELIMIT)
	__GETB2MN _cable_func_handle,8
	CPI  R26,LOW(0x9)
	BREQ _0x20C0007
; 0001 005C 	{
; 0001 005D 		//print the error in here!
; 0001 005E 		return 0;
; 0001 005F 	}
; 0001 0060 	else
; 0001 0061 	{
; 0001 0062 	Cable_Check();
	RCALL _Cable_Check
; 0001 0063 	Cable_Error_Check();
	RCALL _Cable_Error_Check
; 0001 0064 	lcd_gotoxy(0,0);
	CALL SUBOPT_0x7
; 0001 0065 	memset(lcd_buffer,' ',sizeof(lcd_buffer));
	CALL SUBOPT_0x8
	CALL SUBOPT_0x9
; 0001 0066 	sprintf(lcd_buffer,"--> %s",cable_func_handle.error_symbol);
	__POINTW1FN _0x20000,17
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1MN _cable_func_handle,9
	CLR  R22
	CLR  R23
	CALL SUBOPT_0xA
; 0001 0067 	lcd_puts(lcd_buffer);
; 0001 0068 	if(cable_func_handle.pass_pins==MAX_CABLE_PINS)
	__GETB2MN _cable_func_handle,18
	CPI  R26,LOW(0x8)
	BRNE _0x20017
; 0001 0069 	{
; 0001 006A 		lcd_gotoxy(0,1);
	CALL SUBOPT_0xB
; 0001 006B 		memset(lcd_buffer,' ',sizeof(lcd_buffer));
	CALL SUBOPT_0x9
; 0001 006C 		sprintf(lcd_buffer," cable%02d PASS!   ", Menue_Cable_Select_Num+Menue_Cable_Select_Select_Num);
	__POINTW1FN _0x20000,24
	RJMP _0x20021
; 0001 006D 		lcd_puts(lcd_buffer);
; 0001 006E 		cable_func_handle.pass_pins=0;
; 0001 006F 	}
; 0001 0070 	else
_0x20017:
; 0001 0071 	{
; 0001 0072 		lcd_gotoxy(0,1);
	CALL SUBOPT_0xB
; 0001 0073 		memset(lcd_buffer,' ',sizeof(lcd_buffer));
	CALL SUBOPT_0x9
; 0001 0074 		sprintf(lcd_buffer,"cable%02d Failed!", Menue_Cable_Select_Num+Menue_Cable_Select_Select_Num);
	__POINTW1FN _0x20000,44
_0x20021:
	ST   -Y,R31
	ST   -Y,R30
	LDS  R26,_Menue_Cable_Select_Num
	LDI  R27,0
	SBRC R26,7
	SER  R27
	LDS  R30,_Menue_Cable_Select_Select_Num
	LDI  R31,0
	SBRC R30,7
	SER  R31
	ADD  R30,R26
	ADC  R31,R27
	CALL __CWD1
	CALL SUBOPT_0xA
; 0001 0075 		lcd_puts(lcd_buffer);
; 0001 0076 		cable_func_handle.pass_pins=0;
	LDI  R30,LOW(0)
	__PUTB1MN _cable_func_handle,18
; 0001 0077 	}
; 0001 0078 	return 0;
_0x20C0007:
	LDI  R30,LOW(0)
	RET
; 0001 0079 	}
; 0001 007A }
	RET
; .FEND
;
;
;
;
;void Menu_Cable_Define(void)
; 0001 0080 {
_Menu_Cable_Define:
; .FSTART _Menu_Cable_Define
; 0001 0081 	lcd_gotoxy(0,0);
	CALL SUBOPT_0x7
; 0001 0082 	In_profile[Menu_Cable_Define_Prof][Menu_Cable_Define_Index_In]=Menu_Cable_Define_Index_In_Num;
	CALL SUBOPT_0xC
	CALL SUBOPT_0xD
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_Menu_Cable_Define_Index_In_Num
	STD  Z+0,R26
; 0001 0083 	Out_profile[Menu_Cable_Define_Prof][Menu_Cable_Define_Index_Out]=Menu_Cable_Define_Index_Out_Num;
	CALL SUBOPT_0xC
	CALL SUBOPT_0xE
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_Menu_Cable_Define_Index_Out_Num
	STD  Z+0,R26
; 0001 0084 	sprintf(lcd_buffer,"%02d->%02d   Prof=%02d",In_profile[Menu_Cable_Define_Prof][Menu_Cable_Define_Index_In],Out_profile[ ...
	CALL SUBOPT_0x8
	__POINTW1FN _0x20000,62
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xC
	CALL SUBOPT_0xD
	CALL SUBOPT_0xF
	CALL SUBOPT_0xC
	CALL SUBOPT_0xE
	CALL SUBOPT_0xF
	LDS  R30,_Menu_Cable_Define_Prof
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,12
	CALL _sprintf
	ADIW R28,16
; 0001 0085 	lcd_puts(lcd_buffer);
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	CALL _lcd_puts
; 0001 0086 	memset(lcd_buffer,0,sizeof(lcd_buffer));
	CALL SUBOPT_0x8
	CALL SUBOPT_0x10
; 0001 0087 	lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
; 0001 0088 	switch (flags_menu.subpage)
	LDS  R30,_flags_menu
	LDI  R31,0
	ANDI R30,LOW(0x7)
	ANDI R31,HIGH(0x7)
	SBRS R30,2
	RJMP _0x2001C
	ORI  R30,LOW(0xFFF8)
	ORI  R31,HIGH(0xFFF8)
_0x2001C:
; 0001 0089 	{
; 0001 008A 	case IN_SELECT:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2001D
; 0001 008B 		sprintf(lcd_buffer," ^               ");
	CALL SUBOPT_0x8
	__POINTW1FN _0x20000,85
	CALL SUBOPT_0x11
; 0001 008C 		break;
	RJMP _0x2001B
; 0001 008D 	case OUT_SELECT:
_0x2001D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x2001E
; 0001 008E 		lcd_gotoxy(0,1);
	CALL SUBOPT_0xB
; 0001 008F 		sprintf(lcd_buffer,"     ^           ");
	__POINTW1FN _0x20000,103
	CALL SUBOPT_0x11
; 0001 0090 	    break;
	RJMP _0x2001B
; 0001 0091 	case PROF_SELECT:
_0x2001E:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x20020
; 0001 0092 		sprintf(lcd_buffer,"               ^");
	CALL SUBOPT_0x8
	__POINTW1FN _0x20000,121
	CALL SUBOPT_0x11
; 0001 0093 		break;
; 0001 0094 	default:
_0x20020:
; 0001 0095 		break;
; 0001 0096 	}
_0x2001B:
; 0001 0097 	lcd_puts(lcd_buffer);
	RJMP _0x20C0006
; 0001 0098 
; 0001 0099 
; 0001 009A 	memset(lcd_buffer,0,sizeof(lcd_buffer));
; 0001 009B }
; .FEND
;
;void Menu_About_Me(void)
; 0001 009E {
_Menu_About_Me:
; .FSTART _Menu_About_Me
; 0001 009F 	lcd_gotoxy(0,0);
	CALL SUBOPT_0x7
; 0001 00A0 	sprintf(lcd_buffer," Cable Test V%02d ",Version);
	CALL SUBOPT_0x8
	__POINTW1FN _0x20000,138
	ST   -Y,R31
	ST   -Y,R30
	__GETD1N 0x1
	CALL SUBOPT_0xA
; 0001 00A1 	lcd_puts(lcd_buffer);
; 0001 00A2 	lcd_gotoxy(0,1);
	CALL SUBOPT_0xB
; 0001 00A3 	sprintf(lcd_buffer,"      NSC      ");
	__POINTW1FN _0x20000,157
	CALL SUBOPT_0x11
; 0001 00A4 	lcd_puts(lcd_buffer);
_0x20C0006:
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	CALL _lcd_puts
; 0001 00A5 	memset(lcd_buffer,0,sizeof(lcd_buffer));
	CALL SUBOPT_0x8
	CALL SUBOPT_0x10
; 0001 00A6 }
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
;
;
;
;/*
;uint8_t (*Read_Pin)(void) = NULL;
;void (*Port_Set)(uint8_t) = NULL;
;void (*sleep_ms)(uint32_t) = NULL;
;int8_t (*profile_lcd_menu)(void) = NULL;
;*/
;
;struct FUNC_HANDLE Profile_ID(void)
; 0002 0015 {

	.CSEG
; 0002 0016     uint8_t Cable_ID=0;
; 0002 0017     Cable_ID=(*profile_lcd_menu)();
;	Cable_ID -> R17
; 0002 0018     if(Cable_ID>MAX_NUMBER_PROFILE)
; 0002 0019     {
; 0002 001A         cable_func_handle.error_other=MAXPROFILELIMIT;
; 0002 001B         return cable_func_handle;
; 0002 001C     }
; 0002 001D     cable_func_handle.cable_id=Cable_ID;
; 0002 001E     return cable_func_handle;
; 0002 001F 
; 0002 0020 }
;
;void Cable_Check(void)
; 0002 0023 {
_Cable_Check:
; .FSTART _Cable_Check
; 0002 0024     uint8_t i=0,j=0;
; 0002 0025     memcpy(Input,In_profile[cable_func_handle.cable_id],MAX_CABLE_PINS);
	ST   -Y,R17
	ST   -Y,R16
;	i -> R17
;	j -> R16
	LDI  R17,0
	LDI  R16,0
	LDI  R30,LOW(_Input)
	LDI  R31,HIGH(_Input)
	CALL SUBOPT_0x12
	SUBI R30,LOW(-_In_profile)
	SBCI R31,HIGH(-_In_profile)
	CALL SUBOPT_0x13
; 0002 0026     memcpy(Output,Out_profile[cable_func_handle.cable_id],MAX_CABLE_PINS);
	LDI  R30,LOW(_Output)
	LDI  R31,HIGH(_Output)
	CALL SUBOPT_0x12
	SUBI R30,LOW(-_Out_profile)
	SBCI R31,HIGH(-_Out_profile)
	CALL SUBOPT_0x13
; 0002 0027     for(i=0;i<sizeof(Output);i++)
	LDI  R17,LOW(0)
_0x40005:
	CPI  R17,8
	BRLO PC+2
	RJMP _0x40006
; 0002 0028     {
; 0002 0029         (*Port_Set)(Output[i]);
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_Output)
	SBCI R31,HIGH(-_Output)
	LD   R26,Z
	__CALL1MN _Port_Set,0
; 0002 002A         for(j=0;j<sizeof(Input);j++)
	LDI  R16,LOW(0)
_0x40008:
	CPI  R16,8
	BRSH _0x40009
; 0002 002B         {
; 0002 002C             //(*sleep_ms)(1);
; 0002 002D             if((*Read_Pin)()==Input[j])
	CALL SUBOPT_0x14
	BRNE _0x4000A
; 0002 002E             {
; 0002 002F                 if(i!=j)
	CP   R16,R17
	BREQ _0x4000B
; 0002 0030                 {
; 0002 0031                     cable_func_handle.error_cable[i]=2+i;
	MOV  R26,R17
	LDI  R27,0
	SUBI R26,LOW(-_cable_func_handle)
	SBCI R27,HIGH(-_cable_func_handle)
	MOV  R30,R17
	SUBI R30,-LOW(2)
	ST   X,R30
; 0002 0032                     flag.connect=1;
	CALL SUBOPT_0x15
; 0002 0033                 }
; 0002 0034                 else if(i==j)
	RJMP _0x4000C
_0x4000B:
	CP   R16,R17
	BRNE _0x4000D
; 0002 0035                 {
; 0002 0036                     flag.connect=1;
	CALL SUBOPT_0x15
; 0002 0037                     cable_func_handle.error_cable[i]=0;
	CALL SUBOPT_0x16
	LDI  R26,LOW(0)
	STD  Z+0,R26
; 0002 0038                 }
; 0002 0039 
; 0002 003A             }
_0x4000D:
_0x4000C:
; 0002 003B             if((*Read_Pin)()>Input[j])
_0x4000A:
	CALL SUBOPT_0x14
	BRSH _0x4000E
; 0002 003C             {
; 0002 003D                flag.connect=1;
	CALL SUBOPT_0x15
; 0002 003E                cable_func_handle.error_cable[i]=3+i;
	MOV  R26,R17
	LDI  R27,0
	SUBI R26,LOW(-_cable_func_handle)
	SBCI R27,HIGH(-_cable_func_handle)
	MOV  R30,R17
	SUBI R30,-LOW(3)
	ST   X,R30
; 0002 003F             }
; 0002 0040         }
_0x4000E:
	SUBI R16,-1
	RJMP _0x40008
_0x40009:
; 0002 0041         if(flag.connect==1)
	LDS  R30,_flag
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE _0x4000F
; 0002 0042         {
; 0002 0043             flag.connect=0;
	LDS  R30,_flag
	ANDI R30,0xFE
	RJMP _0x4001C
; 0002 0044         }
; 0002 0045         else if(flag.connect==0)
_0x4000F:
	LDS  R30,_flag
	ANDI R30,LOW(0x1)
	BRNE _0x40011
; 0002 0046         {
; 0002 0047              cable_func_handle.error_cable[i]=1;
	CALL SUBOPT_0x16
	LDI  R26,LOW(1)
	STD  Z+0,R26
; 0002 0048              flag.notconnect=1;
	LDS  R30,_flag
	ORI  R30,2
_0x4001C:
	STS  _flag,R30
; 0002 0049         }
; 0002 004A     }
_0x40011:
	SUBI R17,-1
	RJMP _0x40005
_0x40006:
; 0002 004B 
; 0002 004C }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;struct FUNC_HANDLE Cable_Error_Check(void)
; 0002 004F {
_Cable_Error_Check:
; .FSTART _Cable_Error_Check
; 0002 0050     uint8_t i=0;
; 0002 0051     for(i=0;i<MAX_CABLE_PINS;i++)
	SBIW R28,19
	ST   -Y,R17
;	i -> R17
	LDI  R17,0
	LDI  R17,LOW(0)
_0x40013:
	CPI  R17,8
	BRSH _0x40014
; 0002 0052     {
; 0002 0053         if(cable_func_handle.error_cable[i]==i+3)
	CALL SUBOPT_0x16
	LD   R26,Z
	MOV  R30,R17
	LDI  R31,0
	ADIW R30,3
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x40015
; 0002 0054         {
; 0002 0055             cable_func_handle.error_symbol[i]=CONFLICT;
	CALL SUBOPT_0x17
	LDI  R30,LOW(67)
	RJMP _0x4001D
; 0002 0056         }
; 0002 0057         else if(cable_func_handle.error_cable[i]==i+2)
_0x40015:
	CALL SUBOPT_0x16
	LD   R26,Z
	MOV  R30,R17
	LDI  R31,0
	ADIW R30,2
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x40017
; 0002 0058         {
; 0002 0059              cable_func_handle.error_symbol[i]= WRONG;
	CALL SUBOPT_0x17
	LDI  R30,LOW(87)
	RJMP _0x4001D
; 0002 005A         }
; 0002 005B         else if(cable_func_handle.error_cable[i]==0)
_0x40017:
	CALL SUBOPT_0x16
	LD   R30,Z
	CPI  R30,0
	BRNE _0x40019
; 0002 005C         {
; 0002 005D              cable_func_handle.error_symbol[i]= GOOD;
	CALL SUBOPT_0x17
	LDI  R30,LOW(71)
	ST   X,R30
; 0002 005E              cable_func_handle.pass_pins++;
	__GETB1MN _cable_func_handle,18
	SUBI R30,-LOW(1)
	__PUTB1MN _cable_func_handle,18
	SUBI R30,LOW(1)
; 0002 005F         }
; 0002 0060         else if(cable_func_handle.error_cable[i]==1)
	RJMP _0x4001A
_0x40019:
	CALL SUBOPT_0x16
	LD   R26,Z
	CPI  R26,LOW(0x1)
	BRNE _0x4001B
; 0002 0061         {
; 0002 0062              cable_func_handle.error_symbol[i]= NOCONNECT;
	CALL SUBOPT_0x17
	LDI  R30,LOW(78)
_0x4001D:
	ST   X,R30
; 0002 0063         }
; 0002 0064     }
_0x4001B:
_0x4001A:
	SUBI R17,-1
	RJMP _0x40013
_0x40014:
; 0002 0065 
; 0002 0066     return cable_func_handle;
	LDI  R30,LOW(_cable_func_handle)
	LDI  R31,HIGH(_cable_func_handle)
	MOVW R26,R28
	ADIW R26,1
	LDI  R24,19
	CALL __COPYMML
	MOVW R30,R28
	ADIW R30,1
	LDI  R24,19
	LDD  R17,Y+0
	JMP  _0x20C0005
; 0002 0067 }
; .FEND
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
;
;
;
;
;void main_menu_button_manager_func(void)
; 0003 000B {

	.CSEG
_main_menu_button_manager_func:
; .FSTART _main_menu_button_manager_func
; 0003 000C     int8_t Menu_Item=-1;
; 0003 000D     Menu_Item =  Menue_Main_Select_Num+Menue_Main_Num;
	ST   -Y,R17
;	Menu_Item -> R17
	LDI  R17,255
	LDS  R30,_Menue_Main_Num
	LDS  R26,_Menue_Main_Select_Num
	ADD  R30,R26
	MOV  R17,R30
; 0003 000E     if(ENTER_BUTTON_PUSHED==1)
	CALL SUBOPT_0x18
	BRNE _0x60004
	LDS  R30,_flags_b
	ANDI R30,LOW(0x2)
	BRNE _0x60004
	LDS  R30,_flags_b
	ANDI R30,LOW(0x4)
	BRNE _0x60004
	LDI  R30,1
	RJMP _0x60005
_0x60004:
	LDI  R30,0
_0x60005:
	CPI  R30,LOW(0x1)
	BRNE _0x60003
; 0003 000F     {
; 0003 0010         flags_b.enter=0;
	CALL SUBOPT_0x19
; 0003 0011         switch (Menu_Item)
	MOV  R30,R17
	LDI  R31,0
	SBRC R30,7
	SER  R31
; 0003 0012         {
; 0003 0013         case RUN_TEST_PAGE:
	SBIW R30,0
	BRNE _0x60009
; 0003 0014             page=RUN_TEST_PAGE;
	LDI  R30,LOW(0)
	STS  _page,R30
; 0003 0015             break;
	RJMP _0x60008
; 0003 0016         case CABLE_SELSECT_PAGE:
_0x60009:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x6000A
; 0003 0017             page=CABLE_SELSECT_PAGE;
	LDI  R30,LOW(1)
	STS  _page,R30
; 0003 0018             break;
	RJMP _0x60008
; 0003 0019         case CABLE_DEFINE_PAGE:
_0x6000A:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x6000B
; 0003 001A             page=CABLE_DEFINE_PAGE;
	LDI  R30,LOW(3)
	STS  _page,R30
; 0003 001B             break;
	RJMP _0x60008
; 0003 001C         case ABOUT_ME_PAGE:
_0x6000B:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x6000D
; 0003 001D             page=ABOUT_ME_PAGE;
	LDI  R30,LOW(2)
	STS  _page,R30
; 0003 001E             break;
; 0003 001F         default:
_0x6000D:
; 0003 0020             break;
; 0003 0021         }
_0x60008:
; 0003 0022         lcd_clear();
	CALL _lcd_clear
; 0003 0023     }
; 0003 0024     else if(UP_BUTTON_PUSHED==1)
	RJMP _0x6000E
_0x60003:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x1)
	BRNE _0x60010
	CALL SUBOPT_0x1A
	BRNE _0x60010
	LDS  R30,_flags_b
	ANDI R30,LOW(0x4)
	BRNE _0x60010
	LDI  R30,1
	RJMP _0x60011
_0x60010:
	LDI  R30,0
_0x60011:
	CPI  R30,LOW(0x1)
	BRNE _0x6000F
; 0003 0025     {
; 0003 0026         flags_b.up=0;
	CALL SUBOPT_0x1B
; 0003 0027         Menue_Main_Select_Num--; //0 or 1
	LDS  R30,_Menue_Main_Select_Num
	SUBI R30,LOW(1)
	STS  _Menue_Main_Select_Num,R30
; 0003 0028         if(Menue_Main_Select_Num<0)
	LDS  R26,_Menue_Main_Select_Num
	CPI  R26,0
	BRGE _0x60012
; 0003 0029         {
; 0003 002A            Menue_Main_Num=Menue_Main_Num-NUM_ROW;
	LDS  R30,_Menue_Main_Num
	SUBI R30,LOW(4)
	STS  _Menue_Main_Num,R30
; 0003 002B            Menue_Main_Select_Num=NUM_ROW-1;
	LDI  R30,LOW(3)
	STS  _Menue_Main_Select_Num,R30
; 0003 002C            if(Menue_Main_Num<0)
	LDS  R26,_Menue_Main_Num
	CPI  R26,0
	BRGE _0x60013
; 0003 002D               Menue_Main_Num=MAX_MAIN_MENU_ITEM-NUM_ROW;
	LDI  R30,LOW(255)
	STS  _Menue_Main_Num,R30
; 0003 002E         }
_0x60013:
; 0003 002F 
; 0003 0030     }
_0x60012:
; 0003 0031     else if(DOWN_BUTTON_PUSHED==1)
	RJMP _0x60014
_0x6000F:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x1)
	BRNE _0x60016
	LDS  R30,_flags_b
	ANDI R30,LOW(0x2)
	BRNE _0x60016
	CALL SUBOPT_0x1C
	BRNE _0x60016
	LDI  R30,1
	RJMP _0x60017
_0x60016:
	LDI  R30,0
_0x60017:
	CPI  R30,LOW(0x1)
	BRNE _0x60015
; 0003 0032     {
; 0003 0033         flags_b.down=0;
	CALL SUBOPT_0x1D
; 0003 0034         Menue_Main_Select_Num++;
	LDS  R30,_Menue_Main_Select_Num
	SUBI R30,-LOW(1)
	STS  _Menue_Main_Select_Num,R30
; 0003 0035         if(Menue_Main_Select_Num>=NUM_ROW || Menue_Main_Select_Num>=MAX_MAIN_MENU_ITEM)
	LDS  R26,_Menue_Main_Select_Num
	CPI  R26,LOW(0x4)
	BRGE _0x60019
	CPI  R26,LOW(0x3)
	BRLT _0x60018
_0x60019:
; 0003 0036         {
; 0003 0037           Menue_Main_Num=Menue_Main_Num+NUM_ROW;
	LDS  R30,_Menue_Main_Num
	SUBI R30,-LOW(4)
	STS  _Menue_Main_Num,R30
; 0003 0038           Menue_Main_Select_Num=0;
	LDI  R30,LOW(0)
	STS  _Menue_Main_Select_Num,R30
; 0003 0039           if(Menue_Main_Num>=(MAX_MAIN_MENU_ITEM-1))
	LDS  R26,_Menue_Main_Num
	CPI  R26,LOW(0x2)
	BRLT _0x6001B
; 0003 003A              Menue_Main_Num=0;
	STS  _Menue_Main_Num,R30
; 0003 003B         }
_0x6001B:
; 0003 003C     }
_0x60018:
; 0003 003D 
; 0003 003E }
_0x60015:
_0x60014:
_0x6000E:
	LD   R17,Y+
	RET
; .FEND
;void run_test_button_manager_func(void)
; 0003 0040 {
_run_test_button_manager_func:
; .FSTART _run_test_button_manager_func
; 0003 0041     if(ENTER_BUTTON_PUSHED==1)
	CALL SUBOPT_0x18
	BRNE _0x6001D
	LDS  R30,_flags_b
	ANDI R30,LOW(0x2)
	BRNE _0x6001D
	LDS  R30,_flags_b
	ANDI R30,LOW(0x4)
	BRNE _0x6001D
	LDI  R30,1
	RJMP _0x6001E
_0x6001D:
	LDI  R30,0
_0x6001E:
	CPI  R30,LOW(0x1)
	BRNE _0x6001C
; 0003 0042     {
; 0003 0043          flags_b.enter=0;
	CALL SUBOPT_0x19
; 0003 0044          page=MAIN_PAGE;
	LDI  R30,LOW(4)
	STS  _page,R30
; 0003 0045     }
; 0003 0046 }
_0x6001C:
	RET
; .FEND
;void cable_select_button_manager_func(void)
; 0003 0048 {
_cable_select_button_manager_func:
; .FSTART _cable_select_button_manager_func
; 0003 0049     if(ENTER_BUTTON_PUSHED==1)
	CALL SUBOPT_0x18
	BRNE _0x60020
	LDS  R30,_flags_b
	ANDI R30,LOW(0x2)
	BRNE _0x60020
	LDS  R30,_flags_b
	ANDI R30,LOW(0x4)
	BRNE _0x60020
	LDI  R30,1
	RJMP _0x60021
_0x60020:
	LDI  R30,0
_0x60021:
	CPI  R30,LOW(0x1)
	BRNE _0x6001F
; 0003 004A     {
; 0003 004B         flags_b.enter=0;
	CALL SUBOPT_0x19
; 0003 004C         page=MAIN_PAGE;
	LDI  R30,LOW(4)
	STS  _page,R30
; 0003 004D         lcd_clear();
	CALL _lcd_clear
; 0003 004E         //temp = Menue_Cable_Select_Num;
; 0003 004F     }
; 0003 0050     else if(UP_BUTTON_PUSHED==1)
	RJMP _0x60022
_0x6001F:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x1)
	BRNE _0x60024
	CALL SUBOPT_0x1A
	BRNE _0x60024
	LDS  R30,_flags_b
	ANDI R30,LOW(0x4)
	BRNE _0x60024
	LDI  R30,1
	RJMP _0x60025
_0x60024:
	LDI  R30,0
_0x60025:
	CPI  R30,LOW(0x1)
	BRNE _0x60023
; 0003 0051     {
; 0003 0052         flags_b.up=0;
	CALL SUBOPT_0x1B
; 0003 0053         Menue_Cable_Select_Select_Num--;
	LDS  R30,_Menue_Cable_Select_Select_Num
	SUBI R30,LOW(1)
	STS  _Menue_Cable_Select_Select_Num,R30
; 0003 0054         if(Menue_Cable_Select_Select_Num<0)
	LDS  R26,_Menue_Cable_Select_Select_Num
	CPI  R26,0
	BRGE _0x60026
; 0003 0055         {
; 0003 0056             Menue_Cable_Select_Select_Num=NUM_ROW-1;
	LDI  R30,LOW(3)
	STS  _Menue_Cable_Select_Select_Num,R30
; 0003 0057             Menue_Cable_Select_Num=Menue_Cable_Select_Num-NUM_ROW;
	LDS  R30,_Menue_Cable_Select_Num
	SUBI R30,LOW(4)
	CALL SUBOPT_0x1E
; 0003 0058             if(Menue_Cable_Select_Num<0)
	CPI  R26,0
	BRGE _0x60027
; 0003 0059                 Menue_Cable_Select_Num=MAX_NUMBER_PROFILE-NUM_ROW;
	LDI  R30,LOW(8)
	STS  _Menue_Cable_Select_Num,R30
; 0003 005A         }
_0x60027:
; 0003 005B 
; 0003 005C     }
_0x60026:
; 0003 005D     else if(DOWN_BUTTON_PUSHED==1)
	RJMP _0x60028
_0x60023:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x1)
	BRNE _0x6002A
	LDS  R30,_flags_b
	ANDI R30,LOW(0x2)
	BRNE _0x6002A
	CALL SUBOPT_0x1C
	BRNE _0x6002A
	LDI  R30,1
	RJMP _0x6002B
_0x6002A:
	LDI  R30,0
_0x6002B:
	CPI  R30,LOW(0x1)
	BRNE _0x60029
; 0003 005E     {
; 0003 005F         flags_b.down=0;
	CALL SUBOPT_0x1D
; 0003 0060         Menue_Cable_Select_Select_Num++;
	LDS  R30,_Menue_Cable_Select_Select_Num
	SUBI R30,-LOW(1)
	STS  _Menue_Cable_Select_Select_Num,R30
; 0003 0061         if(Menue_Cable_Select_Select_Num>=NUM_ROW)
	LDS  R26,_Menue_Cable_Select_Select_Num
	CPI  R26,LOW(0x4)
	BRLT _0x6002C
; 0003 0062         {
; 0003 0063             Menue_Cable_Select_Select_Num=0;
	LDI  R30,LOW(0)
	STS  _Menue_Cable_Select_Select_Num,R30
; 0003 0064             Menue_Cable_Select_Num=Menue_Cable_Select_Num+NUM_ROW;
	LDS  R30,_Menue_Cable_Select_Num
	SUBI R30,-LOW(4)
	CALL SUBOPT_0x1E
; 0003 0065             if(Menue_Cable_Select_Num>=(MAX_NUMBER_PROFILE-1))
	CPI  R26,LOW(0xB)
	BRLT _0x6002D
; 0003 0066                 Menue_Cable_Select_Num=0;
	LDI  R30,LOW(0)
	STS  _Menue_Cable_Select_Num,R30
; 0003 0067         }
_0x6002D:
; 0003 0068 
; 0003 0069     }
_0x6002C:
; 0003 006A }
_0x60029:
_0x60028:
_0x60022:
	RET
; .FEND
;
;void cable_define_button_manager_func(void)
; 0003 006D {
_cable_define_button_manager_func:
; .FSTART _cable_define_button_manager_func
; 0003 006E     if(ENTER_BUTTON_PUSHED==1)
	CALL SUBOPT_0x18
	BRNE _0x6002F
	LDS  R30,_flags_b
	ANDI R30,LOW(0x2)
	BRNE _0x6002F
	LDS  R30,_flags_b
	ANDI R30,LOW(0x4)
	BRNE _0x6002F
	LDI  R30,1
	RJMP _0x60030
_0x6002F:
	LDI  R30,0
_0x60030:
	CPI  R30,LOW(0x1)
	BRNE _0x6002E
; 0003 006F     {
; 0003 0070         flags_b.enter=0;
	CALL SUBOPT_0x19
; 0003 0071         if (flags_menu.subpage==IN_SELECT)
	LDS  R30,_flags_menu
	ANDI R30,LOW(0x7)
	CPI  R30,LOW(0x2)
	BRNE _0x60031
; 0003 0072         {
; 0003 0073            flags_menu.subpage=OUT_SELECT;
	LDS  R30,_flags_menu
	ANDI R30,LOW(0xF8)
	ORI  R30,LOW(0x3)
	RJMP _0x6004F
; 0003 0074         }
; 0003 0075         else if (flags_menu.subpage==OUT_SELECT)
_0x60031:
	LDS  R30,_flags_menu
	ANDI R30,LOW(0x7)
	CPI  R30,LOW(0x3)
	BRNE _0x60033
; 0003 0076         {
; 0003 0077             flags_menu.subpage=PROF_SELECT;
	LDS  R30,_flags_menu
	ANDI R30,LOW(0xF8)
	ORI  R30,4
	RJMP _0x6004F
; 0003 0078         }
; 0003 0079         else if(flags_menu.subpage==PROF_SELECT)
_0x60033:
	LDS  R30,_flags_menu
	ANDI R30,LOW(0x7)
	CPI  R30,LOW(0x4)
	BRNE _0x60035
; 0003 007A         {
; 0003 007B             flags_menu.subpage=IN_SELECT;
	LDS  R30,_flags_menu
	ANDI R30,LOW(0xF8)
	ORI  R30,2
_0x6004F:
	STS  _flags_menu,R30
; 0003 007C         }
; 0003 007D 
; 0003 007E     }
_0x60035:
; 0003 007F     else if(UP_BUTTON_PUSHED==1)
	RJMP _0x60036
_0x6002E:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x1)
	BRNE _0x60038
	CALL SUBOPT_0x1A
	BRNE _0x60038
	LDS  R30,_flags_b
	ANDI R30,LOW(0x4)
	BRNE _0x60038
	LDI  R30,1
	RJMP _0x60039
_0x60038:
	LDI  R30,0
_0x60039:
	CPI  R30,LOW(0x1)
	BRNE _0x60037
; 0003 0080     {
; 0003 0081         flags_b.up=0;
	CALL SUBOPT_0x1B
; 0003 0082         Menue_Cable_Select_Num++;
	LDS  R30,_Menue_Cable_Select_Num
	SUBI R30,-LOW(1)
	CALL SUBOPT_0x1E
; 0003 0083         if(Menue_Cable_Select_Num>MAX_NUMBER_PROFILE)
	CPI  R26,LOW(0xD)
	BRLT _0x6003A
; 0003 0084            Menue_Cable_Select_Num=0;
	LDI  R30,LOW(0)
	STS  _Menue_Cable_Select_Num,R30
; 0003 0085     }
_0x6003A:
; 0003 0086     else if(DOWN_BUTTON_PUSHED==1)
	RJMP _0x6003B
_0x60037:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x1)
	BRNE _0x6003D
	LDS  R30,_flags_b
	ANDI R30,LOW(0x2)
	BRNE _0x6003D
	CALL SUBOPT_0x1C
	BRNE _0x6003D
	LDI  R30,1
	RJMP _0x6003E
_0x6003D:
	LDI  R30,0
_0x6003E:
	CPI  R30,LOW(0x1)
	BRNE _0x6003C
; 0003 0087     {
; 0003 0088         flags_b.down=0;
	CALL SUBOPT_0x1D
; 0003 0089         Menue_Cable_Select_Num--;
	LDS  R30,_Menue_Cable_Select_Num
	SUBI R30,LOW(1)
	CALL SUBOPT_0x1E
; 0003 008A         if(Menue_Cable_Select_Num<0)
	CPI  R26,0
	BRGE _0x6003F
; 0003 008B             Menue_Cable_Select_Num=MAX_NUMBER_PROFILE;
	LDI  R30,LOW(12)
	STS  _Menue_Cable_Select_Num,R30
; 0003 008C     }
_0x6003F:
; 0003 008D     else if(EXIT_BUTTON_PUSHED==1)
	RJMP _0x60040
_0x6003C:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x1)
	BRNE _0x60042
	CALL SUBOPT_0x1A
	BRNE _0x60042
	CALL SUBOPT_0x1C
	BRNE _0x60042
	LDI  R30,1
	RJMP _0x60043
_0x60042:
	LDI  R30,0
_0x60043:
	CPI  R30,LOW(0x1)
	BRNE _0x60041
; 0003 008E     {
; 0003 008F          flags_b.up=0;
	CALL SUBOPT_0x1B
; 0003 0090           flags_b.down=0;
	CALL SUBOPT_0x1D
; 0003 0091           page=MAIN_PAGE;
	LDI  R30,LOW(4)
	STS  _page,R30
; 0003 0092     }
; 0003 0093 }
_0x60041:
_0x60040:
_0x6003B:
_0x60036:
	RET
; .FEND
;
;void about_me_button_manager_func(void)
; 0003 0096 {
_about_me_button_manager_func:
; .FSTART _about_me_button_manager_func
; 0003 0097     if(ENTER_BUTTON_PUSHED==1)
	CALL SUBOPT_0x18
	BRNE _0x60045
	LDS  R30,_flags_b
	ANDI R30,LOW(0x2)
	BRNE _0x60045
	LDS  R30,_flags_b
	ANDI R30,LOW(0x4)
	BRNE _0x60045
	LDI  R30,1
	RJMP _0x60046
_0x60045:
	LDI  R30,0
_0x60046:
	CPI  R30,LOW(0x1)
	BRNE _0x60044
; 0003 0098     {
; 0003 0099          flags_b.enter=0;
	LDS  R30,_flags_b
	ANDI R30,0xFE
	RJMP _0x60050
; 0003 009A         page=MAIN_PAGE;
; 0003 009B     }
; 0003 009C     else if(UP_BUTTON_PUSHED==1)
_0x60044:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x1)
	BRNE _0x60049
	CALL SUBOPT_0x1A
	BRNE _0x60049
	LDS  R30,_flags_b
	ANDI R30,LOW(0x4)
	BRNE _0x60049
	LDI  R30,1
	RJMP _0x6004A
_0x60049:
	LDI  R30,0
_0x6004A:
	CPI  R30,LOW(0x1)
	BRNE _0x60048
; 0003 009D     {
; 0003 009E          flags_b.up=0;
	LDS  R30,_flags_b
	ANDI R30,0xFD
	RJMP _0x60050
; 0003 009F         page=MAIN_PAGE;
; 0003 00A0     }
; 0003 00A1     else if(DOWN_BUTTON_PUSHED==1)
_0x60048:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x1)
	BRNE _0x6004D
	LDS  R30,_flags_b
	ANDI R30,LOW(0x2)
	BRNE _0x6004D
	CALL SUBOPT_0x1C
	BRNE _0x6004D
	LDI  R30,1
	RJMP _0x6004E
_0x6004D:
	LDI  R30,0
_0x6004E:
	CPI  R30,LOW(0x1)
	BRNE _0x6004C
; 0003 00A2     {
; 0003 00A3          flags_b.down=0;
	LDS  R30,_flags_b
	ANDI R30,0xFB
_0x60050:
	STS  _flags_b,R30
; 0003 00A4         page=MAIN_PAGE;
	LDI  R30,LOW(4)
	STS  _page,R30
; 0003 00A5     }
; 0003 00A6 
; 0003 00A7 
; 0003 00A8 }
_0x6004C:
	RET
; .FEND
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
	JMP  _0x20C0002
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
	CALL SUBOPT_0x1F
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	CALL SUBOPT_0x1F
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
	CALL SUBOPT_0x20
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x21
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	CALL SUBOPT_0x20
	CALL SUBOPT_0x22
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	CALL SUBOPT_0x20
	CALL SUBOPT_0x22
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
	CALL SUBOPT_0x20
	CALL SUBOPT_0x23
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
	CALL SUBOPT_0x20
	CALL SUBOPT_0x23
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
	CALL SUBOPT_0x1F
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
	CALL SUBOPT_0x1F
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
	CALL SUBOPT_0x21
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	CALL SUBOPT_0x1F
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
	CALL SUBOPT_0x21
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
_0x20C0005:
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x24
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
	CALL SUBOPT_0x24
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	CALL SUBOPT_0x25
	RJMP _0x20C0004
; .FEND
_snprintf:
; .FSTART _snprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	__GETWRN 18,19,0
	CALL SUBOPT_0x26
	SBIW R30,0
	BRNE _0x2000073
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0003
_0x2000073:
	CALL SUBOPT_0x24
	SBIW R30,0
	BREQ _0x2000074
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x26
	STD  Y+6,R30
	STD  Y+6+1,R31
	CALL SUBOPT_0x24
	STD  Y+8,R30
	STD  Y+8+1,R31
	CALL SUBOPT_0x25
_0x2000074:
_0x20C0004:
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
_memcpy:
; .FSTART _memcpy
	ST   -Y,R27
	ST   -Y,R26
    ldd  r25,y+1
    ld   r24,y
    adiw r24,0
    breq memcpy1
    ldd  r27,y+5
    ldd  r26,y+4
    ldd  r31,y+3
    ldd  r30,y+2
memcpy0:
    ld   r22,z+
    st   x+,r22
    sbiw r24,1
    brne memcpy0
memcpy1:
    ldd  r31,y+5
    ldd  r30,y+4
	ADIW R28,6
	RET
; .FEND
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
	LDD  R5,Y+1
	LDD  R4,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x27
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x27
	LDI  R30,LOW(0)
	MOV  R4,R30
	MOV  R5,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2060005
	CP   R5,R7
	BRLO _0x2060004
_0x2060005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R4
	MOV  R26,R4
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2060007
	RJMP _0x20C0001
_0x2060007:
_0x2060004:
	INC  R5
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
	LDD  R7,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G103,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G103,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x28
	CALL SUBOPT_0x28
	CALL SUBOPT_0x28
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
	.BYTE 0x13
_flag:
	.BYTE 0x2
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
_Menue_Main_Num:
	.BYTE 0x1
_Menue_Main_Select_Num:
	.BYTE 0x1
_Menue_Cable_Select_Num:
	.BYTE 0x1
_Menue_Cable_Select_Select_Num:
	.BYTE 0x1
_Menu_Cable_Define_Prof:
	.BYTE 0x1
_Menu_Cable_Define_Index_In:
	.BYTE 0x1
_Menu_Cable_Define_Index_Out:
	.BYTE 0x1
_Menu_Cable_Define_Index_In_Num:
	.BYTE 0x1
_Menu_Cable_Define_Index_Out_Num:
	.BYTE 0x1
_flags_menu:
	.BYTE 0x1
_page:
	.BYTE 0x1
_flags_b:
	.BYTE 0x1
_Menue_Main_Srting:
	.BYTE 0x54
_Menue_Main_Arrow_String:
	.BYTE 0x6
_lcd_buffer:
	.BYTE 0x14
__seed_G101:
	.BYTE 0x4
__base_y_G103:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	CALL __SAVELOCR4
	__GETWRN 16,17,0
	LDI  R19,0
	LDI  R19,LOW(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R19
	CALL _lcd_gotoxy
	LDI  R30,LOW(_lcd_buffer)
	LDI  R31,HIGH(_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _memset
	LDI  R30,LOW(_lcd_buffer)
	LDI  R31,HIGH(_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x2:
	LDI  R31,0
	SBRC R30,7
	SER  R31
	CALL __EQW12
	LDI  R26,LOW(3)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,LOW(-_Menue_Main_Arrow_String)
	SBCI R31,HIGH(-_Menue_Main_Arrow_String)
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3:
	LDI  R27,0
	SBRC R26,7
	SER  R27
	MOV  R30,R19
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	CALL __PUTPARD1
	LDI  R24,8
	CALL _snprintf
	ADIW R28,14
	MOVW R16,R30
	__CPWRN 16,17,20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x5:
	MOVW R30,R16
	SUBI R30,LOW(-_lcd_buffer)
	SBCI R31,HIGH(-_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	SUB  R30,R16
	SBC  R31,R17
	MOVW R26,R30
	JMP  _memset

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(0)
	__PUTB1MN _lcd_buffer,20
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(_lcd_buffer)
	LDI  R31,HIGH(_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _memset
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xA:
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	LDI  R26,LOW(_lcd_buffer)
	LDI  R27,HIGH(_lcd_buffer)
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0xB:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xC:
	LDS  R30,_Menu_Cable_Define_Prof
	LDI  R31,0
	CALL __LSLW3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	SUBI R30,LOW(-_In_profile)
	SBCI R31,HIGH(-_In_profile)
	MOVW R26,R30
	LDS  R30,_Menu_Cable_Define_Index_In
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	SUBI R30,LOW(-_Out_profile)
	SBCI R31,HIGH(-_Out_profile)
	MOVW R26,R30
	LDS  R30,_Menu_Cable_Define_Index_Out
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(20)
	LDI  R27,0
	JMP  _memset

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x11:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x12:
	ST   -Y,R31
	ST   -Y,R30
	__GETB1MN _cable_func_handle,17
	LDI  R31,0
	CALL __LSLW3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(8)
	LDI  R27,0
	JMP  _memcpy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x14:
	__CALL1MN _Read_Pin,0
	MOV  R26,R30
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_Input)
	SBCI R31,HIGH(-_Input)
	LD   R30,Z
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x15:
	LDS  R30,_flag
	ORI  R30,1
	STS  _flag,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x16:
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_cable_func_handle)
	SBCI R31,HIGH(-_cable_func_handle)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x17:
	__POINTW2MN _cable_func_handle,9
	CLR  R30
	ADD  R26,R17
	ADC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x18:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x19:
	LDS  R30,_flags_b
	ANDI R30,0xFE
	STS  _flags_b,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1A:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1B:
	LDS  R30,_flags_b
	ANDI R30,0xFD
	STS  _flags_b,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1C:
	LDS  R30,_flags_b
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1D:
	LDS  R30,_flags_b
	ANDI R30,0xFB
	STS  _flags_b,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1E:
	STS  _Menue_Cable_Select_Num,R30
	LDS  R26,_Menue_Cable_Select_Num
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1F:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x20:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x21:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x22:
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
SUBOPT_0x23:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x24:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x25:
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
	CALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x26:
	MOVW R26,R28
	ADIW R26,14
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x27:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x28:
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

__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__EQW12:
	CP   R30,R26
	CPC  R31,R27
	LDI  R30,1
	BREQ __EQW12T
	CLR  R30
__EQW12T:
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
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

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__COPYMML:
	CLR  R25
__COPYMM:
	PUSH R30
	PUSH R31
__COPYMM0:
	LD   R22,Z+
	ST   X+,R22
	SBIW R24,1
	BRNE __COPYMM0
	POP  R31
	POP  R30
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
