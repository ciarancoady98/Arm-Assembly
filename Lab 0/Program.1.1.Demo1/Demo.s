	AREA	Demo, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	MOV	R0, R1
	ADD	R0, R0, R2
	ADD	R0, R0, R3
	ADD	R0, R0, R4

stop
	B	stop

	END	