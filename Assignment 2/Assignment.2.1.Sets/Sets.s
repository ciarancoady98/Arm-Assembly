	AREA	Sets, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R0, =ASize; 
	LDR R0, [R0]; number of elements in a
	LDR R1, =AElems; first element address a
	LDR R2, =BSize; number of elements in b
	LDR R3, [R2]; temp b count
	LDR R4, =BElems; start address of b 
	MOV R5, R4; temp address of b
	LDR R8, =0; c count
	LDR R9, =CElems; start address of c
	
	CMP R0, #0
	BEQ storeSize
	CMP R2, #0
	BEQ storeSize
	
whA
	LDR R6, [R1]; takes element of a
	CMP R0, #0; are we at the end of set a
	BEQ bCheck;
	
whA2
	LDR R7, [R5]; get element from b
	CMP R6, R7;  is a == b
	BEQ notUniqueA
	CMP R3, #0; have we reached the end of b
	BEQ uniqueA
	ADD R5, R5, #4; move b on to next number
	SUB R3, R3, #1; b counter--
	B whA2
	
notUniqueA
	ADD R1, R1, #4; move a on to next number
	SUB R0, R0, #1; a counter--
	LDR R3, [R2]; reset b counter
	MOV R5, R4; reset b address
	B whA
	
uniqueA
	ADD R8, R8, #1; c counter++
	STR R6, [R9]; store element to memory
	ADD R9, R9, #4; move c on to next number slot
	ADD R1, R1, #4; move a on to next number
	SUB R0, R0, #1; a counter--
	LDR R3, [R2]; reset b counter
	MOV R5, R4; reset b address
	B whA
	
bCheck	
	LDR R0, =BSize; 
	LDR R0, [R0]; number of elements in b
	LDR R1, =BElems; first element address a
	LDR R2, =ASize; number of elements in a
	LDR R3, [R2]; temp a count
	LDR R4, =AElems; start address of a	
	MOV R5, R4; temp address of a
	
whB
	LDR R6, [R1]; takes element of b
	CMP R0, #0; are we at the end of set b
	BEQ storeSize;
	
whB2
	LDR R7, [R5]; get element from a
	CMP R6, R7;  is a == b
	BEQ notUniqueB
	CMP R3, #0; have we reached the end of a
	BEQ uniqueB
	ADD R5, R5, #4; move a on to next number
	SUB R3, R3, #1; a counter--
	B whB2
	
notUniqueB
	ADD R1, R1, #4; move b on to next number
	SUB R0, R0, #1; b counter--
	LDR R3, [R2]; reset a counter
	MOV R5, R4; reset a address
	B whB
	
uniqueB
	ADD R8, R8, #1; c counter++
	STR R6, [R9]; store element to memory
	ADD R9, R9, #4; move c on to next number slot
	ADD R1, R1, #4; move b on to next number
	SUB R0, R0, #1; b counter--
	LDR R3, [R2]; reset a counter
	MOV R5, R4; reset a address
	B whB	

	
storeSize
	LDR R7, =CSize
	STR R8, [R7]; store size of c

	


stop	B	stop


	AREA	TestData, DATA, READWRITE
	
ASize	DCD	6			; Number of elements in A
AElems	DCD 13,9,1,20,5,8	; Elements of A

BSize	DCD	6			; Number of elements in B
BElems	DCD	13,9,1,20,5,8		; Elements of B

CSize	DCD	0			; Number of elements in C
CElems	SPACE	56			; Elements of C

	END	
