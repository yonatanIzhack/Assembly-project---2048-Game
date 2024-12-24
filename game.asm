.386
IDEAL
MODEL small
STACK 100h
DATASEG

arr 	   dw 16 dup (0)				; array of the tile values ​​according to their location

thousands  db "0$"						; the thousands are in the user's score
hundreds   db "0$"						; the hundreds are in the user's score
tens 	   db "0$"						; the tens are in the user's score
units	   db "0$"						; the units are in the user's score

scoreText  db 'score: $'				; contains the string 'score: '
score 	   dw 0							; contains user score initialized to 0
	
returnLine dw ? 						; The line the code comes back to in the end of the function
X          dw 0							; Contains an X location of a file
Y          dw 0							; Contains an Y location of a file

; Screen list
ruleScreen db 'rules.bmp' , 0
gameScreen db 'start.bmp', 0
homeScreen db 'home.bmp'  , 0
winScreen  db 'win.bmp'   , 0
loseScreen db 'lose.bmp'  , 0

; tiles list
img2       db '2.bmp'    , 0
img4       db '4.bmp'    , 0
img8       db '8.bmp'    , 0
img16      db '16.bmp'   , 0
img32      db '32.bmp'   , 0
img64      db '64.bmp'   , 0
img128     db '128.bmp'  , 0
img256     db '256.bmp'  , 0
img512     db '512.bmp'  , 0
img1024    db '1024.bmp' , 0
img2048    db '2048.bmp' , 0

; bmp variables 
filehandle dw ? 						
Header 	   db 54 dup (0)				; At the beginning of the header are the "BM" characters that indicate the file is In BMP format.
Palette    db 256*4 dup (0)				; 256 colors, each color occupies four bytes
ScrLine    db 320 dup (0) 				; screen length
ErrorMsg   db 'Error', 13, 10,'$'		; contains error messege

; the game board is like:
;    1  2  3  4
; A |A1|A2|A3|A4|   
; B |B1|B2|B3|B4| 
; C |C1|C2|C3|C4|  
; D |D1|D2|D3|D4|

; the vertical position of the values
POSITION_A equ 5
POSITION_B equ 46
POSITION_C equ 87
POSITION_D equ 128

; the horizontal position of the values
POSITION_1 equ 79
POSITION_2 equ 120
POSITION_3 equ 161
POSITION_4 equ 202

; button locations edges
TOP_EDGE_BUTTONS 	equ 163 			; the top edge of the buttons
BOTTOM_EDGE_BUTTONS equ 193				; the bottom edge of the buttons

LEFT_EDGE_BTN1 		equ 8				; the left edge of the first button
RIGHT_EDGE_BTN1 	equ 81				; the right edge of the first button

LEFT_EDGE_BTN2 		equ 126   			; the left edge of the second button
RIGHT_EDGE_BTN2 	equ 199				; the right edge of the second button

LEFT_EDGE_BTN3 		equ 238				; the left edge of the third button
RIGHT_EDGE_BTN3 	equ 311				; the right edge of the third button

CLOCK 				equ es:6Ch 

macro closeFileMac						; closes the file, because more than 15 files are not possible
	mov ah,3Eh
	mov bx, [filehandle]
	int 21h
endm

; each macro draws a square in a different location
macro drawA1Mac
	call ReadHeader
	call ReadPalette
	call CopyPal

	push position_A						; Y position of the tile
	push position_1						; X position of the tile
	call CopyBitmap40X40
endm drawA1Mac

macro drawA2Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_A						; Y position of the tile
	push position_2						; X position of the tile
	call CopyBitmap40X40	
endm drawA2Mac

macro drawA3Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_A						; Y position of the tile
	push position_3						; X position of the tile
	call CopyBitmap40X40	
endm drawA3Mac

macro drawA4Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_A						; Y position of the tile
	push position_4						; X position of the tile
	call CopyBitmap40X40	
endm drawA4Mac

macro drawB1Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_B						; Y position of the tile
	push position_1						; X position of the tile
	call CopyBitmap40X40	
endm drawB1Mac

macro drawB2Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_B						; Y position of the tile
	push position_2						; X position of the tile
	call CopyBitmap40X40	
endm drawB2Mac

macro drawB3Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_B						; Y position of the tile
	push position_3						; X position of the tile
	call CopyBitmap40X40	
endm drawB1Mac

macro drawB4Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_B						; Y position of the tile
	push position_4						; X position of the tile
	call CopyBitmap40X40	
endm drawB4Mac

macro drawC1Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_C						; Y position of the tile
	push position_1						; X position of the tile
	call CopyBitmap40X40	
endm drawC1Mac

macro drawC2Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_C						; Y position of the tile
	push position_2						; X position of the tile
	call CopyBitmap40X40	
endm drawC2Mac

macro drawC3Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_C						; Y position of the tile
	push position_3						; X position of the tile
	call CopyBitmap40X40	
endm drawC3Mac

macro drawC4Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_C						; Y position of the tile
	push position_4						; X position of the tile
	call CopyBitmap40X40	
endm drawC4Mac

macro drawD1Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_D						; Y position of the tile
	push position_1						; X position of the tile
	call CopyBitmap40X40	
endm drawD1Mac

macro drawD2Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_D						; Y position of the tile
	push position_2						; X position of the tile
	call CopyBitmap40X40	
endm drawD2Mac

macro drawD3Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_D						; Y position of the tile
	push position_3						; X position of the tile
	call CopyBitmap40X40	
endm drawD3Mac

macro drawD4Mac
	call ReadHeader
	call ReadPalette
	call CopyPal
	
	push position_D						; Y position of the tile
	push position_4						; X position of the tile
	call CopyBitmap40X40	
endm drawD4Mac

