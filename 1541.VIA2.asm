; ------------------------------------------------------------------------------------------------------------- ;
; VIC 1541 - 6522 VIA2 chip register definitions
; ------------------------------------------------------------------------------------------------------------- ;
; VIA #2 Registers - $1C00-$1C0F - Disk Controller Port: motor and read/write head control
; ------------------------------------------------------------------------------------------------------------- ;
VIA2                        = $1C00             ; Base address 
; ------------------------------------------------------------------------------------------------------------- ;
; Two 8-bit bidirectional I/O ports (Port A and Port B)
; ------------------------------------------------------------------------------------------------------------- ;
DSKCNT                      = VIA2 + $00        ; Disk Controller
VIA2PB                      = DSKCNT            ; Data Port B (Motor, LED, Protection, Bit Rates, SYNC)
VIA2PB_STEP_PHASE             = %00000011       ; stepper motor head step direction

VIA2PB_STEP_PHASE_0           = %00000001       ; stepper motor bit0
VIA2PB_STEP_PHASE_1           = %00000010       ; stepper motor bit1
                              
VIA2PB_STEP_PHASE_A           = %11111100       ; Phase: Increase Sequence - 00/01/10/11/00/... - move head inwards
VIA2PB_STEP_PHASE_B           = %11111101       ; Phase: Decrease Sequence - 00/11/10/01/00/... - move head outwards
VIA2PB_STEP_PHASE_C           = %11111110       ; 
VIA2PB_STEP_PHASE_D           = %11111111       ; 
                              
VIA2PB_MOTOR                  = %00000100       ; drive #0 motor control
VIA2PB_MOTOR_ON               = %00000100       ;   1=on
VIA2PB_MOTOR_OFF              = %11111011       ;   0=off
                                    
VIA2PB_LED                    = %00001000       ; drive #0 LED control
VIA2PB_LED_ON                 = %00001000       ;   1=on
VIA2PB_LED_OFF                = %11110111       ;   0=off
                                    
VIA2PB_PROT                   = %00010000       ; state write protect photo cell
VIA2PB_PROT_ON                = %11101111       ;   0=write protect tab covered   = disk protected
VIA2PB_PROT_OFF               = %00010000       ;   1=write protect tab uncovered = disk not protected
                                    
VIA2PB_BITRATE                = %01100000       ; drive transfer rate - data density
VIA2PB_BITRATE_0              = %00100000       ; bitrate bit0 - density select 0
VIA2PB_BITRATE_1              = %01000000       ; bitrate bit1 - density select 1
VIA2PB_BITRATE_T31            = %00000000       ;  00=250000 Bit/s - Tracks 31-35
VIA2PB_BITRATE_T25            = %00100000       ;  01=266667 Bit/s - Tracks 25-30
VIA2PB_BITRATE_T18            = %01000000       ;  10=285714 Bit/s - Tracks 18-24
VIA2PB_BITRATE_T01            = %01100000       ;  11=307692 Bit/s - Tracks  1-17
                              
VIA2PB_SYNC                   = %10000000       ; SYNC detected
                                                ;   bit7=0 - data currently read
                                                ;   bit7=1 - SYNC marks read
                              
VIA2PB_INI                  = VIA2PB_SYNC | VIA2PB_BITRATE_T01 | VIA2PB_PROT_OFF & VIA2PB_LED_OFF & VIA2PB_MOTOR_OFF & VIA2PB_STEP_PHASE_A

VIA2ORB                     = DSKCNT            ; output register B
VIA2ORB_PB0                   = %00000000       ; 
VIA2ORB_PB1                   = %00000010       ; 
VIA2ORB_PB2                   = %00000100       ; 
VIA2ORB_PB3                   = %00001000       ; 
VIA2ORB_PB4                   = %00010000       ; 
VIA2ORB_PB5                   = %00100000       ; 
VIA2ORB_PB6                   = %01000000       ; 
VIA2ORB_PB7                   = %10000000       ; 
                            
VIA2IRB                     = DSKCNT            ; input register B
VIA2IRB_PB0                   = %00000000       ; 
VIA2IRB_PB1                   = %00000010       ; 
VIA2IRB_PB2                   = %00000100       ; 
VIA2IRB_PB3                   = %00001000       ; 
VIA2IRB_PB4                   = %00010000       ; 
VIA2IRB_PB5                   = %00100000       ; 
VIA2IRB_PB6                   = %01000000       ; 
VIA2IRB_PB7                   = %10000000       ; 

