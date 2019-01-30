	AREA	Countdown, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =cdWord	; Load start address of word
	LDR	R2, =cdLetters	; Load start address of letters
	LDR R9, =0x7B; loads { as blanking character
	
wh1
	LDRB R3, [R1]; loads in first character of word
	CMP R3, #0x61; //
	BLT endofword; //
	CMP R3, #0x7A; //
	BGT endofword; checking if we've gotten to the end of the word 
	
	MOV R4, R2			; temp start address of letters
	
wh2 
	LDRB R5, [R4]		; //
	CMP R5, #0x61		; //
	BLT endwh2			; //
	CMP R5, #0x7B		; //
	BGT endwh2			; end if gotten to end of letters
	CMP R5, R3			; if(letter of word == letter in list)
	BEQ match			;  go to match block of code
	ADD R4, R4, #1		;  else
	B wh2				;	temp address++
	
endwh2
	LDR R0, =0			; word cannot be formed
	B finished			;
	
endofword
	LDR R0, =1			; word can be formed
	B finished			;
	
match 
	STRB R9, [R4]		; if(match == true)
	ADD R1, R1, #1		;  replace that number with blanking character
	B wh1				;
	
finished


stop	B	stop



	AREA	TestData, DATA, READWRITE
	
cdWord
	DCB	"longerthanlist",0

cdLetters
	DCB	"longertha",0
	
	END	
