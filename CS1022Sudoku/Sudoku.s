	AREA	Sudoku, CODE, READONLY
	EXPORT	start
	IMPORT sendchar
	PRESERVE8

start
	
	;
	;Testing for getSquare subroutine
	;
	
	;test first element
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =0;										Row = 0
	;LDR R2, =0;										Column = 0
	;BL getSquare;									getSquare(gridStartAddr, Row, Column)
	
	;test random value
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =4;										Row = 4
	;LDR R2, =2;										Column = 2
	;BL getSquare;									getSquare(gridStartAddr, Row, Column)
	
	;test end of grid
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =8;										Row = 8
	;LDR R2, =8;										Column = 8
	;BL getSquare;									getSquare(gridStartAddr, Row, Column)
	
	;test last column
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =0;										Row = 0
	;LDR R2, =8;										Column = 8
	;BL getSquare;									getSquare(gridStartAddr, Row, Column)
	
	;test last row
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =8;										Row = 8
	;LDR R2, =0;										Column = 0
	;BL getSquare;									getSquare(gridStartAddr, Row, Column)

	;
	;Testing for setSquare subroutine
	;
	
	;test first element
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =0;										Row = 0
	;LDR R2, =0;										Column = 0
	;LDR R3, =9;										newSquareValue = 9
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)
	
	;test random value
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =4;										Row = 4
	;LDR R2, =2;										Column = 2
	;LDR R3, =5;										newSquareValue = 5
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)
	
	;test end of grid
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =8;										Row = 8
	;LDR R2, =8;										Column = 8
	;LDR R3, =0;										newSquareValue = 0
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)
	
	;test last column
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =0;										Row = 0
	;LDR R2, =8;										Column = 8
	;LDR R3, =7;										newSquareValue = 7
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)
	
	;test last row
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =8;										Row = 8
	;LDR R2, =0;										Column = 0
	;LDR R3, =1;										newSquareValue = 1
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)

	;
	; Testing for isValid subroutine
	;
	; Testing isValidRow
	;
	;test invalid result
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =0;										Row = 0
	;LDR R2, =0;										Column = 0
	;LDR R3, =8;										newSquareValue = 9
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)
	;BL isValidRow;
	
	;test valid result
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =4;										Row = 4
	;LDR R2, =2;										Column = 2
	;LDR R3, =5;										newSquareValue = 5
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)
	;BL isValidRow;
	
	;test a value of zero
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =8;										Row = 8
	;LDR R2, =8;										Column = 8
	;LDR R3, =0;										newSquareValue = 0
	;BL setSquare;
	;BL isValidRow;
	
	; Testing isValidColumn
	;
	;test invalid result
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =0;										Row = 0
	;LDR R2, =0;										Column = 0
	;LDR R3, =8;										newSquareValue = 9
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)
	;BL isValidColumn;
	
	;test valid result
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =4;										Row = 4
	;LDR R2, =2;										Column = 2
	;LDR R3, =5;										newSquareValue = 5
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)
	;BL isValidColumn;
	
	;test a value of zero
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =8;										Row = 8
	;LDR R2, =8;										Column = 8
	;LDR R3, =0;										newSquareValue = 0
	;BL setSquare;
	;BL isValidColumn;
	
	;Testing identifySubGrid
	;
	;test first subgrid
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R3, =0;										testCase = 0
	;BL identifySubGrid;
	
	;test second subgrid
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R3, =4;										testCase = 0
	;BL identifySubGrid;
	
	;test third subgrid
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R3, =8;										testCase = 0
	;BL identifySubGrid;
	
	;Testing isValidSubgrid
	;
	
	;test invalid result
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =0;										Row = 0
	;LDR R2, =0;										Column = 0
	;LDR R3, =8;										newSquareValue = 9
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)
	;BL isValidSubgrid;
	
	;test valid result
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =4;										Row = 4
	;LDR R2, =2;										Column = 2
	;LDR R3, =5;										newSquareValue = 5
	;BL setSquare;									getSquare(gridStartAddr, Row, Column, newSquareValue)
	;BL isValidSubgrid;
	
	;test a value of zero
	;LDR	R0, =gridOne;								gridStartAddr
	;LDR R1, =8;										Row = 8
	;LDR R2, =8;										Column = 8
	;LDR R3, =0;										newSquareValue = 0
	;BL setSquare;
	;BL isValidSubgrid;


	;Testing isValid subroutine
	;
	;repeated tests using different grids
	
	;LDR	R0, =testGrid3;								gridStartAddr
	;LDR R1, =0;										Row = 0
	;LDR R2, =0;										Column = 0
	;BL isValid;
	
	;LDR	R0, =testGrid1;								gridStartAddr
	;LDR R1, =4;										Row = 4
	;LDR R2, =2;										Column = 2
	;BL isValid;
	
	;LDR	R0, =testGrid1;								gridStartAddr
	;LDR R1, =8;										Row = 8
	;LDR R2, =8;										Column = 8
	;BL isValid;
	
	;testing printBoard subroutine
	;
	;LDR R0, =board
	;BL printBoard
	
	;testing storeGridToBoard subroutine
	;
	;LDR R0, =testGrid1
	;LDR R1, =board
	;BL storeGridToBoard
	;LDR R0, =board
	;BL printBoard
	
	;LDR R0, =testGrid2
	;LDR R1, =board
	;BL storeGridToBoard
	;LDR R0, =board
	;BL printBoard
	
	;LDR R0, =testGrid3
	;LDR R1, =board
	;BL storeGridToBoard
	;LDR R0, =board
	;BL printBoard
	
	;
	; test sudoku subroutine
	;
	
	LDR R0, =gridOne
	LDR R1, =board
	BL storeGridToBoard
	LDR R0, =board
	BL printBoard
	
	LDR R1, =0
	LDR R2, =0
	LDR	R0, =gridOne
	BL	sudoku
	BL printMessage
	
	LDR R0, =gridOne
	LDR R1, =board
	BL storeGridToBoard
	LDR R0, =board
	BL printBoard