; ------------------------------------------------------------------------------------------------------------- ;
VIA2PA                      = VIA2 + $01        ; Data Port A - Data to/from head
VIA2DATA                    = VIA2PA            ; 

VIA2ORA                     = VIA2PA            ; output register A
VIA2ORA_PA0                   = %00000001       ; 
VIA2ORA_PA1                   = %00000010       ; 
VIA2ORA_PA2                   = %00000100       ; 
VIA2ORA_PA3                   = %00001000       ; 
VIA2ORA_PA4                   = %00010000       ; 
VIA2ORA_PA5                   = %00100000       ; 
VIA2ORA_PA6                   = %01000000       ; 
VIA2ORA_PA7                   = %10000000       ; 
                            
VIA2IRA                     = VIA2PA            ; input register A
VIA2IRA_PA0                   = %00000001       ; 
VIA2IRA_PA1                   = %00000010       ; 
VIA2IRA_PA2                   = %00000100       ; 
VIA2IRA_PA3                   = %00001000       ; 
VIA2IRA_PA4                   = %00010000       ; 
VIA2IRA_PA5                   = %00100000       ; 
VIA2IRA_PA6                   = %01000000       ; 
VIA2IRA_PA7                   = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
; DDRB specify which pins within the port bus are to be designated as inputs or outputs
;   Bit 0…7 = 0 - corresponding pin in PB acts as INPUT
;   Bit 0…7 = 1 - corresponding pin in PB acts as OUTPUT
; ------------------------------------------------------------------------------------------------------------- ;
VIA2DDRB                    = VIA2 + $02        ; Data Direction Register Port B
VIA2DDRB_STEP_PHASE_OUT       = %00000011       ; stepper motor bit0-bit1
VIA2DDRB_STEP_PHASE_IN        = %11111100       ; 
VIA2DDRB_MOTOR_OUT            = %00000100       ; drive #0 motor control
VIA2DDRB_MOTOR_IN             = %11111011       ; 
VIA2DDRB_LED_OUT              = %00001000       ; drive #0 LED control
VIA2DDRB_LED_IN               = %11110111       ; 
VIA2DDRB_PROT_OUT             = %00010000       ; state write protect photo cell
VIA2DDRB_PROT_IN              = %11101111       ; 
VIA2DDRB_BITRATE_OUT          = %01100000       ; bitrate bit0-bit1
VIA2DDRB_BITRATE_IN           = %10011111       ; 
VIA2DDRB_BITRATE_0_OUT        = %00100000       ; bitrate bit0
VIA2DDRB_BITRATE_0_IN         = %11011111       ; 
VIA2DDRB_BITRATE_1_OUT        = %01000000       ; bitrate bit1
VIA2DDRB_BITRATE_1_IN         = %10111111       ; 
VIA2DDRB_SYNC_OUT             = %10000000       ; SYNC
VIA2DDRB_SYNC_IN              = %01111111       ; 
                              
VIA2DDRB_PB0                  = %00000001       ; 0=Input  1=output
VIA2DDRB_PB1                  = %00000010       ; 0=Input  1=output
VIA2DDRB_PB2                  = %00000100       ; 0=Input  1=output
VIA2DDRB_PB3                  = %00001000       ; 0=Input  1=output
VIA2DDRB_PB4                  = %00010000       ; 0=Input  1=output
VIA2DDRB_PB5                  = %00100000       ; 0=Input  1=output
VIA2DDRB_PB6                  = %01000000       ; 0=Input  1=output
VIA2DDRB_PB7                  = %10000000       ; 0=Input  1=output
                            
