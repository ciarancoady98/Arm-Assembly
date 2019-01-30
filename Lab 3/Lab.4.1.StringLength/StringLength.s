	AREA	StringLength, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =str1
	LDR R0, =0; stores length of string
	
while 
	LDRB R2, [R1]; load in value at this address
	CMP R2, #0			; while(value != 0)
	BEQ endwh			; {
	ADD R0, R0, #1		;  lengthOfString++
	ADD R1, R1, #1		;  address++
	B while				; }
endwh

	
stop	B	stop



	AREA	TestData, DATA, READWRITE

str1	DCB	"Friday",0

	END	