CODESEG
;***********************************************************
; Procedures: OpenFile	                                   *
;                                                          *
;  These procedures open the pictures of the tiles         *
;                                                          *
;  Input parametrs:                                        *
;	Nothing											       *
;***********************************************************
	proc OpenFile2	
		mov ah, 3Dh
		xor al, al
		mov dx, offset img2
		int 21h
		jc openerror2
		mov [filehandle], ax
		ret
	openerror2:							; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile2

	proc OpenFile4	
		mov ah, 3Dh
		xor al, al
		mov dx, offset img4
		int 21h
		jc openerror4
		mov [filehandle], ax
		ret
	openerror4:							; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile4	

	proc OpenFile8
		mov ah, 3Dh
		xor al, al
		mov dx, offset img8
		int 21h
		jc openerror8
		mov [filehandle], ax
		ret
	openerror8:							; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile8

	proc OpenFile16	
		mov ah, 3Dh
		xor al, al
		mov dx, offset img16
		int 21h
		jc openerror16
		mov [filehandle], ax
		ret
	openerror16:						; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile16

	proc OpenFile32
		mov ah, 3Dh
		xor al, al
		mov dx, offset img32
		int 21h
		jc openerror32
		mov [filehandle], ax
		ret
	openerror32:							; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile32
 
	proc OpenFile64
		mov ah, 3Dh
		xor al, al
		mov dx, offset img64
		int 21h
		jc openerror64
		mov [filehandle], ax
		ret
	openerror64:							; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile64
 

	proc OpenFile128
		mov ah, 3Dh
		xor al, al
		mov dx, offset img128
		int 21h
		jc openerror128
		mov [filehandle], ax
		ret
	openerror128:							; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile128

	proc OpenFile256
		mov ah, 3Dh
		xor al, al
		mov dx, offset img256
		int 21h
		jc openerror256
		mov [filehandle], ax
		ret
	openerror256:							; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile256

	proc OpenFile512
		mov ah, 3Dh
		xor al, al
		mov dx, offset img512
		int 21h
		jc openerror512
		mov [filehandle], ax
		ret
	openerror512:							; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile512
 

	proc OpenFile1024
		mov ah, 3Dh
		xor al, al
		mov dx, offset img1024
		int 21h
		jc openerror1024
		mov [filehandle], ax
		ret
	openerror1024:							; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile1024
 

	proc OpenFile2048
		mov ah, 3Dh
		xor al, al
		mov dx, offset img2048
		int 21h
		jc openerror2048
		mov [filehandle], ax
			
		ret
	openerror2048:							; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFile2048

	;***********************************************************
	; Procedure: OpenFileHome                                  *
	;                                                          *
	;  This procedure opens the home image file                *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc OpenFileHome
			mov ah, 3Dh
			xor al, al
			mov dx, offset homeScreen
			int 21h
			jc openerrorHome
			mov [filehandle], ax
			ret
		openerrorHome: 					; if there is an error, Print an error messege
			mov dx, offset ErrorMsg
			mov ah, 9h
			int 21h
			ret
	endp OpenFileHome

	;***********************************************************
	; Procedure: OpenFileRules                                 *
	;                                                          *
	;  This procedure opens the rules image file               *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc OpenFileRules
		mov ah, 3Dh
		xor al, al
		mov dx, offset ruleScreen
		int 21h
		jc openerrorRules
		mov [filehandle], ax
		ret
	openerrorRules:						; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFileRules

	;***********************************************************
	; Procedure: OpenFileGame                                  *
	;                                                          *
	;  This procedure opens the game image file                *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************

	proc OpenFileGame
		mov ah, 3Dh
		xor al, al
		mov dx, offset gameScreen
		int 21h
		jc openerrorGame
		mov [filehandle], ax
		ret
	openerrorGame:						; if there is an error, Print an error messege
		mov dx, offset ErrorMsg
		mov ah, 9h
		int 21h
		ret
	endp OpenFileGame

	;***********************************************************
	; Procedure: OpenFileWin                                   *
	;                                                          *
	;  This procedure opens the home image file                *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc OpenFileWin
			mov ah, 3Dh
			xor al, al
			mov dx, offset winScreen
			int 21h
			jc openerrorWin
			mov [filehandle], ax
			ret
		openerrorWin: 					; if there is an error, Print an error messege
			mov dx, offset ErrorMsg
			mov ah, 9h
			int 21h
			ret
	endp OpenFileWin	
	
	;***********************************************************
	; Procedure: OpenFileLose                                   *
	;                                                          *
	;  This procedure opens the home image file                *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc OpenFileLose
			mov ah, 3Dh
			xor al, al
			mov dx, offset loseScreen
			int 21h
			jc openerrorLose
			mov [filehandle], ax
			ret
		openerrorLose: 					; if there is an error, Print an error messege
			mov dx, offset ErrorMsg
			mov ah, 9h
			int 21h
			ret
	endp OpenFileLose	
	
	;***********************************************************
	; Procedure: ReadHeader		                               *
	;                                                          *
	;  This procedure read BMP file header, 54 bytes	       *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************	
	
	proc ReadHeader
		mov ah,3fh
		mov bx, [filehandle]
		mov cx,54
		mov dx,offset Header
		int 21h
		ret
	endp ReadHeader
	
	;***********************************************************
	; Procedure: ReadPalette		                           *
	;                                                          *
	;  This procedure Read BMP file color palette, 	           *
	;  256 colors * 4 bytes (400h)							   *
	;														   *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc ReadPalette
		mov ah,3fh
		mov cx,400h
		mov dx,offset Palette
		int 21h
		ret
	endp ReadPalette
	
	;***********************************************************
	; Procedure: CopyPal			                           *
	;                                                          *
	;  This procedure copy the colors palette to the video     *
	;  memory. The number of the first color should be sent to *
	;  port 3C8h. The palette is sent to port 3C9h.			   *
	;														   *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc CopyPal
		mov si,offset Palette
		mov cx,256
		mov dx,3C8h
		mov al,0
		; Copy starting color to port 3C8h
		out dx,al
		; Copy palette itself to port 3C9h
		inc dx
		PalLoop:
		; Note: Colors in a BMP file are saved as BGR values rather than RGB.
			mov al,[si+2] 					; Get red value.
			shr al,2 						; Max. is 255, but video palette maximal value is 63. Therefore dividing by 4.
			out dx,al 						; Send it.
			mov al,[si+1] 					; Get green value.
			shr al,2
			out dx,al 						; Send it.
			mov al,[si] 					; Get blue value.
			shr al,2
			out dx,al 						; Send it.
			add si,4 						; Point to next color.
		loop PalLoop
		ret
	endp CopyPal

	;***********************************************************
	; Procedure: CopyBitmap40X40			                   *
	;                                                          *
	;  This procedure read the graphic line by line. 		   *
	;  displaying the lines from bottom to top.				   *
	;														   *
	;  Input parametrs:                                        *
	;	1. X - The X position of the image					   *
	;	2. Y - The Y position of the image					   *
	;***********************************************************
	
	proc CopyBitmap40X40
		pop [returnLine]
		pop [X]
		pop [Y]
		
		mov ax, 0A000h
		mov es, ax
		mov cx,40
		PrintBMPLoop2:
			push cx
			; di = cx*320, point to the correct screen line
			add cx, [Y] 					; add to cx the Y location
			mov di,cx
			shl cx,6
			shl di,8
			add cx, [X]						; add to cx the X location
			add di,cx
			; Read one line
			mov ah,3fh
			mov cx,40
			mov dx,offset ScrLine
			int 21h
			; Copy one line into video memory
			cld 							; Clear direction flag, for movsb
			mov cx,40
			mov si,offset ScrLine
			rep movsb 						; Copy line to the screen

			pop cx
		loop PrintBMPLoop2
		push [returnLine]
		
		ret
	endp CopyBitmap40X40

	;***********************************************************
	; Procedure: CopyBitmap320X200			                   *
	;                                                          *
	;  This procedure read the graphic line by line. 		   *
	;  displaying the lines from bottom to top.				   *
	;														   *
	;  Input parametrs:                                        *
	;    Nothing 											   *
	;***********************************************************
	
	proc CopyBitmap320X200
		mov ax, 0A000h
		mov es, ax
		mov cx,200
		PrintBMPLoop:
			push cx
			; di = cx*320, point to the correct screen line
			mov di,cx
			shl cx,6
			shl di,8
			add di,cx
			; Read one line
			mov ah,3fh
			mov cx,320
			mov dx,offset ScrLine
			int 21h
			; Copy one line into video memory
			cld 							; Clear direction flag, for movsb
			mov cx,320
			mov si,offset ScrLine
			rep movsb 						; Copy line to the screen

			pop cx
		loop PrintBMPLoop
		ret
	endp CopyBitmap320X200

	;***********************************************************
	; Procedure: resetArr					                   *
	;                                                          *
	;  This procedure reset the arr.		     		   	   *
	;														   *
	;  Input parametrs:                                        *
	;    Nothing 											   *
	;***********************************************************
	
	proc resetArr

		mov [arr + 0] , 0
		mov [arr + 2] , 0
		mov [arr + 4] , 0
		mov [arr + 6] , 0
		mov [arr + 8] , 0
		mov [arr + 10], 0
		mov [arr + 12], 0
		mov [arr + 14], 0
		mov [arr + 16], 0
		mov [arr + 18], 0
		mov [arr + 20], 0
		mov [arr + 22], 0
		mov [arr + 24], 0
		mov [arr + 26], 0
		mov [arr + 28], 0
		mov [arr + 30], 0
	
		ret
	endp resetArr

	;***********************************************************
	; Procedure: draw		                                   *
	;                                                          *
	;  This procedure updates the screen according to the arr  *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc draw
		; reset the screen
		call OpenFileGame
		call ReadHeader
		call ReadPalette
		call CopyPal
		call CopyBitmap320X200
		closeFileMac	
		
		checkA1:						; check any option in the A1 position
			cmp [arr + 0], 2
			je draw2InA1

			cmp [arr + 0], 4
			je draw4InA1
			
			cmp [arr + 0], 8
			je draw8InA1
			
			cmp [arr + 0], 16
			je draw16InA1
			
			cmp [arr + 0], 32
			je draw32InA1

			cmp [arr + 0], 64
			je draw64InA1
			
			cmp [arr + 0], 128
			je draw128InA1

			cmp [arr + 0], 256
			je draw256InA1
			
			cmp [arr + 0], 512
			je draw512InA1

			cmp [arr + 0], 1024
			je draw1024InA1

			cmp [arr + 0], 2048
			je draw2048InA1		
			
		checkA2:						; check any option in the A2 position
			cmp [arr + 2], 2
			je draw2InA2

			cmp [arr + 2], 4
			je draw4InA2
			
			cmp [arr + 2], 8
			je draw8InA2
			
			cmp [arr + 2], 16
			je draw16InA2
			
			cmp [arr + 2], 32
			je draw32InA2

			cmp [arr + 2], 64
			je draw64InA2
			
			cmp [arr + 2], 128
			je draw128InA2

			cmp [arr + 2], 256
			je draw256InA2
			
			cmp [arr + 2], 512
			je draw512InA2

			cmp [arr + 2], 1024
			je draw1024InA2

			cmp [arr + 2], 2048
			je draw2048InA2		
			
		checkA3:						; check any option in the A3 position
			cmp [arr + 4], 2
			je draw2InA3

			cmp [arr + 4], 4
			je draw4InA3
			
			cmp [arr + 4], 8
			je draw8InA3
			
			cmp [arr + 4], 16
			je draw16InA3
			
			cmp [arr + 4], 32
			je draw32InA3

			cmp [arr + 4], 64
			je draw64InA3
			
			cmp [arr + 4], 128
			je draw128InA3
			
			cmp [arr + 4], 256
			je draw256InA3		
			
			cmp [arr + 4], 512
			je draw512InA3

			cmp [arr + 4], 1024
			je draw1024InA3

			cmp [arr + 4], 2048
			je draw2048InA3		
			
		checkA4:						; check any option in the A4 position	
			cmp [arr + 6], 2
			je draw2InA4

			cmp [arr + 6], 4
			je draw4InA4
			
			cmp [arr + 6], 8
			je draw8InA4
			
			cmp [arr + 6], 16
			je draw16InA4
			
			cmp [arr + 6], 32
			je draw32InA4

			cmp [arr + 6], 64
			je draw64InA4
			
			cmp [arr + 6], 128
			je draw128InA4
			
			cmp [arr + 6], 512
			je draw512InA4

			cmp [arr + 6], 256
			je draw256InA4

			cmp [arr + 6], 1024
			je draw1024InA4

			cmp [arr + 6], 2048
			je draw2048InA4	
			
		checkB1:						; check any option in the B1 position	
			cmp [arr + 8], 2
			je draw2InB1

			cmp [arr + 8], 4
			je draw4InB1
			
			cmp [arr + 8], 8
			je draw8InB1
			
			cmp [arr + 8], 16
			je draw16InB1
			
			cmp [arr + 8], 32
			je draw32InB1

			cmp [arr + 8], 64
			je draw64InB1
			
			cmp [arr + 8], 128
			je draw128InB1
			
			cmp [arr + 8], 256
			je draw256InB1		
			
			cmp [arr + 8], 512
			je draw512InB1

			cmp [arr + 8], 1024
			je draw1024InB1

			cmp [arr + 8], 2048
			je draw2048InB1	

		checkB2:						; check any option in the B2 position	
			cmp [arr + 10], 2
			je draw2InB2

			cmp [arr + 10], 4
			je draw4InB2
			
			cmp [arr + 10], 8
			je draw8InB2
			
			cmp [arr + 10], 16
			je draw16InB2
			
			cmp [arr + 10], 32
			je draw32InB2

			cmp [arr + 10], 64
			je draw64InB2
			
			cmp [arr + 10], 128
			je draw128InB2

			cmp [arr + 10], 256
			je draw256InB2
			
			cmp [arr + 10], 512
			je draw512InB2

			cmp [arr + 10], 1024
			je draw1024InB2

			cmp [arr + 10], 2048
			je draw2048InB2	

		checkB3:						; check any option in the B3 position	
			cmp [arr + 12], 2
			je draw2InB3

			cmp [arr + 12], 4
			je draw4InB3
			
			cmp [arr + 12], 8
			je draw8InB3
			
			cmp [arr + 12], 16
			je draw16InB3
			
			cmp [arr + 12], 32
			je draw32InB3

			cmp [arr + 12], 64
			je draw64InB3
			
			cmp [arr + 12], 128
			je draw128InB3
			
			cmp [arr + 12], 256
			je draw256InB3	
			
			cmp [arr + 12], 512
			je draw512InB3

			cmp [arr + 12], 1024
			je draw1024InB3

			cmp [arr + 12], 2048
			je draw2048InB3	

		checkB4:						; check any option in the B4 position	
			cmp [arr + 14], 2
			je draw2InB4

			cmp [arr + 14], 4
			je draw4InB4
			
			cmp [arr + 14], 8
			je draw8InB4
			
			cmp [arr + 14], 16
			je draw16InB4
			
			cmp [arr + 14], 32
			je draw32InB4

			cmp [arr + 14], 64
			je draw64InB4
			
			cmp [arr + 14], 128
			je draw128InB4
			
			cmp [arr + 14], 256
			je draw256InB4	
			
			cmp [arr + 14], 512
			je draw512InB4

			cmp [arr + 14], 1024
			je draw1024InB4

			cmp [arr + 14], 2048
			je draw2048InB4		
		
		checkC1:						; check any option in the C1 position
			cmp [arr + 16], 2
			je draw2InC1

			cmp [arr + 16], 4
			je draw4InC1
			
			cmp [arr + 16], 8
			je draw8InC1
			
			cmp [arr + 16], 16
			je draw16InC1
			
			cmp [arr + 16], 32
			je draw32InC1

			cmp [arr + 16], 64
			je draw64InC1
			
			cmp [arr + 16], 128
			je draw128InC1
			
			cmp [arr + 16], 256
			je draw256InC1	
			
			cmp [arr + 16], 512
			je draw512InC1

			cmp [arr + 16], 1024
			je draw1024InC1

			cmp [arr + 16], 2048
			je draw2048InC1		
			
		checkC2:						; check any option in the C2 position
			cmp [arr + 18], 2
			je draw2InC2

			cmp [arr + 18], 4
			je draw4InC2
			
			cmp [arr + 18], 8
			je draw8InC2
			
			cmp [arr + 18], 16
			je draw16InC2
			
			cmp [arr + 18], 32
			je draw32InC2

			cmp [arr + 18], 64
			je draw64InC2
			
			cmp [arr + 18], 128
			je draw128InC2
			
			cmp [arr + 18], 256
			je draw256InC2
			
			cmp [arr + 18], 512
			je draw512InC2

			cmp [arr + 18], 1024
			je draw1024InC2

			cmp [arr + 18], 2048
			je draw2048InC2		
			
		checkC3:						; check any option in the C3 position
			cmp [arr + 20], 2
			je draw2InC3

			cmp [arr + 20], 4
			je draw4InC3
			
			cmp [arr + 20], 8
			je draw8InC3
			
			cmp [arr + 20], 16
			je draw16InC3
			
			cmp [arr + 20], 32
			je draw32InC3

			cmp [arr + 20], 64
			je draw64InC3
			
			cmp [arr + 20], 128
			je draw128InC3
			
			cmp [arr + 20], 256
			je draw256InC3			
			
			cmp [arr + 20], 512
			je draw512InC3

			cmp [arr + 20], 1024
			je draw1024InC3

			cmp [arr + 20], 2048
			je draw2048InC3	
			
		checkC4:						; check any option in the C4 position
			cmp [arr + 22], 2
			je draw2InC4

			cmp [arr + 22], 4
			je draw4InC4
			
			cmp [arr + 22], 8
			je draw8InC4
			
			cmp [arr + 22], 16
			je draw16InC4
			
			cmp [arr + 22], 32
			je draw32InC4

			cmp [arr + 22], 64
			je draw64InC4
			
			cmp [arr + 22], 128
			je draw128InC4
			
			cmp [arr + 22], 256
			je draw256InC4	
			
			cmp [arr + 22], 512
			je draw512InC4

			cmp [arr + 22], 1024
			je draw1024InC4

			cmp [arr + 22], 2048
			je draw2048InC4	
			
		checkD1:						; check any option in the D1 position
			cmp [arr + 24], 2
			je draw2InD1

			cmp [arr + 24], 4
			je draw4InD1
			
			cmp [arr + 24], 8
			je draw8InD1
			
			cmp [arr + 24], 16
			je draw16InD1
			
			cmp [arr + 24], 32
			je draw32InD1

			cmp [arr + 24], 64
			je draw64InD1
			
			cmp [arr + 24], 128
			je draw128InD1
			
			cmp [arr + 24], 256
			je draw256InD1					
			
			cmp [arr + 24], 512
			je draw512InD1

			cmp [arr + 24], 1024
			je draw1024InD1

			cmp [arr + 24], 2048
			je draw2048InD1		
			
		checkD2:						; check any option in the D2 position
			cmp [arr + 26], 2
			je draw2InD2

			cmp [arr + 26], 4
			je draw4InD2
			
			cmp [arr + 26], 8
			je draw8InD2
			
			cmp [arr + 26], 16
			je draw16InD2
			
			cmp [arr + 26], 32
			je draw32InD2

			cmp [arr + 26], 64
			je draw64InD2
			
			cmp [arr + 26], 128
			je draw128InD2
			
			cmp [arr + 26], 256
			je draw256InD2	
			
			cmp [arr + 26], 512
			je draw512InD2

			cmp [arr + 26], 1024
			je draw1024InD2

			cmp [arr + 26], 2048
			je draw2048InD2		
			
		checkD3:						; check any option in the D3 position
			cmp [arr + 28], 2
			je draw2InD3

			cmp [arr + 28], 4
			je draw4InD3
			
			cmp [arr + 28], 8
			je draw8InD3
			
			cmp [arr + 28], 16
			je draw16InD3
			
			cmp [arr + 28], 32
			je draw32InD3

			cmp [arr + 28], 64
			je draw64InD3
			
			cmp [arr + 28], 128
			je draw128InD3
			
			cmp [arr + 28], 256
			je draw256InD3
			
			cmp [arr + 28], 512
			je draw512InD3

			cmp [arr + 28], 1024
			je draw1024InD3

			cmp [arr + 28], 2048
			je draw2048InD3		
			
		checkD4:						; check any option in the D4 position
			cmp [arr + 30], 2
			je draw2InD4

			cmp [arr + 30], 4
			je draw4InD4
			
			cmp [arr + 30], 8
			je draw8InD4
			
			cmp [arr + 30], 16
			je draw16InD4
			
			cmp [arr + 30], 32
			je draw32InD4

			cmp [arr + 30], 64
			je draw64InD4
			
			cmp [arr + 30], 128
			je draw128InD4
			
			cmp [arr + 30], 256
			je draw256InD4
			
			cmp [arr + 30], 512
			je draw512InD4

			cmp [arr + 30], 1024
			je draw1024InD4

			cmp [arr + 30], 2048
			je draw2048InD4		
			
		finalCheck:
			push 14						; the x position of the score
			push 23						; the y position of the score
			call printScore
			ret

	endp draw
	
	;***********************************************************
	; Procedure: addNumber	                                   *
	;                                                          *
	;  This procedure adds a random number to the game screen  *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
		
	proc addNumber			
	
	; random number between 0-15
		random15:
			mov ax, 40h
			mov es, ax
			mov ax, [es:6Ch]
			and al, 1111b	
		
		cmp al, 0000b
		je IsFullA1
			
		cmp al, 0001b
		je IsFullA2
		
		cmp al, 0010b
		je IsFullA3
		
		cmp al, 0011b
		je IsFullA4
		
		cmp al, 0100b
		je IsFullB1
		
		cmp al, 0101b
		je IsFullB2
		
		cmp al, 0110b
		je IsFullB3
		
		cmp al, 0111b
		je IsFullB4
		
		cmp al, 1000b
		je IsFullC1
		
		cmp al, 1001b
		je IsFullC2
		
		cmp al, 1010b
		je IsFullC3
		
		cmp al, 1011b
		je IsFullC4
		
		cmp al, 1100b
		je IsFullD1
		
		cmp al, 1101b
		je IsFullD2
		
		cmp al, 1110b
		je IsFullD3
		
		cmp al, 1111b
		je IsFullD4	
		
		IsFullA1:
			cmp [arr + 0], 0
			je A1
			jmp random15
			
		IsFullA2:
			cmp [arr + 2], 0
			je A2
			jmp random15
			
		IsFullA3:
			cmp [arr + 4], 0
			je A3
			jmp random15
			
		IsFullA4:
			cmp [arr + 6], 0
			je A4
			jmp random15

		IsFullB1:
			cmp [arr + 8], 0
			je B1
			jmp random15
			
		IsFullB2:
			cmp [arr + 10], 0
			je B2
			jmp random15
			
		IsFullB3:
			cmp [arr + 12], 0
			je B3
			jmp random15
			
		IsFullB4:
			cmp [arr + 14], 0
			je B4
			jmp random15

		IsFullC1:
			cmp [arr + 16], 0
			je C1
			jmp random15
		
		IsFullC2:
			cmp [arr + 18], 0
			je C2
			jmp random15
		
		IsFullC3:
			cmp [arr + 20], 0
			je C3
			jmp random15
		
		IsFullC4:
			cmp [arr + 22], 0
			je C4
			jmp random15

		IsFullD1:
			cmp [arr + 24], 0
			je D1
			jmp random15
			
		IsFullD2:
			cmp [arr + 26], 0
			je D2
			jmp random15
		
		IsFullD3:
			cmp [arr + 28], 0
			je D3
			jmp random15

		IsFullD4:
			cmp [arr + 30], 0
			je D4	
			jmp random15
			
		ret

	endp addNumber

	;***********************************************************
	; Procedure: checkLose                                     *
	;                                                          *
	;  This procedure checks if the screen full                *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc checkLose

		Is0Zero:
			cmp [arr + 0], 0
			jne Is2Zero
			ret
			
		Is2Zero:
			cmp [arr + 2], 0
			jne Is4Zero
			ret
			
		Is4Zero:
			cmp [arr + 4], 0
			jne Is6Zero
			ret
			
		Is6Zero:
			cmp [arr + 6], 0
			jne Is8Zero
			ret

		Is8Zero:
			cmp [arr + 8], 0
			jne Is10Zero
			ret
			
		Is10Zero:
			cmp [arr + 10], 0
			jne Is12Zero
			ret
			
		Is12Zero:
			cmp [arr + 12], 0
			jne Is14Zero
			ret
			
		Is14Zero:
			cmp [arr + 14], 0
			jne Is16Zero
			ret

		Is16Zero:
			cmp [arr + 16], 0
			jne Is18Zero
			ret
		
		Is18Zero:
			cmp [arr + 18], 0
			jne Is20Zero
			ret
		
		Is20Zero:
			cmp [arr + 20], 0
			jne Is22Zero
			ret
		
		Is22Zero:
			cmp [arr + 22], 0
			jne Is24Zero
			ret

		Is24Zero:
			cmp [arr + 24], 0
			jne Is26Zero
			ret
			
		Is26Zero:
			cmp [arr + 26], 0
			jne Is28Zero
			ret
		
		Is28Zero:
			cmp [arr + 28], 0
			jne Is30Zero
			ret

		Is30Zero:
			cmp [arr + 30], 0
			jne lose
			ret
		
	endp checkLose

	;***********************************************************
	; Procedure: combineRight                                  *
	;                                                          *
	;  This procedure combine the tiles after the user press   *
	;  the key 'D'. any two equales tiles will turn into one.  *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc combineRight
		combine30And28:
			mov ax, [arr + 30]
			cmp [arr + 28], ax
			jne combine28And26

			mov ax, [arr + 28]
			add [arr + 30], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 28], 0

		combine28And26:
			mov ax, [arr + 28]
			cmp [arr + 26], ax
			jne combine26And24

			mov ax, [arr + 26]
			add [arr + 28], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 26], 0

		combine26And24:
			mov ax, [arr + 26]
			cmp [arr + 24], ax
			jne combine22And20

			mov ax, [arr + 24]
			add [arr + 26], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 24], 0

		combine22And20:
			mov ax, [arr + 22]
			cmp [arr + 20], ax
			jne combine20And18

			mov ax, [arr + 20]
			add [arr + 22], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 20], 0	
			
		combine20And18:
			mov ax, [arr + 20]
			cmp [arr + 18], ax
			jne combine18And16

			mov ax, [arr + 18]
			add [arr + 20], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 18], 0	
			
		combine18And16:
			mov ax, [arr + 18]
			cmp [arr + 16], ax
			jne combine14And12

			mov ax, [arr + 16]
			add [arr + 18], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 16], 0		
			
		combine14And12:
			mov ax, [arr + 14]
			cmp [arr + 12], ax
			jne combine12And10

			mov ax, [arr + 12]
			add [arr + 14], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 12], 0	

		combine12And10:
			mov ax, [arr + 12]
			cmp [arr + 10], ax
			jne combine10And8

			mov ax, [arr + 10]
			add [arr + 12], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 10], 0
			
		combine10And8:
			mov ax, [arr + 10]
			cmp [arr + 8], ax
			jne combine6And4

			mov ax, [arr + 8]
			add [arr + 10], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 8], 0	
		
		combine6And4:
			mov ax, [arr + 6]
			cmp [arr + 4], ax
			jne combine4And2

			mov ax, [arr + 4]
			add [arr + 6], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 4], 0
			
		combine4And2:
			mov ax, [arr + 4]
			cmp [arr + 2], ax
			jne combine2And0

			mov ax, [arr + 2]
			add [arr + 4], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 2], 0
			
		combine2And0:
			mov ax, [arr + 2]
			cmp [arr + 0], ax
			jne endCombineRight

			mov ax, [arr + 0]
			add [arr + 2], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 0], 0	
			
		endCombineRight:
		
			call draw
		ret
	endp combineRight

	;***********************************************************
	; Procedure: combineLeft                                   *
	;                                                          *
	;  This procedure combine the tiles after the user press   *
	;  the key 'A'. any two equales tiles will turn into one.  *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc combineLeft
		combine24And26:
			mov ax, [arr + 24]
			cmp [arr + 26], ax
			jne combine26And28

			mov ax, [arr + 26]
			add [arr + 24], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 26], 0
			
		combine26And28:
			mov ax, [arr + 26]
			cmp [arr + 28], ax
			jne combine28And30

			mov ax, [arr + 28]
			add [arr + 26], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 28], 0	
		
		combine28And30:
			mov ax, [arr + 28]
			cmp [arr + 30], ax
			jne combine16And18

			mov ax, [arr + 30]
			add [arr + 28], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 30], 0
		
		combine16And18:
			mov ax, [arr + 16]
			cmp [arr + 18], ax
			jne combine18And20

			mov ax, [arr + 18]
			add [arr + 16], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 18], 0

		combine18And20:
			mov ax, [arr + 18]
			cmp [arr + 20], ax
			jne combine20And22

			mov ax, [arr + 20]
			add [arr + 18], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 20], 0	
		
		combine20And22:
			mov ax, [arr + 20]
			cmp [arr + 22], ax
			jne combine8And10

			mov ax, [arr + 22]
			add [arr + 20], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 22], 0	
		
		combine8And10:
			mov ax, [arr + 8]
			cmp [arr + 10], ax
			jne combine10And12

			mov ax, [arr + 10]
			add [arr + 8], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 10], 0	
		
		combine10And12:
			mov ax, [arr + 10]
			cmp [arr + 12], ax
			jne combine12And14

			mov ax, [arr + 12]
			add [arr + 10], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 12], 0	
		
		combine12And14:
			mov ax, [arr + 12]
			cmp [arr + 14], ax
			jne combine0And2

			mov ax, [arr + 14]
			add [arr + 12], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 14], 0	
		
		combine0And2:
			mov ax, [arr + 0]
			cmp [arr + 2], ax
			jne combine2And4

			mov ax, [arr + 2]
			add [arr + 0], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 2], 0	
		
		combine2And4:
			mov ax, [arr + 2]
			cmp [arr + 4], ax
			jne combine4And6

			mov ax, [arr + 4]
			add [arr + 2], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 4], 0	
		
		combine4And6:
			mov ax, [arr + 4]
			cmp [arr + 6], ax
			jne endCombineLeft

			mov ax, [arr + 6]
			add [arr + 4], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 6], 0

		endCombineLeft:
			
			call draw
			
		ret
	endp combineLeft

	;***********************************************************
	; Procedure: combineUp	                                   *
	;                                                          *
	;  This procedure combine the tiles after the user press   *
	;  the key 'W'. any two equales tiles will turn into one.  *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc combineUp

		combine8And0:
			mov ax, [arr + 	0]
			cmp [arr + 8], ax
			jne combine16And8

			mov ax, [arr + 8]
			add [arr + 0], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 8], 0		

		combine16And8:
			mov ax, [arr + 	8]
			cmp [arr + 16], ax
			jne combine24And16

			mov ax, [arr + 16]
			add [arr + 8], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 16], 0	
		
		combine24And16:
			mov ax, [arr + 	16]
			cmp [arr + 24], ax
			jne combine10And2

			mov ax, [arr + 24]
			add [arr + 16], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 24], 0

		combine10And2:
			mov ax, [arr + 	2]
			cmp [arr + 10], ax
			jne combine18And10

			mov ax, [arr + 10]
			add [arr + 2], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 10], 0
		
		combine18And10:
			mov ax, [arr + 	10]
			cmp [arr + 18], ax
			jne combine26And18

			mov ax, [arr + 18]
			add [arr + 10], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 18], 0
			
		combine26And18:
			mov ax, [arr + 	18]
			cmp [arr + 26], ax
			jne combine12And4

			mov ax, [arr + 26]
			add [arr + 18], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 26], 0
			
		combine12And4:
			mov ax, [arr + 	4]
			cmp [arr + 12], ax
			jne combine20And12

			mov ax, [arr + 12]
			add [arr + 4], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 12], 0	
		
		combine20And12:
			mov ax, [arr + 12]
			cmp [arr + 20], ax
			jne combine28And20

			mov ax, [arr + 20]
			add [arr + 12], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 20], 0	
		
		combine28And20:
			mov ax, [arr + 	20]
			cmp [arr + 28], ax
			jne combine14And6

			mov ax, [arr + 28]
			add [arr + 20], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 28], 0		
			
		combine14And6:
			mov ax, [arr + 	6]
			cmp [arr + 14], ax
			jne combine22And14

			mov ax, [arr + 14]
			add [arr + 6], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 14], 0
			
		combine22And14:
			mov ax, [arr + 	14]
			cmp [arr + 22], ax
			jne combine30And22

			mov ax, [arr + 22]
			add [arr + 14], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 22], 0
			
		combine30And22:
			mov ax, [arr + 	22]
			cmp [arr + 30], ax
			jne endCombineUp

			mov ax, [arr + 30]
			add [arr + 22], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 30], 0
			
		endCombineUp:
			
			call draw
			
		ret

	endp combineUp

	;***********************************************************
	; Procedure: combineDown                                   *
	;                                                          *
	;  This procedure combine the tiles after the user press   *
	;  the key 'S'. any two equales tiles will turn into one.  *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************

	proc combineDown
		combine0And8:
			mov ax, [arr + 	8]
			cmp [arr + 0], ax
			jne combine8And16

			mov ax, [arr + 0]
			add [arr + 8], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 0], 0
			
		combine8And16:
			mov ax, [arr + 	16]
			cmp [arr + 8], ax
			jne combine16And24

			mov ax, [arr + 8]
			add [arr + 16], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 8], 0
			
		combine16And24:
			mov ax, [arr + 	24]
			cmp [arr + 16], ax
			jne combine2And10

			mov ax, [arr + 16]
			add [arr + 24], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 16], 0	
			
		combine2And10:
			mov ax, [arr + 	10]
			cmp [arr + 2], ax
			jne combine10And18

			mov ax, [arr + 2]
			add [arr + 10], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 2], 0	
			
		combine10And18:
			mov ax, [arr + 	18]
			cmp [arr + 10], ax
			jne combine18And26

			mov ax, [arr + 10]
			add [arr + 18], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 10], 0	
			
		combine18And26:
			mov ax, [arr + 	26]
			cmp [arr + 18], ax
			jne combine4And12

			mov ax, [arr + 18]
			add [arr + 26], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 18], 0
			
		combine4And12:
			mov ax, [arr + 	12]
			cmp [arr + 4], ax
			jne combine12And20

			mov ax, [arr + 4]
			add [arr + 12], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 4], 0	

		combine12And20:
			mov ax, [arr + 	20]
			cmp [arr + 12], ax
			jne combine20And28

			mov ax, [arr + 12]
			add [arr + 20], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 12], 0	
			
		combine20And28:
			mov ax, [arr + 	28]
			cmp [arr + 20], ax
			jne combine6And14

			mov ax, [arr + 20]
			add [arr + 28], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 20], 0	
			
		combine6And14:
			mov ax, [arr + 	14]
			cmp [arr + 6], ax
			jne combine14And22

			mov ax, [arr + 6]
			add [arr + 14], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 6], 0		

		combine14And22:
			mov ax, [arr + 	22]
			cmp [arr + 14], ax
			jne combine22And30

			mov ax, [arr + 14]
			add [arr + 22], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 14], 0
		
		combine22And30:
			mov ax, [arr + 	30]
			cmp [arr + 22], ax
			jne endCombineDown

			mov ax, [arr + 22]
			add [arr + 30], ax
			shl ax, 1						; ax *= 2
			add [score], ax					; abc
			mov [arr + 22], 0	
		
		endCombineDown:

			call draw
		ret	
	endp combineDown

	;***********************************************************
	; Procedure: updateScore                                   *
	;                                                          *
	;  This procedure update the score value. 				   *
	;                                                          *
	;  Input parametrs:                                        *
	;	Nothing											       *
	;***********************************************************
	
	proc updateScore	
		
		mov [units],	 '0'
		mov [tens],		 '0'
		mov [hundreds],  '0'
		mov [thousands], '0'
		
		cmp [score], 1000 				; if the score is above 1000
		jge fourDigitScore

		cmp [score], 100				; if the score is above 100
		jge threeDigitScore

		cmp [score], 10					; if the score is above 10
		jge twoDigitScore
		
		jmp oneDigitScore				; if the score is 0-9

		fourDigitScore:	
			; print the tousand's digit
			xor dx, dx
			mov ax, [word ptr score] 		; ax = score
			mov bx, 1000					; bx = 1000

			div bx							; ax = score / 1000
	
			add [thousands], al					; print the tousand's digit

			; print the hundred's digit
			xor dx, dx
			mov ax, [word ptr score] 		; ax = score
			mov bx, 100						; bx = 100

			div bx							; ax = score / 100
			
			xor dx, dx
			mov bx, 10
			
			div bx							; dx = score / 100 % 10
			
			add [hundreds], dl					; print the hundred's digit
			
			; print the ten's digit
			xor dx, dx
			mov ax, [word ptr score] 		; ax = score
			mov bx, 10

			div bx							; ax = score / 10
			
			xor dx, dx
			mov bx, 10
			
			div bx							; dx = score / 10 % 10
			
			add [tens], dl 			    ; print the ten's digit
			
			; print the unit's digit
			xor dx, dx
			mov ax, [word ptr score] 		; ax = score
			mov bx, 10
			div bx
			
			add [units], dl 			    ; print the unit's digit
			ret
			
		threeDigitScore:
			; print the hundred's digit
			xor dx, dx		
			mov ax, [word ptr score] 		; ax = score
			mov bx, 100						; bx = 100

			div bx							; ax = score / 100
			
			add [hundreds], al					; print the hundred's digit
			
			; print the ten's digit
			xor dx, dx
			mov ax, [word ptr score] 		; ax = score
			mov bx, 10						; bx = 10

			div bx							; ax = score / 10
			
			xor dx, dx
			mov bx, 10
			
			div bx							; dx = score / 10 % 10
			
			add [tens], dl					; print the ten's digit
			; print the units digit
			
			xor dx, dx
			mov bx, 10
			mov ax, [word ptr score] 		; ax = score
			
			div bx							; dx = score % 10
			add [units], dl					; print the units digit
			
			ret
			
		twoDigitScore:
			xor dx, dx
			
			mov bx, [score]
			
			mov ax, [word ptr score] 		; ax = score
			mov bx, 10						; bx = 10

			div bx							; ax = score / 10
			
			add [tens], al 				; print the tens digit
			add [units], dl					; print the units digit
			
			ret
			
		oneDigitScore:
			mov bx, [score]
			add [units], bl					; print the units digit
		ret
	endp updateScore
	
	;***********************************************************
	; Procedure: printScore                                    *
	;                                                          *
	;  This procedure print the score value on the screen.	   *
	;                                                          *
	;  Input parametrs:                                        *
	;	1. ax - x position of the score text.				   *
	;	2. bx - y position of the score text.				   *
	;***********************************************************
	
	proc printScore
		call updateScore
		
		pop [returnLine]
		pop ax
		pop bx
		
		mov  dl, bl			   			; Column
		mov  dh, al		   				; Row
		mov  bh, 0    					; Display page
		mov  ah, 02h  					; SetCursorPosition
		int  10h

		lea dx, [scoreText]
		MOV AH,09H 
		INT 21H	
		
		lea dx, [thousands]
		MOV AH,09H 
		INT 21H	

		lea dx, [hundreds]
		MOV AH,09H 
		INT 21H	

		lea dx, [tens]
		MOV AH,09H 
		INT 21H	

		lea dx, [units]
		MOV AH,09H 
		INT 21H	
		
		push [returnLine] 
		ret 
	endp printScore

