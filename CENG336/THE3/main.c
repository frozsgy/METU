/**
 *   
 *  Group number : 42
 *  Group members:
 *      1- e2309615, Mustafa Ozan, Alpay
 *      2- e2309920, Yavuz, Durmazkeser
 *      3- e2237469, Melih Furkan, Gunes
 *
 *  The information in this comment block is a summary for everything except the 
 *  main and ISR methods. Step by step explanation for the rest can be found at 
 *  the respective parts.
 *
 *  == MAIN FUNCTION == 
 *
 *  Our main function has two major parts, namely:
 *  1- The part until the blinking
 *  2- The part of blinking
 *
 *  Each subpart will act if the respective flags was set inside the ISR.
 *  Details on the ISR can be found at the bottom of this comment block.
 *
 *  The part until the blinking is responsible to handle 4 different events.
 *  Namely:
 *  1- when the ADC initialization is complete
 *  2- when the ADC acquired a value
 *  3- when RB4 is pressed (a guess was made)
 *  4- when the game is ended (either by a correct guess, or time limit) 
 *
 *  Event 1- when the ADC initialization is complete
 *    adc_init_flag is set when 50ms interrupt is received from TIMER0.
 *    This triggers the conversion to start converting.
 *    When the conversion is complete, an interrupt is received and this sets
 *    the adc_done_flag.
 *
 *  Event 2- when the ADC acquired a value
 *    The adc_value is calculated using ADRESH and ADRESL values and the 
 *    respective guess value is calculated from the adc_value by using the 
 *    conversion chart. This guess number gets written to the 7-segment
 *    display, and the adc_done_flag gets set as 0 again.
 *
 *  Event 3- when RB4 is pressed (a guess was made)
 *    The make_guess method checks the guess, and hints if the guess is
 *    wrong, or ends the game if the guess is correct. If the guess is correct
 *    the game_ended_flag gets set. 
 *
 *  Event 4- when the game is ended (either by a correct guess, or time limit) 
 *    By setting the game_ended_flag, we move to the second portion of the game. 
 *
 *  The part of the blinking is responsible to handle 2 different events. Namely:
 *  1- when it's time to blink the 7-segment display
 *  2- when it's time to finish (and restart) the game
 *
 *  The blink_led method starts the blinking of the 7-segment display
 *  and sets the TIMER1 to blink the display for 4 500 ms (2s total) intervals.
 *  When the 4th interrupt is received, the blink_ended_flag gets set
 *  and this allows the loop to break, which ends the game.
 *
 *
 *  == DETAILS ABOUT THE ISR  == 
 *
 *  Our ISR watches for 5 interrupts. All of them are high priority interrupts.
 *  At first we thought we might use low priority interrupts as well,
 *  but in the end we didn't need any, thus the only priority difference
 *  is the ordering of the if clauses inside this method.
 *  Common properties: each interrupt clears the interrupt flag and returns
 *  from the method to avoid calling the interrupt over and over again.
 *
 *  Timer 0 Interrupt
 *    This interrupt happens when the TIMER0 reaches 50 ms. mark.
 *    The interrupt resets the timer values, sets the adc_init_flag
 *    to get another ADC reading and allows the system to continue.
 *
 *  Timer 1 Interrupt
 *    This interrupt happens when the TIMER1 reaches 50 ms. mark.
 *    The interrupt first resets the timer values. Then the action
 *    depends on the game_ended_flag, which marks if the game has 
 *    ended or not.
 *    If the game_ended_flag is 0, then the tmr1_counter counts
 *    until the total time is 5 seconds to end the game.
 *    If the game_ended_flag is 1, then we are using TIMER1 to blink
 *    the 7-segment display to display the number. To achieve this, 
 *    we use every 10th count (500 ms). Since the end sequence has
 *    4 * 500 ms for blinking, when we reach the 4th blink, we
 *    restart the game. If the blink count is not 4 yet, we continue
 *    with alternating the blink flag to achieve the blinking effect.
 *
 *  Timer 2 Interrupt
 *    This interrupt happens when the TIMER2 counts for 1 ms. 
 *    We used this interrupt to debounce the RB4 input. To achieve 
 *    this, we split the actions on RB4 into 4 different states:
 *     _____________________________________
 *    |                  |                  |
 *    |  initial state   |   next state     |
 *    |------------------|------------------|
 *    |  0 (not pressed) |  0 (not pressed) |
 *    |  0 (not pressed) |  1 (pressed)     |
 *    |  1 (pressed)     |  0 (not pressed) |
 *    |  1 (pressed)     |  1 (pressed)     |
 *    |__________________|__________________|
 *
 *    a. For the 0 -> 0 transition, we increment tmr2_counter. If we
 *       reach 10, it means that this is a genuine release of RB4. 
 *       We update the button_status_flag as 0.
 *    b. For the 0 -> 1 transition, we reset tmr2_counter and start TIMER2. 
 *    c. For the 1 -> 0 transition, we reset tmr2_counter and start TIMER2. 
 *    d. For the 1 -> 1 transition, we increment tmr2_counter. If we 
 *       reach 10, it means that this is a genuine press of RB4. 
 *       We update the button_status_flag as 1.
 *
 *  RB Interrupt
 *    This interrupt happens when the value on RB is changed.
 *    With this interrupt, we reset the TIMER2 to achieve the state transitions
 *    as explained above.
 *
 *  ADC Interrupt
 *    This interrupt happens when the ADC conversion is complete.
 *    The interrupt sets the adc_done_flag to notify the main loop,
 *    and clears the interrupt flag.
 *
 *
 *  == SUMMARY OF FUNCTIONS ==
 *
 *  Detailed step by step description of the functions can be found at  
 *  their respective function bodies.
 *
 *    void init(void)                   :: initialize modules
 *    void timer_init(void)             :: reseting TIMER1 before blinking
 *    void hint_lower(void)             :: displays the hint as lower 
 *    void clear_hint(void)             :: clears the hint 
 *    void hint_higher(void)            :: displays the hint as higher
 *    void clear_7s(void)               :: clears the 7-segment display
 *    void write_7s(unsigned char v)    :: displays v in the 7-segment display
 *    void start_adc(void)              :: starts the ADC conversion
 *    void read_adc(void)               :: reads from ADC
 *    void make_guess(void)             :: checks if the guess is correct
 *    void blink_led(void)              :: blinks the 7-segment display
 *  
 */

