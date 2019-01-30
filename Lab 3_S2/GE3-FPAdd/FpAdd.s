	AREA	FpAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	;
	; Part 1 - decode
	;

	LDR	r0, =0x3F000000		; fpval1 = 0.5
	LDR	r1, =0x3EE00000		; fpval2 = 0.4375
	
	LDR	r0, =0x3F000000		; fpval1 = 0.5 result 1 = 0x3f800000
	LDR	r1, =0x3F000000		; fpval2 = 0.5
	
	LDR	r0, =0x3FC00000		; fpval1 = 1.5
	LDR	r1, =0x40100000		; fpval2 = 2.25  result 3.75 =  0x40700000
	
	LDR	r0, =0xBF000000		; fpval1 = -0.5  result -0.9375 = 0xbf700000
	LDR	r1, =0xBEE00000		; fpval2 = -0.4375
	
	LDR	r0, =0x3F000000		; fpval1 = 0.5    result 0.0625 = 0x3d800000
	LDR	r1, =0xBEE00000		; fpval2 = -0.4375
	
	LDR R0, =0xC0100000     ; fpval1 = -2.25    result -0.75 = 0xBF400000
	LDR	R1, =0x3FC00000		; fpval1 = 1.5  
	
	LDR R0, =0x414E0000     ; fpval1 = 12.875   result -17.5 =0xC18C0000
	LDR	R1, =0xC1F30000	    ; fpval1 = -30.375  
	
	LDR	r0, =0x3F000000		; fpval1 = 0.5    result 0 = 0x00000000
	LDR	r1, =0xbf000000		; fpval2 = -0.5
	
	LDR R0, =0x40133333     ; fpval1 = 2.3		result 1.8 = 0x3FE66666
	LDR	R1, =0xbf000000  	; fpval2 = -0.5

	BL	fpadd

stop	B	stop

; fpadd subroutine
; Adds two IEEE754 single precision floating point values
; Parameters:
;   R0: first floating point value
;   R1: second floating point value
; Return value:
;   R0: floating point result
;
fpadd
	STMFD SP!, {R4-R9 ,lr}
	MOV R4, R0;						storing away floating point numbers
	MOV R5, R1;
	BL getComponents
	MOV R9, R3;						store away result for use later
	MOV R4, R0;						
	MOV R5, R1;
	CMP R3, #1;						check state
	BGT negativeNumbers
	LDR R1, =0;						get positive fraction of this number
	BL getFraction
	MOV R6, R3;
	MOV R0, R4;						get exponent for number 1
	BL getExponent
	MOV R7, R3;
	MOV R0, R5;
	LDR R1, =0;						get positive fraction of this number
	BL getFraction
	MOV R8, R3;
	MOV R0, R5;						get exponent for number 2
	BL getExponent
	B endNegativeNumbers
negativeNumbers
	LDR R1, =0;						get positive fraction of this number
	BL getFraction
	MOV R6, R3;
	MOV R0, R4;						get exponent for number 1
	BL getExponent
	MOV R7, R3;
	MOV R0, R5;
	LDR R1, =1;						get negative fraction of this number
	BL getFraction
	MOV R8, R3;
	MOV R0, R5;						get exponent for number 2
	BL getExponent
endNegativeNumbers
	MOV R2, R3;						num2 exponent
	MOV R0, R8;						num1 exponent
	MOV R3, R7;						num2 fraction
	MOV R1, R6;						num1 fraction
	BL bringToSamePower
	BL addNumbers
	MOV R2, R9;						
	BL storeResult
	LDMFD SP!, {R4-R9, PC}
	
; getComponents subroutine
; rearranges two floating point numbers based on size
; indicating if the result of their addition will be positive
; Parameters:
;   R0: first floating point value
;   R1: second floating point value
; Return value:
;   R0: biggest magnitude floating point number
;	R1: smallest magnitude floating point number
;   R3: state of addition
getComponents
	STMFD SP!, {R4-R7, lr}
	MOV R4, R0
	MOV R5, R1
	BL getExponent
	MOV R6, R3
	MOV R0, R5
	BL getExponent
	MOV R7, R3
	CMP R6, R7							;check which exponent is bigger
	BGE noRearrange	
	BLT needRearrange					;swap numbers to order largest to smallest
needRearrange
	MOV R0, R5
	MOV R1, R4
	MOV R4, R0
	MOV R5, R1
	B getSign
noRearrange
	MOV R0, R4
	MOV R1, R5
	B getSign
getSign
	LDR R6, =0x80000000					;this code will determine which signs are required for the addition
	AND R7, R5, R6						; no1		|	no2		|	result		|	state
	AND R6, R4, R6						;positive	|positive	|	positive	|	0
	CMP R6, #0							;negative	|negative	|	negative	|	1
	BEQ biggerNumberPositive			;positive	|negative	|	positive	|	2
	CMP R7, #0							;negative	|positive	|	negative	|	3
	BEQ negPos							
	LDR R3, =1							
	B endgetSign						
negPos
	LDR R3, =3
	B endgetSign
biggerNumberPositive
	CMP R7, #0
	BNE posNeg
	LDR R3, =0
	B endgetSign
posNeg
	LDR R3, =2
endgetSign
	LDMFD SP!, {R4-R7, PC}
	
	
	
