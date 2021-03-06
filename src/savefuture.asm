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
	; (planned but not used)
	;lda #35
	;sta $22f
	lda #8
	sta HSCRL
;	lda #6
	sta co


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
	; Set VBI
	ldx #>vbi
	ldy #<vbi
	lda #$07
	jsr SETVBV
	

stop	jmp stop	

co	.byte $00
co2 .byte $0c
co3 .byte $18
sc1 .byte $00
sc2 .byte $00
sc3	.byte $00
o   .byte $00
;
	run start	
;
; VBI routine
;
vbi
	;scroll
	dec co
	bne notyet
	inc dl.lms00+1
	inc dl.lms01+1
	lda #4
	sta co
	;sta HSCRL
notyet	
	dec o
	bne odd
	lda #2
	sta o
	dec co2
	bne notyet2
	inc dl.lms02+1
	lda #4
	sta co2
odd
notyet2
	dec co3
	bne notyet3
	inc dl.lms05+1
	inc dl.lms06+1
	inc dl.lms07+1
	inc dl.lms08+1
	inc dl.lms09+1
	inc dl.lms10+1
	lda #24
	sta co3
notyet3
	dec HSCRL
	;dec HSCRL
	jmp XITVBV


;
; DLI Routines
;
dli	pha
	lda co
	sta HSCRL
	lda #<dli1
	sta $200
	lda #>dli1
	sta $201
	pla
	rti

dli1
	pha
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
	 	lda #$d6
	 	sta COLPF0
	 	lda #$c2
	 	sta COLPF1
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
	 	lda #202
	 	sta COLPF1
		lda #<dli
		sta $200
		lda #>dli
		sta $201
	 	pla 
	 	rti

;-----------------------------
; Character shift routines
;-----------------------------

copycset
		 
	
		rts
		
	

;-----------------------------
; Data	
;-----------------------------
; Display List
;
	.local dl
	.byte $D0
lms00	.byte $55,$00,$40
lms01	.byte $55,$00,$41
		.byte $20 ; for more space between clouds
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
lms23	.byte $D5,$00,$64
txt		.byte $47,$00,$65
		.byte $41,a(dl)
	.endl
;
; Screen memory
;
	org $4000
	.local sm
	.byte 14,15,15,15,16,$00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte 14,15,15,15,16,$00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte 14,15,15,15,16,$00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte 14,15,15,15,16,$00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte 14,15,15,15,16,$00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte 14,15,15,15,16,$00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte 14,15,15,15,16,$00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte 14,15,15,15,16,$00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.endl
	org $4100
	.byte 17,18,18,18,19,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 17,18,18,18,19,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 17,18,18,18,19,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 17,18,18,18,19,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 17,18,18,18,19,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 17,18,18,18,19,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 17,18,18,18,19,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 17,18,18,18,19,0,0,0,0,0,0,0,0,0,0,0,0,0
	
	org $4200
	;.byte $00,$01,$02,$03,$04,$81,$82,$83,$84
	.byte $00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte $00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte $00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte $00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte $00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	.byte $00,$00,$0a,$0c,$0b,$0c,$0d,$00,$8a,$8c,$8b,$8c,$8d
	
	org $4300
	;.byte $00,$05,$06,$07,$08,$85,$86,$87,$88
	org $4400
	.byte 00
	
	org $4500
	.byte 0,0,0,0,0,0,21,22,23,24,0,0,0,0,0,0,0,0,21,22,23,24,0,0,0,0,0
;	.byte 0,0,0,0,0,0,21,22,23,24,0,0,0,0,0,0,0,0,21,22,23,24,0,0,0,0,0
	
	org $4600
	.byte 0,0,0,0,149,150,153,153,153,153,151,152,0,0,0,0,149,150,153,153,153,153,151,152,0,0,0,0,0,21,22,23,24
;	.byte 0,0,0,0,149,150,153,153,153,153,151,152,0,0,0,0,149,150,153,153,153,153,151,152,0,0,0,0,0,21,22,23,24

	org $4700
	.byte 0,0,149,150,153,153,153,153,153,153,153,153,151,152,149,150,153,153,153,153,153,153,153,153,151,152
	.byte 0,149,150,153,153,153,153,151,152
	org $4800
	.byte 149,150,153,153,153,153,153,153,153,153,153,153,153,153,156,157
    .byte 153,153,153,153,153,153,153,153,153,153,156,157
    .byte 153,153,153,153,153,153,153,151,152
	
	org $4900
	.byte 153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,156,157
	.byte 153,153,153,153,153,153,153,153,153,153,156,157
	.byte 153,153,153,153,153,153,153,151,152
	
	org $5000
	.byte 153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,156,157
	.byte 153,153,153,153,153,153,153,153,153,153,156,157
	.byte 153,153,153,153,153,153,153,151,152
; grass
	org $5100
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $5200
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $5300
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $5400
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $5500
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $5600
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $5700
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $5800
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $5900
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $6000
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $6100
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $6200
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $6300
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	.byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9	

	org $6400
	.byte 20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20
	.byte 20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20
	.byte 20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20
	.byte 20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20
		
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
	.byte %01000100
	.byte %01000100
	.byte %00010001
	.byte %00010001
	.byte %00010001
	.byte %10101010

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
	.byte %01010000

; 14-19  cloud 2 (large)

	.byte %00000001
	.byte %00000111
	.byte %00000111
	.byte %00011111
	.byte %00011111
	.byte %01111111
	.byte %01111111
	.byte %01111111
	
	.byte %01010101
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	
	.byte %01000000
	.byte %11010000
	.byte %11010000
	.byte %11110100
	.byte %11110100
	.byte %11111101
	.byte %11111101
	.byte %11111101

	.byte %01111111
	.byte %01111111
	.byte %01111111
	.byte %00011111
	.byte %00011111
	.byte %00000111
	.byte %00000111
	.byte %00000001
		
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %01010101
	
	.byte %11111101
	.byte %11111101
	.byte %11111101
	.byte %11110100
	.byte %11110100
	.byte %11010000
	.byte %11010000
	.byte %01000000
	
	;20 Grass 2
	.byte %01000100
	.byte %01000100
	.byte %01000100
	.byte %01000100
	.byte %00010001
	.byte %00010001
	.byte %00010001
	.byte %10101010

	; 21-   Mointains
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000001
	.byte %00000111
	.byte %00011111
	.byte %01111111
;22
	.byte %00000001
	.byte %00000111
	.byte %00011111
	.byte %01111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
		
;23	
	.byte %01000000
	.byte %11010000
	.byte %11110100
	.byte %11111101
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
;24	
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %01000000
	.byte %11010000
	.byte %11110100
	.byte %11111101
;25
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
;26
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111101
	.byte %11110111
	.byte %11011111
	.byte %01111111
;27
	.byte %11111110
	.byte %11110111
	.byte %11011111
	.byte %01111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
;28						
	.byte %01111111
	.byte %11011111
	.byte %11110111
	.byte %11111101
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
;29
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %01111111
	.byte %11011111
	.byte %11110111
	.byte %11111101

	.endl
;shifted sets 3 - 2 - 1 - 4


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
	
