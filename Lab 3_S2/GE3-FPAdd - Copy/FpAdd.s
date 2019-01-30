	AREA	FpAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	;Tests

	LDR	r0, =0x3F000000		; fpval1 = 0.5 result 0.9375 = 0x3f700000
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
	
	LDR	r0, =0x3F000000		; fpval1 = 0.5    result 0.0625 = 0x3d800000
	LDR	r1, =0xbf000000		; fpval2 = -0.5
	
	LDR R0, =0x40133333     ; fpval1 = 2.3
	LDR	R1, =0xbf000000  	; fpval2 = -0.5
	
	LDR R0, =0x461c400a     ; fpval1 = 10000.01
	LDR	R1, =0x38d1b717 	; fpval2 = 0.0001
	
	LDR R0, =0x461c400a     ; fpval1 = 10000.01
	LDR	R1, =0xb8d1b717 	; fpval2 = -0.0001
	
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
    STMFD sp!,{R4-R12,LR};

    LDR R11,=0; default first positive
	LDR R12,=0; default second positive
	LDR R10,=0; result sign
	MOV R4,R0; store the parameter
	MOV R5,R1; store the parameter
	MOVS R6,R4, LSL #1; check the most significant bit of the 1st number
	BCS firstNegative
back1
    MOVS R6,R5, LSL #1; check the most significant bit of the 2nd number
	BCS secondNegative
back2
     
	CMP R11,#0;
	BNE notBothPositive
	CMP R12,#0;
	BNE notBothPositive
	LDR R10,=0; result = positive
	B addOperation

notBothPositive
    CMP R11,#1;
	BNE notBothNegative
	CMP R12,#1;
	BNE notBothNegative
	LDR R10,=1; result = negative
	B addOperation
	
notBothNegative
  
	
	MOV R0,R4; set parameter
	BL getExponent; call getExponent
	MOV R6,R0;  save exponent in R6
	MOV R0,R5; set parameter
	BL getExponent; call getExponent
	MOV R7,R0; save exponent in R7
	
	CMP R6,R7;
	BEQ compareTheFraction
	CMP R6,R7; compare the exponent
	BGT firstNumberBigger
secondNumberBigger
	MOV R8,R4;
	MOV R4,R5;
	MOV R5,R8;swap two numbers to make sure that abs(firstnumber) is bigger than abs(secondnumber)
	
	CMP R12,#0;
	BEQ setResultPositive;
	B setResultNegative;
back3
    B subtractOperation
	
firstNumberBigger
    CMP R12,#0;
	BEQ setResultNegative;
	B setResultPositive

compareTheFraction
    MOV R0,R4; set parameter
	BL getFraction; call getFraction
	MOV R6,R0;  save exponent in R6
	MOV R0,R5; set parameter
	BL getFraction; call getFraction
	MOV R7,R0; save exponent in R7
	CMP R6,R7; compare the fraction
	BGT firstNumberBigger
	B secondNumberBigger
    
    


setResultPositive
    LDR R10,=0; result = positive
	B back3;
	
setResultNegative
    LDR R10,=1; result = negative
	B back3;
	
addOperation
    MOV R0,R4 ; set parameter
	BL getExponent; get exponent of the first number
	MOV R6,R0; save the exponent
	MOV R0,R5; set parameter
	BL getExponent; get exponent of the second number
	MOV R7,R0; save the exponent
	CMP R6,R7;
	BGT secondshift;
	
	MOV R11,R7; save the bigger expoenent in R11
	SUB R6,R7,R6; get the difference between the two exponents
    MOV R0,R4; set parameter
	BL getFraction; get get fraction of the first number
	MOV R7,R0; save the fraction
	MOV R0,R5; set parameter
	BL getFraction; get fraction of the second number
	MOV R8,R0; save the fraction
	LDR R9,=0x00800000; set value to or
	ORR R7,R9; get 1 back because the number is 1.fraction
	ORR R8,R9; get 1 back because the number is 1.fraction
	MOV R7,R7, LSR R6; shift the smaller number fraction
	B addFraction;
	
	
	
secondshift
    MOV R11,R6; save the bigger expoenent in R11
    SUB R6,R6,R7; get the difference between the two exponents
	MOV R0,R4; set parameter
	BL getFraction; get get fraction of the first number
	MOV R7,R0; save the fraction
	MOV R0,R5; set parameter
	BL getFraction; get fraction of the second number
	MOV R8,R0; save the fraction
	LDR R9,=0x00800000; set value to or
	ORR R7,R9; get 1 back because the number is 1.fraction
	ORR R8,R9; get 1 back because the number is 1.fraction
	MOV R8,R8, LSR R6; shift the smaller number fraction
	B addFraction;

