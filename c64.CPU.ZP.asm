; --------------------------------------------------------------------------------------------------------------------- ;
; C64 Zeropage Processor Definition
; --------------------------------------------------------------------------------------------------------------------- ;
; 6510 CPU Port Data Direction Register
; --------------------------------------------------------------------------------------------------------------------- ;
D6510                       = $00               ; 6510 On-Chip I/O Data Direction
D6510_LORAM                   = %00000001       ;   Bit 0   : (1=output, 0=input) - default: 1=output
D6510_LORAM_OUT                 = D6510_LORAM   ;           : 
D6510_LORAM_IN                  = ~D6510_LORAM  ;           : 
D6510_HIRAM                   = %00000010       ;   Bit 1   : (1=output, 0=input) - default: 1=output
D6510_HIRAM_OUT                 = D6510_HIRAM   ;           : 
D6510_HIRAM_IN                  = ~D6510_HIRAM  ;           : 
D6510_CHAREN                  = %00000100       ;   Bit 2   : (1=output, 0=input) - default: 1=output
D6510_CHAREN_OUT                = D6510_CHAREN  ;           : 
D6510_CHAREN_IN                 = ~D6510_CHAREN ;           : 
D6510_DATA                    = %00001000       ;   Bit 3   : (1=output, 0=input) - default: 1=output
D6510_DATA_OUT                  = D6510_DATA    ;           : 
D6510_DATA_IN                   = ~D6510_DATA   ;           :  
D6510_SENSE                   = %00010000       ;   Bit 4   : (1=output, 0=input) - default: 0=input
D6510_SENSE_OUT                 = D6510_SENSE   ;           : 
D6510_SENSE_IN                  = ~D6510_SENSE  ;           : 
D6510_MOTOR                   = %00100000       ;   Bit 5   : (1=output, 0=input) - default: 1=output
D6510_MOTOR_OUT                 = R6510_MOTOR   ;           : 
D6510_MOTOR_IN                  = ~R6510_MOTOR  ;           : 
                              
                              ;  .1......       ;   Bit    6: <not connected>
                              ;  1.......       ;   Bit    7: <not connected>
                              
