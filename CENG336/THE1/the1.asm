LIST    P=18F8722

#INCLUDE <p18f8722.inc>
CONFIG OSC=HSPLL, FCMEN=OFF, IESO=OFF,PWRT=OFF,BOREN=OFF, WDT=OFF, MCLRE=ON, LPT1OSC=OFF, LVP=OFF, XINST=OFF, DEBUG=OFF

var1 udata 0x20 ;Number1
var1
 
var2 udata 0x21 ;Number2
var2
 
var3 udata 0x22 ; result
var3
 
UDATA_ACS
  t1	res 1	; used in delay
  t2	res 1	; used in delay
  t3	res 1	; used in delay
    
ORG 0X0000
    goto setup
    
ORG 0X0008
    goto $
    
DELAY	; Time Delay Routine with 3 nested loops -- taken from main.asm in the recitation 2 materials   
    MOVLW 82	; Copy desired value to W
    MOVWF t3	; Copy W into t3
    _loop3:
	MOVLW 0xA0  ; Copy desired value to W
	MOVWF t2    ; Copy W into t2
	_loop2:
	    MOVLW 0x9F	; Copy desired value to W
	    MOVWF t1	; Copy W into t1
	    _loop1:
		decfsz t1,F ; Decrement t1. If 0 Skip next instruction
		GOTO _loop1 ; ELSE Keep counting down
		decfsz t2,F ; Decrement t2. If 0 Skip next instruction
		GOTO _loop2 ; ELSE Keep counting down
		decfsz t3,F ; Decrement t3. If 0 Skip next instruction
		GOTO _loop3 ; ELSE Keep counting down
		return
    
setup
    
    CLRF PORTA ;setting up registers and such
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE
    CLRF var1
    CLRF var2
    CLRF var3
    
    MOVLW b'00000000';
    MOVWF TRISB
    MOVWF TRISC
    MOVWF TRISD
    
    MOVLW b'00010000' ; ra4 as input
    MOVWF TRISA
    
    MOVLW b'00011000' ;re3, re4 as input
    MOVWF TRISE
    
    MOVLW h'0F' ; 0-4
    MOVWF LATB
    MOVWF LATC
    
    MOVLW h'FF'; 0-7
    MOVWF LATD
    
    CALL DELAY
    GOTO start_push
    

state0:
    CLRF var1
    CLRF var2
    CLRF var3
    MOVLW b'00000000';
    MOVWF LATB
    MOVWF LATC
    MOVWF LATD
  
start_push: ; state 0 - wait for push and release of ra4  
    BTFSS   PORTA, 4
    GOTO    start_push
start_release:
    BTFSC   PORTA, 4
    GOTO    start_release
    


state1: ; addition
    CLRF LATB
    CLRF LATC
    CLRF LATD
    CLRF var1
    CLRF var2
    CLRF var3
    BTFSS   PORTE, 3	    ; check if re3 pressed
    GOTO s1_ra4		    ; re3 not pressed
    GOTO s1_re3_release	    ; re3 pressed
s1_ra4:
    BTFSS   PORTA, 4	    ; check if ra4 pressed
    GOTO state1		    ; ra4 not pressed
    GOTO s1_ra4_release    ; ra4 pressed
s1_ra4_release:
    BTFSC   PORTA, 4	    ; check if ra4 released
    GOTO s1_ra4_release    ; ra4 not released
    GOTO state2
s1_re3_release:
    BTFSC   PORTE, 3	    ; check if re3 released
    GOTO s1_re3_release	    ; re3 not released
    GOTO s1_sb	    ; re3 released
s1_sb:
    NOP ; state B
    MOVLW d'0'
    MOVWF var1
    MOVLW b'00000000' 
    MOVWF LATB
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s1_sb_re4      ; re3 not pressed
    GOTO s1_sb_re3_release      ; re3 pressed
s1_sb_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s1_sb          ; re4 not pressed
    GOTO s1_sb_re4_release    ; re4 pressed
s1_sb_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s1_sb_re4_release    ; re4 not released
    GOTO s1_sb_set_1
s1_sb_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s1_sb_re3_release      ; re3 not released
    GOTO s1_sc      ; re3 released


