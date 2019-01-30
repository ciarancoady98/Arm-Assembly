	AREA	Divide, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R0, =0	; quotient
	LDR R1, =0	; remainder
	LDR R2, =7	; a
	LDR R3, =2	; b
	MOV R1, R2	; set remainder = a
	
checkifzero
	CMP R0, R3; if (b == 0)
	BEQ endwh 
	
while
	CMP R1, R3	; if (remainder >= b)
	BLT endwh
	ADD R0, R0, #1	; quotient = quotient + 1
	SUB R1, R1, R3	; remainder = remainder - b
	B while

endwh
	

	
stop	B	stop

	END		