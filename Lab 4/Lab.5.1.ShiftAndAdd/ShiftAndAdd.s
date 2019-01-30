	AREA	ShiftAndAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R0, =0; where result goes
	LDR	R1, =9; first number
	LDR	R2, =10; second number
	LDR R3, =0; count
	LDR R4, =0; is the digit that falls off a 1 or a 0

	
while
	CMP R1, #0; if (first number == 0
	BEQ endwh;     end while loop
	AND R4, R1, #0x00000001; clears all digits except last one
	MOV R1, R1, LSR	#1; shift first number to the right
	CMP R4, #0;        if (number that fell off == 0)
	BEQ notMultiplying;    no need to add in more to result
	B multiply;            need to add in more to result depending on value of count
	
multiply
	ADD R0, R0, R2, LSL R3; shift second number across by count and add to result
	ADD R3, R3, #1; count++
	B while

notMultiplying
	ADD R3, R3, #1; count++
	B while
	
endwh
	
	
	

	
stop	B	stop


	END	
	