addFraction
    
    ADD R7,R7,R8; 1st fraction + 2nd fraction and store in R7
	MOVS R8,R7, LSL #8; check the 25th bit to see if it's 1
	BCS ExponentAddOne; if the 25th bit equals to 1,fraction LSR 1 exponent add 1
back4
    LDR R9,=0xFF7FFFFF; set value to AND
	AND R7,R9;clear the 24th bit of the fraction result
    MOV R0,R7; set the result fraction
	ORR R0,R11,LSL #23; set the result exponent
	CMP R10,#0; check the sign of the result;
	BNE setFinalResultNegative
	B return;
	
ExponentAddOne
    MOV R7,R7, LSR #1; move right 1 bit
    ADD R11,R11,#1; result exponent
	B back4;
setFinalResultNegative
    LDR R9,=0x80000000; set the value to ORR
	ORR R0,R0,R9; set the most significant bit to 1
	B return;
	
subtractOperation
    MOV R0,R4 ; set parameter
	BL getExponent; get exponent of the first number
	MOV R6,R0; save the exponent
	MOV R0,R5; set parameter
	BL getExponent; get exponent of the second number
	MOV R7,R0; save the exponent
	
	MOV R11,R6; save the bigger expoenent in R11
    SUB R6,R6,R7; get the difference between the two exponents
	MOV R0,R4; set parameter
	BL getFraction; get fraction of the first number
	MOV R7,R0; save the fraction
	MOV R0,R5; set parameter
	BL getFraction; get fraction of the second number
	MOV R8,R0; save the fraction
	LDR R9,=0x00800000; set value to or
	ORR R7,R9; get 1 back because the number is 1.fraction
	ORR R8,R9; get 1 back because the number is 1.fraction
	MOV R8,R8, LSR R6; shift the smaller number fraction
	
	SUB R7,R7,R8; subtract fraction
	MOV R7,R7, LSL #8;shift fraction result 8 bits left
	LDR R9,=0; count=0
checkExponentSubtract
	MOVS R7,R7, LSL #1;shift fraction result 1 bit left
	BCS endCheckExponentSubtract;
	ADD R9,R9,#1; count++
	B checkExponentSubtract
	
endCheckExponentSubtract
	MOV R7,R7,LSR #9;shift fraction result back
	MOV R0,R7;set the result fraction
	B ExponentSubtract;
back5
	ORR R0,R11,LSL #23; set the result exponent
	CMP R10,#0; check the sign of the result;
	BNE setFinalResultNegative
	B return;

ExponentSubtract
    SUB R11,R9; exponent = exponent - shiftNumber/count
	B back5;
	
return
    LDMFD sp!,{R4-R12,PC}
    
	
	
    
	
	
    
	
	
	
	
	
    





; getExpoent subroutine
; get the exponent part of a IEEE754 single precision floating point value
; Parameters:
;   R0: floating point value
; Return value:
;   R0: exponent part of the floating point value
;
getExponent
    STMFD sp!,{R6,R9,LR} ;store local registors;
	MOV R6, R0,LSR #23; get the first number's sign and exponent
	LDR R9,=0xFFFFFEFF; seta value to and
	AND R6,R6,R9; clear the 9th bit of the first number
	MOV R0,R6; return the exponent value in R0
	LDMFD sp!,{R6,R9,PC} ;load local registors;
	
; getFraction subroutine
; get the fraction part of a IEEE754 single precision floating point value
; Parameters:
;   R0: floating point value
; Return value:
;   R0: fraction part of the floating point value
;
getFraction
    STMFD sp!,{R6,R9,LR} ;store local registors;
	MOV R6, R0;save number in R6
	LDR R9,=0x007FFFFF; set value to and
	AND R6,R6,R9; clear the most 9 significant bits to get fraction 
	MOV R0,R6; return the fraction value in R0
	LDMFD sp!,{R6,R9,PC} ;load local registors;
	
    
	
	
	
	
    
    
	
	
    
	

firstNegative
    LDR R11,=1; first is negative
	B back1;

secondNegative
    LDR R12,=1; second is negative
	B back2;



	END