stop	B	stop



; getSquare subroutine
; This takes the index of the desired square and returns the byte sized value in that square
; R0 - start address of the grid
; R1 - row
; R2 - column
; R3 - returns the value in the square

getSquare
	STMFD SP!, {R4-R5, lr}; 								saving stuff to the stack 
	LDR R5, =9; 											row_size
	MUL R4, R1, R5; 										row * row_size
	ADD R4, R4, R2; 										index = (row * row_size) + column
	LDRB R3, [R0, R4]; 										squareValue = memory.byte[gridStartAddr + index]
	LDMFD SP!, {R4-R5, PC};
	



; setSquare subroutine
; This takes the index of the desired square and stores a passed byte sized value in it
; R0 - start address of the grid
; R1 - row
; R2 - column
; R3 - element to be stored in square

setSquare
	STMFD SP!, {R4-R5, lr}; 								saving stuff to the stack 
	LDR R5, =9; 											row_size
	MUL R4, R1, R5; 										row * row_size
	ADD R4, R4, R2; 										index = (row * row_size) + column
	STRB R3, [R0, R4];  									memory.byte[gridStartAddr + index] = squareValue
	LDMFD SP!, {R4-R5, PC};



; isValid subroutine
; takes a row and column of a square and determines if that row, column and subgrid is valid
; R0 - start address of the grid
; R1 - row
; R2 - column