start:
	mov ax, @data
	mov ds, ax
	
	; Graphic mode
	mov ax, 13h
	int 10h

; ===================================================================
; ***************************HOME SCREEN*****************************
; ===================================================================

HomeScr:
	; reset the screen
	mov ax, 13h
	int 10h
	
	; start the program with the home screen
	call OpenFileHome
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap320X200	
	
	; initializes the mouse
	mov ax,0h
	int 33h
	
	; show mouse
	mov ax,1h
	int 33h

MSrc_MouseLP:							; Loop until mouse click
		mov ax,3h
		int 33h	
		
		cmp bx, 01h 							; check left mouse click
		jne MSrc_MouseLP
		
	shr cx, 1 								; adjust cx to range 0-319, to fit screen
		
	cmp dx, TOP_EDGE_BUTTONS 					; checks if the mouse on the bottom of the screen
	jg MSrc_checkYLocation 					
	jmp MSrc_MouseLP
	
MSrc_checkYLocation: 						; checks if the mouse is in the Y position of the buttons
	cmp dx, BOTTOM_EDGE_BUTTONS
	jl MSrc_checkXLocation
	jmp MSrc_MouseLP
	
MSrc_checkXLocation: 						; checks if the mouse is in the X position of the buttons
	cmp cx, LEFT_EDGE_BTN1
	jg MSrc_checkRulesButton

