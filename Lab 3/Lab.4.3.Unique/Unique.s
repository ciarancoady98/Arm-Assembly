	AREA	Unique, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR	R1, =VALUES
	LDR R2, =COUNT
	LDR R2, [R2]
	ADD R3, R1, #4; 2nd loop start address
	SUB R4, R2, #1; 2nd loop count
	
while
	LDR R5, [R1]		; get number to check
	CMP R2, #0			; while (count != 0)
	BEQ endSequence		; {
	ADD R1, R1, #4		;  move onto next number in sequence
	SUB R2, R2, #1		;  count--
						;  }
numberCheck
	LDR R6, [R3]					; get number to compare to 
	CMP R6, R5						; while (number to check != next number && count != 0)
	BEQ thereIsADuplicateNumber		; {
	CMP R4, #0						;  move onto next comparison number
	BEQ endNumberCheck				;  count2--
	ADD R3, R3, #4					; }
	SUB R4, R4, #1					;
	B numberCheck					;
	
endNumberCheck
	ADD R3, R1, #4					; reset noth count2 & address for next number
	SUB R4, R2, #1					;
	B while							;
	
thereIsADuplicateNumber
	LDR R0, =0						; if a number occurs more than once 
	B endwh							; put 0 in R0
	
endSequence
	LDR R0, =1						; if all numbers are unique
	B endwh							; put 1 in R1
	
endwh
	
stop	B	stop


	AREA	TestData, DATA, READWRITE
	
COUNT	DCD	10
VALUES	DCD	1, 5, 7, 3, 13, 4, 18, 8, 9, 12


	END	