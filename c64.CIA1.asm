; ------------------------------------------------------------------------------------------------------------- ;
; MOS6526 - Complex Interface Adapter (CIA) #1 Registers - $DC00-$DC0F - Keyboard/Joystick/Paddles
; ------------------------------------------------------------------------------------------------------------- ;
CIA1                        = $DC00             ; Base address
CIAPRA                      = CIA1 + $00        ; Data Port A  (Keyboard, Joystick Port #2, Paddles)
CIAPRA_PA0                    = %00000001       ; 
CIAPRA_PA1                    = %00000010       ; 
CIAPRA_PA2                    = %00000100       ; 
CIAPRA_PA3                    = %00001000       ; 
CIAPRA_PA4                    = %00010000       ; 
CIAPRA_PA5                    = %00100000       ; 
CIAPRA_PA6                    = %01000000       ; 
CIAPRA_PA7                    = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
; Keyboard Check: Row Selection
; ------------------------------------------------------------------------------------------------------------- ;
CIAPRA_KEY_SEL_ROW_0          = CIAPRA_PA0      ; Bit 0: key matrix row 0 select (0=read row, 1=ignore row)
CIAPRA_KEY_SEL_ROW_1          = CIAPRA_PA1      ; Bit 1: key matrix row 1 select (0=read row, 1=ignore row)
CIAPRA_KEY_SEL_ROW_2          = CIAPRA_PA2      ; Bit 2: key matrix row 2 select (0=read row, 1=ignore row)
CIAPRA_KEY_SEL_ROW_3          = CIAPRA_PA3      ; Bit 3: key matrix row 3 select (0=read row, 1=ignore row)
CIAPRA_KEY_SEL_ROW_4          = CIAPRA_PA4      ; Bit 4: key matrix row 4 select (0=read row, 1=ignore row)
CIAPRA_KEY_SEL_ROW_5          = CIAPRA_PA5      ; Bit 5: key matrix row 5 select (0=read row, 1=ignore row)
CIAPRA_KEY_SEL_ROW_6          = CIAPRA_PA6      ; Bit 6: key matrix row 6 select (0=read row, 1=ignore row)
CIAPRA_KEY_SEL_ROW_7          = CIAPRA_PA7      ; Bit 7: key matrix row 7 select (0=read row, 1=ignore row)
; ------------------------------------------------------------------------------------------------------------- ;
; Joystick Port #2
; ------------------------------------------------------------------------------------------------------------- ;
CIAPRA_JOY_ALL                = %00011111       ; Joystick Moves + Fire
CIAPRA_JOY_MOVE               = %00001111       ; Joystick Moves
                                
CIAPRA_JOY_UP                 = %00000001       ; Joystick #2 - Up     0=pressed
CIAPRA_JOY_DO                 = %00000010       ; Joystick #2 - Down   0=pressed
CIAPRA_JOY_LE                 = %00000100       ; Joystick #2 - Left   0=pressed
CIAPRA_JOY_RI                 = %00001000       ; Joystick #2 - Right  0=pressed
                                
CIAPRA_JOY_FIRE               = %00010000       ; Joystick #2 - Fire   0=pressed
; ------------------------------------------------------------------------------------------------------------- ;
; Paddles
; ------------------------------------------------------------------------------------------------------------- ;
CIAPRA_PAD_FIRE               = %00110000       ; Paddle: Fire Buttons
CIAPRA_PAD_FIRE_1             = %00010000       ; Paddle: Fire Button #1
CIAPRA_PAD_FIRE_2             = %00100000       ; Paddle: Fire Button #2
                              
CIAPRA_PAD_PORT               = %11000000       ; Paddle: Set Read on Port A or B (only one bit may be active)
CIAPRA_PAD_PORT_A             = %01000000       ; Paddle: Set Read Port A 
CIAPRA_PAD_PORT_B             = %10000000       ; Paddle: Set Read Port B
; ------------------------------------------------------------------------------------------------------------- ;
CIAPRB                      = CIA1 + $01        ; Data Port B  (Keyboard, Joystick Port #1, Paddles)
CIAPRB_PB0                    = %00000001       ; 
CIAPRB_PB1                    = %00000010       ; 
CIAPRB_PB2                    = %00000100       ; 
CIAPRB_PB3                    = %00001000       ; 
CIAPRB_PB4                    = %00010000       ; 
CIAPRB_PB5                    = %00100000       ; 
CIAPRB_PB6                    = %01000000       ; 
CIAPRB_PB7                    = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
; Keyboard Check: Column Result
; ------------------------------------------------------------------------------------------------------------- ;
CIAPRB_KEY_RES_COL_0          = CIAPRB_PB0      ; Bit 0: matrix column 0 result (0=key pressed, 1=key not pressed)
CIAPRB_KEY_RES_COL_1          = CIAPRB_PB1      ; Bit 1: matrix column 1 result (0=key pressed, 1=key not pressed)
CIAPRB_KEY_RES_COL_2          = CIAPRB_PB2      ; Bit 2: matrix column 2 result (0=key pressed, 1=key not pressed)
CIAPRB_KEY_RES_COL_3          = CIAPRB_PB3      ; Bit 3: matrix column 3 result (0=key pressed, 1=key not pressed)
CIAPRB_KEY_RES_COL_4          = CIAPRB_PB4      ; Bit 4: matrix column 4 result (0=key pressed, 1=key not pressed)
CIAPRB_KEY_RES_COL_5          = CIAPRB_PB5      ; Bit 5: matrix column 5 result (0=key pressed, 1=key not pressed)
CIAPRB_KEY_RES_COL_6          = CIAPRB_PB6      ; Bit 6: matrix column 6 result (0=key pressed, 1=key not pressed)
CIAPRB_KEY_RES_COL_7          = CIAPRB_PB7      ; Bit 7: matrix column 7 result (0=key pressed, 1=key not pressed)
                              
CIAPRB_KEY_NONE               = %11111111       ; no key pressed
; ------------------------------------------------------------------------------------------------------------- ;
; Joystick Port #1
; ------------------------------------------------------------------------------------------------------------- ;
CIAPRB_JOY_ALL                = %00011111       ; Joystick Moves + Fire
CIAPRB_JOY_MOVE               = %00001111       ; Joystick Moves
                                
CIAPRB_JOY_UP                 = %00000001       ; Joystick #1 - Up     0=pressed
CIAPRB_JOY_DO                 = %00000010       ; Joystick #1 - Down   0=pressed
CIAPRB_JOY_LE                 = %00000100       ; Joystick #1 - Left   0=pressed
CIAPRB_JOY_RI                 = %00001000       ; Joystick #1 - Right  0=pressed
                                
CIAPRB_JOY_FIRE               = %00010000       ; Joystick #1 - Fire   0=pressed
; ------------------------------------------------------------------------------------------------------------- ;
CIAPRB_TI_TYPE                = %11000000       ; Toggle or pulse data output for Timer A/B
CIAPRB_TI_TYPE_TA             = %01000000       ; Toggle or pulse data output for Timer A - see CIACRA bit1/bit2
CIAPRB_TI_TYPE_TB             = %10000000       ; Toggle or pulse data output for Timer B - see CIACRB bit1/bit2
; ----------------------------------------------+-------------------------------------------------------------------------------- ;
                                                ;  init CIADDRA=$ff / CIADDRB=$00 1st
; ----------------------------------------------+-------------------------------------------------------------------------------- ;
                                                ;  CIAPRA Write: Select the row to check
                                                ;                  Set row bit to check  = 0
                                                ;                  Set row bit to ignore = 1
                                                ;  CIAPRB Read : Get the result of the checked column
                                                ;                  The col bit of key pressed = 0
; ----------------------------------------------+----------+----------+----------+----------+----------+----------+----------+----------+----------+
                                                ;          !   col_7  !   col_6  !   col_5  !   col_4  !   col_3  !   col_2  !   col_1  !   col_0  ! <-- CIAPRB
                                                ;          !   PRB_7  !   PRB_6  !   PRB_5  !   PRB_4  !   PRB_3  !   PRB_2  !   PRB_1  !   PRB_0  ! 
                                                ;  --------+----------+----------+----------+----------+----------+----------+----------+----------+------------+
                                                ;   row_7  !   Stop   !    Q     !    C=    !   Space  !    2     !   Ctrl   !    <-    !    1     !    $7f     !
                                                ;   PRA_7  !   $3f    !   $3e    !   $3d    !   $3c    !   $3b    !   $3a    !   $39    !   $38    !  .#######  !
                                                ;  --------+----------+----------+----------+----------+----------+----------+----------+----------+------------+
                                                ;   row_6  !    /     !    ^     !    =     !  Shft_R  !   Home   !    ;     !    *     !   LIRA   !    $bf     !
                                                ;   PRA_6  !   $37    !   $36    !   $35    !   $34    !   $33    !   $32    !   $31    !   $30    !  #.######  !
                                                ;  --------+----------+----------+----------+----------+----------+----------+----------+----------+------------+
                                                ;   row_5  !    ,     !    @     !    :     !    .     !    -     !    L     !    P     !    +     !    $df     !
                                                ;   PRA_5  !   $2f    !   $2e    !   $2d    !   $2c    !   $2b    !   $2a    !   $29    !   $28    !  ##.#####  !
                                                ;  --------+----------+----------+----------+----------+----------+----------+----------+----------+------------+
                                                ;   row_4  !    N     !    O     !    K     !    M     !    0     !    J     !    I     !    9     !    $ef     !
                                                ;   PRA_4  !   $27    !   $26    !   $25    !   $24    !   $23    !   $22    !   $21    !   $20    !  ###.####  !
                                                ;  --------+----------+----------+----------+----------+----------+----------+----------+----------+------------+
                                                ;   row_3  !    V     !    U     !    H     !    B     !    8     !    G     !    Y     !    7     !    $f7     !
                                                ;   PRA_3  !   $1f    !   $1e    !   $1d    !   $1c    !   $1b    !   $1a    !   $19    !   $18    !  ####.###  !
                                                ;  --------+----------+----------+----------+----------+----------+----------+----------+----------+------------+
                                                ;   row_2  !    X     !    T     !    F     !    C     !    6     !    D     !    R     !    5     !    $fb     !
                                                ;   PRA_2  !   $17    !   $16    !   $15    !   $14    !   $13    !   $12    !   $11    !   $10    !  #####.##  !
                                                ;  --------+----------+----------+----------+----------+----------+----------+----------+----------+------------+
                                                ;   row_1  !  Shft_L  !    E     !    S     !    Z     !    4     !    A     !    W     !    3     !    $fd     !
                                                ;   PRA_1  !   $0f    !   $0e    !   $0d    !   $0c    !   $0b    !   $0a    !   $09    !   $08    !  ######.#  !
                                                ;  --------+----------+----------+----------+----------+----------+----------+----------+----------+------------+
                                                ;   row_0  !  Crsr_D  !    F5    !    F3    !    F1    !    F7    !  Crsr_R  !  Return  !  Delete  !    $fe     !
                                                ;   PRA_0  !   $07    !   $06    !   $05    !   $04    !   $03    !   $02    !    $01   !   $00    !  #######.  !
; ----------------------------------------------+----------+----------+----------+----------+----------+----------+----------+----------+----------+------------+
                                                ; ^        !   $7f    !   $bf    !   $df    !   $ef    !   $f7    !   $fb    !   $fd    !   $fe    !
                                                ; | CIAPRA ! .####### ! #.###### ! ##.##### ! ###.#### ! ####.### ! #####.## ! ######.# ! #######. !
; ----------------------------------------------+----------+----------+----------+----------+----------+----------+----------+----------+----------+
                                                ; ScanKeyboard               Does    : Scan the whole keyboard matix and table the results
                                                ;                            Expects : 
                                                ;                            Returns : 
                                                ;                            Comment : Routine from Craig Bruce found at http://codebase64.com
                                                ; --------------------------------------------------------------------------------------------------------------------- ;
                                                ;ScanKeyboard               .block                           ; 
                                                ;                            ldx #$00                        ; set up for all KEYBOARD inputs
                                                ;                            stx CIADDRB                     ; CIA1($DC03) Data Direction Register B
                                                ;                            dex                             ; set up for all KEYBOARD outputs
                                                ;                            stx CIADDRA                     ; CIA1($DC02) Data Direction Register A
                                                ;                            
                                                ;TstJoystick_1st             jsr ScanJoystick                ; test joystick interference 1st
                                                ;                            bcc TstJoystick_1st             ; check: interference - yes: wait
                                                ;                            
                                                ;                            sei                             ; don't get interrupted
                                                ;                            
                                                ;IniRowCount                 ldx #$07                        ; init scan row count to max
                                                ;                            lda #~CIAPRA_KEY_SEL_ROW_7      ; get scan row selection mask
                                                ;                            sta KeyScanRowMask              ; ini scan row selection mask
                                                ;                            
                                                ;SetNextRowSelMask           lda KeyScanRowMask              ; get row selection mask
                                                ;                            sta CIAPRA                      ; set row selection mask
                                                ;                            
                                                ;KeyDebounce                 lda CIAPRB                      ; get col result mask
                                                ;                            cmp CIAPRB                      ; 
                                                ;                            bne KeyDebounce                 ; check: same - no
                                                ;                            
                                                ;                            sta ScanColGotMasks,x           ; store col result mask separately for each col
                                                ;                            
                                                ;                            sec                             ; set .C for ROR
                                                ;                            ror KeyScanRowMask              ; set selection mask next row
                                                ;                            
                                                ;                            dex                             ; count down rows
                                                ;                            bpl SetNextRowSelMask           ; check: all rows handled - no: continue
                                                ;                            
                                                ;                            cli                             ; 
                                                ;                            
                                                ;TstJoystick_2nd             jsr ScanJoystick                ; test joystick interference 2nd
                                                ;                            bcc IniRowCount                 ; check: interference - yes: check for keys once again
                                                ;                            
                                                ;ScanKeyboardX               rts                             ; 
                                                ;                           .bend
                                                ; --------------------------------------------------------------------------------------------------------------------- ;
                                                ; ScanJoystick               Does    : Check for Joystick interference on port #1
                                                ;                            Expects : 
                                                ;                            Returns : .C=0 Joystick interference
                                                ;                                    : .C=1 No Joystick interference
                                                ;                            Comment : 
                                                ; --------------------------------------------------------------------------------------------------------------------- ;
                                                ;ScanJoystick               .block                           ; 
                                                ;                            lda #$ff                        ; sel all rows
                                                ;                            sta CIAPRA                      ; set row selection mask
                                                ;                            
                                                ;JoyDebounce                 lda CIAPRB                      ; get col result mask
                                                ;                            cmp CIAPRB                      ; 
                                                ;                            bne JoyDebounce                 ; check: same - no
                                                ;                            
                                                ;                            cmp #$ff                        ; check for 0-bits = joystick interference
                                                ;ScanJoystickX               rts                             ; 
                                                ;                           .bend                            ; 
                                                ; --------------------------------------------------------------------------------------------------------------------- ;
                                                ;ScanColGotMasks             = *       ; store one col result mask per keyboard scan row
                                                ;                                      ; +--------+--------+--------+--------+--------+--------+--------+--------+
                                                ;                                      ; !.#######!#.######!##.#####!###.####!####.###!#####.##!######.#!#######.!
                                                ;                                      ; +--------+--------+--------+--------+--------+--------+--------+--------+
                                                ;KeyScanColMask_00           .byte $00 ; ! Crsr_D !   F5   !   F3   !   F1   !   F7   ! Crsr_R ! Return ! Delete !
                                                ;KeyScanColMask_01           .byte $00 ; ! Shft_L !   E    !   S    !   Z    !   4    !   A    !   W    !   3    !
                                                ;KeyScanColMask_02           .byte $00 ; !   X    !   T    !   F    !   C    !   6    !   D    !   R    !   5    !
                                                ;KeyScanColMask_03           .byte $00 ; !   V    !   U    !   H    !   B    !   8    !   G    !   Y    !   7    !
                                                ;KeyScanColMask_04           .byte $00 ; !   N    !   O    !   K    !   M    !   0    !   J    !   I    !   9    !
                                                ;KeyScanColMask_05           .byte $00 ; !   ,    !   @    !   :    !   .    !   -    !   L    !   P    !   +    !
                                                ;KeyScanColMask_06           .byte $00 ; !   /    !   ^    !   =    ! Shft_R !  Home  !   ;    !   *    !  LIRA  !
                                                ;KeyScanColMask_07           .byte $00 ; !  Stop  !   Q    !   C=   !  Space !   2    !  Ctrl  !   <-   !   1    !
                                                ;KeyScanRowMask              .byte $00 ; +--------+--------+--------+--------+--------+--------+--------+--------+
; --------------------------------------------------------------------------------------------------------------------- ;
CIA_KEY_NONE                  = %11111111       ; no key pressed
; --------------------------------------------------------------------------------------------------------------------- ;
CIA_KEY_STOP                  = %01111111       ; row 7
CIA_KEY_Q                     = %10111111       ; 
CIA_KEY_CMDRE                 = %11011111       ; 
CIA_KEY_SPACE                 = %11101111       ; 
CIA_KEY_2                     = %11110111       ; 
CIA_KEY_CTRL                  = %11111011       ; 
CIA_KEY_ARROW_L               = %11111101       ; 
CIA_KEY_1                     = %11111110       ; 
                              
CIA_KEY_SLASH                 = %01111111       ; row 6
CIA_KEY_ARROW_U               = %10111111       ; 
CIA_KEY_EQUAL                 = %11011111       ; 
CIA_KEY_SHFT_R                = %11101111       ; 
CIA_KEY_HOME                  = %11110111       ; 
CIA_KEY_SEMIK                 = %11111011       ; 
CIA_KEY_MULT                  = %11111101       ; 
CIA_KEY_LIRA                  = %11111110       ; 
                              
CIA_KEY_COMMA                 = %01111111       ; row 5
CIA_KEY_AT                    = %10111111       ; 
CIA_KEY_COLON                 = %11011111       ; 
CIA_KEY_PERIOD                = %11101111       ; 
CIA_KEY_MINUS                 = %11110111       ; 
CIA_KEY_L                     = %11111011       ; 
CIA_KEY_P                     = %11111101       ; 
CIA_KEY_PLUS                  = %11111110       ; 
                              
CIA_KEY_N                     = %01111111       ; row 4
CIA_KEY_O                     = %10111111       ; 
CIA_KEY_K                     = %11011111       ; 
CIA_KEY_M                     = %11101111       ; 
CIA_KEY_0                     = %11110111       ; 
CIA_KEY_J                     = %11111011       ; 
CIA_KEY_I                     = %11111101       ; 
CIA_KEY_9                     = %11111110       ; 
                              
CIA_KEY_V                     = %01111111       ; row 3
CIA_KEY_U                     = %10111111       ; 
CIA_KEY_H                     = %11011111       ; 
CIA_KEY_B                     = %11101111       ; 
CIA_KEY_8                     = %11110111       ; 
CIA_KEY_G                     = %11111011       ; 
CIA_KEY_Y                     = %11111101       ; 
CIA_KEY_7                     = %11111110       ; 
                              
CIA_KEY_X                     = %01111111       ; row 2
CIA_KEY_T                     = %10111111       ; 
CIA_KEY_F                     = %11011111       ; 
CIA_KEY_C                     = %11101111       ; 
CIA_KEY_6                     = %11110111       ; 
CIA_KEY_D                     = %11111011       ; 
CIA_KEY_R                     = %11111101       ; 
CIA_KEY_5                     = %11111110       ; 
                              
CIA_KEY_SHFT_L                = %01111111       ; row 1
CIA_KEY_E                     = %10111111       ; 
CIA_KEY_S                     = %11011111       ; 
CIA_KEY_Z                     = %11101111       ; 
CIA_KEY_4                     = %11110111       ; 
CIA_KEY_A                     = %11111011       ; 
CIA_KEY_W                     = %11111101       ; 
CIA_KEY_3                     = %11111110       ; 
                              
CIA_KEY_CRSR_D                = %01111111       ; row 0
CIA_KEY_F5                    = %10111111       ; 
CIA_KEY_F3                    = %11011111       ; 
CIA_KEY_F1                    = %11101111       ; 
CIA_KEY_F7                    = %11110111       ; 
CIA_KEY_CRSR_R                = %11111011       ; 
CIA_KEY_RETURN                = %11111101       ; 
CIA_KEY_DELETE                = %11111110       ; 
; ------------------------------------------------------------------------------------------------------------- ;
CIADDRA                     = CIA1 + $02        ; Data Direction Register A - for keybord scan set all to output ($ff=default)
CIADDRA_DPA0                  = %00000001       ;    Bit 0: for keybord scan set to output (1=output, 0=input)
CIADDRA_DPA1                  = %00000010       ;    Bit 1: for keybord scan set to output (1=output, 0=input)
CIADDRA_DPA2                  = %00000100       ;    Bit 2: for keybord scan set to output (1=output, 0=input)
CIADDRA_DPA3                  = %00001000       ;    Bit 3: for keybord scan set to output (1=output, 0=input)
CIADDRA_DPA4                  = %00010000       ;    Bit 4: for keybord scan set to output (1=output, 0=input)
CIADDRA_DPA5                  = %00100000       ;    Bit 5: for keybord scan set to output (1=output, 0=input)
CIADDRA_DPA6                  = %01000000       ;    Bit 6: for keybord scan set to output (1=output, 0=input)
CIADDRA_DPA7                  = %10000000       ;    Bit 7: for keybord scan set to output (1=output, 0=input)
; ------------------------------------------------------------------------------------------------------------- ;
CIADDRB                     = CIA1 + $03        ; Data Direction Register B - for keybord scan set all to input ($00=default)
CIADDRB_DPB0                  = %00000001       ;    Bit 0: for keybord scan set to input  (1=output, 0=input)
CIADDRB_DPB1                  = %00000010       ;    Bit 1: for keybord scan set to input  (1=output, 0=input)
CIADDRB_DPB2                  = %00000100       ;    Bit 2: for keybord scan set to input  (1=output, 0=input)
CIADDRB_DPB3                  = %00001000       ;    Bit 3: for keybord scan set to input  (1=output, 0=input)
CIADDRB_DPB4                  = %00010000       ;    Bit 4: for keybord scan set to input  (1=output, 0=input)
CIADDRB_DPB5                  = %00100000       ;    Bit 5: for keybord scan set to input  (1=output, 0=input)
CIADDRB_DPB6                  = %01000000       ;    Bit 6: for keybord scan set to input  (1=output, 0=input)
CIADDRB_DPB7                  = %10000000       ;    Bit 7: for keybord scan set to input  (1=output, 0=input)
; ------------------------------------------------------------------------------------------------------------- ;
; Interval Timers (Timer A / Timer B)
; ------------------------------------------------------------------------------------------------------------- ;
; each Interval Timer consists of
;  - a 16-bit read-only  Timer Counter - Current State of Timer A
;  - a 16-bit write-only Timer Latch   - Value to be loaded at next start of Timer A
; 
; data written to the timer are latched in the Timer Latch
; data read  from the timer are present contents of the Timer Counter
; 
; the timers can be used independently or linked for extended operations
; each timer has an associated control register
; ------------------------------------------------------------------------------------------------------------- ;
CIATALO                     = CIA1 + $04        ; Timer A Low Byte                          (Kernal-IRQ, Tape)
CIATALO_TAL0                  = %00000001       ; Bit 0: Read  (Timer)
CIATALO_TAL1                  = %00000010       ; Bit 1: Read  (Timer)
CIATALO_TAL2                  = %00000100       ; Bit 2: Read  (Timer)
CIATALO_TAL3                  = %00001000       ; Bit 3: Read  (Timer)
CIATALO_TAL4                  = %00010000       ; Bit 4: Read  (Timer)
CIATALO_TAL5                  = %00100000       ; Bit 5: Read  (Timer)
CIATALO_TAL6                  = %01000000       ; Bit 6: Read  (Timer)
CIATALO_TAL7                  = %10000000       ; Bit 7: Read  (Timer)
                                                ; 
CIATALO_PAL0                  = %00000001       ; Bit 0: Write (Prescaler)
CIATALO_PAL1                  = %00000010       ; Bit 1: Write (Prescaler)
CIATALO_PAL2                  = %00000100       ; Bit 2: Write (Prescaler)
CIATALO_PAL3                  = %00001000       ; Bit 3: Write (Prescaler)
CIATALO_PAL4                  = %00010000       ; Bit 4: Write (Prescaler)
CIATALO_PAL5                  = %00100000       ; Bit 5: Write (Prescaler)
CIATALO_PAL6                  = %01000000       ; Bit 6: Write (Prescaler)
CIATALO_PAL7                  = %10000000       ; Bit 7: Write (Prescaler)
TIMALO                      = CIATALO           ; 
; ------------------------------------------------------------------------------------------------------------- ;
CIATAHI                     = CIA1 + $05        ; Timer A High Byte                         (Kernal-IRQ, Tape)
CIATAHI_TAH0                  = %00000001       ; Bit 0: Read  (Timer)
CIATAHI_TAH1                  = %00000010       ; Bit 1: Read  (Timer)
CIATAHI_TAH2                  = %00000100       ; Bit 2: Read  (Timer)
CIATAHI_TAH3                  = %00001000       ; Bit 3: Read  (Timer)
CIATAHI_TAH4                  = %00010000       ; Bit 4: Read  (Timer)
CIATAHI_TAH5                  = %00100000       ; Bit 5: Read  (Timer)
CIATAHI_TAH6                  = %01000000       ; Bit 6: Read  (Timer)
CIATAHI_TAH7                  = %10000000       ; Bit 7: Read  (Timer)
                                                ; 
CIATAHI_PAH0                  = %00000001       ; Bit 0: Write (Prescaler)
CIATAHI_PAH1                  = %00000010       ; Bit 1: Write (Prescaler)
CIATAHI_PAH2                  = %00000100       ; Bit 2: Write (Prescaler)
CIATAHI_PAH3                  = %00001000       ; Bit 3: Write (Prescaler)
CIATAHI_PAH4                  = %00010000       ; Bit 4: Write (Prescaler)
CIATAHI_PAH5                  = %00100000       ; Bit 5: Write (Prescaler)
CIATAHI_PAH6                  = %01000000       ; Bit 6: Write (Prescaler)
CIATAHI_PAH7                  = %10000000       ; Bit 7: Write (Prescaler)
TIMAHI                      = CIATAHI           ; 
; ------------------------------------------------------------------------------------------------------------- ;
CIATBLO                     = CIA1 + $06        ; Timer B Low Byte                          (Tape, Serial Port)
CIATBLO_TBL0                  = %00000001       ; Bit 0: Read  (Timer)
CIATBLO_TBL1                  = %00000010       ; Bit 1: Read  (Timer)
CIATBLO_TBL2                  = %00000100       ; Bit 2: Read  (Timer)
CIATBLO_TBL3                  = %00001000       ; Bit 3: Read  (Timer)
CIATBLO_TBL4                  = %00010000       ; Bit 4: Read  (Timer)
CIATBLO_TBL5                  = %00100000       ; Bit 5: Read  (Timer)
CIATBLO_TBL6                  = %01000000       ; Bit 6: Read  (Timer)
CIATBLO_TBL7                  = %10000000       ; Bit 7: Read  (Timer)
                                                ; 
CIATBLO_PBL0                  = %00000001       ; Bit 0: Write (Prescaler)
CIATBLO_PBL1                  = %00000010       ; Bit 1: Write (Prescaler)
CIATBLO_PBL2                  = %00000100       ; Bit 2: Write (Prescaler)
CIATBLO_PBL3                  = %00001000       ; Bit 3: Write (Prescaler)
CIATBLO_PBL4                  = %00010000       ; Bit 4: Write (Prescaler)
CIATBLO_PBL5                  = %00100000       ; Bit 5: Write (Prescaler)
CIATBLO_PBL6                  = %01000000       ; Bit 6: Write (Prescaler)
CIATBLO_PBL7                  = %10000000       ; Bit 7: Write (Prescaler)
TIMBLO                      = CIATBLO           ; 
; ------------------------------------------------------------------------------------------------------------- ;
CIATBHI                     = CIA1 + $07        ; Timer B High Byte                         (Tape, Serial Port)
CIATBHI_TBH0                  = %00000001       ; Bit 0: Read  (Timer)
CIATBHI_TBH1                  = %00000010       ; Bit 1: Read  (Timer)
CIATBHI_TBH2                  = %00000100       ; Bit 2: Read  (Timer)
CIATBHI_TBH3                  = %00001000       ; Bit 3: Read  (Timer)
CIATBHI_TBH4                  = %00010000       ; Bit 4: Read  (Timer)
CIATBHI_TBH5                  = %00100000       ; Bit 5: Read  (Timer)
CIATBHI_TBH6                  = %01000000       ; Bit 6: Read  (Timer)
CIATBHI_TBH7                  = %10000000       ; Bit 7: Read  (Timer)
                                                ; 
CIATBHI_PBH0                  = %00000001       ; Bit 0: Write (Prescaler)
CIATBHI_PBH1                  = %00000010       ; Bit 1: Write (Prescaler)
CIATBHI_PBH2                  = %00000100       ; Bit 2: Write (Prescaler)
CIATBHI_PBH3                  = %00001000       ; Bit 3: Write (Prescaler)
CIATBHI_PBH4                  = %00010000       ; Bit 4: Write (Prescaler)
CIATBHI_PBH5                  = %00100000       ; Bit 5: Write (Prescaler)
CIATBHI_PBH6                  = %01000000       ; Bit 6: Write (Prescaler)
CIATBHI_PBH7                  = %10000000       ; Bit 7: Write (Prescaler)
TIMBHI                      = CIATBHI           ; 
; ------------------------------------------------------------------------------------------------------------- ;
; write to TODHR   - ToD clock is automatically stopped
; write to TOD10TH - ToD clock is automatically started
; 
; CIACRB_ALARM
;   0 = a WRITE to TOD the registers sets ALARM
;   1 = a WRITE to TOD the registers sets TOD clock
; ------------------------------------------------------------------------------------------------------------- ;
; LATCHing keeps all ToD information constant during a read sequence
; 
;   read TODHR   - enable  ToD registers LATCH - ToD continues to count
;   read TOD10TH - disable ToD registers LATCH
;   
;   each register reads out in BCD format
; 
;   any read of TODHRS must be followed by a read of TODTEN to disable the LATCHing again
;   any other single register can be read 'on the fly'
; ------------------------------------------------------------------------------------------------------------- ;
TOD10TH                     = CIA1 + $08        ; Time of Day Clock Tenths of Seconds
TOD10TH_T1                    = %00000001       ;   Bits 0…3: Time of Day tenths of second        (BCD)
TOD10TH_T2                    = %00000010       ;   
TOD10TH_T4                    = %00000100       ;   
TOD10TH_T8                    = %00001000       ;   
                                                ; 
                              ;  ...1....       ;   Bit    4: <not used>
                              ;  ..1.....       ;   Bit    5: <not used>
                              ;  .1......       ;   Bit    6: <not used>
                              ;  1.......       ;   Bit    7: <not used>
                                                ; 
TODTEN                      = TOD10TH           ; 
; ------------------------------------------------------------------------------------------------------------- ;
TODSEC                      = CIA1 + $09        ; Time of Day Clock Seconds
TODSEC_SLO                    = %00001111       ;   Bits 0…3: Second digit of Time of Day seconds (BCD)
TODSEC_SL1                    = %00000001       ; 
TODSEC_SL2                    = %00000010       ; 
TODSEC_SL4                    = %00000100       ; 
TODSEC_SL8                    = %00001000       ; 
                                                ; 
TODSEC_SHI                    = %01110000       ;   Bits 4…6: First  digit of Time of Day seconds (BCD)
TODSEC_SH1                    = %00010000       ; 
TODSEC_SH2                    = %00100000       ; 
TODSEC_SH4                    = %01000000       ; 
                                                ; 
                              ;  1.......       ;   Bit    7: <not used>
; ------------------------------------------------------------------------------------------------------------- ;
TODMIN                      = CIA1 + $0a        ; Time of Day Clock Minutes
TODMIN_MLO                    = %00001111       ;   Bits 0…3: Second digit of Time of Day minutes (BCD)
TODMIN_ML1                    = %00000001       ; 
TODMIN_ML2                    = %00000010       ; 
TODMIN_ML4                    = %00000100       ; 
TODMIN_ML8                    = %00001000       ; 
                                                ; 
TODMIN_MHI                    = %01110000       ;   Bits 4…6: First  digit of Time of Day minutes (BCD)
TODMIN_MH1                    = %00010000       ; 
TODMIN_MH2                    = %00100000       ; 
TODMIN_MH4                    = %01000000       ; 
                                                ; 
                              ;  1.......       ;   Bit    7: <not used>
; ------------------------------------------------------------------------------------------------------------- ;
TODHR                       = CIA1 + $0b        ; Time of Day Clock Hours
TODHR_HLO                     = %00001111       ;   Bits 0…3: Second digit of Time of Day hours   (BCD)
TODHR_HL1                     = %00000001       ; 
TODHR_HL2                     = %00000010       ; 
TODHR_HL4                     = %00000100       ; 
TODHR_HL8                     = %00001000       ; 
                                                ; 
TODHR_HH                      = %00010000       ;   Bit    4: First  digit of Time of Day hours   (BCD)
                                                ; 
                              ;  ..1.....       ;   Bit    5: <not used>
                              ;  .1......       ;   Bit    6: <not used>
                                                ;   
TODHR_PM                      = %10000000       ;   Bit    7: AM/PM Flag (1=PM, 0=AM)
TODHR_AM                      = %01111111       ; 
                                                ; 
TODHRS                      = TODHR             ; 
; ------------------------------------------------------------------------------------------------------------- ;
CIASDR                      = CIA1 + $0c        ; Synchronous Serial I/O Data Buffer (Serial Data Port Shift register)
                                                ; Bits are read/written upon every positive edge of the user port CNT pin
CIASDR_S0                     = %00000001       ; 
CIASDR_S1                     = %00000010       ; 
CIASDR_S2                     = %00000100       ; 
CIASDR_S3                     = %00001000       ; 
CIASDR_S4                     = %00010000       ; 
CIASDR_S5                     = %00100000       ; 
CIASDR_S6                     = %01000000       ; 
CIASDR_S7                     = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
; The Interrupt Control Register consists of
;   - a DATA register - read-only 
;       Bit 0: Read : Did Timer A count down to 0? ...................... (1=yes)
;       Bit 1: Read : Did Timer B count down to 0? ...................... (1=yes)
;       Bit 2: Read : Did Time of Day Clock reach the alarm time? ....... (1=yes)
;       Bit 3: Read : Did the serial shift register finish a byte? ...... (1=yes)
;       Bit 4: Read : Was a signal sent on the FLAG line? ............... (1=yes)
;       Bit 5:      : <not used>
;       Bit 6:      : <not used>
;       Bit 7: Read : Did any CIA #1 source cause an interrupt? ......... (1=yes)
;   
;   - a MASK register - write-only
;       Bit 0: Write: Enable or disable Timer A interrupt ............... (1=enable, 0=disable)
;       Bit 1: Write: Enable or disable Timer B interrupt ............... (1=enable, 0=disable)
;       Bit 2: Write: Enable or disable TOD clock alarm interrupt ....... (1=enable, 0=disable)
;                   : Serial Port full/empty
;       Bit 3: Write: Enable or disable serial shift register interrupt . (1=enable, 0=disable)
;                   : FLAG-pin: Cassette port Data input / Serial bus SRQ IN
;       Bit 4: Write: Enable or disable FLAG line interrupt ............. (1=enable, 0=disable)
;       Bit 5:      : <not used>
;       Bit 6:      : <not used>
;       Bit 7: Write: Set or clear bits of this register ................ (1=bits written with 1 will be set)
;                                                                         (0=bits written with 1 will be cleared)
; ------------------------------------------------------------------------------------------------------------- ;
CIAICR                      = CIA1 + $0d        ; Interrupt Control Register   (IRQ)
                                                ; ------------------------------------------------------------- ;
CIAICR_DATA_ALL               = %00011111       ;         Read  : DATA Register: Interrupt Origin
CIAICR_DATA_TA                = %00000001       ;   Bit 0 Read  : Underflow Timer A
CIAICR_DATA_TB                = %00000010       ;   Bit 1 Read  : Underflow Timer B
CIAICR_DATA_ALRM              = %00000100       ;   Bit 2 Read  : ToD equal Alarm Time
CIAICR_DATA_SP                = %00001000       ;   Bit 3 Read  : SDR full or empty (full byte transferred depending of serial bus operating mode)
CIAICR_DATA_FLG               = %00010000       ;   Bit 4 Read  : IRQ Signal occured at FLAG-pin (Cassette port Data input / Serial bus SRQ IN)
                                                ; 
                              ;  ..1.....       ;   Bit 5       : <not used>
                              ;  .1......       ;   Bit 6       : <not used>
                                                ; 
CIAICR_IR                     = %10000000       ;   Bit 7 Read  : An interrupt occured (if at least one bit of CIAICR_MASK is set)
                                                ; ------------------------------------------------------------- ;
CIAICR_MASK_ALL               = %00011111       ;         Write : MASK Register: Interrupt Selection
CIAICR_MASK_TA                = %00000001       ;   Bit 0 Write : Underflow Timer A
CIAICR_MASK_TB                = %00000010       ;   Bit 1 Write : Underflow Timer B
CIAICR_MASK_ALRM              = %00000100       ;   Bit 2 Write : ToD equal Alarm Time
CIAICR_MASK_SP                = %00001000       ;   Bit 3 Write : SDR full or empty (full byte transferred depending of serial busoperating mode)
CIAICR_MASK_FLG               = %00010000       ;   Bit 4 Write : IRQ Signal occured at FLAG-pin (Cassette port Data input / Serial bus SRQ IN)
                                                ;   
                              ;  ..1.....       ;   Bit 5       : <not used>
                              ;  .1......       ;   Bit 6       : <not used>
                                                ; 
CIAICR_SC                     = %10000000       ;   Bit 7 Write : The corresponding MASK bit must be set to generate an Interrupt Request
CIAICR_SC_SET                   = %10000000     ;   Bit 7 Write : Set a Selected Interrupt Source
CIAICR_SC_SET_ALL               = %11111111     ;               : Set all Interrupt Sources
CIAICR_SC_CLR                   = %00000000     ;   Bit 7 Write : Clear a Selected Interrupt Source
CIAICR_SC_CLR_ALL               = %01111111     ;               : Clear All Interrupt Sources
; ------------------------------------------------------------------------------------------------------------- ;
CIACRA                      = CIA1 + $0e        ; Control Register A
CIACRA_START                  = %00000001       ;   Bit 0:  Start Timer A                         (1=start, 0=stop)
                                                ;           Automatically reset when underflow occurs during one-shot mode
CIACRA_PBON                   = %00000010       ;   Bit 1:  Select Timer A output on Port B       (1=Timer A output appears on pin PB6)
                                                ;                                                    overrides the CIADDRB control bit and 
                                                ;                                                    forces the PB6 line to an output
CIACRA_OUTMODE                = %00000100       ;   Bit 2:  Port B (PB6) output mode
CIACRA_OUTMODE_TOGGLE           = %00000100     ;                                                 (1=toggle Bit 6)
CIACRA_OUTMODE_PULSE            = %11111011     ;                                                 (0=pulse  Bit 6 for one cycle)
CIACRA_RUNMODE                = %00001000       ;   Bit 3:  Timer A run mode
CIACRA_RUNMODE_OS               = %00001000     ;                                                 (1=one-shot   - stop after underflow)
CIACRA_RUNMODE_CONT             = %11110111     ;                                                 (0=continuous - reload LATCHed value after underflow)
CIACRA_LOAD                   = %00010000       ;   Bit 4:  Load LATCHed value into Timer A once  (1=force load STROBE)
                                                ;                                                    no data storage - will always read back a 0 
                                                ;                                                    writing a 0 has no effect
CIACRA_INMODE                 = %00100000       ;   Bit 5:  Timer A input mode
CIACRA_INMODE_CNT               = %00100000     ;                                                 (1=count positive CNT transitions)
CIACRA_INMODE_PHI2              = %11011111     ;                                                 (0=count system PHI2 clock pulses)
CIACRA_SPMODE                 = %01000000       ;   Bit 6:  Serial Port (CI2SDR) mode
CIACRA_SPMODE_OUTPUT            = %01000000     ;                                                 (1=output - CNT sources shift clock)
CIACRA_SPMODE_INPUT             = %10111111     ;                                                 (0=input  - external shift clock required)
CIACRA_TODIN                  = %10000000       ;   Bit 7:  Time of Day Clock frequency
CIACRA_TODIN_50HZ               = %10000000     ;                                                 (1=50Hz clock required for accurate time)
CIACRA_TODIN_60HZ               = %01111111     ;                                                 (0=60Hz clock required for accurate time)
; ------------------------------------------------------------------------------------------------------------- ;
CIACRB                      = CIA1 + $0f        ; Control Register B
CIACRB_START                  = %00000001       ;   Bit 0:  Start Timer B                         (1=start, 0=stop)
                                                ;           Automatically reset when underflow occurs during one-shot mode
CIACRB_PBON                   = %00000010       ;   Bit 1:  Select Timer B output on Port B       (1=Timer B output appears on pin PB7)
                                                ;                                                    overrides the CIADDRB control bit and 
                                                ;                                                    forces the PB7 line to an output
CIACRB_OUTMODE                = %00000100       ;   Bit 2:  Port B output mode
CIACRB_OUTMODE_TOGGLE           = %00000100     ;                                                 (1=toggle Bit 6)
CIACRB_OUTMODE_PULSE            = %11111011     ;                                                 (0=pulse  Bit 6 for one cycle)
CIACRB_RUNMODE                = %00001000       ;   Bit 3:  Timer B run mode
CIACRB_RUNMODE_OS               = %00001000     ;                                                 (1=one-shot   - stop after underflow)
CIACRB_RUNMODE_CONT             = %11110111     ;                                                 (0=continuous - reload LATCHed value after underflow)
CIACRB_LOAD                   = %00010000       ;   Bit 4:  Load LATCHed value into Timer B once  (1=force load STROBE - no data storage)
                                                ;                                                    will always read back a 1 
                                                ;                                                    writing a 0 has no effect
CIACRB_INMODE                 = %01100000       ;   Bit 5…6: Timer B input mode
CIACRB_INMODE_PHI2              = %00000000     ;            00 = Count system PHI2 clock pulses
CIACRB_INMODE_CNT               = %00100000     ;            01 = Count positive transitions on CNT line at pin 4 of User Port
CIACRB_INMODE_TA                = %01000000     ;            10 = Count underflows Timer A pulses (count down to zero)
CIACRB_INMODE_TAC               = %01100000     ;            11 = Count underflows Timer A pulses while CNT-pin is high
CIACRB_ALARM                  = %10000000       ;   Bit 7: Select Time of Day write
                                                ;          0 = WRITE to the TOD registers sets ALARM
                                                ;          1 = WRITE to the TOD registers sets TOD clock
; ------------------------------------------------------------------------------------------------------------- ;
; $DC10-$DCFF                                   ; CIA #1 Register Images - Mirror of $DC00-$DC0F
; ------------------------------------------------------------------------------------------------------------- ;
 