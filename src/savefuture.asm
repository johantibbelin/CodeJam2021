;
; OLC CodeJam 2021- Save the Future
;
; For the Atari 8-bit computers (64kB needed)
;
; Coded by: sjfroos
;
; Adresses needed
;
VCOUNT=$d40b
WSYNC=$d40a
XITVBV=$e462
HSCRL=$d404
SETVBV=$e45c
COLOR0=708
COLOR1=709
COLOR2=710
COLOR3=711
COLOR4=712
CHBAS=756
COLPF0=$d016
COLPF1=$d017
COLPF2=$d018
COLPF3=$d019
COLBK=$d01a
CHBASE=$d409
NMIEN=$d40e
;
; Start adress
;
	org $2000

;
; Init
;

start
; 	Load display list
	lda #<dl
	sta $230
	lda #>dl
	sta $231
	; wide playfield
	;lda #35
	;sta $22f
	lda #0
	sta HSCRL

	; Character set at $7000
	lda #$70
	sta CHBAS

	; set colors
	
	lda #$88
	sta COLOR4

	lda #$09
	sta COLOR0
	
	lda #$0f
	sta COLOR2 

	lda #$06
	sta COLOR3
	
	; Set DLI
	lda #<dli
	sta $200
	lda #>dli
	sta $201
	lda #$CF
	sta $d40e
	

stop	jmp stop	

;
	run start	
;
; VBI routine
;


;
; DLI Routines
;
dli	pha
	lda #$4e
	sta WSYNC
	sta COLBK
	lda #<dli2
	sta $200
	lda #>dli2
	sta $201
	pla
	rti

dli2	pha
	 	lda #$4c
	 	sta WSYNC
	 	sta COLBK
		lda #<dli3
		sta $200
		lda #>dli3
		sta $201
	 	pla 
	 	rti

dli3	pha
	 	lda #$4a
	 	sta WSYNC
	 	sta COLBK
		lda #<dli4
		sta $200
		lda #>dli4
		sta $201
	 	pla 
	 	rti

dli4	pha
	 	lda #$48
	 	sta WSYNC
	 	sta COLBK
		lda #<dli5
		sta $200
		lda #>dli5
		sta $201
	 	pla 
	 	rti

dli5	pha
	 	lda #$d4
	 	sta WSYNC
	 	sta COLBK
		lda #<dli6
		sta $200
		lda #>dli6
		sta $201
	 	pla 
	 	rti

dli6	pha
	 	lda #$00
	 	sta WSYNC
	 	sta COLBK
	 	lda #$48
	 	sta COLPF0
	 	lda #$E0
	 	sta CHBASE
		lda #<dli
		sta $200
		lda #>dli
		sta $201
	 	pla 
	 	rti

atch 	.byte $00
;-----------------------------
; Data	
;-----------------------------
; Display List
;
	.local dl
	.byte $70
lms00	.byte $45,$00,$40
lms01	.byte $45,$00,$41
lms02	.byte $44,$00,$42
lms03	.byte $44,$00,$43
lms04	.byte $44,$00,$44
lms05	.byte $44,$00,$45
lms06	.byte $E4,$00,$46
lms07	.byte $E4,$00,$47
lms08	.byte $E4,$00,$48
lms09	.byte $E4,$00,$49
lms10	.byte $E4,$00,$50
lms11	.byte $44,$00,$51
lms12	.byte $44,$00,$52
lms13	.byte $44,$00,$53
lms14	.byte $44,$00,$54
lms15	.byte $44,$00,$55
lms16	.byte $44,$00,$56
lms17	.byte $44,$00,$57
lms18	.byte $44,$00,$58
lms19	.byte $44,$00,$60
lms20	.byte $44,$00,$61
lms21	.byte $44,$00,$62
lms22	.byte $44,$00,$63
lms23	.byte $D4,$00,$64
txt		.byte $46,$00,$65
		.byte $41,a(dl)
	.endl
;
; Screen memory
;
	org $4000
	.local sm
	.byte $00,$01,$02,$03,$04,$81,$82,$83,$84,$00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.endl
	org $4100
	.byte $00,$05,$06,$07,$08,$85,$86,$87,$88
	org $4200
	.byte $00,$01,$02,$03,$04,$81,$82,$83,$84
	org $4300
	.byte $00,$05,$06,$07,$08,$85,$86,$87,$88
	
	org $6500
	;.local text	
text	.byte "  Save the Future"
	
		
;
; Character sets
;
	org $7000
	.local chset0
	.byte $00,$00,$00,$00,$00,$00,$00,$00


	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000001
	.byte %00000111
	.byte %00011111
	.byte %01111111


	.byte %00000001
	.byte %00000111
	.byte %00011111
	.byte %01111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111110

	.byte %01000000
	.byte %11010000
	.byte %11110100
	.byte %11111101
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %10111111

	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %01000000
	.byte %11010000
	.byte %11110100
	.byte %11111101

	.byte %01111111
	.byte %00011111
	.byte %00000111
	.byte %00000001
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000

	.byte %11111110
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %01111111
	.byte %00011111
	.byte %00000111
	.byte %00000001

	.byte %10111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111101
	.byte %11110100
	.byte %11010000
	.byte %01000000

	.byte %11111101
	.byte %11110100
	.byte %11010000
	.byte %01000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	
	; #9 grass

	.byte %01000100
	.byte %01000100
	.byte %00010001
	.byte %00010001
	.byte %01000100
	.byte %01000100
	.byte %00010001
	.byte %00010001

; 10-13 cloud1

	.byte %00000101
	.byte %00011111
	.byte %01111111
	.byte %01111111
	.byte %01111111
	.byte %01111111
	.byte %00011111
	.byte %00000101

; 11
	.byte %01000001
	.byte %11010111
	.byte %11110111
	.byte %11111111
	.byte %11111111
	.byte %11110111
	.byte %11010111
	.byte %01000001
; 12
	.byte %01010101
	.byte %11111111
	.byte %11011111
	.byte %11111111
	.byte %11111111
	.byte %11110111
	.byte %11111111
	.byte %01010101
; 13
	.byte %01010000
	.byte %11110100			
	.byte %11111101
	.byte %11111101
	.byte %11111101
	.byte %11110100
	.byte %01010000
	

	.endl
	org $7400
	.local chset1
	.endl
	org $7800
	.local chset2
	org $8200
	.endl
	.local chset3
	org $8600
	.endl
	
