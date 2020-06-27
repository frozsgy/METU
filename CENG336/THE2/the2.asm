; We prefer grading on simulator. (THE2_v2)
; Group number : 42
; Group members:
;     1- e2309615, Mustafa Ozan, Alpay
;     2- e2309920, Yavuz, Durmazkeser
;     3- e2237469, Melih Furkan, Güne?
    LIST P=18F8722

#INCLUDE <p18f8722.inc> 
    
    config OSC = HSPLL, FCMEN = OFF, IESO = OFF, PWRT = OFF, BOREN = OFF, WDT = OFF, MCLRE = ON, LPT1OSC = OFF, LVP = OFF, XINST = OFF, DEBUG = OFF

    level udata 0x00
    level
    health udata 0x01
    health
    position udata 0x02
    position
    pressed udata 0x03
    pressed
    time_has_come udata 0x04
    time_has_come
    game_ended udata 0x05
    game_ended
    current_balls udata 0x06
    current_balls
    remaining_balls udata 0x07
    remaining_balls
    miss_count udata 0x08
    miss_count
    timer_count udata 0x09
    timer_count

    ORG 0x0000
    goto MAIN

    ORG 0x0008
    goto ISR

TABLE
    rlncf WREG
    addwf PCL
    retlw 0x3F ; 0 
    retlw 0x06 ; 1
    retlw 0x5B ; 2
    retlw 0x4F ; 3
    retlw 0x66 ; 4
    retlw 0x6D ; 5
    
INIT
    clrf INTCON
    clrf PIE1
    clrf TMR0
    movlw b'01000111'
    movwf T0CON
    clrf TMR1H
    clrf TMR1L
    movlw b'00000001'
    movwf T1CON
    clrf position
    bsf position, 0
    clrf LATA
    bsf LATA, 5
    clrf LATB
    bsf LATB, 5
    clrf LATC
    clrf LATD
    clrf level
    bsf level, 1
    clrf LATJ
    movlw d'5'
    movwf health
    clrf LATH
    clrf LATG
    clrf TRISA
    clrf TRISB
    clrf TRISC
    clrf TRISD
    clrf TRISJ
    clrf TRISH
    clrf pressed
    clrf time_has_come
    bsf time_has_come, 0
    clrf game_ended
    movlw d'5'
    movwf remaining_balls
    movlw d'36'
    movwf current_balls
    movlw b'00001101'
    movwf TRISG
WAIT_RG0_PUSH
    call SWAP_LEDS
    btfss PORTG, 0
    goto WAIT_RG0_PUSH
WAIT_RG0_RELEASE
    call SWAP_LEDS
    btfsc PORTG, 0
    goto WAIT_RG0_RELEASE
    bcf T1CON, 0
    bsf T0CON, 7
    movlw b'10100000'
    movwf INTCON
    return

ISR
    bcf INTCON, 2
    INCF timer_count
    btfsc level, 2
    goto ISR_LV2
    btfsc level, 3
    goto ISR_LV3
ISR_LV1
    movf timer_count, W
    sublw d'76'
    btfss STATUS, Z
    retfie FAST
    clrf timer_count
    bsf time_has_come, 0
    retfie FAST
ISR_LV2
    movf timer_count, W
    sublw d'61'
    btfss STATUS, Z
    retfie FAST
    clrf timer_count
    bsf time_has_come, 0
    retfie FAST
ISR_LV3
    movf timer_count, W
    sublw d'53'
    btfss STATUS, Z
    retfie FAST
    clrf timer_count
    bsf time_has_come, 0
    retfie FAST

MOVE_RIGHT
    bcf pressed, 2
    call SWAP_LEDS
    btfsc PORTG, 2
    goto MOVE_RIGHT
    btfss position, 0
    goto MOVE_RIGHT_
    rlncf position
    bcf LATA, 5
    bsf LATC, 5
    return
MOVE_RIGHT_
    btfss position, 1
    return
    rlncf position
    bcf LATB, 5
    bsf LATD, 5
    return
    
MOVE_LEFT
    bcf pressed, 3
    call SWAP_LEDS
    btfsc PORTG, 3
    goto MOVE_LEFT
    btfss position, 2
    goto MOVE_LEFT_
    rrncf position
    bcf LATD, 5
    bsf LATB, 5
    return
MOVE_LEFT_
    btfss position, 1
    return
    rrncf position
    bcf LATC, 5
    bsf LATA, 5
    return

