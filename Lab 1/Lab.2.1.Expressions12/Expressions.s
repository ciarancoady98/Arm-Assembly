	AREA	Expressions, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	
	LDR R1, =5; x = 5
	LDR R2, =6; y = 6
	
	MUL R0, R1, R1; x * x
	LDR R3, =3; temp = 3
	MUL R0, R3, R0; 3xSquared
	
	LDR R3, =5; temp = 5
	MUL R3, R1, R3; 5x
	
	ADD R0, R0, R3; 3xSquared + 5x
	
	
	
	
	
	LDR R1, =5; x = 5
	LDR R2, =6; y = 6
	LDR R3, =2; temp = 2
	LDR R4, =6; temp = 6
	LDR R5, =3; temp = 3
	
	MUL R0, R1, R1; x*x
	MUL R0, R3, R0; 2xSquared
	
	MUL R6, R2, R2; y*y
	MUL R6, R5, R6; 6ySquared
	
	ADD R0, R0, R6; 2xSquared + 6ySquared
	
	MUL R7, R1, R2; x*y
	MUL R7, R4, R7; 6xy
	
	ADD R0, R0, R7; 2xSquared + 6xy + 3ySquared
	
	
	
	
	
	LDR R1, =5; x = 5
	LDR R2, =6; y = 6
	LDR R3, =-4; temp = -4
	LDR R4, =3; temp = 3
	LDR R5, =8; temp = 8
	
	MUL R6, R1, R1; x*x
	MUL R0, R6, R1; xCubed
	
	MUL R7, R3, R6; -4xSquared
	ADD R0, R0, R7; xCubed - 4xSquared
	
	MUL R7, R1, R4; 3x
	ADD R0, R0, R7; xCubed - 4xSquared + 3x
	
	ADD R0, R0, R5; xCubed - 4xSquared + 3x + 8
	
	
	
	
	
stop	B	stop

	END	