VIA2DDRB_INI                = DDRB2_BITRATE_OUT | DDRB2_LED_OUT | DDRB2_MOTOR_OUT | DDRB2_STEP_PHASE_OUT & DDRB2_SYNC_IN & DDRB2_PROT_IN ; SYNC_IN / DDRB2_PROT_IN
; ------------------------------------------------------------------------------------------------------------- ;
; DDRA specifies which pins within the port bus are to be designated as inputs or outputs
;   Bit 0…7 = 0 - corresponding pin in PA acts as INPUT
;   Bit 0…7 = 1 - corresponding pin in PA acts as OUTPUT
; ------------------------------------------------------------------------------------------------------------- ;
VIA2DDRA                    = VIA2 + $03        ; Data Direction Register Port A - Data to/from head
VIA2DDRA_PA0                  = %00000001       ; 0=Input  1=output
VIA2DDRA_PA1                  = %00000010       ; 0=Input  1=output
VIA2DDRA_PA2                  = %00000100       ; 0=Input  1=output
VIA2DDRA_PA3                  = %00001000       ; 0=Input  1=output
VIA2DDRA_PA4                  = %00010000       ; 0=Input  1=output
VIA2DDRA_PA5                  = %00100000       ; 0=Input  1=output
VIA2DDRA_PA6                  = %01000000       ; 0=Input  1=output
VIA2DDRA_PA7                  = %10000000       ; 0=Input  1=output
                            
VIA2DDRA_READ               = %00000000         ;   $00 - read  from disk
VIA2DDRA_WRITE              = %11111111         ;   $ff - write to   disk
; ------------------------------------------------------------------------------------------------------------- ;
; Interval Timer 1 (T1) consists of two 8-bit latches and a 16-bit counter
;   the latches store data to be loaded into the counter
;   the counter decrements at Phase 2 clock rate
;   if reaching zero VIA1IFR_TI1 causing an Interrupt Request if VIA1IER_TI1 is set
; ------------------------------------------------------------------------------------------------------------- ;
VIA2T1CL                    = VIA2 + $04        ; Timer 1 Counter LO                                 (IRQ Timer)
                                                ;   read low byte to (re)start timer upon underflow
VIA2T1CL_T1CL0                = %00000001       ; write=latches LO  read=counter LO
VIA2T1CL_T1CL1                = %00000010       ; write=latches LO  read=counter LO
VIA2T1CL_T1CL2                = %00000100       ; write=latches LO  read=counter LO
VIA2T1CL_T1CL3                = %00001000       ; write=latches LO  read=counter LO
VIA2T1CL_T1CL4                = %00010000       ; write=latches LO  read=counter LO
VIA2T1CL_T1CL5                = %00100000       ; write=latches LO  read=counter LO
VIA2T1CL_T1CL6                = %01000000       ; write=latches LO  read=counter LO
VIA2T1CL_T1CL7                = %10000000       ; write=latches LO  read=counter LO
; ------------------------------------------------------------------------------------------------------------- ;
VIA2T1CH                    = VIA2 + $05        ; Timer 1 Counter HI                                 (IRQ Timer)
                                                ;   write high byte to (re)start timer upon underflow