s1_sc:
    NOP ; state c
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s1_sc_re4      ; re3 not pressed
    GOTO s1_sc_re3_release      ; re3 pressed
s1_sc_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s1_sc          ; re4 not pressed
    GOTO s1_sc_re4_release    ; re4 pressed
s1_sc_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s1_sc_re4_release    ; re4 not released
    GOTO s1_sc_set_1
s1_sc_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s1_sc_re3_release      ; re3 not released
    GOTO s1_sd      ; re3 released
    
    
s1_sd:
    NOP ; state d
    NOP ; display result for 1 sec, reset leds
    
    
    MOVF var1, W
    ADDWF var2, W
    MOVWF var3
    
    
    
s1_rem0:
    TSTFSZ var3
    GOTO s1_rem1
    MOVLW b'00000000' 
    MOVWF LATD
    CALL DELAY
    GOTO state0
    
s1_rem1:
    DECFSZ var3
    GOTO s1_rem2
    MOVLW b'00000001' 
    MOVWF LATD
    CALL DELAY
    GOTO state0
    
s1_rem2:
    DECFSZ var3
    GOTO s1_rem3
    MOVLW b'00000011' 
    MOVWF LATD
    CALL DELAY
    GOTO state0
    
s1_rem3:
    DECFSZ var3
    GOTO s1_rem4
    MOVLW b'00000111' 
    MOVWF LATD
    CALL DELAY
    GOTO state0
    
s1_rem4:
    DECFSZ var3
    GOTO s1_rem5
    MOVLW b'00001111' 
    MOVWF LATD
    CALL DELAY
    GOTO state0
        
s1_rem5:
    DECFSZ var3
    GOTO s1_rem6
    MOVLW b'00011111' 
    MOVWF LATD    
    CALL DELAY
    GOTO state0
    
s1_rem6:
    DECFSZ var3
    GOTO s1_rem7
    MOVLW b'00111111' 
    MOVWF LATD 
    CALL DELAY
    GOTO state0
    
s1_rem7:
    DECFSZ var3
    GOTO s1_rem8
    MOVLW b'01111111' 
    MOVWF LATD 
    CALL DELAY
    GOTO state0
    
s1_rem8:
    DECFSZ var3
    GOTO s1_rem0
    MOVLW b'11111111' 
    MOVWF LATD  
    CALL DELAY
    GOTO state0
    
    
    GOTO mainline
    
s1_sb_set_1:
    NOP ; set b as 1
    MOVLW d'1'
    MOVWF var1
    MOVLW b'00000001' 
    MOVWF LATB
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s1_sb_set_1_re4        ; re3 not pressed
    GOTO s1_sb_set_1_re3_release        ; re3 pressed
s1_sb_set_1_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s1_sb_set_1            ; re4 not pressed
    GOTO s1_sb_set_1_re4_release    ; re4 pressed
s1_sb_set_1_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s1_sb_set_1_re4_release    ; re4 not released
    GOTO s1_sb_set_2
s1_sb_set_1_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s1_sb_set_1_re3_release        ; re3 not released
    GOTO s1_sc      ; re3 released
    
    
s1_sb_set_2:
    NOP ; set b as 2
    MOVLW d'2'
    MOVWF var1
    MOVLW b'00000011' 
    MOVWF LATB
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s1_sb_set_2_re4        ; re3 not pressed
    GOTO s1_sb_set_2_re3_release        ; re3 pressed
s1_sb_set_2_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s1_sb_set_2            ; re4 not pressed
    GOTO s1_sb_set_2_re4_release    ; re4 pressed
s1_sb_set_2_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s1_sb_set_2_re4_release    ; re4 not released
    GOTO s1_sb_set_3
s1_sb_set_2_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s1_sb_set_2_re3_release        ; re3 not released
    GOTO s1_sc      ; re3 released
    
  
s1_sb_set_3:
    NOP ; set b as 3
    MOVLW d'3'
    MOVWF var1
    MOVLW b'00000111' 
    MOVWF LATB
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s1_sb_set_3_re4        ; re3 not pressed
    GOTO s1_sb_set_3_re3_release        ; re3 pressed
