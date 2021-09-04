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

	lda #$70
	sta 756
	
	lda #$88
	sta 712

	lda #$09
	sta 708
	
	lda #$0f
	sta 710 

	lda #$06
	sta 711

stop	jmp stop	

;
	run start	
;
; VBI routine
;


;
; DLI Routine
;

;-----------------------------
; Data	
;-----------------------------
; Display List
;
	.local dl
	.byte $F0
lms00	.byte $45,$00,$40
lms01	.byte $45,$00,$41
lms02	.byte $44,$00,$42
lms03	.byte $44,$00,$43
lms04	.byte $44,$00,$44
lms05	.byte $44,$00,$45
lms06	.byte $44,$00,$46
lms07	.byte $44,$00,$47
lms08	.byte $44,$00,$48
lms09	.byte $44,$00,$49
lms10	.byte $44,$00,$50
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
;lms23	.byte $44,$00,$64
txt		.byte $47,$00,$65
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
text	.byte "Test of text"
	
		
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
	