VIA2T1CH_T1CH0                = %00000001       ; read/write=counter HI
VIA2T1CH_T1CH1                = %00000010       ; read/write=counter HI
VIA2T1CH_T1CH2                = %00000100       ; read/write=counter HI
VIA2T1CH_T1CH3                = %00001000       ; read/write=counter HI
VIA2T1CH_T1CH4                = %00010000       ; read/write=counter HI
VIA2T1CH_T1CH5                = %00100000       ; read/write=counter HI
VIA2T1CH_T1CH6                = %01000000       ; read/write=counter HI
VIA2T1CH_T1CH7                = %10000000       ; read/write=counter HI
; ------------------------------------------------------------------------------------------------------------- ;
VIA2T1LL                    = VIA2 + $06        ; Timer 1 Latches LO - read/write starting value of timer from/to here
VIA2T1LL_T1LL0                = %00000001       ; read/write=latch LO
VIA2T1LL_T1LL1                = %00000010       ; read/write=latch LO
VIA2T1LL_T1LL2                = %00000100       ; read/write=latch LO
VIA2T1LL_T1LL3                = %00001000       ; read/write=latch LO
VIA2T1LL_T1LL4                = %00010000       ; read/write=latch LO
VIA2T1LL_T1LL5                = %00100000       ; read/write=latch LO
VIA2T1LL_T1LL6                = %01000000       ; read/write=latch LO
VIA2T1LL_T1LL7                = %10000000       ; read/write=latch LO
; ------------------------------------------------------------------------------------------------------------- ;
VIA2T1HL                    = VIA2 + $07        ; Timer 1 Latches HI - read/write starting value of timer from/to here
VIA2T1LH_T1HL0                = %00000001       ; read/write=latch HI
VIA2T1LH_T1HL1                = %00000010       ; read/write=latch HI
VIA2T1LH_T1HL2                = %00000100       ; read/write=latch HI
VIA2T1LH_T1HL3                = %00001000       ; read/write=latch HI
VIA2T1LH_T1HL4                = %00010000       ; read/write=latch HI
VIA2T1LH_T1HL5                = %00100000       ; read/write=latch HI
VIA2T1LH_T1HL6                = %01000000       ; read/write=latch HI
VIA2T1LH_T1HL7                = %10000000       ; read/write=latch HI
; ------------------------------------------------------------------------------------------------------------- ;
; Timer 2 (T2) operates in One-Shot Mode only (as an interval timer) or as a pulse counter for counting negative pulses on PB6
; ------------------------------------------------------------------------------------------------------------- ;
VIA2T2CL                    = VIA2 + $08        ; Timer 2 Counter LO                                    (unused)
VIA2T2CL_T2CL0                = %00000001       ; write=latches LO  read=counter LO
VIA2T2CL_T2CL1                = %00000010       ; write=latches LO  read=counter LO
VIA2T2CL_T2CL2                = %00000100       ; write=latches LO  read=counter LO
VIA2T2CL_T2CL3                = %00001000       ; write=latches LO  read=counter LO
VIA2T2CL_T2CL4                = %00010000       ; write=latches LO  read=counter LO
VIA2T2CL_T2CL5                = %00100000       ; write=latches LO  read=counter LO
VIA2T2CL_T2CL6                = %01000000       ; write=latches LO  read=counter LO
VIA2T2CL_T2CL7                = %10000000       ; write=latches LO  read=counter LO
; ------------------------------------------------------------------------------------------------------------- ;
VIA2T2CH                    = VIA2 + $09        ; Timer 2 Counter HI                                    (unused)
VIA2T2CH_T2CH0                = %00000001       ; read/write=counter LO
VIA2T2CH_T2CH1                = %00000010       ; read/write=counter LO
VIA2T2CH_T2CH2                = %00000100       ; read/write=counter LO
VIA2T2CH_T2CH3                = %00001000       ; read/write=counter LO
VIA2T2CH_T2CH4                = %00010000       ; read/write=counter LO
VIA2T2CH_T2CH5                = %00100000       ; read/write=counter LO
VIA2T2CH_T2CH6                = %01000000       ; read/write=counter LO
VIA2T2CH_T2CH7                = %10000000       ; read/write=counter LO
; ------------------------------------------------------------------------------------------------------------- ;
VIA2SR                      = VIA2 + $0a        ; Shift Register                                        (unused)
; ------------------------------------------------------------------------------------------------------------- ;
VIA2ACR                     = VIA2 + $0b        ; Auxiliary Control Register
VIA2ACR_LATCH                 = %00000011       ; LATCH enable/disable
VIA2ACR_LATCH_PA              = %00000001       ; Control latching PA
VIA2ACR_LATCH_PA_ENA          = %00000001       ;   1=enable  latching PA
VIA2ACR_LATCH_PA_DISA         = %11111110       ;   0=disable latching PA
VIA2ACR_LATCH_PB              = %00000010       ; Control latching PB
VIA2ACR_LATCH_PB_ENA          = %00000010       ;   1=enable  latching PB
VIA2ACR_LATCH_PB_DISA         = %11111101       ;   0=disable latching PB
                              
VIA2ACR_SHFT                  = %00011100       ; Shift Register Control
VIA2ACR_SHFT_I_DISA           = %00000000       ;   000 - SR Mode 0: Shift register disabled
VIA2ACR_SHFT_I_TI2            = %00000100       ;   001 - SR Mode 1: Shift in  under TI2  control
VIA2ACR_SHFT_I_PHI2           = %00001000       ;   010 - SR Mode 2: Shift in  under Phi2 control
VIA2ACR_SHFT_I_CB1            = %00001100       ;   011 - SR Mode 3: Shift in  under CB1  control (external clock)
VIA2ACR_SHFT_O_FRE            = %00010000       ;   100 - SR Mode 4: Shift out under TI2  control (free-running at TI2 rate)
VIA2ACR_SHFT_O_TI2            = %00010100       ;   101 - SR Mode 5: Shift out under TI2  control
VIA2ACR_SHFT_O_PHI2           = %00011000       ;   110 - SR Mode 6: Shift out under Phi2 control
VIA2ACR_SHFT_O_CB1            = %00011100       ;   111 - SR Mode 7: Shift out under CB1  control (external clock)
                              