s1_sb_set_3_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s1_sb_set_3            ; re4 not pressed
    GOTO s1_sb_set_3_re4_release    ; re4 pressed
s1_sb_set_3_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s1_sb_set_3_re4_release    ; re4 not released
    GOTO s1_sb_set_4
s1_sb_set_3_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s1_sb_set_3_re3_release        ; re3 not released
    GOTO s1_sc      ; re3 released
    

s1_sb_set_4:
    NOP ; set b as 4
    MOVLW d'4'
    MOVWF var1
    MOVLW b'00001111' 
    MOVWF LATB
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s1_sb_set_4_re4        ; re3 not pressed
    GOTO s1_sb_set_4_re3_release        ; re3 pressed
s1_sb_set_4_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s1_sb_set_4            ; re4 not pressed
    GOTO s1_sb_set_4_re4_release    ; re4 pressed
s1_sb_set_4_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s1_sb_set_4_re4_release    ; re4 not released
    GOTO s1_sb
s1_sb_set_4_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s1_sb_set_4_re3_release        ; re3 not released
    GOTO s1_sc      ; re3 released    
    

s1_sc_set_1:
    NOP ; set c as 1
    MOVLW d'1'
    MOVWF var2
    MOVLW b'00000001' 
    MOVWF LATC
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s1_sc_set_1_re4        ; re3 not pressed
    GOTO s1_sc_set_1_re3_release        ; re3 pressed
s1_sc_set_1_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s1_sc_set_1            ; re4 not pressed
    GOTO s1_sc_set_1_re4_release    ; re4 pressed
s1_sc_set_1_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s1_sc_set_1_re4_release    ; re4 not released
    GOTO s1_sc_set_2
s1_sc_set_1_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s1_sc_set_1_re3_release        ; re3 not released
    GOTO s1_sd      ; re3 released
    
    
s1_sc_set_2:
    NOP ; set c as 2
    MOVLW d'2'
    MOVWF var2
    MOVLW b'00000011' 
    MOVWF LATC
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s1_sc_set_2_re4        ; re3 not pressed
    GOTO s1_sc_set_2_re3_release        ; re3 pressed
s1_sc_set_2_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s1_sc_set_2            ; re4 not pressed
    GOTO s1_sc_set_2_re4_release    ; re4 pressed
s1_sc_set_2_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s1_sc_set_2_re4_release    ; re4 not released
    GOTO s1_sc_set_3
s1_sc_set_2_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s1_sc_set_2_re3_release        ; re3 not released
    GOTO s1_sd      ; re3 released
    
  
s1_sc_set_3:
    NOP ; set c as 3
    MOVLW d'3'
    MOVWF var2
    MOVLW b'00000111' 
    MOVWF LATC
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s1_sc_set_3_re4        ; re3 not pressed
    GOTO s1_sc_set_3_re3_release        ; re3 pressed
s1_sc_set_3_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s1_sc_set_3            ; re4 not pressed
    GOTO s1_sc_set_3_re4_release    ; re4 pressed
s1_sc_set_3_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s1_sc_set_3_re4_release    ; re4 not released
    GOTO s1_sc_set_4
s1_sc_set_3_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s1_sc_set_3_re3_release        ; re3 not released
    GOTO s1_sd      ; re3 released
    

s1_sc_set_4:
    NOP ; set c as 4
    MOVLW d'4'
    MOVWF var2
    MOVLW b'00001111' 
    MOVWF LATC
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s1_sc_set_4_re4        ; re3 not pressed
    GOTO s1_sc_set_4_re3_release        ; re3 pressed
s1_sc_set_4_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s1_sc_set_4            ; re4 not pressed
    GOTO s1_sc_set_4_re4_release    ; re4 pressed
s1_sc_set_4_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s1_sc_set_4_re4_release    ; re4 not released
    GOTO s1_sc
s1_sc_set_4_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s1_sc_set_4_re3_release        ; re3 not released
    GOTO s1_sd      ; re3 released  
  
    
    GOTO mainline
    
    