isValid
	STMFD SP!, {R4-R5, lr} ; saving stuff to the stack
	MOV R4, R1
	MOV R5, R2
	BL isValidRow;					if(isValidRow(row, column) && isValidColumn(row, column) && isValidSubgrid(row, column))
	CMP R3, #0;						{
	BEQ notValid;						return true;
	MOV R1, R4
	MOV R2, R5
	BL isValidColumn;				}
	CMP R3, #0;						else
	BEQ notValid;					{
	MOV R1, R4
	MOV R2, R5
	BL isValidSubgrid;					return false;
	CMP R3, #0;						}
	BEQ notValid
	LDR R3, =1
	LDMFD SP!, {R4-R5, pc}
notValid
	LDMFD SP!, {R4-R5, pc}
	


; isValidRow subroutine
; takes a square (row and column) and determines if the row is valid
; R0 - start address of the grid
; R1 - row
; R2 - column

isValidRow
	STMFD SP!, {R4-R9, lr}; 					saving stuff to the stack
	BL getSquare;								square = grid[row][column], (returns square value to R3)
	MOV R4, R1; 								R4 = row
	MOV R5, R2; 								R5 = column
	MOV R6, R3; 								R6 = square
	LDR R7, =9; 								row length = 9
	LDR R9, =1; 								isValidRow = 1;
ifValidRow1
	CMP R6, #0; 								if(square != 0)
	BEQ endifValidRow1;							{
	LDR R8, =0; 								  for(index = 0; index < row_length); index++)
forValidRow							
	CMP R8, R7; 								  {
	BGE endforValidRow
ifValidRow2
	CMP R8, R5; 									if(index != column)
	BEQ endifValidRow2;								{
	MOV R2, R8; 
	BL getSquare; 									  square1 = grid[row][index]
ifValidRow3
	CMP R6, R3; 									  if(square == square1)
	BNE endifValidRow3;								  {
	LDR R9, =0; 										isValidRow = false
	B endifValidRow1;								  }
endifValidRow3;										 }
endifValidRow2;												
	ADD R8, R8, #1;									index++
	B forValidRow;								  }
endforValidRow;									}
endifValidRow1
	MOV R3, R9;									return bool isValidRow
	LDMFD SP!, {R4-R9, PC}; 					restore from the stack



; isValidColumn subroutine
; takes a square (row and column) and determines if the column is valid
; R0 - start address of the grid
; R1 - row
; R2 - column

isValidColumn

	STMFD SP!, {R4-R9, lr}; 					saving stuff to the stack
	BL getSquare;								square = grid[row][column], (returns square value to R3)
	MOV R4, R1; 								R4 = row
	MOV R5, R2; 								R5 = column
	MOV R6, R3; 								R6 = square
	LDR R7, =9; 								column length = 9
	LDR R9, =1; 								isValidColumn = 1;
ifValidColumn1
	CMP R6, #0; 								if(square != 0)
	BEQ endifValidColumn1;						{
	LDR R8, =0; 								  for(index = 0; index < column_length); index++)
forValidColumn							
	CMP R8, R7; 								  {
	BGE endforValidColumn
ifValidColumn2
	CMP R8, R4; 								 	if(index != row)
	BEQ endifValidColumn2;							{
	MOV R1, R8; 
	BL getSquare; 									  square1 = grid[index][column]
ifValidColumn3
	CMP R6, R3; 									  if(square == square1)
	BNE endifValidColumn3;							  {
	LDR R9, =0; 										isValidColumn = false
	B endifValidColumn1;							  }
endifValidColumn3;									}
endifValidColumn2;											
	ADD R8, R8, #1;									index++
	B forValidColumn;							  }
endforValidColumn;								}
endifValidColumn1
	MOV R3, R9;									return bool isValidColumn
	LDMFD SP!, {R4-R9, PC}; 					restore from the stack


; isValidSubGrid subroutine
; takes a square (row and column) and determines if its subgrid is valid
; note: i have named each smaller 3*3 grid within the sudoku board a subgrid, each subgrid then has a start corner denoted by subGridXStart(column) and subGridYStart(row)
; R0 - start address of the grid
; R1 - row
; R2 - column
isValidSubgrid

	STMFD SP!, {R4-R11, lr}
	MOV R3, R1; 								get subGridYStart
	BL identifySubGrid
	MOV R4, R3;									R4 = subGridYStart
	MOV R3, R2;									get subGridXStart
	BL identifySubGrid
	MOV R5, R3;									R5 = subGridXStart
	MOV R6, R4;									R6 = testRow
	MOV R7, R5;									R7 = testCol
	BL getSquare;								testSquare = getSquare(testRow, TestColumn)
	MOV R8, R3;									R8 = testSquare
