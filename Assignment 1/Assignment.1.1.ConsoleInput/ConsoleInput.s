	AREA	ConsoleInput, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	LDR R6, =10; 
	LDR R4, =0;
	LDR R5, =0x30; ascii code for 0

read
	BL	getkey		; read key from console
	CMP	R0, #0x0D  	; while (key != CR)
	BEQ	endRead		; {
	BL	sendchar	;   echo key back to console
		
while	
	CMP R4, #0			; if (first number entered)
	BEQ firstnumber		; 
	B addnumber			;  

firstnumber
	SUB R4, R0, R5		; covert from ascii and store in r4
	B read				;
addnumber
	MUL R7, R4, R6		; total = total *10
	SUB R4, R0, R5		; convert number inputted from ascii and store in r4
	ADD R4, R7, R4		; total = total + number inputted
	
	B	read		
endRead

stop	B	stop

	END	