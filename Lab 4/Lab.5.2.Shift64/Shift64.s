	AREA	Shift64, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =0x13131313
	LDR	R1, =0x13131313
	LDR	R2, =8 ; number to shift by
	LDR	R3, =0 ; mask for carry bit
	
	CMP R2, #0;				if(count<0)
	BLT negativeCounter;		go to negative counter
	
positiveCount
	CMP R2, #0;					if(count = 0)
	BLE endwh;					 stop shifting
	MOV R0, R0, LSR	#1;			shift least sig half right by 1
	AND R3, R1, #0x00000001;    get the last bit of most sig half
	MOV R3, R3, LSL #31;        rearrange this mask to be in the right position to be added on
	MOV R1, R1, LSR #1;         shift most sig half right by 1
	ORR R0, R0, R3;				add on "carry" bit
	SUB R2, R2, #1;				counter--
	B positiveCount
	
negativeCount
	CMP R2, #0;					if(count = 0)
	BLE endwh;					 stop shifting
	MOV R1, R1, LSL	#1;			shift most sig half left by one
	AND R3, R0, #0xE0000000;	get the first bit of least sig half
	MOV R3, R3, LSR #31;		rearrange this mask to be in the right position to be added on
	MOV R0, R0, LSL #1;			shift least sig half left by 1		
	ORR R1, R1, R3;				add on "carry" bit
	SUB R2, R2, #1;				counter--
	B negativeCount
	
negativeCounter
	SUB R2, R2, #0x00000001;	counter - 1 bit
	LDR R4, =0xFFFFFFFF;		invert mask
	EOR R2, R2, R4;				invert bits
	B negativeCount
	
endwh
	
stop	B	stop


	END
		