ifValidSubGrid1
	CMP R8, #0;									if(testSquare != 0)							
	BEQ endIfValidSubGrid1;						{
	MOV R9, R6;									  index1 = testRow
forValidSubGrid1;								  for(index1; index1 < subGridYStart+3; index1++)
	ADD R10, R4, #3;							  {
	CMP R9, R10;
	BGE endforValidSubGrid1;
	MOV R11, R7; 									index2 = testCol
forValidSubGrid2;									for(index2; index2 < subGridXStart+3; index2++)
	ADD R10, R5, #3;								{
	CMP R11, R10;
	BGE endforValidSubGrid2;
	STMFD SP!, {R1-R2};								  storing passed row and column to stack for later comparision
	MOV R1, R9;									
	MOV R2, R11;									  testSquare2 = getSquare(index1, index2)
	BL getSquare;
ifValidSubGrid2
	LDMFD SP!, {R1-R2};								  loading back passed row and column from stack
	CMP R9, R1;										  if(index1 != row || index2 != column)
	BNE ifValidSubGrid3;							  {
	CMP R11, R2;
	BEQ endifValidSubGrid2;
ifValidSubGrid3
	CMP R8, R3;										    if(testSquare == testSquare2)
	BNE endifValidSubGrid3;							    {
	LDR R3, =0;										  	  isValidSubGrid = false;
	B endIfValidSubGrid1;							    }
endifValidSubGrid3;									  }
endifValidSubGrid2;
	
	
	ADD R11, R11, #1;							 	    index2++
	B forValidSubGrid2;							 	}
endforValidSubGrid2
	
	
	MOV R7, R5;										testCol = subGridXStart;
	ADD R9, R9, #1 ; 								index1++
	B forValidSubGrid1;							  }
endforValidSubGrid1
	LDR R3, =1;										isValidSubGrid = true;

endIfValidSubGrid1
	LDMFD SP!, {R4-R11, pc};						return isValidSubGrid
	



; identifySubGrid subroutine
; takes a value R3, and determines what subgrid it is in
; R3 = row/column - testCase

identifySubGrid
	STMFD SP!, {lr};						save link register to the stack
ifIdentifySubGrid1;							
	CMP R3, #6;								if(testCase >= 6)
	BLO ifIdentifySubGrid2;					{
	LDR R3, =6;								  subGridStart = 6;
	B endifIdentifySubGrid1;				}

ifIdentifySubGrid2;							
	CMP R3, #3;								elseif(testCase >= 3)
	BLO ifIdentifySubGrid3;					{				 
	LDR R3, =3;								  subGridStart = 3;
	B endifIdentifySubGrid2;				}

ifIdentifySubGrid3;							else
	LDR R3, =0;									subGridStart = 0;
	
endifIdentifySubGrid1;
endifIdentifySubGrid2;

	LDMFD SP!, {pc};						restore link register to program counter

	

; sudoku subroutine
; takes a sudoku grid and tries to find a solution to it
; R0 = start address of grid
; R1 = row
; R2 = column
;
sudoku
	STMFD SP!, {R4-R9 , lr}
	LDR R4, =0;								 boolean result = false;
	; R5 = nxtcol
	; R6 = nxtrow
	MOV R8, R1;								row
	MOV R9, R2;								column
	
	;precompute next row and col
	ADD R5, R9, #1; 						nxtcol = col + 1
	MOV R6, R8;								nxtrow = row
ifSudoku1
	CMP R5, #8;								if(nxtcol > 8)
	BLE endifSudoku1;						{
	LDR R5, =0;								  nxtcol = 0;
	ADD R6, R6, #1;							  nxtrow++;
	;										}
endifSudoku1

