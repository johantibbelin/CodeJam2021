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
	jmp start	

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
lms00	.byte $D4,a(sm)
lms01	.byte $D4,a(sm+160)
lms02	.byte $D4,a(sm+320)
lms03	.byte $D4,a(sm+480)
lms04	.byte $D4,a(sm+640)
lms05	.byte $D4,a(sm+800)
lms06	.byte $D4,a(sm+960)
lms07	.byte $D4,a(sm+1120)
lms08	.byte $44,a(sm+1280)
lms09	.byte $44,a(sm+1440)
lms10	.byte $44,a(sm+1600)
lms11	.byte $44,a(sm+1760)
lms12	.byte $D4,a(sm+1920)
lms13	.byte $54,a(sm+2080)
lms14	.byte $54,a(sm+2240)
lms15	.byte $54,a(sm+2400)
lms16	.byte $54,a(sm+2560)
lms17	.byte $54,a(sm+2720)
lms18	.byte $D4,a(sm+2880)
lms19	.byte $D4,a(sm+3040)
lms20	.byte $D4,a(sm+3200)
lms21	.byte $D4,a(sm+3360)
lms22	.byte $D4,a(sm+3520)
lms23	.byte $D4,a(sm+3680)
txt		.byte $06,a(text)
		.byte $41,a(dl)
	.endl
;
; Screen memory
;
	org $4000
	.local sm
	.byte "First line"
	.endl
	
	org *+$3836
	.local text	
	.byte "Test of text"
	.endl
		
;
; Character sets
;
	org $5000
	.local chset0
	.endl
	org $5400
	.local chset1
	.endl
	org *+$5800
	.local chset2
	org $6200
	.endl
	.local chset3
	org $6600
	.endl
	
