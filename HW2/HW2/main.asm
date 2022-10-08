
.INCLUDE "M32DEF.INC"

;initializing stack pointer
LDI R16, HIGH(RAMEND)
OUT SPH, R16 
LDI R16, LOW(RAMEND)
OUT SPL, R16

;Port D now is output
LDI R16,0XFF
OUT DDRD, R16

;Port C now is output
LDI R16,0XFF
OUT DDRC, R16 


LDI R20 , 0 ;yekan
LDI R21, 0  ;dahgan
LDI R22, 0	;sadgan
LDI R23 ,0 ; hezargan
LDI R24,0  ; ms bit 

RJMP START


;swicher to ASC or DEC 
SWITCH:
		IN R25, PINA
		CPI R25,0
		BRNE LOOP2
		RJMP LOOP1 


;ASC loop
LOOP1:
		CALL INCREL0
		CPI R24 ,10
		BRNE START
		LDI R24,0
		CALL INCREL1
		CPI R20 ,10
		BRNE START
		LDI R20,0
		CALL INCREL2
		CPI R21,10
		BRNE START
		LDI R21,0
		CALL INCREL3
		CPI R22,10 
		BRNE START
		LDI R22, 0
		CALL INCREL4
		CPI R23 ,10 
		BRNE START
		LDI R23, 0
		RJMP START

; DEC loop
LOOP2:
		CALL DECL0
		CPI R24 ,0XFF
		BRNE START
		LDI R24,9
		CALL DECL1
		CPI R20 ,0XFF
		BRNE START
		LDI R20,9
		CALL DECL2
		CPI R21,0XFF
		BRNE START
		LDI R21,9
		CALL DECL3
		CPI R22,0XFF
		BRNE START
		LDI R22, 9
		CALL DECL4
		CPI R23 ,0XFF 
		BRNE START
		LDI R23, 9
		RJMP START


; start program
START:


;7seg 1
LIGHT1:
	
	LDI R16, 0B11110111
	OUT PORTD, R16
	MOV R17, R20
	CALL CONVERT
	CALL DELAY


;7seg 2
LIGHT2:
	
	LDI R16, 0B11111011
	OUT PORTD, R16
	MOV R17, R21
	CALL CONVERT
	CALL DELAY

;7seg 3
LIGHT3:
	
	LDI R16, 0B11111101
	OUT PORTD, R16
	MOV R17, R22
	CALL CONVERT
	CALL DELAY
	
	
;7seg 4
LIGHT4:
	
	LDI R16, 0B11111110
	OUT PORTD, R16
	MOV R17, R23
	CALL CONVERT
	CALL DELAY
	RJMP SWITCH

;inc ms bit 	
INCREL0:
	INC R24
	RET
;inc bit 1
INCREL1:
	INC R20
	RET
;inc bit 2
INCREL2:
	INC R21
	RET
;inc bit 3
INCREL3:
	INC R22
	RET

;inc bit 3
INCREL4:
	INC R23
	RET

;dec ms bit 
DECL0:
	DEC R24
	RET

;dec bit 1
DECL1:
	DEC R20
	RET
;dec bit 2
DECL2:
	DEC R21
	RET
;inc bit 3
DECL3:
	DEC R22
	RET
;inc bit 4
DECL4:
	DEC R23
	RET

;convertor number of any segment to 0 or 1 or 2 or 3 or 4 ....
CONVERT:

	L0:
		CPI R17, 0
		BRNE L1
		LDI R18, 0x3F
		OUT PORTC, R18
		RET

	L1:
		CPI R17, 1
		BRNE L2
		LDI R18, 0x06
		OUT PORTC ,R18
		RET
    L2:
		CPI R17, 2
		BRNE L3
		LDI R18, 0x5B
		OUT PORTC, R18
		RET
	L3:
		CPI R17, 3
		BRNE L4
		LDI R18, 0x4F
		OUT PORTC, R18
		RET
	L4:
		CPI R17, 4
		BRNE L5
		LDI R18, 0x66
		OUT PORTC, R18
		RET
	L5:
		CPI R17, 5
		BRNE L6
		LDI R18, 0x6D
		OUT PORTC, R18
		RET
	L6:
		CPI R17, 6
		BRNE L7
		LDI R18, 0x7D
		OUT PORTC, R18
		RET
	L7:
		CPI R17, 7
		BRNE L8
		LDI R18, 0x07
		OUT PORTC, R18
		RET
	L8:
		CPI R17, 8
		BRNE L9
		LDI R18, 0x7F
		OUT PORTC, R18
		RET
	L9:
		CPI R17, 9
		BRNE NULL 
		LDI R18, 0x6F
		OUT PORTC, R18
		RET
	NULL:
		RET


;delay for seg 3 to 5 ms for observe  4 numbers 
DELAY:
	
	LDI		R30,255

LO2: 
	LDI R29, 20

LO3:	
		DEC		R29
		BRNE	LO3
		DEC		R30
		BRNE	LO2
		RET
	
	 
	
	 
	
