	AREA	DisplayResult, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	LDR R6, =10		; fixed value of 10 used when adding in a new number
	LDR R4, =0		; where the number being worked on is stored
	LDR R7, =0x30	; ascii code for 0
	LDR R12, =0		; stores pending operation
	LDR R5, =0		; total / end result
	

read
	BL	getkey		; read key from console
	CMP R12, #0x0D  ; if (enter is the pending operation)
	BEQ endcode 	; jump to end of the code
	CMP	R0, #0x0D  	; if (enter is pressed by the user)
	BEQ	endRead		; finished reading numbers
	BL	sendchar	; display number in r0 to the console
	
	CMP R0, #0x2B	; if(+ pressed)
	BEQ firstnumbercheck;
	CMP R0, #0x2D	; if(- pressed)
	BEQ firstnumbercheck;
	CMP R0, #0x2A	; if(* pressed)
	BEQ firstnumbercheck; 
	

	CMP R4, #0		; while (number being worked on != 0)
	BEQ firstnumber	; {					
	B addnumber     ;	go to add number function
					; }
					; else
					; {
					;  this is the first number being worked on
					; }
					

firstnumber
	SUB R4, R0, R7;		converts user input to decimal and makes the result 
	B read;				into the new number being worked on
	
addnumber
	MUL R11, R4, R6; takes the existing number and multiplies it by 10 stores it in temp location
	SUB R4, R0, R7;	 converts new number to decimal
	ADD R4, R11, R4; adds new number and number in temp location
	
	B	read
	
endRead



firstnumbercheck
	CMP R12, #0				; if (this is the first number)
	BNE operationchecker	;
							; {
	ADD R5, R4, R5			;  total = new number
	MOV R12, R0				;  pending operation = user entered operation
	LDR R4, =0				;  number being worked on = 0
							;  }
							;  else
							;  {
							;  check what operation we should be doing
							;  }
	B read
	
operationchecker
	CMP R12, #0x2B			; plus
	BEQ addition
	CMP R12, #0x2D			; minus
	BEQ subtraction
	CMP R12, #0x2A			; multiply
	BEQ multiplication
	CMP R12, #0x0D			; enter
	BEQ endcode
	
addition
	ADD R5, R5, R4			; total = total + number being worked on
	LDR R4, =0				; number being worked on = 0
	MOV R12, R0				; put operation in r0
	B read

subtraction
	SUB R5, R5, R4			; total = total - number being worked on
	LDR R4, =0				; number being worked on = 0
	MOV R12, R0				; put operation in r0
	B read

multiplication
	MUL R5, R4, R5			; total = total * number being worked on
	LDR R4, =0				; number being worked on = 0
	MOV R12, R0				; put operation in r0
	B read

endcode

	
	LDR R6, =1; test divisor
	LDR R7, =0; actual divisor
	LDR R8, =10; used to multiply
	LDR R9, =0; quotient
	
	LDR R0, =0x3D; displays the equals symbol
	BL sendchar


initialzero
	CMP R5, #0			; if (result of operator = 0)
	BNE getdivisor		;	{
	LDR R0, =0x30		;	output 0 to console
	BL sendchar			;	end program
	B finish			;	}
						;   else
						;	start code to display the number
						;
getdivisor
	CMP R5, R6		; while (result >= testdivisor)
	BLO divide		; {
	MOV R7, R6		;  divisor = testdivisor
	MUL R6, R8, R6	;  testdivisor = testdivisor *10
	B getdivisor	; }
	
divide 
	CMP R5, R7		; while (number >= divisor)
	BLO display		; {
	SUB R5, R5, R7	;  number = number - divisor
	ADD R9, R9, #1	;  quotient = quotient +1
	B divide		; }
	
display
	MOV R11, R7			; temp divisor store
	ADD R0, R9, #0x30	; convert digit to diplay to ascii
	BL sendchar
	
	LDR R10, =0			; new divisor quotient
	

getnextdivisor
	CMP R11, #0			; while (temp divisor != 0)
	BEQ zerocheck		; {
	SUB R11, R11, R8	;  temp divisor = temp divisor - 10
	ADD R10, R10, #1	;  new divisor = new divisor + 1
	B getnextdivisor	; }
	
zerocheck
	CMP R10, R5			; if (new divisor > number)
	BLS reset			; {
	LDR R0, =0x30		;  display a zero in the console
	BL sendchar			;  temp divisor = new divisor
	MOV R11, R10		;  new divisor = 0
	LDR R10, =0			; }
	B getnextdivisor	;
	
reset
	LDR R9, =0			; resets registry values then starts back to display other digits
	LDR R7, =0			;
	LDR R6, =1			;
	B getdivisor		;

finish
	


	
stop	B	stop

	END	