#pragma config OSC = HSPLL, FCMEN = OFF, IESO = OFF, PWRT = OFF, BOREN = OFF, WDT = OFF, MCLRE = ON, LPT1OSC = OFF, LVP = OFF, XINST = OFF, DEBUG = OFF

#include <xc.h>
#include "breakpoints.h"

unsigned char adc_init_flag;        /* To check if the ADC is ready for another reading */
unsigned char adc_done_flag;        /* To check if the AD conversion is complete */
unsigned char guess_init_flag;      /* To check if a guess was made */
unsigned char game_ended_flag;      /* To check if the game ended */
unsigned char blink_flag;           /* To check if currently blinking */
unsigned char blink_ended_flag;     /* To check if blinking ended */
unsigned char tmr1_counter;         /* To count how many interrupts of TIMER1 happened */
unsigned char blink_counter;        /* To keep the number of blinks */
unsigned char guess;                /* [0,1023] to [0,9] conversion */
unsigned char pb;                   /* Used for PORTB readings */
unsigned char tmr2_counter;         /* To count 10 times of 1 ms of TIMER2 for debouncing */
unsigned char button_status_flag;   /* To keep the status of RB4, 0 = released, 1 = pressed */

void init(void);
void timer_init(void);
void __interrupt() isr(void);
void hint_lower(void);
void clear_hint(void);
void hint_higher(void);
void clear_7s(void);
void write_7s(unsigned char v);
void start_adc(void);
void read_adc(void);
void make_guess(void);
void blink_led(void);