;get fraction subroutine
;Parameters
;IEEE 754 number in R0
;sign of number in R1
;returns fraction in R3

getFraction
	STMFD SP!, {R4-R6, lr}
	LDR R5, =0x007FFFFF ;mask for fraction
	AND R4, R0, R5 ;get fraction
	ORR R4, R4, #0x00800000 ;reintroduce 1
	CMP R1, #0
	BEQ positive
	MVN R4, R4				;2's complement representation for negative numbers
	ADD R4, R4, #1
positive
	MOV R3, R4;
	LDMFD SP!, {R4-R6, pc}
	
;get exponent subroutine
;IEEE 754 number in R0
;returns exponent in R3

getExponent
	STMFD SP!, {R4-R6, lr}
	LDR R5, =0x7F800000
	AND R4, R0, R5 ;get exponent
	MOV R4, R4, LSR#23 ;shift to right of register
	LDR R6, =127;      
	SUB R4, R4, R6 ; subtract offset
	MOV R3, R4
	LDMFD SP!, {R4-R6, pc}
	
;bringToSamePower subroutine
;takes fractions in R0 & R1
;takes exponents in R2 & R3

bringToSamePower
	STMFD SP!, {R4-R8, lr}
	CMP R2, R3; if(num1<num2)
	BGT numOneBigger
	MOV R4, R3; R4 = num2 exponent
	MOV R5, R2; R5 = num1 exponent
	MOV R6, R1; R6 = num2 fraction
	MOV R7, R0; R7 = num1 fraction
	SUB R8, R4, R5; adjustAmount = biggerExponent - smallerExponent
	MOV R7, R7, LSR R8; adjust smaller number fraction
	ADD R5, R5, R8; adjust smaller number exponent
	MOV R2, R5; return result ensuring number of larger magnitude is first
	MOV R3, R4
	MOV R0, R7
	MOV R1, R6
	B endnumOneBigger
numOneBigger
	MOV R4, R2; R4 = num1 exponent
	MOV R5, R3; R5 = num2 exponent
	MOV R6, R0; R6 = num1 fraction
	MOV R7, R1; R7 = num2 fraction
	SUB R8, R4, R5; adjustAmount = biggerExponent - smallerExponent
	MOV R7, R7, LSR R8; adjust smaller number fraction
	ADD R5, R5, R8; adjust smaller number exponent
	MOV R2, R4; directly return result
	MOV R3, R5
	MOV R0, R6
	MOV R1, R7
endnumOneBigger
	LDMFD SP!, {R4-R8, PC}
	
	;add numbers subroutine
	;takes two numbers (exponent and fraction) and adds them
	;R0 num1 fraction
	;R1 num2 fraction
	;R2 num1 exponent
	;R3 num2 exponent
	
	;returns result 
	; R0 - result exponent
	; R1 - result fraction
addNumbers
	STMFD SP!, {R4-R10 , lr}
	MOV R4, R2; R4 = num1 exponent
	MOV R5, R3; R5 = num2 exponent
	MOV R6, R0; R6 = num1 fraction
	MOV R7, R1; R7 = num2 fraction
	ADD R8, R6, R7; num1 + num2
	LDR R9, =0x01FFFFFF
	AND R8, R8, R9;	mask out un-needed bits
	LDR R9, =0
	MOV R10, R8
countLeadingZeros
	CMP R9, #32;			accounts for 0 result
	BEQ zeroResult
	MOVS R10, R10, LSL#1
	BCS endLeadingZeros
	ADD R9, R9, #1
	B countLeadingZeros
endLeadingZeros
	LDR R10, =8
	CMP R10, R9
	BLT leftShift			; normalises the result
	SUB R9, R10, R9			; gets normalise amount
	MOV R8, R8, LSR R9		; shifts by normalise amount
	ADD R4, R4, R9			; adjusts exponent
	B endShift
leftShift
	SUB R9, R9, R10			; gets normalise amount
	MOV R8, R8, LSL R9		; shifts by normalise amount
	SUB R4, R4, R9			; adjusts exponent
	B endShift
zeroResult
	LDR R0, =0				; store 0 for fraction and exponent if result = 0
	LDR R1, =0
	B endaddNumbers
endShift
	LDR R10, =127
	ADD R4, R4, R10
	MOV R0, R4
	MOV R1, R8
endaddNumbers
	LDMFD sp!, {R4-R10, PC}
	
	;store result subroutine
	;R0 = exponent
	;R1 = fraction
	;R2 = sign of result
	;returns result in R0 (ieee 754 form)
storeResult 
	STMFD SP!, {R4-R8, lr}
	MOV R5, R0 ; exponent
	MOV R6, R1 ; fraction
	MOV R7, R2 ; sign of result
	LDR R8, =0x007FFFFF ;mask for fraction
	AND R6, R6, R8 ;remove leading 1
	MOV R5, R5, LSL#23; shift exponent to correct position
	ORR R6, R6, R5; add in exponents
	CMP R7, #0;	check sign of result base on state
	BEQ posResult
	CMP R7, #1
	BEQ negResult
	CMP R7, #2
	BEQ posResult
	CMP R7, #3
	BEQ negResult
negResult
	LDR R8, =0x80000000
	ORR R6, R6, R8; add in sign
posResult
	MOV R0, R6
	LDMFD sp!, {R4-R8, PC}
	
	END