MSrc_checkRulesButton: 						; checks if the rules button is pressed
	cmp cx, RIGHT_EDGE_BTN1
	jl RulesScr

	cmp cx, LEFT_EDGE_BTN2
	jg MSrc_checkStartButton
	
	; if RIGHT_EDGE_BTN1 < cx < LEFT_EDGE_BTN2, no button was pressed
	jmp MSrc_MouseLP
		
MSrc_checkStartButton: 					; checks if the start button is pressed
	cmp cx, RIGHT_EDGE_BTN2
	jl GameSrc
	
	cmp cx, LEFT_EDGE_BTN3
	jg Msrc_checkQuitButton
	
	; if RIGHT_EDGE_BTN2 < cx < LEFT_EDGE_BTN3, no button was pressed
	jmp MSrc_MouseLP

MSrc_checkQuitButton: 					; checks if the quit button is pressed
	cmp cx, RIGHT_EDGE_BTN3
	jl Quit
	
	; if cx > RIGHT_EDGE_BTN3, no button was pressed
	jmp MSrc_MouseLP
	
; ===================================================================
; ***************************RULES SCREEN****************************
; ===================================================================

RulesScr:							
	; reset the screen
	mov ax, 13h
	int 10h
	
	; show the rules image
	call OpenFileRules
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap320X200

	; initializes the mouse
	mov ax,0h
	int 33h
	
	; show mouse
	mov ax,1h
	int 33h
		
; Loop until mouse click
RSrc_MouseLP:
		mov ax,3h
		int 33h	
		
		cmp bx, 01h 							; check left mouse click
		jne RSrc_MouseLP
		
	shr cx,1 								; adjust cx to range 0-319, to fit screen
	sub dx, 1 								; move one pixel, so the pixel will not be hidden by mouse
		
	mov bh, 0h 								; read dot

	cmp dx, TOP_EDGE_BUTTONS 				; checks if the mouse on the bottom of the screen
	jg RSrc_checkYLocation
	jmp RSrc_MouseLP
	
