	AREA	ArrayMove, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =array
	LDR	R1, =N
	LDR	R2, =3		; move from index 
	LDR	R3, =6		; move to index
	
	LDR R4, [R0, R2, LSL #2] ;numberToMove = array[indexFrom]
if				
	CMP R2, R3		;if (indexFrom != indexTo)
	BEQ endall		;{
if2					;	
	CMP R2, R3		;	if( indexFrom > indexTo)
	BLO if3			;	{
	LDR R7, =-1		;		directionToMove = -1
	B wh1			;	}	
if3 				;	if (indexFrom < indexTo){
	LDR R7, =1		;		directionToMove = 1}
wh1					
	CMP R2, R3		;	while (indexFrom != indexTo)
	BEQ endwh		;	{
	ADD R6, R2, R7				; nextIndex = indexFrom + directionToMove
	LDR R5, [R0, R6, LSL #2]	; shiftingNumber = array[nextIndex]
	STR R5, [R0, R2, LSL #2]	; array[indexFrom] shiftingNumber
	ADD R2, R2, R7				; indexFrom += directionToMove
	B wh1						;}
endwh
	
	STR R4, [R0, R3, LSL#2]		;array[indexTo] = numberToMove
								;
endall				;}
	
stop	B	stop


	AREA	TestArray, DATA, READWRITE

N	equ	9
array	DCD	7,2,5,9,1,3,2,3,4

	END	