ifSudoku2
	MOV R1, R8
	MOV R2, R9
	BL getSquare;							if(getSquare(grid, row, col) != 0)
	CMP R3, #0;								{
	BEQ elseSudoku2;						
	; a pre-filled square
ifSudoku3									
	CMP R8, #8;								 if(row == 8 && col == 8)
	BNE elseSudoku1;						 {
	CMP R9, #8;								   return true;
	BNE elseSudoku1;						 }
	B returnTrue;							
elseSudoku1
	; nothing to do here - just move on to the next square
	MOV R1, R6;								 else
	MOV R2, R5;								 {
	BL sudoku;								   result = sudoku(grid, nxtrow, nxtcol);
	MOV R4, R3;								 }
	B endifSudoku2;							}
endelseSudoku1
endifSudoku3
elseSudoku2
	; a blank square - try filling it with 1......9
	LDR R7, =1; 							else
forSudoku1
	CMP R7, #9;								{
	BGT endforSudoku1;						  for(byte try = 1; try <= 9 && !result; try++){
	CMP R4, #0;									
	BNE endforSudoku1;							
	MOV R3, R7;
	MOV R1, R8;
	MOV R2, R9;
	BL setSquare;								setSquare(grid, row, col, try);
ifSudoku4
	BL isValid;									if(isValid(grid, row, col))
	CMP R3, #0;									{
	BEQ endifSudoku4;
	; putting the value here works so far...
ifSudoku5
	CMP R8, #8;
	BNE elseSudoku3;
	CMP R9, #8;
	BNE elseSudoku3;							if(row == 8 && col == 8){
	;last square -- success!!
	LDR R4, =1;										result = true;
	B endifSudoku5;								}
elseSudoku3
	;move on to the next square
	MOV R1, R6;									else
	MOV R2, R5;									{
	BL sudoku;			  						  result = sudoku(grid, nxtrow, nxtcol)
	MOV R4, R3;									}
	B endelseSudoku3;						}
endelseSudoku3
endifSudoku5
endifSudoku4
	ADD R7, R7, #1;
	B forSudoku1;							}
endforSudoku1
ifSudoku6
	CMP R4, #0;
	BNE endifSudoku6;
	;made an earlier mistake - backtrack by setting the current square back to zero/blank
	LDR R3, =0;								if(!result){
	MOV R1, R8;									setSquare(grid, row, col, 0);
	MOV R2, R9;								}
	BL setSquare;								
endifSudoku6
endelseSudoku2
endifSudoku2

	MOV R3, R4;
	LDMFD SP!, {R4-R9 , pc};				return result;
	
	
returnTrue
	LDR R3, =1;								result = true;
	LDMFD SP!, {R4-R9 , pc};				return result;
	

; printBoard subroutine
; takes a sudoku board and prints it to the console
; R0 = start address of board
; note - takes a 19*19 array of characters
;

printBoard
	STMFD SP!, {R4-R7, lr}
	LDR R4, =0; 							int rowIndex = 0;
forPrintBoard
	CMP R4, #19;							for(rowIndex; rowIndex<board.columnLength)
	BGE endforPrintBoard
	LDR R5, =0;								int columnIndex = 0;
forPrintBoard2
	CMP R5, #19;							for(columnIndex; columnIndex<board.rowLength)
	BGE endforPrintBoard2
	;System.out.print(board[rowIndex][columnIndex]);
	LDR R6, =19;							row_size
	MUL R6, R4, R6; 						row * row_size
	ADD R6, R6, R5; 						index = (row * row_size) + column
	LDRB R7, [R0, R6];  					characterToPrint = memory.byte[boardStartAddr + index]
	MOV R6, R0;
	MOV R0, R7;
	BL sendchar;							printf(characterToPrint)
	MOV R0, R6;
	ADD R5, R5, #1;							columnIndex++;	
	B forPrintBoard2