RSrc_checkYLocation: 						; checks if the mouse is in the Y position of the buttons
	cmp dx, BOTTOM_EDGE_BUTTONS
	jl RSrc_checkXLocation
	jmp RSrc_MouseLP

RSrc_checkXLocation: 						; checks if the mouse is in the X position of the buttons
	cmp cx, LEFT_EDGE_BTN1
	jg RSrc_checkStartButton	
	
	; if cx < LEFT_EDGE_BTN1, no button was pressed
	jmp RSrc_MouseLP
	
RSrc_checkStartButton: 						; checks if the start button is pressed
	cmp cx, RIGHT_EDGE_BTN1
	jl GameSrc

	cmp cx, LEFT_EDGE_BTN3
	jg RSrc_checkBackButton
	
	; if RIGHT_EDGE_BTN1 < cx < LEFT_EDGE_BTN3, no button was pressed
	jmp RSrc_MouseLP

RSrc_checkBackButton: 						; checks if the back button is pressed
	cmp cx, RIGHT_EDGE_BTN3
	jl back
	
	; if cx > RIGHT_EDGE_BTN3, no button was pressed
	jmp RSrc_MouseLP
	
; ===================================================================
; ***************************GAME SCREEN*****************************
; ===================================================================

GameSrc:
	mov [score], 0
	; reset the screen
	mov ax, 13h
	int 10h
		
	call resetArr 						; call the function that reser the arr
	
	call draw							; draw the game image									    	
	call addNumber						; add 2 or 4 in a random location
	call addNumber						; add 2 or 4 in a random location

	jmp WaitForData						; starts the game
	
Quit: 									; exit the game
	jmp exit

back:									; back to the Home screen
	jmp HomeScr

; ===================================================================
; ***************************LOSE SCREEN*****************************
; ===================================================================
lose: 									; if the user lost 
	; wait for first change in timer
	mov ax, 40h
	mov es, ax
	mov ax, [Clock]

	; wait 3 seconeds
	FirstTickLose:
		cmp ax, [Clock]
		je FirstTickLose
		
		; count 3 sec
		mov cx, 40  						; 40x0.055sec = ~3sec
		
	DelayLoopLose:
		mov ax, [Clock]
		
	TickLose:
		cmp ax, [Clock]
		je TickLose
		loop DelayLoopLose
		

	; reset the screen
	mov ax, 13h
	int 10h
	
	; open the lose screen
	call OpenFileLose
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap320X200
	
	jmp lastScreen 						; jump to the last screen
	
; ===================================================================
; ***************************WIN SCREEN*****************************
; ===================================================================
win: 									; if the user won
	; wait for first change in timer
	mov ax, 40h
	mov es, ax
	mov ax, [Clock]

	FirstTickWin:
		cmp ax, [Clock]
		je FirstTickWin
		
		; count 3 sec
		mov cx, 40  						; 40x0.055sec = ~3sec
		
	DelayLoopWin:
		mov ax, [Clock]
		
	TickWin:
		cmp ax, [Clock]
		je TickWin
		loop DelayLoopWin
		
	; reset the screen
	mov ax, 13h
	int 10h
	
	; open the win screen
	call OpenFileWin
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap320X200

; =========================================================================
; ***************************LAST SCREEN***********************************
; the logic behind the lose and the win screen, because they are the same.
; =========================================================================
lastScreen:
	push 15							; X position of the score
	push 12							; Y position of the score
	call printScore
	
	; initializes the mouse
	mov ax,0h
	int 33h
	
	; show mouse
	mov ax,1h
	int 33h
	
LSrc_MouseLP:							; Loop until mouse click
		mov ax,3h
		int 33h	
		
		cmp bx, 01h 							; check left mouse click
		jne LSrc_MouseLP

	shr cx, 1 								; adjust cx to range 0-319, to fit screen
	sub dx, 1 								; move one pixel, so the pixel will not be hidden by mouse
	
	cmp dx, TOP_EDGE_BUTTONS 					; checks if the mouse on the bottom of the screen
	jg LSrc_checkYLocation 					
	jmp LSrc_MouseLP
	
LSrc_checkYLocation: 						; checks if the mouse is in the Y position of the button
	cmp dx, BOTTOM_EDGE_BUTTONS
	jl LSrc_checkXLocation
	jmp LSrc_MouseLP
	
LSrc_checkXLocation:						; checks if the mouse is in the X position of the button
	cmp cx, LEFT_EDGE_BTN3
	jg LSrc_checkBackButton
	jmp LSrc_MouseLP
	
LSrc_checkBackButton: 					; checks if the back button is pressed
	cmp cx, RIGHT_EDGE_BTN3
	jl HomeScr
	
	; if cx > RIGHT_EDGE_BTN3, no button was pressed
	jmp LSrc_MouseLP
	
		
A1:										; draw in A1
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InA1 						; if al = 0, draw 2
	jmp draw4InA1						; if al = 1, draw 4
	
	draw2InA1:
		call OpenFile2
		drawA1Mac
		closeFileMac
		mov [arr + 0], 2					
		jmp checkA2
	
	draw4InA1:
		call OpenFile4
		drawA1Mac
		closeFileMac
		mov [arr + 0], 4						
		jmp checkA2	
		
	draw8InA1:
		call OpenFile8
		drawA1Mac
		closeFileMac
		mov [arr + 0], 8						
		jmp checkA2	

	draw16InA1:
		call OpenFile16
		drawA1Mac
		closeFileMac
		mov [arr + 0], 16						
		jmp checkA2	

	draw32InA1:
		call OpenFile32
		drawA1Mac
		closeFileMac
		mov [arr + 0], 32						
		jmp checkA2	

	draw64InA1:
		call OpenFile64
		drawA1Mac
		closeFileMac
		mov [arr + 0], 64						
		jmp checkA2	

	draw128InA1:
		call OpenFile128
		drawA1Mac
		closeFileMac
		mov [arr + 0], 128						
		jmp checkA2	

	draw256InA1:
		call OpenFile256
		drawA1Mac
		closeFileMac
		mov [arr + 0], 256					
		jmp checkA2	

	draw512InA1:
		call OpenFile512
		drawA1Mac
		closeFileMac
		mov [arr + 0], 512						
		jmp checkA2	

	draw1024InA1:
		call OpenFile1024
		drawA1Mac
		closeFileMac
		mov [arr + 0], 1024				
		jmp checkA2	

	draw2048InA1:
		call OpenFile2048
		drawA1Mac
		closeFileMac
		mov [arr + 0], 2048					
		jmp win		
		
A2:										; draw in A2

	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InA2 						; if al = 0, draw 2
	jmp draw4InA2						; if al = 1, draw 4
	
	draw2InA2:
		call OpenFile2
		drawA2Mac
		closeFileMac
		mov [arr + 2], 2						
		jmp checkA3
	
	draw4InA2:
		call OpenFile4
		drawA2Mac
		closeFileMac
		mov [arr + 2], 4						
		jmp checkA3	
		
	draw8InA2:
		call OpenFile8
		drawA2Mac
		closeFileMac
		mov [arr + 2], 8						
		jmp checkA3	

	draw16InA2:
		call OpenFile16
		drawA2Mac
		closeFileMac
		mov [arr + 2], 16						
		jmp checkA3	

	draw32InA2:
		call OpenFile32
		drawA2Mac
		closeFileMac
		mov [arr + 2], 32						
		jmp checkA3	

	draw64InA2:
		call OpenFile64
		drawA2Mac
		closeFileMac
		mov [arr + 2], 64						
		jmp checkA3	

	draw128InA2:
		call OpenFile128
		drawA2Mac
		closeFileMac
		mov [arr + 2], 128						
		jmp checkA3	

	draw256InA2:
		call OpenFile256
		drawA2Mac
		closeFileMac
		mov [arr + 2], 256						
		jmp checkA3	

	draw512InA2:
		call OpenFile512
		drawA2Mac
		closeFileMac
		mov [arr + 2], 512						
		jmp checkA3	

	draw1024InA2:
		call OpenFile1024
		drawA2Mac
		closeFileMac
		mov [arr + 2], 1024						
		jmp checkA3	

	draw2048InA2:
		call OpenFile2048
		drawA2Mac
		closeFileMac
		mov [arr + 2], 2048						
		jmp win
	
A3:										; draw in A3

	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InA3 						; if al = 0, draw 2
	jmp draw4InA3						; if al = 1, draw 4
	
	draw2InA3:
		call OpenFile2
		drawA3Mac
		closeFileMac
		mov [arr + 4], 2						
		jmp checkA4
	
	draw4InA3:
		call OpenFile4
		drawA3Mac
		closeFileMac
		mov [arr + 4], 4						
		jmp checkA4	
		
	draw8InA3:
		call OpenFile8
		drawA3Mac
		closeFileMac
		mov [arr + 4], 8						
		jmp checkA4	

	draw16InA3:
		call OpenFile16
		drawA3Mac
		closeFileMac
		mov [arr + 4], 16						
		jmp checkA4	

	draw32InA3:
		call OpenFile32
		drawA3Mac
		closeFileMac
		mov [arr + 4], 32						
		jmp checkA4	

	draw64InA3:
		call OpenFile64
		drawA3Mac
		closeFileMac
		mov [arr + 4], 64						
		jmp checkA4	

	draw128InA3:
		call OpenFile128
		drawA3Mac
		closeFileMac
		mov [arr + 4], 128						
		jmp checkA4	

	draw256InA3:
		call OpenFile256
		drawA3Mac
		closeFileMac
		mov [arr + 4], 256						
		jmp checkA4	

	draw512InA3:
		call OpenFile512
		drawA3Mac
		closeFileMac
		mov [arr + 4], 512						
		jmp checkA4	

	draw1024InA3:
		call OpenFile1024
		drawA3Mac
		closeFileMac
		mov [arr + 4], 1024						
		jmp checkA4	

	draw2048InA3:
		call OpenFile2048
		drawA3Mac
		closeFileMac
		mov [arr + 4], 2048						
		jmp win
	
A4:										; draw in A4
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InA4 						; if al = 0, draw 2
	jmp draw4InA4						; if al = 1, draw 4
	
	draw2InA4:
		call OpenFile2
		drawA4Mac
		closeFileMac
		mov [arr + 6], 2						
		jmp checkB1
	
	draw4InA4:
		call OpenFile4
		drawA4Mac
		closeFileMac
		mov [arr + 6], 4						
		jmp checkB1	
		
	draw8InA4:
		call OpenFile8
		drawA4Mac
		closeFileMac
		mov [arr + 6], 8						
		jmp checkB1	

	draw16InA4:
		call OpenFile16
		drawA4Mac
		closeFileMac
		mov [arr + 6], 16						
		jmp checkB1	

	draw32InA4:
		call OpenFile32
		drawA4Mac
		closeFileMac
		mov [arr + 6], 32						
		jmp checkB1	

	draw64InA4:
		call OpenFile64
		drawA4Mac
		closeFileMac
		mov [arr + 6], 64						
		jmp checkB1	

	draw128InA4:
		call OpenFile128
		drawA4Mac
		closeFileMac
		mov [arr + 6], 128						
		jmp checkB1	

	draw256InA4:
		call OpenFile256
		drawA4Mac
		closeFileMac
		mov [arr + 6], 256						
		jmp checkB1	

	draw512InA4:
		call OpenFile512
		drawA4Mac
		closeFileMac
		mov [arr + 6], 512						
		jmp checkB1	

	draw1024InA4:
		call OpenFile1024
		drawA4Mac
		closeFileMac
		mov [arr + 6], 1024						
		jmp checkB1	

	draw2048InA4:
		call OpenFile2048
		drawA4Mac
		closeFileMac
		mov [arr + 6], 2048						
		jmp win
	
