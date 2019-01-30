	AREA	StringReverse, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =strSrc; address of string
	LDR	R2, =strDst; address where reverse is to be stored

	MOV R3, R1; backing up start address of string
	LDR R4, =0; loading zero for use later
	
while 
	LDRB R5, [R1]		; while (letter != 0)
	CMP R5, #0			; {
	BEQ endwh			;  srcAddr = srcAddr + 1
	ADD R1, R1, #1		;  desAddr = desAddr + 1
	ADD R2, R2, #1		; }
	B while				;		
endwh
	
	MOV R1, R3			; scrAddr = backup of start address
	STRB R4, [R2]		; put a null end in destination
	
reverse
	LDRB R5, [R1]		; while (letter !=0)
	CMP R5, #0			; {
	BEQ endReverse		;  srcAddr = srcAddr + 1
	ADD R1, R1, #1		;  desAddr = desAddr - 1
	SUB R2, R2, #1		;  }
	B reverse			;
	
endReverse

stop	B	stop


	AREA	TestData, DATA, READWRITE


strSrc	DCB	"hello",0
strDst	SPACE	128

	END	