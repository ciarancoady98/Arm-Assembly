	AREA	Lotto, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =TICKETS; start address of tickets
	LDR R2, =COUNT; address of number of tickets
	LDR R2, [R2]; number of tickets
	LDR R3, =DRAW; start address of draw numbers
	MOV R4, R3; temp start address of draw numbers 
	LDR R7, =6; count of digits in draw numbers
	LDR R8, =0; number of matches
	LDR R9, =6; count of digits in ticket being checked
	
wh1
	CMP R2, #0				; check if we've run out of tickets
	BEQ endwh1				;
	CMP R9, #0				; check have we gotten to the end of the current ticket
	BEQ endOfTicket			; else
	LDRB R5, [R1]			; load in digit to be checked

wh2
	CMP R7, #0				; check have we gotten to end of draw
	BEQ noMatch				;
	LDRB R6, [R4]			;
	CMP R5, R6				; does the number from ticket match draw
	BEQ match				; else
	ADD R4, R4, #1			; temp address++
	SUB R7, R7, #1			; draw count--
	B wh2					;
	
match
	ADD R8, R8, #1			; number of matches++
	MOV R4, R3				; reset temp address
	ADD R1, R1, #1			; ticket address++
	SUB R9, R9, #1			; digits of ticket--
	LDR R7, =6				; reset draw count
	B wh1					;
	
noMatch
	MOV R4, R3				; reset temp address
	ADD R1, R1, #1			; ticket address++
	SUB R9, R9, #1			; digits of ticket--
	LDR R7, =6				; reset draw count
	B wh1					;
	
endOfTicket
	LDR R9, =6				; reset digits in ticket
	SUB R2, R2, #1			; ticket count--
	CMP R8, #4				; checks if 4 matches were made
	BEQ match4				;
	CMP R8, #5				; checks if 5 matches were made
	BEQ match5				;
	CMP R8, #6				; checks if 6 matches were made
	BEQ match6				;
	LDR R8, =0				; else reset match counter
	B wh1					;
	
match4
	LDR R10, =MATCH4		; load match 4 address
	LDR R11, [R10]			;
	ADD R11, R11, #1		; add 1 to match 4
	STRB R11, [R10]			; store result back to main memory
	LDR R8, =0				; reset match counter
	B wh1					;
	
match5
	LDR R10, =MATCH5		; load match 5 address
	LDR R11, [R10]			; 
	ADD R11, R11, #1		; add 1 to match 5
	STRB R11, [R10]			; store result back to main memory
	LDR R8, =0				; reset match counter
	B wh1					;
	
match6
	LDR R10, =MATCH6		; load match 6 address
	LDR R11, [R10]			; 
	ADD R11, R11, #1		; add 1 to match 6
	STRB R11, [R10]			; store result back to main memory
	LDR R8, =0				; reset match counter
	B wh1					;
	
endwh1	
	
	
	
	
	
	

stop	B	stop 



	AREA	TestData, DATA, READWRITE
	
COUNT	DCD	3			; Number of Tickets
TICKETS	DCB	10, 11, 12, 22, 26, 31	; Tickets
	DCB	10, 11, 12, 22, 27, 32
	DCB	10, 11, 12, 22, 26, 30

DRAW	DCB	10, 11, 12, 22, 26, 30	; Lottery Draw

MATCH4	DCD	0
MATCH5	DCD	0
MATCH6	DCD	0

	END	