B1:										; draw in B1

	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InB1 						; if al = 0, draw 2
	jmp draw4InB1						; if al = 1, draw 4
	
	draw2InB1:
		call OpenFile2
		drawB1Mac
		closeFileMac
		mov [arr + 8], 2						
		jmp checkB2
	
	draw4InB1:
		call OpenFile4
		drawB1Mac
		closeFileMac
		mov [arr + 8], 4						
		jmp checkB2	
		
	draw8InB1:
		call OpenFile8
		drawB1Mac
		closeFileMac
		mov [arr + 8], 8						
		jmp checkB2	

	draw16InB1:
		call OpenFile16
		drawB1Mac
		closeFileMac
		mov [arr + 8], 16						
		jmp checkB2	

	draw32InB1:
		call OpenFile32
		drawB1Mac
		closeFileMac
		mov [arr + 8], 32						
		jmp checkB2	

	draw64InB1:
		call OpenFile64
		drawB1Mac
		closeFileMac
		mov [arr + 8], 64						
		jmp checkB2	

	draw128InB1:
		call OpenFile128
		drawB1Mac
		closeFileMac
		mov [arr + 8], 128						
		jmp checkB2	

	draw256InB1:
		call OpenFile256
		drawB1Mac
		closeFileMac
		mov [arr + 8], 256						
		jmp checkB2	

	draw512InB1:
		call OpenFile512
		drawB1Mac
		closeFileMac
		mov [arr + 8], 512						
		jmp checkB2	

	draw1024InB1:
		call OpenFile1024
		drawB1Mac
		closeFileMac
		mov [arr + 8], 1024						
		jmp checkB2	

	draw2048InB1:
		call OpenFile2048
		drawB1Mac
		closeFileMac
		mov [arr + 8], 2048						
		jmp win	
		
B2:										; draw in B2
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InB2 						; if al = 0, draw 2
	jmp draw4InB2						; if al = 1, draw 4
	
	draw2InB2:
		call OpenFile2
		drawB2Mac
		closeFileMac
		mov [arr + 10], 2						
		jmp checkB3
	
	draw4InB2:
		call OpenFile4
		drawB2Mac
		closeFileMac
		mov [arr + 10], 4						
		jmp checkB3	
		
	draw8InB2:
		call OpenFile8
		drawB2Mac
		closeFileMac
		mov [arr + 10], 8						
		jmp checkB3	

	draw16InB2:
		call OpenFile16
		drawB2Mac
		closeFileMac
		mov [arr + 10], 16						
		jmp checkB3	

	draw32InB2:
		call OpenFile32
		drawB2Mac
		closeFileMac
		mov [arr + 10], 32						
		jmp checkB3	

	draw64InB2:
		call OpenFile64
		drawB2Mac
		closeFileMac
		mov [arr + 10], 64						
		jmp checkB3	

	draw128InB2:
		call OpenFile128
		drawB2Mac
		closeFileMac
		mov [arr + 10], 128						
		jmp checkB3	

	draw256InB2:
		call OpenFile256
		drawB2Mac
		closeFileMac
		mov [arr + 10], 256						
		jmp checkB3	

	draw512InB2:
		call OpenFile512
		drawB2Mac
		closeFileMac
		mov [arr + 10], 512						
		jmp checkB3	

	draw1024InB2:
		call OpenFile1024
		drawB2Mac
		closeFileMac
		mov [arr + 10], 1024						
		jmp checkB3	

	draw2048InB2:
		call OpenFile2048
		drawB2Mac
		closeFileMac
		mov [arr + 10], 2048						
		jmp win	
		
B3:										; draw in B3
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InB3 						; if al = 0, draw 2
	jmp draw4InB3						; if al = 1, draw 4
	
	draw2InB3:
		call OpenFile2
		drawB3Mac
		closeFileMac
		mov [arr + 12], 2						
		jmp checkB4
	
	draw4InB3:
		call OpenFile4
		drawB3Mac
		closeFileMac
		mov [arr + 12], 4						
		jmp checkB4	
		
	draw8InB3:
		call OpenFile8
		drawB3Mac
		closeFileMac
		mov [arr + 12], 8						
		jmp checkB4	

	draw16InB3:
		call OpenFile16
		drawB3Mac
		closeFileMac
		mov [arr + 12], 16						
		jmp checkB4	

	draw32InB3:
		call OpenFile32
		drawB3Mac
		closeFileMac
		mov [arr + 12], 32						
		jmp checkB4	

	draw64InB3:
		call OpenFile64
		drawB3Mac
		closeFileMac
		mov [arr + 12], 64						
		jmp checkB4	

	draw128InB3:
		call OpenFile128
		drawB3Mac
		closeFileMac
		mov [arr + 12], 128						
		jmp checkB4	

	draw256InB3:
		call OpenFile256
		drawB3Mac
		closeFileMac
		mov [arr + 12], 256						
		jmp checkB4	

	draw512InB3:
		call OpenFile512
		drawB3Mac
		closeFileMac
		mov [arr + 12], 512						
		jmp checkB4	

	draw1024InB3:
		call OpenFile1024
		drawB3Mac
		closeFileMac
		mov [arr + 12], 1024						
		jmp checkB4	

	draw2048InB3:
		call OpenFile2048
		drawB3Mac
		closeFileMac
		mov [arr + 12], 2048						
		jmp win	
		
B4:										; draw in B4
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InB4 						; if al = 0, draw 2
	jmp draw4InB4						; if al = 1, draw 4
	
	draw2InB4:
		call OpenFile2
		drawB4Mac
		closeFileMac
		mov [arr + 14], 2						
		jmp checkC1
	
	draw4InB4:
		call OpenFile4
		drawB4Mac
		closeFileMac
		mov [arr + 14], 4						
		jmp checkC1	
		
	draw8InB4:
		call OpenFile8
		drawB4Mac
		closeFileMac
		mov [arr + 14], 8						
		jmp checkC1	

	draw16InB4:
		call OpenFile16
		drawB4Mac
		closeFileMac
		mov [arr + 14], 16						
		jmp checkC1	

	draw32InB4:
		call OpenFile32
		drawB4Mac
		closeFileMac
		mov [arr + 14], 32						
		jmp checkC1	

	draw64InB4:
		call OpenFile64
		drawB4Mac
		closeFileMac
		mov [arr + 14], 64						
		jmp checkC1	

	draw128InB4:
		call OpenFile128
		drawB4Mac
		closeFileMac
		mov [arr + 14], 128						
		jmp checkC1	

	draw256InB4:
		call OpenFile256
		drawB4Mac
		closeFileMac
		mov [arr + 14], 256						
		jmp checkC1	

	draw512InB4:
		call OpenFile512
		drawB4Mac
		closeFileMac
		mov [arr + 14], 512						
		jmp checkC1	

	draw1024InB4:
		call OpenFile1024
		drawB4Mac
		closeFileMac
		mov [arr + 14], 1024						
		jmp checkC1	

	draw2048InB4:
		call OpenFile2048
		drawB4Mac
		closeFileMac
		mov [arr + 14], 2048						
		jmp win	
	
C1:										; draw in C1
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InC1 						; if al = 0, draw 2
	jmp draw4InC1						; if al = 1, draw 4
	
	draw2InC1:
		call OpenFile2
		drawC1Mac
		closeFileMac
		mov [arr + 16], 2						
		jmp checkC2
	
	draw4InC1:
		call OpenFile4
		drawC1Mac
		closeFileMac
		mov [arr + 16], 4						
		jmp checkC2	
		
	draw8InC1:
		call OpenFile8
		drawC1Mac
		closeFileMac
		mov [arr + 16], 8						
		jmp checkC2	

	draw16InC1:
		call OpenFile16
		drawC1Mac
		closeFileMac
		mov [arr + 16], 16						
		jmp checkC2	

	draw32InC1:
		call OpenFile32
		drawC1Mac
		closeFileMac
		mov [arr + 16], 32						
		jmp checkC2	

	draw64InC1:
		call OpenFile64
		drawC1Mac
		closeFileMac
		mov [arr + 16], 64						
		jmp checkC2	

	draw128InC1:
		call OpenFile128
		drawC1Mac
		closeFileMac
		mov [arr + 16], 128						
		jmp checkC2	

	draw256InC1:
		call OpenFile256
		drawC1Mac
		closeFileMac
		mov [arr + 16], 256						
		jmp checkC2	

	draw512InC1:
		call OpenFile512
		drawC1Mac
		closeFileMac
		mov [arr + 16], 512						
		jmp checkC2	

	draw1024InC1:
		call OpenFile1024
		drawC1Mac
		closeFileMac
		mov [arr + 16], 1024						
		jmp checkC2	

	draw2048InC1:
		call OpenFile2048
		drawC1Mac
		closeFileMac
		mov [arr + 16], 2048						
		jmp win	
		
C2:										; draw in C2
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InC2 						; if al = 0, draw 2
	jmp draw4InC2						; if al = 1, draw 4
	
	draw2InC2:
		call OpenFile2
		drawC2Mac
		closeFileMac
		mov [arr + 18], 2						
		jmp checkC3
	
	draw4InC2:
		call OpenFile4
		drawC2Mac
		closeFileMac
		mov [arr + 18], 4						
		jmp checkC3	
		
	draw8InC2:
		call OpenFile8
		drawC2Mac
		closeFileMac
		mov [arr + 18], 8						
		jmp checkC3	

	draw16InC2:
		call OpenFile16
		drawC2Mac
		closeFileMac
		mov [arr + 18], 16						
		jmp checkC3	

	draw32InC2:
		call OpenFile32
		drawC2Mac
		closeFileMac
		mov [arr + 18], 32						
		jmp checkC3	

	draw64InC2:
		call OpenFile64
		drawC2Mac
		closeFileMac
		mov [arr + 18], 64						
		jmp checkC3	

	draw128InC2:
		call OpenFile128
		drawC2Mac
		closeFileMac
		mov [arr + 18], 128						
		jmp checkC3	

	draw256InC2:
		call OpenFile256
		drawC2Mac
		closeFileMac
		mov [arr + 18], 256						
		jmp checkC3	

	draw512InC2:
		call OpenFile512
		drawC2Mac
		closeFileMac
		mov [arr + 18], 512						
		jmp checkC3	

	draw1024InC2:
		call OpenFile1024
		drawC2Mac
		closeFileMac
		mov [arr + 18], 1024						
		jmp checkC3	

	draw2048InC2:
		call OpenFile2048
		drawC2Mac
		closeFileMac
		mov [arr + 18], 2048						
		jmp win	
		
C3:										; draw in C3
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InC3 						; if al = 0, draw 2
	jmp draw4InC3						; if al = 1, draw 4
	
	draw2InC3:
		call OpenFile2
		drawC3Mac
		closeFileMac
		mov [arr + 20], 2						
		jmp checkC4
	
	draw4InC3:
		call OpenFile4
		drawC3Mac
		closeFileMac
		mov [arr + 20], 4						
		jmp checkC4	
		
	draw8InC3:
		call OpenFile8
		drawC3Mac
		closeFileMac
		mov [arr + 20], 8						
		jmp checkC4	

	draw16InC3:
		call OpenFile16
		drawC3Mac
		closeFileMac
		mov [arr + 20], 16						
		jmp checkC4	

	draw32InC3:
		call OpenFile32
		drawC3Mac
		closeFileMac
		mov [arr + 20], 32						
		jmp checkC4	

	draw64InC3:
		call OpenFile64
		drawC3Mac
		closeFileMac
		mov [arr + 20], 64						
		jmp checkC4	

	draw128InC3:
		call OpenFile128
		drawC3Mac
		closeFileMac
		mov [arr + 20], 128						
		jmp checkC4	

	draw256InC3:
		call OpenFile256
		drawC3Mac
		closeFileMac
		mov [arr + 20], 256						
		jmp checkC4	

	draw512InC3:
		call OpenFile512
		drawC3Mac
		closeFileMac
		mov [arr + 20], 512						
		jmp checkC4	

	draw1024InC3:
		call OpenFile1024
		drawC3Mac
		closeFileMac
		mov [arr + 20], 1024						
		jmp checkC4	

	draw2048InC3:
		call OpenFile2048
		drawC3Mac
		closeFileMac
		mov [arr + 20], 2048						
		jmp win	
		
