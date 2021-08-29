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

;
; Character sets
;