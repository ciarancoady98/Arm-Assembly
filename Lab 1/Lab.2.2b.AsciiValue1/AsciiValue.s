	AREA	AsciiValue, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R4, ='2'	; Load '2','0','3','4' into R4...R1
	LDR	R3, ='0'	;
	LDR	R2, ='3'	;
	LDR	R1, ='4'	;
	
	LDR R5, =0x30 ; sets r5 to ascii 0
	LDR R6, =1000 ; sets r6 1000
	LDR R7, =100 ; sets r7 100
	LDR R8, =10 ; sets r8 10
		
	
	SUB R4, R4, R5 ; gets 2
	SUB R3, R3, R5 ; gets 0
	SUB R2, R2, R5 ; gets 3
	SUB R1, R1, R5 ; gets 4
	
	MUL R4, R6, R4 ; gets 2000
	MUL R3, R7, R3 ; gets 000
	MUL R2, R8, R2 ; gets 30
	
	ADD R0, R4, R3 ; adds 2000 + 000
	ADD R0, R0, R2 ; adds 2000 + 30
	ADD R0, R0, R1 ; adds 2000 + 30 + 4
	
	; Job Done!
	
	
	
stop	B	stop

	END	