void init(void) {
    /* Setting PORTC, PORTD, PORTE as outputs */
    TRISC = 0; 
    TRISD = 0; 
    TRISE = 0;
    /* Setting the 7-segment display as output */
    TRISJ = 0;
    /* Setting PORTB[7:4] as input */
    /* 1111 0000 */
    TRISB = 0xF0;
    /* Setting AD12 as input at TRISH[4] */
    TRISH = 0x10; 
    /* Setting ADC converter */
    ADCON0 = 0x30;          /* AD12 */
    ADCON1 = 0;             /* Analog input */
    /* 1010 1010 
       1            -> right justified  
        0           -> unimplemented
         10 1       -> ACQT : 12 * T_AD :: we need at least 11 T_AD for conversion
             010    -> F_OSC / 32
    */
    ADCON2 = 0xAA;
    ADON = 1;               /* ADC on */
  
    /* Clearing values */
    LATB = 0;
    LATC = 0;
    LATD = 0;
    LATE = 0;
    LATH = 8;
    LATJ = 0;
    /* Setting flags */ 
    adc_init_flag = 0;
    adc_done_flag = 0;
    guess_init_flag = 0;
    game_ended_flag = 0;
    blink_flag = 0;
    blink_ended_flag = 0;
    tmr1_counter = 0;
    blink_counter = 0;
    tmr2_counter = 0;
    button_status_flag = 0;
  
    /**  
     *   Setting TIMER0 
     *   init       : 3036
     *   prescaler  : 8
     *   bit-depth  : 16
     *   to generate interrupts every 50 ms
     */ 
    TMR0L = 0xDC;       /* Setting initial value of 3036 */
    TMR0H = 0x0B;
  
    /**  
     *   Setting TIMER1
     *   init       : 3036
     *   prescaler  : 8
     *   bit-depth  : 16
     *   to generate interrupts every 50 ms
     */ 
    TMR1L = 0xDC;       /* Setting initial value of 3036 */
    TMR1H = 0x0B;
  
    /**
     *  Setting TIMER2 for RB4 debouncing
     *  prescaler   : 16
     *  postscaler  : 16
     *  init        : 0
     *  PR2 value   : 39
     *  to generate interrupts every 1 ms
     */
    TMR2 = 0;
    PR2 = 39;
  
    /* Setting interrupts */
    IPEN = 1;
    INTCON = 0x28;      /* Enable TMR0, RB interrupts, disable global interrupts */
    INTCON2 = 0x05;     /* Set RB change, TMR0 high priority interrupt */
    PIE1 = 0x41;        /* Set TMR1, ADC interrupts */ 
    IPR1 = 0x41;        /* Set TMR1, ADC high priority interrupt */ 
  
    init_complete();
  
    T0CON = 0x82;       /* 16-bit, prescaler 8, timer starts */ 
    T1CON = 0x31;       /* 16-bit, prescaler 8, timer starts */   
  
    GIE = 1;            /* Enable global interrupts */ 
    
}

void timer_init(void) {
    /* Disabling interrupt bits for TMR0, RB change, ADC */ 
    TMR0IE = 0;
    RBIE = 0;
    ADIE = 0;
    TMR1ON = 0;
  
    /**  
     *   Setting TIMER1
     *   will count 10 times of 50 ms = 500 ms
     *   init       : 3036
     *   prescaler  : 8
     *   bit-depth  : 16
     */ 
    TMR1L = 0xDC;       /* Setting initial value of 3036 */
    TMR1H = 0x0B;
    tmr1_counter = 0;
    T1CON = 0x31;       /* 16-bit, prescaler 8, timer starts */ 
      
    /* Clearing values */
    clear_hint();
    /* Show special number */
    write_7s(special_number());
    
}

void __interrupt() isr(void) {
    /* Details about the ISR can be found at the top of this file. */
    if (TMR0IF == 1) {
        TMR0L = 0xDC;       /* Setting initial value of 3036 */
        TMR0H = 0x0B;
        adc_init_flag = 1;
        TMR0IF = 0;         /* Removing the interrupt */
        return;
    }
  
    if (TMR1IF == 1) {
        TMR1L = 0xDC;       /* Setting initial value of 3036 */
        TMR1H = 0x0B;
        if (!game_ended_flag) {
            tmr1_counter++;
            if (tmr1_counter % 10 == 0) hs_passed();
            if (tmr1_counter == 100) {
                TMR2ON = 0;
                TMR2IE = 0;
                button_status_flag = 0;
                game_ended_flag = 1;
                game_over();
            }
            TMR1IF = 0;      /* Removing the interrupt */
            return;
        }
        else {
            tmr1_counter++;
            if (tmr1_counter == 10) {
                hs_passed();
                blink_counter++;
                if (blink_counter == 4) {
                    blink_ended_flag = 1;
                    TMR1IF = 0;         /* Removing the interrupt */
                    restart();
                    return;
                }
                else {
                    tmr1_counter = 0;
                    blink_flag = 1;
                    TMR1IF = 0;         /* Removing the interrupt */
                    return;
                }
            }
            else {
                TMR1IF = 0;
                return;
            }
        }
    }

    if (TMR2IF == 1) {
        tmr2_counter++;     /* Inrease the number of ms pressed */
        if (tmr2_counter == 10) {
            /**
             * If the total number of interrupts to TIMER2 reached
             * to 10, it means it is a genuine stimulus of RB4.
             */
            pb = PORTB;
            if ((pb & 0x10) == 0x10) {
                /* RB4 is pressed */
                TMR2IF = 0;
                guess_init_flag = 1;
                rb4_handled();         
                TMR2ON = 0;
                TMR2IE = 0;
                tmr2_counter = 0;
                button_status_flag = 1;
                return;
            } else {
                /* RB4 is released */
                TMR2ON = 0;   
                TMR2IE = 0;
                tmr2_counter = 0;
                TMR2IF = 0;
                button_status_flag = 0;
                return;
            }
        }
        else {
            TMR2IF = 0;
            return;
        }        
    }

    if (RBIF == 1) {
        /**
         * Any change in RB4 should invoke this interrupt.
         * Such changes should cause TIMER2 to count to see
         * if those changes are actual changes or bounces.
         */
        pb = PORTB;
        if ((pb & 0x10) == 0) {
            /* RB4 is released */
            TMR2ON = 0;
            tmr2_counter = 0;
            TMR2IE = 1;
            TMR2IP = 1;
            TMR2 = 0;
            T2CON = 0x7A;
            TMR2ON = 1;
            RBIF = 0;
            return;
        }
        else {
            /* RB4 is pressed */
            TMR2ON = 0;
            tmr2_counter = 0;
            TMR2IE = 1;
            TMR2IP = 1;
            TMR2 = 0;
            T2CON = 0x7A;
            TMR2ON = 1;
            RBIF = 0;
            return;
        }
    }
  
    if (ADIF == 1) {
        adc_done_flag = 1;
        ADIF = 0;
        return;
    }
}