D6510_INI                     = D6510_MOTOR_OUT | D6510_DATA_OUT | D6510_CHAREN_OUT | D6510_HIRAM_OUT | D6510_LORAM_OUT ; default: $2f (..#.####)
; --------------------------------------------------------------------------------------------------------------------- ;
; 6510 CPU Port Data Register
; --------------------------------------------------------------------------------------------------------------------- ;
R6510                       = $01               ; 6510 On-Chip I/O Data
; --------------------------------------------------------------------------------------------------------------------- ;
; Bits 0…2: Select Memory Configuration
; --------------------------------------------------------------------------------------------------------------------- ;
R6510_MEM                     = %00000111       ; memory config control
LORAM                         = %00000001       ;   Bit 0  : L
LORAM_BASIC_ON                = %00000001       ;          : 1=BASIC
LORAM_BASIC_OFF               = %00111110       ;          : 0=RAM
                              
HIRAM                         = %00000010       ;   Bit 1  : H  
HIRAM_KERNAL_ON               = %00000010       ;          : 1=Kernal
HIRAM_KERNAL_OFF              = %00111101       ;          : 0=RAM --> If KERNAL = OFF then BASIC = OFF too - needs KERNAL
                              
CHAREN                        = %00000100       ;   Bit 2  : C
CHAREN_IO_ON                  = %00000100       ;          : 1=I/O area instead of Char ROM
CHAREN_IO_OFF                 = %00111011       ;          : 0=Char ROM instead of I/O area
                              
CHAREN_CHAR_ON                = CHAREN_IO_OFF   ;          : 0=Char ROM instead of I/O area
CHAREN_CHAR_OFF               = CHAREN_IO_ON    ;          : 1=I/O area instead of Char ROM
                                                ; 
R6510_MEM_INI                 = CHAREN_IO_ON | HIRAM_KERNAL_ON | LORAM_BASIC_ON ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Bits 3…5: Tape Control
; --------------------------------------------------------------------------------------------------------------------- ;
R6510_TAPE                    = %00111000       ; tape control
R6510_DATA                    = %00001000       ;   Bit 3  : Tape Data Output Pulse
R6510_DATA_PULSE              = %00001000       ;          :   Tape Data In = Bit4 (CIAICR_DATA_FLG) of CIAICR
R6510_SENSE                   = %00010000       ;   Bit 4  : Tape Switch Sense  (1=no button Pressed,0=one of PLAY/RECORD/FFWD/REW pressed)
R6510_MOTOR                   = %00100000       ;   Bit 5  : Tape Motor Control
R6510_MOTOR_OFF               = %00100000       ;          : 1=Switch tape motor off
R6510_MOTOR_ON                = %00011111       ;          : 0=switch tape motor on
                              
                              ;  .1......       ;   Bit    6: <not connected>
                              ;  1.......       ;   Bit    7: <not connected>
                              
R6510_TAPE_INI              = $00 & ~R6510_DATA_PULSE | R6510_SENSE | R6510_MOTOR_OFF ; default $30 - %00110000
; --------------------------------------------------------------------------------------------------------------------- ;
R6510_INI                   = R6510_TAPE_INI | R6510_MEM_INI ; default $37 - %00110111 = Motor Off / No button pressed / Data low / IO KERNAL BASIC on
; --------------------------------------------------------------------------------------------------------------------- ;
; Presets
; ----+-------------+-------------------------------------------------------------------------------------------------- ;
; Bit ! Name        ! Value
; ----+-------------+---------------------------
;  0  ! LORAM       ! 1 = BASIC,  0 = RAM
;  1  ! HIRAM       ! 1 = Kernal, 0 = RAM       <-- if KERNAL = OFF then BASIC = OFF
;  2  ! CHAREN      ! 1 = I/O,    0 = Char ROM
; ----+-------------+--------+-------+----------
;     ! Bit ! $D000 ! $E000  ! $A000 ! 
;     !     ! $DFFF ! $FFFF  ! $BFFF ! 
;     ! ----+-------+--------+-------+ 
;     ! 000 ! ram   ! ram    ! ram   ! 
;     ! 001 ! Chars ! ram    ! ram   ! 
;     ! 010 ! Chars ! Kernal ! ram   ! 
;     ! 011 ! Chars ! Kernal ! BASIC ! 
;     ! 100 ! ram   ! ram    ! ram   ! 
;     ! 101 ! I/O   ! ram    ! ram   ! 
;     ! 110 ! I/O   ! Kernal ! ram   ! 
;     ! 111 ! I/O   ! Kernal ! BASIC !          <-- default $07
; ----+-------------+---+-----------------------
;  3  ! Tape Data Out   ! 0=Output line signal level
;  4  ! Tape Switch     ! 1=No button pressed, 0=One or more of PLAY, RECORD, F.FWD or REW pressed
;  5  ! Tape Motor Ctrl ! 1=Off, 0=On
; ----+-----------------+-----------------------
;  6  ! unused          ! 0
;  7  ! unused          ! 0
; ----+-----------------+---------------------------------------------------------------------------------------------- ;
R6510_B_OFF                 = R6510_TAPE_INI | CHAREN_IO_ON  | HIRAM_KERNAL_ON  & LORAM_BASIC_OFF ; %00110110 ($36) -> I/O  - KERNAL - RAM    - 
R6510_K_OFF                 = R6510_TAPE_INI | CHAREN_IO_ON  & HIRAM_KERNAL_OFF | LORAM_BASIC_ON  ; %00110101 ($35) -> I/O  - RAM    - RAM    - BASIC off if KERNAL off
R6510_KB_OFF                = R6510_TAPE_INI | CHAREN_IO_ON  & HIRAM_KERNAL_OFF & LORAM_BASIC_OFF ; %00110100 ($34) -> RAM  - RAM    - RAM    - IO    off if KERNAL and BASIC off
R6510_IKB_OFF               = R6510_TAPE_INI & CHAREN_IO_OFF & HIRAM_KERNAL_OFF & LORAM_BASIC_OFF ; %00110000 ($30) -> RAM  - RAM    - RAM    - 
                                
R6510_I_OFF                 = R6510_TAPE_INI & CHAREN_IO_OFF | HIRAM_KERNAL_ON  | LORAM_BASIC_ON  ; %00110011 ($33) -> CHAR - KERNAL - BASIC  - 
                                
R6510_IKB_ON                = R6510_TAPE_INI | CHAREN_IO_ON  | HIRAM_KERNAL_ON  | LORAM_BASIC_ON  ; %00110111 ($37) -> I/O  - KERNAL - BASIC  - 
R6510_CBK_ON                = R6510_TAPE_INI & CHAREN_IO_OFF | HIRAM_KERNAL_ON  | LORAM_BASIC_ON  ; %00110011 ($33) -> CHAR - KERNAL - BASIC  - 
R6510_CK_ON                 = R6510_TAPE_INI & CHAREN_IO_OFF | HIRAM_KERNAL_ON  & LORAM_BASIC_OFF ; %00110010 ($32) -> CHAR - KERNAL - RAM    - 
R6510_C_ON                  = R6510_TAPE_INI & CHAREN_IO_OFF & HIRAM_KERNAL_OFF | LORAM_BASIC_ON  ; %00110001 ($31) -> CHAR - RAM    - RAM    - BASIC off if KERNAL off
; --------------------------------------------------------------------------------------------------------------------- ;
; 6510 CPU Status Byte
; --------------------------------------------------------------------------------------------------------------------- ;
; Six processor STATUS flags are pushed to the STACK by:
;   2 interrupts   (/IRQ and /NMI)
;   2 instructions (PHP  and BRK)
; The STATUS byte contains two additional flags then:
;   the B flag
;     bit4 = 0 - if from an interrupt line being pulled low (/IRQ or /NMI)
;     bit4 = 1 - if from an instruction (PHP or BRK)
;   bit5 - always set to 1
; The only time and place where the B flag exists
;   - in Bit4 of the copy that is written to the stack
;   - NOT in the status register itself
; --------------------------------------------------------------------------------------------------------------------- ;
S6510_FLAG_N                = %10000000         ; Negative
S6510_FLAG_V                = %01000000         ; Overflow
S6510_FLAG_5                = %00100000         ; Always 1
S6510_FLAG_B                = %00010000         ; B flag - No CPU effect
                                                ;   0 - if from an interrupt line being pulled low (/IRQ or /NMI)
                                                ;   1 - if from an instruction (PHP or BRK)
S6510_FLAG_D                = %00001000         ; Decimal
S6510_FLAG_I                = %00000100         ; Interrupt Disable
S6510_FLAG_Z                = %00000010         ; Zero
S6510_FLAG_C                = %00000001         ; Carry
; --------------------------------------------------------------------------------------------------------------------- ;