state2: ; subtraction
    CLRF LATB
    CLRF LATC
    CLRF LATD
    CLRF var1
    CLRF var2
    CLRF var3
    BTFSS   PORTE, 3	    ; check if re3 pressed
    GOTO s2_ra4		    ; re3 not pressed
    GOTO s2_re3_release	    ; re3 pressed
s2_ra4:
    BTFSS   PORTA, 4	    ; check if ra4 pressed
    GOTO state2		    ; ra4 not pressed
    GOTO s2_ra4_release    ; ra4 pressed
s2_ra4_release:
    BTFSC   PORTA, 4	    ; check if ra4 released
    GOTO s2_ra4_release    ; ra4 not released
    GOTO state1
s2_re3_release:
    BTFSC   PORTE, 3	    ; check if re3 released
    GOTO s2_re3_release	    ; re3 not released
    GOTO s2_sb	    ; re3 released
s2_sb:
    NOP ; state B
    MOVLW d'0'
    MOVWF var1
    MOVLW b'00000000' 
    MOVWF LATB
    BTFSS   PORTE, 3	    ; check if re3 pressed
    GOTO s2_sb_re4	    ; re3 not pressed
    GOTO s2_sb_re3_release	    ; re3 pressed
s2_sb_re4:
    BTFSS   PORTE, 4	    ; check if re4 pressed
    GOTO s2_sb		    ; re4 not pressed
    GOTO s2_sb_re4_release    ; re4 pressed
s2_sb_re4_release:
    BTFSC   PORTE, 4	    ; check if re4 released
    GOTO s2_sb_re4_release    ; re4 not released
    GOTO s2_sb_set_1
s2_sb_re3_release:
    BTFSC   PORTE, 3	    ; check if re3 released
    GOTO s2_sb_re3_release	    ; re3 not released
    GOTO s2_sc	    ; re3 released
    
s2_sc:
    NOP ; state c
    BTFSS   PORTE, 3	    ; check if re3 pressed
    GOTO s2_sc_re4	    ; re3 not pressed
    GOTO s2_sc_re3_release	    ; re3 pressed
s2_sc_re4:
    BTFSS   PORTE, 4	    ; check if re4 pressed
    GOTO s2_sc		    ; re4 not pressed
    GOTO s2_sc_re4_release    ; re4 pressed
s2_sc_re4_release:
    BTFSC   PORTE, 4	    ; check if re4 released
    GOTO s2_sc_re4_release    ; re4 not released
    GOTO s2_sc_set_1
s2_sc_re3_release:
    BTFSC   PORTE, 3	    ; check if re3 released
    GOTO s2_sc_re3_release	    ; re3 not released
    GOTO s2_sd	    ; re3 released
    
    
s2_sd:
    NOP ; state d
    NOP ; display result for 1 sec, reset leds

    MOVF var1, 0  
    CPFSGT var2
    GOTO s2_sd_seq ; smaller or equal to
    GOTO s2_sd_g ; greater than
    
    s2_sd_seq:
    MOVF var1, 0
    SUBWF var2, 0
    MOVWF var3
    NEGF var3
    MOVF var3, 0
    GOTO s2_rem0
    
    
    s2_sd_g:    
    SUBWF var2, 0
    MOVWF var3
    GOTO s2_rem0
    
    
    
s2_rem0:
    TSTFSZ var3
    GOTO s2_rem1
    MOVLW b'00000000' 
    MOVWF LATD
    CALL DELAY
    GOTO state0
    
s2_rem1:
    DECFSZ var3 ;CPFSEQ d'1' ; if w 1
    GOTO s2_rem2
    MOVLW b'00000001' 
    MOVWF LATD
    CALL DELAY
    GOTO state0
    
s2_rem2:
    DECFSZ var3
    GOTO s2_rem3
    MOVLW b'00000011' 
    MOVWF LATD
    CALL DELAY
    GOTO state0
    
s2_rem3:
    DECFSZ var3
    GOTO s2_rem4
    MOVLW b'00000111' 
    MOVWF LATD
    CALL DELAY
    GOTO state0
    
s2_rem4:
    DECFSZ var3
    GOTO s2_rem5
    MOVLW b'00001111' 
    MOVWF LATD
    CALL DELAY
    GOTO state0
        