VIA2ACR_T2                    = %00100000       ; Timer 2 Control
VIA2ACR_T2_PULSE              = %00100000       ;   1=Count Down with incoming Pulses on PB6
VIA2ACR_T2_TIMED              = %11011111       ;   0=Timed Interrupt - single interval timing
                                    
VIA2ACR_T1                    = %11000000       ; Timer 1 Control
VIA2ACR_T1_OS                 = %00000000       ;   00=Timed Interrupt each time Timer 1 is loaded - one-shot - no PB7 output pulses
VIA2ACR_T1_FRE                = %01000000       ;   01=Continuous Interrupts                       - free run - no PB7 output pulses
VIA2ACR_T1_OSPB7              = %10000000       ;   10=Timed Interrupt each time Timer 1 is loaded - one-shot on PB7 (negative pulses)
VIA2ACR_T1_FREPB7             = %11000000       ;   11=Continuous Interrupts                       - free run on PB7 (square-wave: invert last pulse)
; ------------------------------------------------------------------------------------------------------------- ;
VIA2PCR                     = VIA2 + $0c        ; Peripheral Control Register
VIA2PCR_CA1_INT               = %00000001       ; CA1 Line Control  - Interrupt Control
                                                ;                     used for BYTE READY
; --------------------------------------------- ; ------------------------------------------------------------------------------ ;
;                                               ; 
;             BYTE-READY                        ; CA1 - Input  Mode - BYTE-READY interrupt control
;                                               ; 
; --------------------------------------------- ; ------------------------------------------------------------------------------ ;
VIA2PCR_CA1_INT_NEG           = %11111110       ;   0=CA1 input on falling edge (Negative active edge)
                                                ;         VIA2IFR_CA1 is set on a high to low transition of CA1
VIA2PCR_CA1_INT_POS           = %00000001       ;   1=CA1 input on rising edge (Positive active edge)
                                                ;         VIA2IFR_CA1 is set on a low to high transition of CA1
; --------------------------------------------- ; ------------------------------------------------------------------------------ ;
VIA2PCR_CA2                   = %00001110       ; Bit 1…3: CA2 Line Control - used for the serial clock output line
                                                ;                             the interrupt flag VIA2IFR_CA2 is used to flag a CB1 interrupt
VIA2PCR_CA2_NEG               = %00000000       ;   000 - Input  Mode     - Negative active edge
                                                ;                           set VIA2IFR_CA2 on a high to low transition of CA2
                                                ;                           clear IER2_CA2 on a read or write of PA2
VIA2PCR_CA2_NEGI              = %00000010       ;   001 - Input  Mode     - Negative edge Independent Interrupt
                                                ;                           set VIA2IFR_CA2 on a high to low transition of CA2
                                                ;                           do not clear IER2_CA2 on a read or write of PA2
                                                ;                           VIA2IFR_CA2 is cleared by writing a 1 to it
VIA2PCR_CA2_POS               = %00000100       ;   010 - Input  Mode     - Positive active edge
                                                ;                           set VIA2IFR_CA2 on a low to high transition of CA2
                                                ;                           clear IER2_CA2 on a read or write of PA2
VIA2PCR_CA2_POSI              = %00000110       ;   011 - Input  Mode     - Positive edge Independent Interrupt
                                                ;                           Set IFR bit 0 on a low to high transition of CA2
                                                ;                           do not clear IER2_CA2 on a read or write of PA2
                                                ;                           VIA2IFR_CA2 is cleared by writing a 1 to it
                                                ; ------------------------------------------------------------------------------ ;
VIA2PCR_CA2_HDS               = %00001000       ;   100 - Output Mode     - Handshake
                                                ;                           Set CA2 low on a read or write of PA2
VIA2PCR_CA2_PULS              = %00001010       ;   101 - Output Mode     - Pulse
                                                ;                           set CA2 line low for one cycle on a read or write of PA2