endforPrintBoard2
	; System.out.print("\n")
	MOV R6, R0;
	LDR R0, ='\n';
	BL sendchar;							printf("\n")
	MOV R0, R6;
	ADD R4, R4, #1;							rowIndex++;
	B forPrintBoard
endforPrintBoard
	LDMFD SP!, {R4-R7, pc}
	
	
storeGridToBoard
	STMFD SP!, {R4-R9, lr};
	LDR R4, =0;								int gridRow = 0;
	LDR R5, =0;								int gridColumn = 0;
	LDR R6, =1;								int boardRow = 1;
forStoreGridToBoard
	CMP R6, #18;							for(boardRow; boardRow < 18)
	BGE endforStoreGridToBoard;				{
	LDR R7, =1;								  int boardColumn = 1;
forStoreGridToBoard2
	CMP R7, #18;							  for(boardColumn; boardColumn < 18)
	BGE endforStoreGridToBoard2;			  {
ifStoreGridToBoard
	CMP R5, #8;									if(gridColumn > grid.length-1)
	BLE endifStoreGridToBoard;					{
	LDR R5, =0;									  gridColumn = 0;
	ADD R4, R4, #1;								  gridRow++
	;											}
endifStoreGridToBoard
	LDR R8, =9; 							  gridRow_size;
	MUL R8, R4, R8; 						  gridRow * gridRow_size;
	ADD R8, R5, R8; 						  index = (gridRow * gridRow_size) + gridColumn;
	LDRB R8, [R0, R8]; 						  extractedNumber = memory.byte[gridStartAddr + index];
	ADD R8, R8, #0x30;						  //converting integer to ascii
	LDR R9, =19; 							  boardRow_size;
	MUL R9, R6, R9; 						  boardRow * boardRow_size;
	ADD R9, R7, R9; 						  index = (boardRow * boardRow_size) + boardColumn;
	STRB R8, [R1, R9]; 						  memory.byte[boardStartAddr + index] = extractedNumber;
	ADD R5, R5, #1;							  gridColumn++;
	ADD R7, R7, #2;							  boardColumn += 2
	B forStoreGridToBoard2;
endforStoreGridToBoard2
	
	ADD R6, R6, #2;							boardRow += 2;			
	B forStoreGridToBoard;
endforStoreGridToBoard
	LDMFD SP!, {R4-R9, pc}
	
; printMessage subroutine
; Prints if a board is solvable of not
; R3 - bool valid/1 or invalid/0
printMessage
	STMFD SP!, {R4-R7, lr}
	LDR R4, =gridIsSolvable
	LDR R5, =gridIsUnsolvable
	CMP R3, #0;								if(gridSolved)
	BEQ printNotValid;						{
	LDR R6, =0;								 for(int index = 0; letter != 0; index++)
forPrintValid								 
	LDRB R7, [R4, R6];						 {
	CMP R7, #0;									letter = memory.byte(gridIsSolvable + index);
	BEQ endPrintMessage
	MOV R0, R7;									printf(letter);
	BL sendchar;
	ADD R6, R6, #1;
	B forPrintValid;						 }
	;										}
printNotValid
	LDR R6, =0;								else
forPrintNotValid;							{
	LDRB R7, [R5, R6];						 for(int index = 0; letter != 0; index++)
	CMP R7, #0;								 {
	BEQ endPrintMessage;						letter = memory.byte(gridIsNotSolvable + index);
	MOV R0, R7;									printf(letter);
	BL sendchar;							 }
	ADD R6, R6, #1;							}
	B forPrintNotValid;
endPrintMessage
	LDMFD SP!, {R4-R7, pc}



	AREA	Grids, DATA, READWRITE

gridOne
		DCB	7,9,0,0,0,0,3,0,0
    	DCB	0,0,0,0,0,6,9,0,0
    	DCB	8,0,0,0,3,0,0,7,6
    	DCB	0,0,0,0,0,5,0,0,2
    	DCB	0,0,5,4,1,8,7,0,0
    	DCB	4,0,0,7,0,0,0,0,0
    	DCB	6,1,0,0,9,0,0,0,8
    	DCB	0,0,2,3,0,0,0,0,0
    	DCB	0,0,9,0,0,0,0,5,4
		
testGrid1
		DCB	8,9,0,0,0,0,3,0,0
    	DCB	0,0,0,0,0,6,9,0,0
    	DCB	8,0,0,0,3,0,0,7,6
    	DCB	0,0,0,0,0,5,0,0,2
    	DCB	0,0,5,4,1,8,7,0,0
    	DCB	4,0,0,7,0,0,0,0,0
    	DCB	6,1,0,0,9,0,0,0,8
    	DCB	0,0,2,3,0,0,0,0,0
    	DCB	0,0,9,0,0,0,0,5,4	

testGrid2
		DCB	7,9,0,0,0,0,3,0,0
    	DCB	0,0,0,0,0,6,9,0,0
    	DCB	8,0,0,0,3,0,0,7,6
    	DCB	0,0,0,0,0,5,0,0,2
    	DCB	0,0,5,4,1,8,7,0,0
    	DCB	4,0,0,7,0,0,0,0,0
    	DCB	6,1,0,0,9,0,0,0,8
    	DCB	0,0,2,3,0,0,0,0,0
    	DCB	0,0,9,0,0,0,0,5,4
		
testGrid3
		DCB	0,0,0,0,0,0,0,0,0
    	DCB	0,0,0,0,0,0,0,0,0
    	DCB	0,0,0,0,0,0,0,0,0
    	DCB	0,0,0,0,0,0,0,0,0
    	DCB	0,0,0,0,0,0,0,0,0
    	DCB	0,0,0,0,0,0,0,0,0
    	DCB	0,0,0,0,0,0,0,0,0
    	DCB	0,0,0,0,0,0,0,0,0
    	DCB	0,0,0,0,0,0,0,0,0
		
gridIsSolvable
		DCB "This grid is solvable","\n",0
		
gridIsUnsolvable
		DCB "This grid is unsolvable","\n",0
		
board
		DCB	'-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-'
    	DCB	'|', ' ','|', ' ', '|', ' ', '|', ' ', '|', ' ', '|', ' ', '|',' ', '|', ' ', '|', ' ', '|'
    	DCB	'|','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','|'
    	DCB	'|', ' ','|', ' ', '|', ' ', '|', ' ', '|', ' ', '|', ' ', '|',' ', '|', ' ', '|', ' ', '|'
    	DCB	'|','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','|'
    	DCB	'|', ' ','|', ' ', '|', ' ', '|', ' ', '|', ' ', '|', ' ', '|',' ', '|', ' ', '|', ' ', '|'
    	DCB	'|','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','|'
    	DCB '|', ' ','|', ' ', '|', ' ', '|', ' ', '|', ' ', '|', ' ', '|',' ', '|', ' ', '|', ' ', '|'
    	DCB	'|','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','|'
		DCB '|', ' ','|', ' ', '|', ' ', '|', ' ', '|', ' ', '|', ' ', '|',' ', '|', ' ', '|', ' ', '|'
		DCB	'|','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','|'
		DCB '|', ' ','|', ' ', '|', ' ', '|', ' ', '|', ' ', '|', ' ', '|',' ', '|', ' ', '|', ' ', '|'
		DCB	'|','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','|'
		DCB '|', ' ','|', ' ', '|', ' ', '|', ' ', '|', ' ', '|', ' ', '|',' ', '|', ' ', '|', ' ', '|'
		DCB	'|','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','|'
		DCB '|', ' ','|', ' ', '|', ' ', '|', ' ', '|', ' ', '|', ' ', '|',' ', '|', ' ', '|', ' ', '|'
		DCB	'|','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','|'
		DCB '|', ' ','|', ' ', '|', ' ', '|', ' ', '|', ' ', '|', ' ', '|',' ', '|', ' ', '|', ' ', '|'
		DCB	'-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-'
	;
	; add other grids for test cases
	;

	END