s2_rem5:
    DECFSZ var3
    GOTO s2_rem6
    MOVLW b'00011111' 
    MOVWF LATD    
    CALL DELAY
    GOTO state0
    
s2_rem6:
    DECFSZ var3
    GOTO s2_rem7
    MOVLW b'00111111' 
    MOVWF LATD 
    CALL DELAY
    GOTO state0
    
s2_rem7:
    DECFSZ var3
    GOTO s2_rem8
    MOVLW b'01111111' 
    MOVWF LATD 
    CALL DELAY
    GOTO state0
    
s2_rem8:
    DECFSZ var3
    GOTO s2_rem0
    MOVLW b'11111111' 
    MOVWF LATD  
    CALL DELAY
    GOTO state0
    
    
    GOTO mainline
    
s2_sb_set_1:
    NOP ; set b as 1
    MOVLW d'1'
    MOVWF var1
    MOVLW b'00000001' 
    MOVWF LATB
    BTFSS   PORTE, 3	    ; check if re3 pressed
    GOTO s2_sb_set_1_re4	    ; re3 not pressed
    GOTO s2_sb_set_1_re3_release	    ; re3 pressed
s2_sb_set_1_re4:
    BTFSS   PORTE, 4	    ; check if re4 pressed
    GOTO s2_sb_set_1		    ; re4 not pressed
    GOTO s2_sb_set_1_re4_release    ; re4 pressed
s2_sb_set_1_re4_release:
    BTFSC   PORTE, 4	    ; check if re4 released
    GOTO s2_sb_set_1_re4_release    ; re4 not released
    GOTO s2_sb_set_2
s2_sb_set_1_re3_release:
    BTFSC   PORTE, 3	    ; check if re3 released
    GOTO s2_sb_set_1_re3_release	    ; re3 not released
    GOTO s2_sc	    ; re3 released
    
    
s2_sb_set_2:
    NOP ; set b as 2
    MOVLW d'2'
    MOVWF var1
    MOVLW b'00000011' 
    MOVWF LATB
    BTFSS   PORTE, 3	    ; check if re3 pressed
    GOTO s2_sb_set_2_re4	    ; re3 not pressed
    GOTO s2_sb_set_2_re3_release	    ; re3 pressed
s2_sb_set_2_re4:
    BTFSS   PORTE, 4	    ; check if re4 pressed
    GOTO s2_sb_set_2		    ; re4 not pressed
    GOTO s2_sb_set_2_re4_release    ; re4 pressed
s2_sb_set_2_re4_release:
    BTFSC   PORTE, 4	    ; check if re4 released
    GOTO s2_sb_set_2_re4_release    ; re4 not released
    GOTO s2_sb_set_3
s2_sb_set_2_re3_release:
    BTFSC   PORTE, 3	    ; check if re3 released
    GOTO s2_sb_set_2_re3_release	    ; re3 not released
    GOTO s2_sc	    ; re3 released
    
  
s2_sb_set_3:
    NOP ; set b as 3
    MOVLW d'3'
    MOVWF var1
    MOVLW b'00000111' 
    MOVWF LATB
    BTFSS   PORTE, 3	    ; check if re3 pressed
    GOTO s2_sb_set_3_re4	    ; re3 not pressed
    GOTO s2_sb_set_3_re3_release	    ; re3 pressed
s2_sb_set_3_re4:
    BTFSS   PORTE, 4	    ; check if re4 pressed
    GOTO s2_sb_set_3		    ; re4 not pressed
    GOTO s2_sb_set_3_re4_release    ; re4 pressed
s2_sb_set_3_re4_release:
    BTFSC   PORTE, 4	    ; check if re4 released
    GOTO s2_sb_set_3_re4_release    ; re4 not released
    GOTO s2_sb_set_4
s2_sb_set_3_re3_release:
    BTFSC   PORTE, 3	    ; check if re3 released
    GOTO s2_sb_set_3_re3_release	    ; re3 not released
    GOTO s2_sc	    ; re3 released
    

s2_sb_set_4:
    NOP ; set b as 4
    MOVLW d'4'
    MOVWF var1
    MOVLW b'00001111' 
    MOVWF LATB
    BTFSS   PORTE, 3	    ; check if re3 pressed
    GOTO s2_sb_set_4_re4	    ; re3 not pressed
    GOTO s2_sb_set_4_re3_release	    ; re3 pressed