C4:										; draw in C4
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InC4 						; if al = 0, draw 2
	jmp draw4InC4						; if al = 1, draw 4
	
	draw2InC4:
		call OpenFile2
		drawC4Mac
		closeFileMac
		mov [arr + 22], 2						
		jmp checkD1

	draw4InC4:
		call OpenFile4
		drawC4Mac
		closeFileMac
		mov [arr + 22], 4						
		jmp checkD1	
		
	draw8InC4:
		call OpenFile8
		drawC4Mac
		closeFileMac
		mov [arr + 22], 8						
		jmp checkD1	

	draw16InC4:
		call OpenFile16
		drawC4Mac
		closeFileMac
		mov [arr + 22], 16						
		jmp checkD1	

	draw32InC4:
		call OpenFile32
		drawC4Mac
		closeFileMac
		mov [arr + 22], 32						
		jmp checkD1	

	draw64InC4:
		call OpenFile64
		drawC4Mac
		closeFileMac
		mov [arr + 22], 64						
		jmp checkD1	

	draw128InC4:
		call OpenFile128
		drawC4Mac
		closeFileMac
		mov [arr + 22], 128						
		jmp checkD1	

	draw256InC4:
		call OpenFile256
		drawC4Mac
		closeFileMac
		mov [arr + 22], 256						
		jmp checkD1	

	draw512InC4:
		call OpenFile512
		drawC4Mac
		closeFileMac
		mov [arr + 22], 512						
		jmp checkD1	

	draw1024InC4:
		call OpenFile1024
		drawC4Mac
		closeFileMac
		mov [arr + 22], 1024						
		jmp checkD1	

	draw2048InC4:
		call OpenFile2048
		drawC4Mac
		closeFileMac
		mov [arr + 22], 2048						
		jmp win	
	
D1:										; draw in D1
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InD1 						; if al = 0, draw 2
	jmp draw4InD1						; if al = 1, draw 4
	
	draw2InD1:
		call OpenFile2
		drawD1Mac
		closeFileMac
		mov [arr + 24], 2						
		jmp checkD2
	
	draw4InD1:
		call OpenFile4
		drawD1Mac
		closeFileMac
		mov [arr + 24], 4						
		jmp checkD2	
		
	draw8InD1:
		call OpenFile8
		drawD1Mac
		closeFileMac
		mov [arr + 24], 8						
		jmp checkD2	

	draw16InD1:
		call OpenFile16
		drawD1Mac
		closeFileMac
		mov [arr + 24], 16						
		jmp checkD2	

	draw32InD1:
		call OpenFile32
		drawD1Mac
		closeFileMac
		mov [arr + 24], 32						
		jmp checkD2	

	draw64InD1:
		call OpenFile64
		drawD1Mac
		closeFileMac
		mov [arr + 24], 64						
		jmp checkD2	

	draw128InD1:
		call OpenFile128
		drawD1Mac
		closeFileMac
		mov [arr + 24], 128						
		jmp checkD2	

	draw256InD1:
		call OpenFile256
		drawD1Mac
		closeFileMac
		mov [arr + 24], 256						
		jmp checkD2	

	draw512InD1:
		call OpenFile512
		drawD1Mac
		closeFileMac
		mov [arr + 24], 512						
		jmp checkD2	

	draw1024InD1:
		call OpenFile1024
		drawD1Mac
		closeFileMac
		mov [arr + 24], 1024						
		jmp checkD2	

	draw2048InD1:
		call OpenFile2048
		drawD1Mac
		closeFileMac
		mov [arr + 24], 2048						
		jmp win	
		
D2:										; draw in D2
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InD2 						; if al = 0, draw 2
	jmp draw4InD2						; if al = 1, draw 4
	
	draw2InD2:
		call OpenFile2
		drawD2Mac
		closeFileMac
		mov [arr + 26], 2						
		jmp checkD3
	
	draw4InD2:
		call OpenFile4
		drawD2Mac
		closeFileMac
		mov [arr + 26], 4						
		jmp checkD3	
		
	draw8InD2:
		call OpenFile8
		drawD2Mac
		closeFileMac
		mov [arr + 26], 8						
		jmp checkD3	

	draw16InD2:
		call OpenFile16
		drawD2Mac
		closeFileMac
		mov [arr + 26], 16						
		jmp checkD3	

	draw32InD2:
		call OpenFile32
		drawD2Mac
		closeFileMac
		mov [arr + 26], 32						
		jmp checkD3	

	draw64InD2:
		call OpenFile64
		drawD2Mac
		closeFileMac
		mov [arr + 26], 64						
		jmp checkD3	

	draw128InD2:
		call OpenFile128
		drawD2Mac
		closeFileMac
		mov [arr + 26], 128						
		jmp checkD3	

	draw256InD2:
		call OpenFile256
		drawD2Mac
		closeFileMac
		mov [arr + 26], 256						
		jmp checkD3	

	draw512InD2:
		call OpenFile512
		drawD2Mac
		closeFileMac
		mov [arr + 26], 512						
		jmp checkD3	

	draw1024InD2:
		call OpenFile1024
		drawD2Mac
		closeFileMac
		mov [arr + 26], 1024						
		jmp checkD3	

	draw2048InD2:
		call OpenFile2048
		drawD2Mac
		closeFileMac
		mov [arr + 26], 2048						
		jmp win	
		
D3:										; draw in D3
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InD3 						; if al = 0, draw 2
	jmp draw4InD3						; if al = 1, draw 4
	
	draw2InD3:
		call OpenFile2
		drawD3Mac
		closeFileMac
		mov [arr + 28], 2						
		jmp checkD4
	
	draw4InD3:
		call OpenFile4
		drawD3Mac
		closeFileMac
		mov [arr + 28], 4						
		jmp checkD4	
		
	draw8InD3:
		call OpenFile8
		drawD3Mac
		closeFileMac
		mov [arr + 28], 8						
		jmp checkD4	

	draw16InD3:
		call OpenFile16
		drawD3Mac
		closeFileMac
		mov [arr + 28], 16						
		jmp checkD4	

	draw32InD3:
		call OpenFile32
		drawD3Mac
		closeFileMac
		mov [arr + 28], 32						
		jmp checkD4	

	draw64InD3:
		call OpenFile64
		drawD3Mac
		closeFileMac
		mov [arr + 28], 64						
		jmp checkD4	

	draw128InD3:
		call OpenFile128
		drawD3Mac
		closeFileMac
		mov [arr + 28], 128						
		jmp checkD4	

	draw256InD3:
		call OpenFile256
		drawD3Mac
		closeFileMac
		mov [arr + 28], 256						
		jmp checkD4	

	draw512InD3:
		call OpenFile512
		drawD3Mac
		closeFileMac
		mov [arr + 28], 512						
		jmp checkD4	

	draw1024InD3:
		call OpenFile1024
		drawD3Mac
		closeFileMac
		mov [arr + 28], 1024						
		jmp checkD4	

	draw2048InD3:
		call OpenFile2048
		drawD3Mac
		closeFileMac
		mov [arr + 28], 2048						
		jmp win	
		
D4:										; draw in D4
	; random number between 0-1
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		and al, 0001b	
	; al equals to 0 or 1
	
	cmp al, 0
	je draw2InD4 						; if al = 0, draw 2
	jmp draw4InD4						; if al = 1, draw 4
	
	draw2InD4:
		call OpenFile2
		drawD4Mac
		closeFileMac
		mov [arr + 30], 2						
		jmp finalCheck
	
	draw4InD4:
		call OpenFile4
		drawD4Mac
		closeFileMac
		mov [arr + 30], 4						
		jmp finalCheck	
		
	draw8InD4:
		call OpenFile8
		drawD4Mac
		closeFileMac
		mov [arr + 30], 8						
		jmp finalCheck	

	draw16InD4:
		call OpenFile16
		drawD4Mac
		closeFileMac
		mov [arr + 30], 16						
		jmp finalCheck	

	draw32InD4:
		call OpenFile32
		drawD4Mac
		closeFileMac
		mov [arr + 30], 32						
		jmp finalCheck	

	draw64InD4:
		call OpenFile64
		drawD4Mac
		closeFileMac
		mov [arr + 30], 64						
		jmp finalCheck	

	draw128InD4:
		call OpenFile128
		drawD4Mac
		closeFileMac
		mov [arr + 30], 128						
		jmp finalCheck	

	draw256InD4:
		call OpenFile256
		drawD4Mac
		closeFileMac
		mov [arr + 30], 256						
		jmp finalCheck	

	draw512InD4:
		call OpenFile512
		drawD4Mac
		closeFileMac
		mov [arr + 30], 512						
		jmp finalCheck	

	draw1024InD4:
		call OpenFile1024
		drawD4Mac
		closeFileMac
		mov [arr + 30], 1024						
		jmp finalCheck	

	draw2048InD4:
		call OpenFile2048
		drawD4Mac
		closeFileMac
		mov [arr + 30], 2048						
		jmp win

WaitForData:

	call checkLose 						; call the procedure that checks if the user lost
	
	; Wait for key press
	mov ah, 1
	int 16h
	jnz dataFromKeyboard
	
dataFromKeyboard:
	mov ah, 0 							; there is a key in the buffer, read it and clear the buffer
	int 16h

	cmp ah, 17 							; if 'W' was Pressed - jmp to move up
	je move_up
	
	cmp ah, 31	 						; if 's' was Pressed - jmp to move down		
	je move_down
	
	cmp ah, 32	 						; if 'd' was Pressed - jmp to move right
	je move_right
	
	cmp ah, 30	 						; if 'a' was Pressed - jmp to move left
	je move_left

	cmp ah, 13h 						; if 'r' was Pressed - restart the game
	je GameSrc
	
	cmp ah, 23h 						; if 'H' was Pressed - restart the game
	je HomeScr	
	
	; if no one of these keys were pressed:
	jmp WaitForData

; for each cell in the array, if it is zero, Replace it with the cell above X3
move_up:

	mov cx, 3 								; loop 3 times 								
	
MU_firstColumnCheck:						; move up all the first Column
	
MU_check0:
	cmp [arr+0], 0
	je replaces0In8LP
	
MU_check8:
	cmp [arr+8], 0
	je replaces8In16LP
	
MU_check16:
	cmp [arr+16], 0
	je replaces16In24LP
	
MU_check24:
	

loop MU_firstColumnCheck	

;---------------------------------------

	mov cx, 3 								; loop 3 times 								
	
MU_secondColumnCheck:						; move up all the second Column
	
MU_check2:
	cmp [arr+2], 0
	je replaces2In10LP	

MU_check10:
	cmp [arr+10], 0
	je replaces10In18LP
	
MU_check18:
	cmp [arr+18], 0
	je replaces18In26LP
	
MU_check26:

loop MU_secondColumnCheck	

;---------------------------------------
	mov cx, 3 								; loop 3 times
	
MU_thirdColumnCheck:						; move up all the first Column
	
MU_check4:
	cmp [arr+4], 0
	je replaces4In12LP
	
MU_check12:
	cmp [arr+12], 0
	je replaces12In20LP
	
MU_check20:
	cmp [arr+20], 0
	je replaces20In28LP
	
MU_check28:

loop MU_thirdColumnCheck	

;---------------------------------------
	mov cx, 3 								; loop 3 times
	
MU_forthColumnCheck:						; move up all the first Column
	
MU_check6:
	cmp [arr+6], 0
	je replaces6In14LP

MU_check14:
	cmp [arr+14], 0
	je replaces14In22LP

MU_check22:
	cmp [arr+22], 0
	je replaces22In30LP	
	
MU_check30:

loop MU_forthColumnCheck	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
call draw	
call combineUp
call addNumber

jmp WaitForData
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	replaces0In8LP: 
		mov ax, [arr + 8]
		mov [arr + 0], ax
		mov [arr + 8], 0
		
		jmp MU_check8
		
	replaces8In16LP: 
		mov ax, [arr + 16]
		mov [arr + 8], ax
		mov [arr + 16], 0
		
		jmp MU_check16
		
	replaces16In24LP:
		mov ax, [arr + 24]
		mov [arr + 16], ax
		mov [arr + 24], 0
		
		jmp MU_check24
		
	replaces2In10LP:
		mov ax, [arr + 10]
		mov [arr + 2], ax
		mov [arr + 10], 0
		
		jmp MU_check10
		
	replaces10In18LP:
		mov ax, [arr + 18]
		mov [arr + 10], ax
		mov [arr + 18], 0
		
		jmp MU_check18

	replaces18In26LP:
		mov ax, [arr + 26]
		mov [arr + 18], ax
		mov [arr + 26], 0
		
		jmp MU_check26	
		
	replaces4In12LP:
		mov ax, [arr + 12]
		mov [arr + 4], ax
		mov [arr + 12], 0
		
		jmp MU_check12

	replaces12In20LP:
		mov ax, [arr + 20]
		mov [arr + 12], ax
		mov [arr + 20], 0
		
		jmp MU_check20

	replaces20In28LP:
		mov ax, [arr + 28]
		mov [arr + 20], ax
		mov [arr + 28], 0
		
		jmp MU_check28		
		
	replaces6In14LP:
		mov ax, [arr + 14]
		mov [arr + 6], ax
		mov [arr + 14], 0
		
		jmp MU_check14
	
	replaces14In22LP:
		mov ax, [arr + 22]
		mov [arr + 14], ax
		mov [arr + 22], 0
		
		jmp MU_check22

	replaces22In30LP:
		mov ax, [arr + 30]
		mov [arr + 22], ax
		mov [arr + 30], 0
		
		jmp MU_check30		

