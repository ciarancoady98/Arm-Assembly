	AREA	GCD, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R2, =32 ; a
	LDR R3, =24 ; b
	
while
	CMP R2, R3 ; if (a != b)
	BEQ endwh 
if
	CMP R2, R3 ; if (a >= b)
	BLS else
	SUB R2, R2, R3 ; a = a - b
	B endif
	
else 
	SUB R3, R3, R2 ; b = b - a 
	MOV R0, R3 ; move result to r0
endif
	B while
endwh

	
stop	B	stop

	END	