ROTATOR
    btfss TMR1L, 0
    bcf STATUS, C
    btfsc TMR1L, 0
    bsf STATUS, C
    rrcf TMR1H
    rrcf TMR1L
    return
    
CHECK_MISS
    clrf time_has_come
    decf current_balls
    clrf miss_count
    btfsc LATA, 5
    INCF miss_count
    btfsc LATB, 5
    INCF miss_count
    btfsc LATC, 5
    INCF miss_count
    btfsc LATD, 5
    INCF miss_count
    movlw d'2'
    subwf miss_count
    bz MOVE_BALLS
    dcfsnz health
    goto END_GAME
MOVE_BALLS
    rlncf LATA
    bcf LATA, 6
    rlncf LATB
    bcf LATB, 6
    rlncf LATC
    bcf LATC, 6
    rlncf LATD
    bcf LATD, 6
    btfsc position, 2
    goto POS2
    btfsc position, 1
    goto POS1
POS0
    bsf LATA, 5
    bsf LATB, 5
    goto ADD_BALL
POS1
    bsf LATB, 5
    bsf LATC, 5
    goto ADD_BALL
POS2
    bsf LATC, 5
    bsf LATD, 5
ADD_BALL
    movf remaining_balls
    bz INCREASE_LEVEL
    decf remaining_balls
    btfsc TMR1L, 1
    goto R1
R0
    btfsc TMR1L, 0
    goto R01
R00
    bsf LATA, 0
    goto LEVEL_ROTATE
R01
    bsf LATB, 0
    goto LEVEL_ROTATE
R1
    btfsc TMR1L, 0
    goto R11
R10
    bsf LATC, 0
    goto LEVEL_ROTATE
R11
    bsf LATD, 0
LEVEL_ROTATE
    btfsc level, 1
    goto ROTATE_LV1
    btfsc level, 2
    goto ROTATE_LV2
ROTATE_LV3
    call ROTATOR
    call ROTATOR
ROTATE_LV2
    call ROTATOR
    call ROTATOR
ROTATE_LV1
    call ROTATOR
    movf remaining_balls
    bz INCREASE_LEVEL
CHECK_END
    movf current_balls
    bz END_GAME
    return
INCREASE_LEVEL
    btfsc level, 3
    goto CHECK_END
    rlncf level
    btfsc level, 3
    goto INIT_LV3
INIT_LV2
    movlw d'10'
    movwf remaining_balls
    return
INIT_LV3
    movlw d'15'
    movwf remaining_balls
    return
END_GAME
    bsf game_ended, 0
    return
    
SWAP_LEDS
    btfsc LATH, 0
    goto DISPLAY_HEALTH
DISPLAY_LEVEL
    bcf LATH, 3
    btfsc level, 3
    goto DISPLAY_LV3
    btfsc level, 2
    goto DISPLAY_LV2
DISPLAY_LV1
    movlw 0x06
    movwf LATJ
    bsf LATH, 0
    return
DISPLAY_LV2
    movlw 0x5B
    movwf LATJ
    bsf LATH, 0
    return
DISPLAY_LV3
    movlw 0x4F
    movwf LATJ
    bsf LATH, 0
    return
DISPLAY_HEALTH
    bcf LATH, 0
    movf health, W
    call TABLE
    movwf LATJ
    bsf LATH, 3
    return
    
MAIN
    call INIT
MAIN_LOOP
    call SWAP_LEDS
    ; check button & move if pressed
PUSH_RG2
    btfsc pressed, 2
    goto RELEASE_RG2
    btfss PORTG, 2
    goto PUSH_RG3
    bsf pressed, 2
RELEASE_RG2
    btfss PORTG, 2
    call MOVE_RIGHT
PUSH_RG3
    btfsc pressed, 3
    goto RELEASE_RG3
    btfss PORTG, 3
    goto TIMER_CHECK
    bsf pressed, 3
RELEASE_RG3
    btfss PORTG, 3
    call MOVE_LEFT
    ; check time_has_come & move(possibly create one) balls
    ; check ball miss & decrease life if miss & game over if life==0
    ; check level done & if level done and no more levels game over else increase level
TIMER_CHECK
    btfsc time_has_come, 0
    call CHECK_MISS
    btfsc game_ended, 0
    goto MAIN
    goto MAIN_LOOP

END