void hint_lower(void) {
    /* Displays the hint as Down Arrow */
    LATC = 0x4;
    LATD = 0xF;
    LATE = 0x4;    
    latcde_update_complete();
    return;
}

void clear_hint(void) {
    /* Clears the hint */
    LATC = 0;
    LATD = 0;
    LATE = 0;
    latcde_update_complete();
    return;
}

void hint_higher(void) {
    /* Displays the hint as Up Arrow */
    LATC = 0x2;
    LATD = 0xF;
    LATE = 0x2;    
    latcde_update_complete();
    return;
}

void clear_7s(void) {
    /* Clears the 7-segment display */
    LATJ = 0; 
    latjh_update_complete();
    return;
}

void write_7s(unsigned char v) {
    /* Displays the unsigned char v in the 7-segment display */
    switch (v) {
        case 0:
            LATJ = 0x3F;
            break;
        case 1:
            LATJ = 0x06;
            break;
        case 2:
            LATJ = 0x5B;
            break;
        case 3:
            LATJ = 0x4F;
            break;
        case 4:
            LATJ = 0x66;
            break;
        case 5:
            LATJ = 0x6D;
            break;
        case 6:
            LATJ = 0x7D;
            break;
        case 7:
            LATJ = 0x07;
            break;
        case 8:
            LATJ = 0x7F;
            break;
        case 9:
            LATJ = 0x6F;
            break;
        default:
            /**
             * Erronous input, display E as value 
             * We should never reach here anyway 
             */
            LATJ = 0x79;
            break;
    }
    latjh_update_complete();
    return;
    
}

void start_adc(void) {
    /* Start the Analog to Digital conversion process */
    GO = 1;
    adc_init_flag = 0;
    return;
}

void read_adc(void) {
    /**
     * Read the converted value from the ADC 
     * and calculate the guess
     * write the guess to the 7-segment
     */
    adc_value = ADRESH * 256 + ADRESL;  /* Concatenate ADRESH and ADRESL */
    adc_complete(); 
    if (adc_value <= 102) guess = 0;
    else if (adc_value <= 204) guess = 1;
    else if (adc_value <= 306) guess = 2;
    else if (adc_value <= 408) guess = 3;
    else if (adc_value <= 510) guess = 4;
    else if (adc_value <= 612) guess = 5;
    else if (adc_value <= 714) guess = 6;
    else if (adc_value <= 816) guess = 7;
    else if (adc_value <= 918) guess = 8;
    else if (adc_value <= 1023) guess = 9;
  
    write_7s(guess);
  
    adc_done_flag = 0;
    return;
}

void make_guess(void) {
    /**
     * Checks if the guess is correct
     * if correct, ends the game
     * if incorrect, displays hint 
     */
    if (special_number() == guess) {
        game_ended_flag = 1;
        TMR2ON = 0;
        TMR2IE = 0;
        TMR2 = 0;
        tmr2_counter = 0;
        button_status_flag = 0;
        correct_guess();
    }
    else if (special_number() < guess) hint_lower();
    else hint_higher();
    
    guess_init_flag = 0;
    return;
}

void blink_led(void) {
    /**
     * If the 7-segment displays a number,
     * clears the display. 
     * Else writes the special number to 
     * the 7-segment display.
     */
    if (LATJ == 0) write_7s(special_number());
    else clear_7s();

    blink_flag = 0;
    return;     
}

void main(void) {
    /* Details about the main function can be found at the top of this file. */
    while (1) {
        init(); 
        while (1) {
            if (adc_init_flag) start_adc();      
            if (adc_done_flag) read_adc();       
            if (guess_init_flag) make_guess();   
            if (game_ended_flag) break;  
        }
        timer_init();
        while (1) {
            if (blink_flag) blink_led();         
            if (blink_ended_flag) break;         
        }
    }  
    return;
}
