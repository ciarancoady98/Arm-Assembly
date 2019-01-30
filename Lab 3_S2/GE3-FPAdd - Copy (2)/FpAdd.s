	AREA	FpAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	;
	; Part 1 - decode
	;

	LDR	r0, =0x3F000000		; fpval1 = 0.5
	LDR	r1, =0x3EE00000		; fpval2 = 0.4375

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
	STMFD SP!, {R4-R7 ,lr}
	MOV R4, R0
	MOV R5, R1
	BL getFraction
	MOV R6, R3
	MOV R0, R4
	BL getExponent
	MOV R7, R3
	MOV R0, R5
	BL getFraction
	MOV R8, R3
	MOV R0, R5
	BL getExponent
	MOV R2, R3
	MOV R0, R8
	MOV R3, R7
	MOV R1, R6
	BL bringToSamePower
	BL addNumbers
	BL storeResult
	
	LDMFD SP!, {R4-R7, PC}
	
	
	
	
	
	
	
;get fraction subroutine
;takes a number in R0
;returns fraction in R3

getFraction
	STMFD SP!, {R4-R6, lr}
	LDR R5, =0x007FFFFF ;mask for fraction
	AND R4, R0, R5 ;get fraction
	ORR R4, R4, #0x00800000 ;reintroduce 1
	MOVS R6, R0, LSL#1;
	BCC notNegative
	MVN R4, R4
	ADD R4, R4, #1
notNegative
	MOV R3, R4;
	LDMFD SP!, {R4-R6, pc}
	
;get exponent subroutine
;takes a number in R0
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
	B endnumOneBigger
numOneBigger
	MOV R4, R2; R4 = num1 exponent
	MOV R5, R3; R5 = num2 exponent
	MOV R6, R0; R6 = num1 fraction
	MOV R7, R1; R7 = num2 fraction
endnumOneBigger
	SUB R8, R4, R5; adjustAmount = biggerExponent - smallerExponent
	MOV R7, R7, LSR R8; adjust smaller number fraction
	ADD R5, R5, R8; adjust smaller number exponent
	MOV R2, R4
	MOV R3, R5
	MOV R0, R6
	MOV R1, R7
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
	LDR R9, =0
	MOV R10, R8
countLeadingZeros
	MOVS R10, R10, LSL#1
	BCS endLeadingZeros
	ADD R9, R9, #1
	B countLeadingZeros
endLeadingZeros
	LDR R10, =8
	SUB R9, R10, R9
	MOV R8, R8, LSR R9
	ADD R4, R4, R9
	
	LDR R10, =127
	ADD R4, R4, R10
	MOV R0, R4
	MOV R1, R8
	LDMFD sp!, {R4-R10, PC}
	
	;store result subroutine
	;R0 = exponent
	;R1 = fraction
	;returns result in R0 (ieee 754 form)
storeResult 
	STMFD SP!, {R4-R6, lr}
	MOV R5, R0 ; exponent
	MOV R6, R1 ; fraction
	LDR R7, =0x007FFFFF ;mask for fraction
	AND R6, R6, R7 ;remove leading 1
	MOV R5, R5, LSL#23
	ORR R6, R6, R5
	MOV R0, R6
	LDMFD sp!, {R4-R6, PC}
	
	END