; for each cell in the array, if it is zero, Replace it with the cell on below X3
move_down:
	
	mov cx, 3 								; loop 3 times
	
MD_firstColumnCheck:						; move down all the first Column
	
MD_check24:
	cmp [arr+24], 0
	je replaces24In16LP

MD_check16:
	cmp [arr+16], 0
	je replaces16In8LP

MD_check8:
	cmp [arr+8], 0
	je replaces8In0LP
		
MD_check0:
	

loop MD_firstColumnCheck	

;---------------------------------------

	mov cx, 3 								; loop 3 times
	
MD_secondColumnCheck:						; move down all the first Column
	
MD_check26:
	cmp [arr+26], 0
	je replaces26In18LP

MD_check18:
	cmp [arr+18], 0
	je replaces18In10LP

MD_check10:
	cmp [arr+10], 0
	je replaces10In2LP
		
MD_check2:
	

loop MD_secondColumnCheck	

;---------------------------------------
	mov cx, 3 								; loop 3 times
	
MD_thirdColumnCheck:						; move down all the first Column
	
MD_check28:
	cmp [arr+28], 0
	je replaces28In20LP

MD_check20:
	cmp [arr+20], 0
	je replaces20In12LP

MD_check12:
	cmp [arr+12], 0
	je replaces12In4LP
		
MD_check4:
	

loop MD_thirdColumnCheck	

;---------------------------------------
	mov cx, 3 								; loop 3 times
	
MD_forthColumnCheck:						; move down all the first Column
	
MD_check30:
	cmp [arr+30], 0
	je replaces30In22LP

MD_check22:
	cmp [arr+22], 0
	je replaces22In14LP

MD_check14:
	cmp [arr+14], 0
	je replaces14In6LP
		
MD_check6:
	
loop MD_forthColumnCheck	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
call draw	
call combineDown
call addNumber

jmp WaitForData
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	replaces24In16LP: 
		mov ax, [arr + 16]
		mov [arr + 24], ax
		mov [arr + 16], 0
		
		jmp MD_check16
		
	replaces16In8LP: 
		mov ax, [arr + 8]
		mov [arr + 16], ax
		mov [arr + 8], 0
		
		jmp MD_check8
		
	replaces8In0LP:
		mov ax, [arr + 0]
		mov [arr + 8], ax
		mov [arr + 0], 0
		
		jmp MD_check0
		
	replaces26In18LP: 
		mov ax, [arr + 18]
		mov [arr + 26], ax
		mov [arr + 18], 0
		
		jmp MD_check18
		
	replaces18In10LP: 
		mov ax, [arr + 10]
		mov [arr + 18], ax
		mov [arr + 10], 0
		
		jmp MD_check10
		
	replaces10In2LP:
		mov ax, [arr + 2]
		mov [arr + 10], ax
		mov [arr + 2], 0
		
		jmp MD_check2
		
	replaces28In20LP: 
		mov ax, [arr + 20]
		mov [arr + 28], ax
		mov [arr + 20], 0
		
		jmp MD_check20
		
	replaces20In12LP: 
		mov ax, [arr + 12]
		mov [arr + 20], ax
		mov [arr + 12], 0
		
		jmp MD_check12
		
	replaces12In4LP:
		mov ax, [arr + 4]
		mov [arr + 12], ax
		mov [arr + 4], 0
		
		jmp MD_check4
		
	replaces30In22LP: 
		mov ax, [arr + 22]
		mov [arr + 30], ax
		mov [arr + 22], 0
		
		jmp MD_check22

	replaces22In14LP: 
		mov ax, [arr + 14]
		mov [arr + 22], ax
		mov [arr + 14], 0
		
		jmp MD_check14
		
	replaces14In6LP:
		mov ax, [arr + 6]
		mov [arr + 14], ax
		mov [arr + 6], 0
		
		jmp MD_check6

; for each cell in the array, if it is zero, Replace it with the cell on the right X3
move_right:

	mov cx, 3 								; loop 3 times 								
;---------------------------------------
	MR_firstRowCheck:						; move right all the first row
		
	MR_check3:
		cmp [arr + 6], 0
		je replaces3In2LP

	MR_check2:
		cmp [arr + 4], 0
		je replaces2In1LP
		
	MR_check1:
		cmp [arr + 2], 0
		je replaces1In0LP
		
	MR_check0:
	
	loop MR_firstRowCheck	
;---------------------------------------

	mov cx, 3 								; loop 3 times 							
	
	MR_secondRowCheck:					; move left all the second row
	
	MR_check7:
		cmp [arr + 14], 0
		je replaces7In6LP
		
	MR_check6:
		cmp [arr + 12], 0
		je replaces6In5LP	
		
	MR_check5:
		cmp [arr + 10], 0
		je replaces5In4LP
		
	MR_check4:
	
	loop MR_secondRowCheck
;---------------------------------------

	mov cx, 3 								; loop 3 times 							

	MR_thirdRowCheck:					; move left all the third row	
	MR_check11:
		cmp [arr + 22], 0
		je replaces11In10LP	
		
	MR_check10:
		cmp [arr + 20], 0
		je replaces10In9LP
		
	MR_check9:
		cmp [arr + 18], 0
		je replaces9In8LP
		
	MR_check8:
	
	loop MR_thirdRowCheck
;---------------------------------------
	mov cx, 3 								; loop 3 times 							

	MR_fourthRowCheck:					; move left all the fourth row

	MR_check15:
		cmp [arr + 30], 0
		je replaces15In14LP
		
	MR_check14:
		cmp [arr + 28], 0
		je replaces14In13LP		
		
	MR_check13:
		cmp [arr + 26], 0
		je replaces13In12LP
	
	MR_check12:
	
	loop MR_fourthRowCheck
;---------------------------------------
call draw	
call combineRight
call addNumber

jmp WaitForData
;---------------------------------------
	replaces3In2LP: 
		mov ax, [arr + 4]
		mov [arr + 6], ax
		mov [arr + 4], 0
		
		jmp MR_check2
		
	replaces2In1LP: 
		mov ax, [arr + 2]
		mov [arr + 4], ax
		mov [arr + 2], 0
		
		jmp MR_check1
		
	replaces1In0LP:
		mov ax, [arr + 0]
		mov [arr + 2], ax
		mov [arr + 0], 0
		
		jmp MR_check0
		
	replaces7In6LP:
		mov ax, [arr + 12]
		mov [arr + 14], ax
		mov [arr + 12], 0
		
		jmp MR_check6
		
	replaces6In5LP:
		mov ax, [arr + 10]
		mov [arr + 12], ax
		mov [arr + 10], 0
		
		jmp MR_check5	
		
	replaces5In4LP:
		mov ax, [arr + 8]
		mov [arr + 10], ax
		mov [arr + 8], 0
		
		jmp MR_check4
		
	replaces11In10LP:
		mov ax, [arr + 20]
		mov [arr + 22], ax
		mov [arr + 20], 0
		
		jmp MR_check10
		
	replaces10In9LP:
		mov ax, [arr + 18]
		mov [arr + 20], ax
		mov [arr + 18], 0
		
		jmp MR_check9
		
	replaces9In8LP:
		mov ax, [arr + 16]
		mov [arr + 18], ax
		mov [arr + 16], 0
		
		jmp MR_check8
		
	replaces15In14LP:
		mov ax, [arr + 28]
		mov [arr + 30], ax
		mov [arr + 28], 0
		
		jmp MR_check14

	replaces14In13LP:
		mov ax, [arr + 26]
		mov [arr + 28], ax
		mov [arr + 26], 0

		jmp MR_check13
		
	replaces13In12LP:
		mov ax, [arr + 24]
		mov [arr + 26], ax
		mov [arr + 24], 0
		
		jmp MR_check12

; for each cell in the array, if it is zero, Replace it with the cell the left X3

move_left:

	mov cx, 3 								; loop 3 times 							
;---------------------------------------

	ML_firstRowCheck:						; move left all the first row
	ML_check0:
		cmp [arr + 0], 0
		je replaces0In1LP
		
	ML_check1:
		cmp [arr + 2], 0
		je replaces1In2LP
		
	ML_check2:
		cmp [arr + 4], 0
		je replaces2In3LP
		
	ML_check3:
	
	loop ML_firstRowCheck	
;---------------------------------------

	mov cx, 3 								; loop 3 times 							
	
	ML_secondRowCheck:					; move left all the second row
	ML_check4:
		cmp [arr + 8], 0
		je replaces4In5LP
		
	ML_check5:
		cmp [arr + 10], 0
		je replaces5In6LP
		
	ML_check6:
		cmp [arr + 12], 0
		je replaces6In7LP
	
	ML_check7:
	
	loop ML_secondRowCheck
;---------------------------------------

	mov cx, 3 								; loop 3 times 							

	ML_thirdRowCheck:					; move left all the third row
	ML_check8:
		cmp [arr + 16], 0
		je replaces8In9LP
		
	ML_check9:
		cmp [arr + 18], 0
		je replaces9In10LP
		
	ML_check10:
		cmp [arr + 20], 0
		je replaces10In11LP
	
	ML_check11:
	
	loop ML_thirdRowCheck
;---------------------------------------
	mov cx, 3 								; loop 3 times 							

	ML_fourthRowCheck:					; move left all the fourth row
	ML_check12:
		cmp [arr + 24], 0
		je replaces12In13LP
		
	ML_check13:
		cmp [arr + 26], 0
		je replaces13In14LP
		
	ML_check14:
		cmp [arr + 28], 0
		je replaces14In15LP
	
	ML_check15:
	
	loop ML_fourthRowCheck
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
call draw
call combineLeft
call addNumber

jmp WaitForData
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	replaces0In1LP:
		mov ax, [arr + 2]
		mov [arr + 0], ax
		mov [arr + 2], 0
		
		jmp ML_check1
		
	replaces1In2LP:
		mov ax, [arr + 4]
		mov [arr + 2], ax
		mov [arr + 4], 0
		
		jmp ML_check2
		
	replaces2In3LP:
		mov ax, [arr + 6]
		mov [arr + 4], ax
		mov [arr + 6], 0
		
		jmp ML_check3
		
	replaces4In5LP:
		mov ax, [arr + 10]
		mov [arr + 8], ax
		mov [arr + 10], 0
		
		jmp ML_check5
		
	replaces5In6LP:
		mov ax, [arr + 12]
		mov [arr + 10], ax
		mov [arr + 12], 0
		
		jmp ML_check6	
		
	replaces6In7LP:
		mov ax, [arr + 14]
		mov [arr + 12], ax
		mov [arr + 14], 0
		
		jmp ML_check7
		
	replaces8In9LP:
		mov ax, [arr + 18]
		mov [arr + 16], ax
		mov [arr + 18], 0
		
		jmp ML_check9
		
	replaces9In10LP:
		mov ax, [arr + 20]
		mov [arr + 18], ax
		mov [arr + 20], 0
		
		jmp ML_check10
		
	replaces10In11LP:
		mov ax, [arr + 22]
		mov [arr + 20], ax
		mov [arr + 22], 0
		
		jmp ML_check11
		
	replaces12In13LP:
		mov ax, [arr + 26]
		mov [arr + 24], ax
		mov [arr + 26], 0
		
		jmp ML_check13

	replaces13In14LP:
		mov ax, [arr + 28]
		mov [arr + 26], ax
		mov [arr + 28], 0
		
		jmp ML_check14
		
	replaces14In15LP:
		mov ax, [arr + 30]
		mov [arr + 28], ax
		mov [arr + 30], 0
		
		jmp ML_check15
		
exit:
	; Back to text mode
	mov ah, 0
	mov al, 2
	int 10h
	
	mov ax, 4c00h
	int 21h
END start