s2_sb_set_4_re4:
    BTFSS   PORTE, 4	    ; check if re4 pressed
    GOTO s2_sb_set_4		    ; re4 not pressed
    GOTO s2_sb_set_4_re4_release    ; re4 pressed
s2_sb_set_4_re4_release:
    BTFSC   PORTE, 4	    ; check if re4 released
    GOTO s2_sb_set_4_re4_release    ; re4 not released
    GOTO s2_sb
s2_sb_set_4_re3_release:
    BTFSC   PORTE, 3	    ; check if re3 released
    GOTO s2_sb_set_4_re3_release	    ; re3 not released
    GOTO s2_sc	    ; re3 released    
    

s2_sc_set_1:
    NOP ; set c as 1
    MOVLW d'1'
    MOVWF var2
    MOVLW b'00000001' 
    MOVWF LATC
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s2_sc_set_1_re4        ; re3 not pressed
    GOTO s2_sc_set_1_re3_release        ; re3 pressed
s2_sc_set_1_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s2_sc_set_1            ; re4 not pressed
    GOTO s2_sc_set_1_re4_release    ; re4 pressed
s2_sc_set_1_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s2_sc_set_1_re4_release    ; re4 not released
    GOTO s2_sc_set_2
s2_sc_set_1_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s2_sc_set_1_re3_release        ; re3 not released
    GOTO s2_sd      ; re3 released
    
    
s2_sc_set_2:
    NOP ; set c as 2
    MOVLW d'2'
    MOVWF var2
    MOVLW b'00000011' 
    MOVWF LATC
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s2_sc_set_2_re4        ; re3 not pressed
    GOTO s2_sc_set_2_re3_release        ; re3 pressed
s2_sc_set_2_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s2_sc_set_2            ; re4 not pressed
    GOTO s2_sc_set_2_re4_release    ; re4 pressed
s2_sc_set_2_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s2_sc_set_2_re4_release    ; re4 not released
    GOTO s2_sc_set_3
s2_sc_set_2_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s2_sc_set_2_re3_release        ; re3 not released
    GOTO s2_sd      ; re3 released
    
  
s2_sc_set_3:
    NOP ; set c as 3
    MOVLW d'3'
    MOVWF var2
    MOVLW b'00000111' 
    MOVWF LATC
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s2_sc_set_3_re4        ; re3 not pressed
    GOTO s2_sc_set_3_re3_release        ; re3 pressed
s2_sc_set_3_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s2_sc_set_3            ; re4 not pressed
    GOTO s2_sc_set_3_re4_release    ; re4 pressed
s2_sc_set_3_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s2_sc_set_3_re4_release    ; re4 not released
    GOTO s2_sc_set_4
s2_sc_set_3_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s2_sc_set_3_re3_release        ; re3 not released
    GOTO s2_sd      ; re3 released
    

s2_sc_set_4:
    NOP ; set c as 4
    MOVLW d'4'
    MOVWF var2
    MOVLW b'00001111' 
    MOVWF LATC
    BTFSS   PORTE, 3        ; check if re3 pressed
    GOTO s2_sc_set_4_re4        ; re3 not pressed
    GOTO s2_sc_set_4_re3_release        ; re3 pressed
s2_sc_set_4_re4:
    BTFSS   PORTE, 4        ; check if re4 pressed
    GOTO s2_sc_set_4            ; re4 not pressed
    GOTO s2_sc_set_4_re4_release    ; re4 pressed
s2_sc_set_4_re4_release:
    BTFSC   PORTE, 4        ; check if re4 released
    GOTO s2_sc_set_4_re4_release    ; re4 not released
    GOTO s2_sc
s2_sc_set_4_re3_release:
    BTFSC   PORTE, 3        ; check if re3 released
    GOTO s2_sc_set_4_re3_release        ; re3 not released
    GOTO s2_sd      ; re3 released  
  
    
    GOTO mainline
    
    
    
mainline
    
    NOP 
    
    
goto mainline
    
    

end
    
    