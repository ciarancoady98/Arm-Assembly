	AREA	BubbleSort, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R4, =testarr	;
	LDR	R5, =N			;
	MOV R0, R4 			;
	MOV	R1, R5			;
	
	BL sort				; Branch to sort subroutine
stop	B	stop
;sort subrotuine
;determines which integers in an array will be swapped
;parameters: 	R0 start address of test array
;				R1 = N
;
sort
	STMFD sp!, {R4-R7,lr}	;R4-R7 used for local variables
	LDR R4, =1				;swapped = true
wh1							;
	CMP R4, #1				;while(swapped == true){
	BNE endsort				;
	LDR R4, =0				;swapped = false
	LDR R5, =1				;i =1
for							;
	CMP R5, R1				;for(i=1;i<N;i++){
	BGE endfor	
	SUB R6, R5, #1			;i-1 = i-1
	MOV R2, R6				;move i-1 into a parameter variable
	MOV R3, R5				;move i into a parameter variable
	LDR R6, [R0, R6, LSL #2];array[i-1]
	LDR R7, [R0, R5, LSL #2];array[i]
if1
	CMP R6, R7				;if(array[i-1] > array[i]){
	BLS endif1				;
	BL swap					;Branch to swap subroutine
	MOV R4, #1				;swapped = true
endif1						;}
	ADD R5, R5, #1			;
	B for					;}
endfor						
	B wh1					;}
endsort
	LDMFD sp!, {R4-R7,PC}	;restore registers

;swap subroutine
;swaps two elements of a 1 dimensional array
;parameters:
;R0 = array address
;R2 = i-1
;R3 = i

swap
	STMFD sp!,{R4-R5,lr}		;store registers used for local variables
	LDR R4,[R0, R2, LSL #2]		;array[i-1] = Memory.word[testArray +((i-1)*4)]
	LDR R5,[R0, R3, LSL #2]		;array[i] == Memory.word[testArray +(i*4)]
	STR R5,[R0, R2, LSL #2]		;Memory.word[testArray + ((i-1)*4)] = array[i]
	STR R4,[R0, R3, LSL #2]		;Momory.word[testtArray + (i*4)] =array[i-1]
	LDMFD sp!, {R4-R5,PC}		;restore registers


	AREA	TestData, DATA, READWRITE
N	EQU	10
testarr	DCD	3,9,2,1,8,0,7,4,9,6
	END