; --------------------------------------------- ; ------------------------------------------------------------------------------ ;
;                                               ; CA2 - Output SOE  - Set Overflow Enable for the 6502 V-Flag
;             SOE                               ;                       PCR2_CA2_SOE_ON  = activate BYTE-READY
;                                               ;                       PCR2_CA2_SOE_OFF = BYTE READY signal will not be available at CA1
;                                               ;                                          the 6502 .V flag will not be set (via SO pin)
; --------------------------------------------- ; ------------------------------------------------------------------------------ ;
VIA2PCR_CA2_SOE_OFF           = %00001100       ;   110 - Output Mode     - Low level (manual)
VIA2PCR_CA2_LO                = VIA2PCR_CA2_SOE_OFF ;                         CA2 line to be held low - deactivate BYTE-READY
VIA2PCR_CA2_SOE_ON            = %00001110       ;   111 - Output Mode     - High level (manual)
VIA2PCR_CA2_HI                = VIA2PCR_CA2_SOE_ON  ;                         CA2 line to be held high - activate BYTE-READY
                                                ; 
VIA2PCR_CA2_SOE_SWITCH        = %00000010       ;   bit1 - switch SOE mode on/off
; --------------------------------------------- ; ------------------------------------------------------------------------------ ;
;                                               ; 
;             CB1                               ; CB1 - not connected
;                                               ; 
; --------------------------------------------- ; ------------------------------------------------------------------------------ ;
VIA2PCR_CB1_INT               = %00010000       ; CB1 Line Control  - Interrupt Control
                                                ;                     used to accept an interrupt for received data
VIA2PCR_CB1_INT_NEG           = %11101111       ;   0=CA2 input on falling edge (Negative active edge)
                                                ;         VIA2IFR_CB2 is set on a high to low transition of CB1
VIA2PCR_CB1_INT_POS           = %00010000       ;   1=CA2 input on rising edge (Positive active edge)
                                                ;         VIA2IFR_CB2 is set on a low to high transition of CB1
; --------------------------------------------- ; ------------------------------------------------------------------------------ ;
VIA2PCR_CB2                   = %11100000       ; Bits 5…7: CB2 Line Control - used for serial data out and for interrupt input
                                                ;                     the interrupt flag VIA2IFR_CB2 is used to flag a CB2 interrupt
                                                ; 
VIA2PCR_CB2_NEG               = %00000000       ;   000 - Input  Mode - Negative active edge
VIA2PCR_CB2_NEG_IRQ           = %00100000       ;   001 - Input  Mode - Negative edge Independent Interrupt
VIA2PCR_CB2_POS               = %01000000       ;   010 - Input  Mode - Positive active edge
VIA2PCR_CB2_POS_IRQ           = %01100000       ;   011 - Input  Mode - Positive edge Independent Interrupt
VIA2PCR_CB2_HDSH              = %10000000       ;   100 - Output Mode - Handshake
VIA2PCR_CB2_PULSE             = %10100000       ;   101 - Output Mode - Pulse
; --------------------------------------------- ; ------------------------------------------------------------------------------ ;
;                                               ; CB2 - Output Mode - Output Enable (OE)
;             HEAD MODE                         ;                     determine whether data is written to or read from the drive head
;                                               ;                       VIA2PCR_CB2_HEAD_WRITE = Write Data
;                                               ;                       VIA2PCR_CB2_HEAD_READ  = Read Data
; --------------------------------------------- ; ------------------------------------------------------------------------------ ;
VIA2PCR_CB2_LO                = %11000000       ; 110 - Output Mode - Low level  (manual)
VIA2PCR_CB2_HEAD_WRITE        = VIA2PCR_CB2_LO  ;                     CB2 line to be held low
VIA2PCR_CB2_HI                = %11100000       ; 111 - Output Mode - High level (manual)
VIA2PCR_CB2_HEAD_READ         = VIA2PCR_CB2_HI  ;                     CB2 line to be held high
                                                ; 
VIA2PCR_CB2_HEAD_SWITCH       = %00100000       ; 001 - toggle head mode read/write
; ------------------------------------------------------------------------------------------------------------- ;
VIA2IFR                       = VIA2 + $0d      ; Interrupt Flag Register
                                                ;   indicate which IFR flags should cause a VIA IRQ to the 6502 IRQ line
VIA2IFR_CA2                     = %00000001     ; Set by: CA2 active edge                 Cleared by: Read or Write PA 
VIA2IFR_CA1                     = %00000010     ; Set by: CA1 active edge                 Cleared by: Read or Write PA 
VIA2IFR_SHIFT                   = %00000100     ; Set by: Complete 8 Shifts               Cleared by: Read or Write Shift register
VIA2IFR_CB2                     = %00001000     ; Set by: Transition of CB2               Cleared by: Read or Write PB 
VIA2IFR_CB1                     = %00010000     ; Set by: Transition of CB1               Cleared by: Read or Write PB 
VIA2IFR_TI2                     = %00100000     ; Set by: Time-Out (underflow) Timer 2    Cleared by: Read TI2 LSB or Write T2 MSB
VIA2IFR_TI1                     = %01000000     ; Set by: Time-Out (underflow) Timer 1    Cleared by: Read TI1 LSB or Write T1 MSB
VIA2IFR_INT                     = %10000000     ; Set by: Any Enabled Interrupt occurred  Cleared by: Set VIA2IFR_INT to 0
                                                ;                                                     Clear all 6 interrupt flags of IFR2
; ------------------------------------------------------------------------------------------------------------- ;
VIA2IER                       = VIA2 + $0e      ; Interrupt Enable Register
                                                ;   Indicate which IFR flags should cause a VIA IRQ to the 6502 IRQ line
                                                ;   Note: The whole byte must be set at once
                                                ;         changing a particular bit individually with AND/OR will have no effect
VIA2IER_CA2                     = %00000001     ; CA2
VIA2IER_CA1                     = %00000010     ; CA1
VIA2IER_SHIFT                   = %00000100     ; Shift Register
VIA2IER_CB2                     = %00001000     ; CB2
VIA2IER_CB1                     = %00010000     ; CB1
VIA2IER_TI2                     = %00100000     ; Timer 2
VIA2IER_TI1                     = %01000000     ; Timer 1
VIA2IER_ENAB                    = %10000000     ; write: 1=Set Interrupt Flags
                                                ;          bits 0…6: each 1 enables the corresponding interrupt 
                                                ;          bits 0…6: each 0 leaves the corresponding interrupt bit unaffected
VIA2IER_CLEAR                   = %01111111     ;        0=Clear Interrupt Flags
                                                ;          bits 0…6: each 1 disables the corresponding interrupt
                                                ;          bits 0…6: each 0 leaves the corresponding interrupt bit unaffected
                                                ; read:    bit    7: will allways be 1 but can in fact be a 0
                                                ;                    it takes an explicit write to to insure its state
                                                ;          bits 0…6: reflect their ENABLE/DISABLE start
; ------------------------------------------------------------------------------------------------------------- ;
VIA2PAN                       = VIA2 + $0f      ; Data Port A - same as PA except no handshake will be initiated
                                                ;               i.e. the CAl and CA2 control lines are not affected     (unused)
VIA2ORAN                      = VIA1PAN         ; Output Register A
VIA2ORAN_PA0                    = %00000001     ; 
VIA2ORAN_PA1                    = %00000010     ; 
VIA2ORAN_PA2                    = %00000100     ; 
VIA2ORAN_PA3                    = %00001000     ; 
VIA2ORAN_PA4                    = %00010000     ; 
VIA2ORAN_PA5                    = %00100000     ; 
VIA2ORAN_PA6                    = %01000000     ; 
VIA2ORAN_PA7                    = %10000000     ; 
                                  
VIA2POTA                      = VIA1PAN         ; Output Register A
VIA2POTA_PA0                    = %00000001     ; 
VIA2POTA_PA1                    = %00000010     ; 
VIA2POTA_PA2                    = %00000100     ; 
VIA2POTA_PA3                    = %00001000     ; 
VIA2POTA_PA4                    = %00010000     ; 
VIA2POTA_PA5                    = %00100000     ; 
VIA2POTA_PA6                    = %01000000     ; 
VIA2POTA_PA7                    = %10000000     ; 
                              
VIA2IRAN                      = VIA1PAN         ; Input  Register A
VIA2IRNA_PA0                    = %00000001     ; 
VIA2IRNA_PA1                    = %00000010     ; 
VIA2IRNA_PA2                    = %00000100     ; 
VIA2IRNA_PA3                    = %00001000     ; 
VIA2IRNA_PA4                    = %00010000     ; 
VIA2IRNA_PA5                    = %00100000     ; 
VIA2IRNA_PA6                    = %01000000     ; 
VIA2IRNA_PA7                    = %10000000     ; 
; ------------------------------------------------------------------------------------------------------------- ;
