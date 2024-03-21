; ------------------------------------------------------------------------------------------------------------- ;
; MOS6526 - Complex Interface Adapter (CIA) #2 Registers - $DD00-$DD0F - Serial Bus/RS-232
; ------------------------------------------------------------------------------------------------------------- ;
CIA2                        = $DD00             ; Base address
; ------------------------------------------------------------------------------------------------------------- ;
CI2PRA                      = CIA2 + $00        ; Data Port A (Serial Bus, RS-232, VIC Base Memory Bank)
CI2PRA_VIC_BANK               = %00000011       ;   Bits 0…1: Select the 16K VIC-II chip memory bank
CI2PRA_VIC_BANK_3             = %00000000       ;   $00     : $c000-$ffff - bank 3
CI2PRA_VIC_BASE_3               = $c000         ;           : 
CI2PRA_VIC_BANK_2             = %00000001       ;   $01     : $8000-$bfff - bank 2
CI2PRA_VIC_BASE_2               = $8000         ;           : 
CI2PRA_VIC_BANK_1             = %00000010       ;   $02     : $4000-$7fff - bank 1
CI2PRA_VIC_BASE_1               = $4000         ;           : 
CI2PRA_VIC_BANK_0             = %00000011       ;   $03     : $0000-$3fff - bank 0
CI2PRA_VIC_BASE_0               = $0000         ;           : 
                                                ; ------------------------------------------------------------- ;
CI2PRA_TXD_OUT                = %00000100       ;   Bit 2   : RS-232 data output      (TXD) / User Port Pin M
                                                ; ------------------------------------------------------------- ;
CI2PRA_SER_OUT                = %00111000       ;   Bits 3…5: Serial bus Output
CI2PRA_ATN_OUT                = %00001000       ;   Bit 3   : Serial bus ATN signal output
CI2PRA_CLK_OUT                = %00010000       ;   Bit 4   : Serial bus clock pulse output
CI2PRA_DATA_OUT               = %00100000       ;   Bit 5   : Serial bus data output
                                                ; ------------------------------------------------------------- ;
CI2PRA_SER_IN                 = %11000000       ;   Bits 6…7: Serial bus Input
CI2PRA_CLK_IN                 = %01000000       ;   Bit 6   : Serial bus clock pulse input
CI2PRA_DATA_IN                = %10000000       ;   Bit 7   : Serial bus data input
; ------------------------------------------------------------------------------------------------------------- ;
CI2PRB                      = CIA2 + $01        ; Data Port B (User Port, RS-232)
CI2PRB_SIN                    = %00000001       ;   Bit 0: RS-232 data input          (SIN) / User Port Pin C (READ)
CI2PRB_RTS                    = %00000010       ;   Bit 1: RS-232 request to send     (RTS) / User Port Pin D (WRITE)
CI2PRB_DTR                    = %00000100       ;   Bit 2: RS-232 data terminal ready (DTR) / User Port Pin E (WRITE)
CI2PRB_RI                     = %00001000       ;   Bit 3: RS-232 ring indicator      (RI)  / User Port Pin F (READ/WRITE)
CI2PRB_DCD                    = %00010000       ;   Bit 4: RS-232 carrier detect      (DCD) / User Port Pin H (READ/WRITE)
CI2PRB_PINJ                   = %00100000       ;   Bit 5:                                    User Port Pin J (READ/WRITE)
CI2PRB_CTS                    = %01000000       ;   Bit 6: RS-232 clear to send       (CTS) / User Port Pin K (READ)
                                                ;          1=sender ready to send
                                                ;          Toggle or pulse data output for Timer A
CI2PRB_DSR                    = %10000000       ;   Bit 7: RS-232 data set ready      (DSR) / Pin L of User Port (READ)
                                                ;          1=receiver ready to receive
                                                ;          Toggle or pulse data output for Timer B
; ------------------------------------------------------------------------------------------------------------- ;
CI2DDRA                     = CIA2 + $02        ; Data Direction Register A
CI2DDRA_DPA0                  = %00000001       ;   Bit 0: Bit 0 of data Port A (1=output, 0=input)
CI2DDRA_DPA1                  = %00000010       ;   Bit 1: Bit 1 of data Port A (1=output, 0=input)
CI2DDRA_DPA2                  = %00000100       ;   Bit 2: Bit 2 of data Port A (1=output, 0=input)
CI2DDRA_DPA3                  = %00001000       ;   Bit 3: Bit 3 of data Port A (1=output, 0=input)
CI2DDRA_DPA4                  = %00010000       ;   Bit 4: Bit 4 of data Port A (1=output, 0=input)
CI2DDRA_DPA5                  = %00100000       ;   Bit 5: Bit 5 of data Port A (1=output, 0=input)
CI2DDRA_DPA6                  = %01000000       ;   Bit 6: Bit 6 of data Port A (1=output, 0=input)
CI2DDRA_DPA7                  = %10000000       ;   Bit 7: Bit 7 of data Port A (1=output, 0=input)
                                                ; 
CI2DDRA_BANK_B0               = CI2DDRA_DPA0    ;   
CI2DDRA_BANK_B1               = CI2DDRA_DPA1    ;   
CI2DDRA_RS2                   = CI2DDRA_DPA2    ;   
CI2DDRA_ATN                   = CI2DDRA_DPA3    ;   
CI2DDRA_CLK                   = CI2DDRA_DPA4    ;   
CI2DDRA_DATA                  = CI2DDRA_DPA5    ;   
CI2DDRA_SER_CLK               = CI2DDRA_DPA6    ;   
CI2DDRA_SER_DATA              = CI2DDRA_DPA7    ;   
; ------------------------------------------------------------------------------------------------------------- ;
CI2DDRB                     = CIA2 + $03        ; Data Direction Register B
CI2DDRB_DPB0                  = %00000001       ;   Bit 0: Bit 0 of data Port B (1=output, 0=input)
CI2DDRB_DPB1                  = %00000010       ;   Bit 1: Bit 1 of data Port B (1=output, 0=input)
CI2DDRB_DPB2                  = %00000100       ;   Bit 2: Bit 2 of data Port B (1=output, 0=input)
CI2DDRB_DPB3                  = %00001000       ;   Bit 3: Bit 3 of data Port B (1=output, 0=input)
CI2DDRB_DPB4                  = %00010000       ;   Bit 4: Bit 4 of data Port B (1=output, 0=input)
CI2DDRB_DPB5                  = %00100000       ;   Bit 5: Bit 5 of data Port B (1=output, 0=input)
CI2DDRB_DPB6                  = %01000000       ;   Bit 6: Bit 6 of data Port B (1=output, 0=input)
CI2DDRB_DPB7                  = %10000000       ;   Bit 7: Bit 7 of data Port B (1=output, 0=input)
                                                ; 
CI2DDRB_SIN                   = CI2DDRB_DPB0    ; 
CI2DDRB_RTS                   = CI2DDRB_DPB1    ; 
CI2DDRB_DTR                   = CI2DDRB_DPB2    ; 
CI2DDRB_RI                    = CI2DDRB_DPB3    ; 
CI2DDRB_DCD                   = CI2DDRB_DPB4    ; 
CI2DDRB_PINJ                  = CI2DDRB_DPB5    ; 
CI2DDRB_CTS                   = CI2DDRB_DPB6    ; 
CI2DDRB_DSR                   = CI2DDRB_DPB7    ; 
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
CI2TALO                     = CIA2 + $04        ; Timer A Low Byte  (RS-232)
CI2TALO_TAL0                  = %00000001       ; Bit 0: Read  (Timer)
CI2TALO_TAL1                  = %00000010       ; Bit 1: Read  (Timer)
CI2TALO_TAL2                  = %00000100       ; Bit 2: Read  (Timer)
CI2TALO_TAL3                  = %00001000       ; Bit 3: Read  (Timer)
CI2TALO_TAL4                  = %00010000       ; Bit 4: Read  (Timer)
CI2TALO_TAL5                  = %00100000       ; Bit 5: Read  (Timer)
CI2TALO_TAL6                  = %01000000       ; Bit 6: Read  (Timer)
CI2TALO_TAL7                  = %10000000       ; Bit 7: Read  (Timer)
                                                ; 
CI2TALO_PAL0                  = %00000001       ; Bit 0: Write (Prescaler)
CI2TALO_PAL1                  = %00000010       ; Bit 1: Write (Prescaler)
CI2TALO_PAL2                  = %00000100       ; Bit 2: Write (Prescaler)
CI2TALO_PAL3                  = %00001000       ; Bit 3: Write (Prescaler)
CI2TALO_PAL4                  = %00010000       ; Bit 4: Write (Prescaler)
CI2TALO_PAL5                  = %00100000       ; Bit 5: Write (Prescaler)
CI2TALO_PAL6                  = %01000000       ; Bit 6: Write (Prescaler)
CI2TALO_PAL7                  = %10000000       ; Bit 7: Write (Prescaler)
TI2ALO                      = CI2TALO           ; 
; ------------------------------------------------------------------------------------------------------------- ;
CI2TAHI                     = CIA2 + $05        ; Timer A High Byte (RS-232)
CI2TAHI_TAH0                  = %00000001       ; Bit 0: Read  (Timer)
CI2TAHI_TAH1                  = %00000010       ; Bit 1: Read  (Timer)
CI2TAHI_TAH2                  = %00000100       ; Bit 2: Read  (Timer)
CI2TAHI_TAH3                  = %00001000       ; Bit 3: Read  (Timer)
CI2TAHI_TAH4                  = %00010000       ; Bit 4: Read  (Timer)
CI2TAHI_TAH5                  = %00100000       ; Bit 5: Read  (Timer)
CI2TAHI_TAH6                  = %01000000       ; Bit 6: Read  (Timer)
CI2TAHI_TAH7                  = %10000000       ; Bit 7: Read  (Timer)
                                                ; 
CI2TAHI_PAH0                  = %00000001       ; Bit 0: Write (Prescaler)
CI2TAHI_PAH1                  = %00000010       ; Bit 1: Write (Prescaler)
CI2TAHI_PAH2                  = %00000100       ; Bit 2: Write (Prescaler)
CI2TAHI_PAH3                  = %00001000       ; Bit 3: Write (Prescaler)
CI2TAHI_PAH4                  = %00010000       ; Bit 4: Write (Prescaler)
CI2TAHI_PAH5                  = %00100000       ; Bit 5: Write (Prescaler)
CI2TAHI_PAH6                  = %01000000       ; Bit 6: Write (Prescaler)
CI2TAHI_PAH7                  = %10000000       ; Bit 7: Write (Prescaler)
TI2AHI                      = CI2TAHI           ; 
; ------------------------------------------------------------------------------------------------------------- ;
CI2TBLO                     = CIA2 + $06        ; Timer B Low Byte  (RS-232)
CI2TBLO_TBL0                  = %00000001       ; Bit 0: Read  (Timer)
CI2TBLO_TBL1                  = %00000010       ; Bit 1: Read  (Timer)
CI2TBLO_TBL2                  = %00000100       ; Bit 2: Read  (Timer)
CI2TBLO_TBL3                  = %00001000       ; Bit 3: Read  (Timer)
CI2TBLO_TBL4                  = %00010000       ; Bit 4: Read  (Timer)
CI2TBLO_TBL5                  = %00100000       ; Bit 5: Read  (Timer)
CI2TBLO_TBL6                  = %01000000       ; Bit 6: Read  (Timer)
CI2TBLO_TBL7                  = %10000000       ; Bit 7: Read  (Timer)
                                                ; 
CI2TBLO_PBL0                  = %00000001       ; Bit 0: Write (Prescaler)
CI2TBLO_PBL1                  = %00000010       ; Bit 1: Write (Prescaler)
CI2TBLO_PBL2                  = %00000100       ; Bit 2: Write (Prescaler)
CI2TBLO_PBL3                  = %00001000       ; Bit 3: Write (Prescaler)
CI2TBLO_PBL4                  = %00010000       ; Bit 4: Write (Prescaler)
CI2TBLO_PBL5                  = %00100000       ; Bit 5: Write (Prescaler)
CI2TBLO_PBL6                  = %01000000       ; Bit 6: Write (Prescaler)
CI2TBLO_PBL7                  = %10000000       ; Bit 7: Write (Prescaler)
TI2BLO                      = CI2TBLO           ; 
; ------------------------------------------------------------------------------------------------------------- ;
CI2TBHI                     = CIA2 + $07        ; Timer B High Byte (RS-232)
CI2TBHI_TBH0                  = %00000001       ; Bit 0: Read  (Timer)
CI2TBHI_TBH1                  = %00000010       ; Bit 1: Read  (Timer)
CI2TBHI_TBH2                  = %00000100       ; Bit 2: Read  (Timer)
CI2TBHI_TBH3                  = %00001000       ; Bit 3: Read  (Timer)
CI2TBHI_TBH4                  = %00010000       ; Bit 4: Read  (Timer)
CI2TBHI_TBH5                  = %00100000       ; Bit 5: Read  (Timer)
CI2TBHI_TBH6                  = %01000000       ; Bit 6: Read  (Timer)
CI2TBHI_TBH7                  = %10000000       ; Bit 7: Read  (Timer)
                                                ; 
CI2TBHI_PBH0                  = %00000001       ; Bit 0: Write (Prescaler)
CI2TBHI_PBH1                  = %00000010       ; Bit 1: Write (Prescaler)
CI2TBHI_PBH2                  = %00000100       ; Bit 2: Write (Prescaler)
CI2TBHI_PBH3                  = %00001000       ; Bit 3: Write (Prescaler)
CI2TBHI_PBH4                  = %00010000       ; Bit 4: Write (Prescaler)
CI2TBHI_PBH5                  = %00100000       ; Bit 5: Write (Prescaler)
CI2TBHI_PBH6                  = %01000000       ; Bit 6: Write (Prescaler)
CI2TBHI_PBH7                  = %10000000       ; Bit 7: Write (Prescaler)
TI2BHI                      = CI2TBHI           ; 
; ------------------------------------------------------------------------------------------------------------- ;
; write to TODHR   - ToD clock is automatically stopped
; write to TO210TH - ToD clock is automatically started
; 
; CI2CRB_ALARM
;   0 = a WRITE to TOD the registers sets ALARM
;   1 = a WRITE to TOD the registers sets TOD clock
; ------------------------------------------------------------------------------------------------------------- ;
; LATCHing keeps all ToD information constant during a read sequence
; 
;   read TO2HR   - enable  ToD registers LATCH - ToD continues to count
;   read TO210TH - disable ToD registers LATCH
;   
;   each register reads out in BCD format
; 
;   any read of TODHR must be followed by a read of TODTEN to disable the LATCHing again
;   any other single register can be read 'on the fly'
; ------------------------------------------------------------------------------------------------------------- ;
TO210TH                     = CIA2 + $08        ; Time of Day Clock Tenths of Seconds
TO210TH_T1                    = %00000001       ;   Bits 0…3: Time of Day tenths of second        (BCD)
TO210TH_T2                    = %00000010       ;   
TO210TH_T4                    = %00000100       ;   
TO210TH_T8                    = %00001000       ;   
                                                ; 
                              ;  ...1....       ;   Bit    4: <not used>
                              ;  ..1.....       ;   Bit    5: <not used>
                              ;  .1......       ;   Bit    6: <not used>
                              ;  1.......       ;   Bit    7: <not used>
                                                ; 
TO2TEN                      = TO210TH           ; 
; ------------------------------------------------------------------------------------------------------------- ;
TO2SEC                      = CIA2 + $09        ; Time of Day Clock Seconds
TO2SEC_SLO                    = %00001111       ;   Bits 0…3: Second digit of Time of Day seconds (BCD)
TO2SEC_SL1                    = %00000001       ; 
TO2SEC_SL2                    = %00000010       ; 
TO2SEC_SL4                    = %00000100       ; 
TO2SEC_SL8                    = %00001000       ; 
                                                ; 
TO2SEC_SHI                    = %01110000       ;   Bits 4…6: First  digit of Time of Day seconds (BCD)
TO2SEC_SH1                    = %00010000       ; 
TO2SEC_SH2                    = %00100000       ; 
TO2SEC_SH4                    = %01000000       ; 
                                                ; 
                              ;  1.......       ;   Bit    7: <not used>
; ------------------------------------------------------------------------------------------------------------- ;
TO2MIN                      = CIA2 + $0a        ; Time of Day Clock Minutes
TO2MIN_MLO                    = %00001111       ;   Bits 0…3: Second digit of Time of Day minutes (BCD)
TO2MIN_ML1                    = %00000001       ; 
TO2MIN_ML2                    = %00000010       ; 
TO2MIN_ML4                    = %00000100       ; 
TO2MIN_ML8                    = %00001000       ; 
                                                ; 
TO2MIN_MHI                    = %01110000       ;   Bits 4…6: First  digit of Time of Day minutes (BCD)
TO2MIN_MH1                    = %00010000       ; 
TO2MIN_MH2                    = %00100000       ; 
TO2MIN_MH4                    = %01000000       ; 
                                                ; 
                              ;  1.......       ;   Bit    7: <not used>
; ------------------------------------------------------------------------------------------------------------- ;
TO2HR                       = CIA2 + $0b        ; Time of Day Clock Hours
TO2HR_HLO                     = %00001111       ;   Bits 0…3: Second digit of Time of Day hours   (BCD)
TO2HR_HL1                     = %00000001       ; 
TO2HR_HL2                     = %00000010       ; 
TO2HR_HL4                     = %00000100       ; 
TO2HR_HL8                     = %00001000       ; 
                                                ; 
TO2HR_HH                      = %00010000       ;   Bit    4: First  digit of Time of Day hours   (BCD)
                                                ; 
                              ;  ..1.....       ;   Bit    5: <not used>
                              ;  .1......       ;   Bit    6: <not used>
                                                ;   
TO2HR_PM                      = %10000000       ;   Bit    7: AM/PM Flag  (1=PM, 0=AM)
TO2HR_AM                      = %01111111       ; 
                                                ; 
TO2HRS                      = TO2HR             ; 
; ------------------------------------------------------------------------------------------------------------- ;
CI2SDR                      = CIA2 + $0c        ; Synchronous Serial I/O Data Buffer (Serial Data Port Shift register)
                                                ; Bits are read/written upon every positive edge of the user port CNT pin
CI2SDR_S0                     = %00000001       ; 
CI2SDR_S1                     = %00000010       ; 
CI2SDR_S2                     = %00000100       ; 
CI2SDR_S3                     = %00001000       ; 
CI2SDR_S4                     = %00010000       ; 
CI2SDR_S5                     = %00100000       ; 
CI2SDR_S6                     = %01000000       ; 
CI2SDR_S7                     = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
; The Interrupt Control Register consists of
;   - a DATA register - READ-only 
;       Bit 0: Read : Did Timer A count down to 0? ...................... (1=yes)
;       Bit 1: Read : Did Timer B count down to 0? ...................... (1=yes)
;       Bit 2: Read : Did Time of Day Clock reach the alarm time? ....... (1=yes)
;       Bit 3: Read : Did the serial shift register finish a byte? ...... (1=yes)
;       Bit 4: Read : Was a signal sent on the FLAG line? ............... (1=yes)
;       Bit 5:      : <not used>
;       Bit 6:      : <not used>
;       Bit 7: Read : Did any CIA #2 source cause an interrupt? ......... (1=yes)
;   
;   - a MASK register - WRITE-only
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
CI2ICR                      = CIA2 + $0d        ; Interrupt Control Register   (NMI)
CI2ICR_DATA_ALL               = %00011111       ;         Read  : DATA Register: Interrupt Origin
CI2ICR_DATA_TA                = %00000001       ;   Bit 0 Read  : Underflow Timer A
CI2ICR_DATA_TB                = %00000010       ;   Bit 1 Read  : Underflow Timer B
CI2ICR_DATA_ALRM              = %00000100       ;   Bit 2 Read  : ToD equal Alarm Time
CI2ICR_DATA_SP                = %00001000       ;   Bit 3 Read  : SDR full or empty (full byte transferred depending of serial busoperating mode)
CI2ICR_DATA_FLG               = %00010000       ;   Bit 4 Read  : IRQ Signal occured at FLAG-pin (Cassette port Data input / Serial bus SRQ IN)
                                                ; 
                              ;  ..1.....       ;   Bit 5       : <not used>
                              ;  .1......       ;   Bit 6       : <not used>
                                                ; 
CI2ICR_IR                     = %10000000       ;   Bit 7 Read  : An interrupt occured (if at least one bit of CI2ICR_MASK is set)
                                                ; ------------------------------------------------------------- ;
CI2ICR_MASK_ALL               = %00011111       ;         Write : MASK Register: Interrupt Selection
CI2ICR_MASK_TA                = %00000001       ;   Bit 0 Write : Underflow Timer A
CI2ICR_MASK_TB                = %00000010       ;   Bit 1 Write : Underflow Timer B
CI2ICR_MASK_ALRM              = %00000100       ;   Bit 2 Write : ToD equal Alarm Time
CI2ICR_MASK_SP                = %00001000       ;   Bit 3 Write : SDR full or empty (full byte transferred depending of serial busoperating mode)
CI2ICR_MASK_FLG               = %00010000       ;   Bit 4 Write : NMI Signal occured at FLAG-Pin (RS-232 Data received / Userport Pin B)
                                                ; 
                              ;  ..1.....       ;   Bit 5       : <not used>
                              ;  .1......       ;   Bit 6       : <not used>
                                                ; 
CI2ICR_SC                     = %10000000       ;   Bit 7 Write : The corresponding MASK bit must be set to generate an Interrupt Request
CI2ICR_SC_SET                   = %10000000     ;   Bit 7 Write : Set a Selected Interrupt Source
CI2ICR_SC_SET_ALL               = %11111111     ;               : Set all Interrupt Sources
CI2ICR_SC_CLR                   = %00000000     ;   Bit 7 Write : Clear a Selected Interrupt Source
CI2ICR_SC_CLR_ALL               = %01111111     ;               : Clear All Interrupt Sources
; ------------------------------------------------------------------------------------------------------------- ;
CI2CRA                      = CIA2 + $0e        ; Control Register A
CI2CRA_START                  = %00000001       ;   Bit 0:  Start Timer A                         (1=start, 0=stop)
                                                ;           Automatically reset when underflow occurs during one-shot mode
CI2CRA_PBON                   = %00000010       ;   Bit 1:  Select Timer A output on Port B       (1=Timer A output appears on pin PB6)
                                                ;                                                    overrides the CI2DDRB control bit and 
                                                ;                                                    forces the PB6 line to an output
CI2CRA_OUTMODE                = %00000100       ;   Bit 2:  Port B (PB6) output mode
CI2CRA_OUTMODE_TOGGLE           = %00000100     ;                                                 (1=toggle Bit 6)
CI2CRA_OUTMODE_PULSE            = %11111011     ;                                                 (0=pulse  Bit 6 for one cycle)
CI2CRA_RUNMODE                = %00001000       ;   Bit 3:  Timer A run mode
CI2CRA_RUNMODE_OS               = %00001000     ;                                                 (1=one-shot   - stop after underflow)
CI2CRA_RUNMODE_CONT             = %11110111     ;                                                 (0=continuous - reload LATCHed value after underflow)
CI2CRA_LOAD                   = %00010000       ;   Bit 4:  Load LATCHed value into Timer A once  (1=force load STROBE)
                                                ;                                                    no data storage - will always read back a 0 
                                                ;                                                    writing a 0 has no effect
CI2CRA_INMODE                 = %00100000       ;   Bit 5:  Timer A input mode
CI2CRA_INMODE_CNT               = %00100000     ;                                                 (1=count positive CNT transitions)
CI2CRA_INMODE_PHI2              = %11011111     ;                                                 (0=count system PHI2 clock pulses)
CI2CRA_SPMODE                 = %01000000       ;   Bit 6:  Serial Port (CI2SDR) mode
CI2CRA_SPMODE_OUTPUT            = %01000000     ;                                                 (1=output - CNT sources shift clock)
CI2CRA_SPMODE_INPUT             = %10111111     ;                                                 (0=input  - external shift clock required)
CI2CRA_TODIN                  = %10000000       ;   Bit 7:  Time of Day Clock frequency
CI2CRA_TODIN_50HZ               = %10000000     ;                                                 (1=50Hz clock required for accurate time)
CI2CRA_TODIN_60HZ               = %01111111     ;                                                 (0=60Hz clock required for accurate time)
; ------------------------------------------------------------------------------------------------------------- ;
CI2CRB                      = CIA2 + $0f        ; Control Register B
CI2CRB_START                  = %00000001       ;   Bit 0:  Start Timer B                         (1=start, 0=stop)
                                                ;           Automatically reset when underflow occurs during one-shot mode
CI2CRB_PBON                   = %00000010       ;   Bit 1:  Select Timer B output on Port B       (1=Timer B output appears on pin PB7)
                                                ;                                                    overrides the CI2DDRB control bit and 
                                                ;                                                    forces the PB7 line to an output
CI2CRB_OUTMODE                = %00000100       ;   Bit 2:  Port B output mode
CI2CRB_OUTMODE_TOGGLE           = %00000100     ;                                                 (1=toggle Bit 6)
CI2CRB_OUTMODE_PULSE            = %11111011     ;                                                 (0=pulse  Bit 6 for one cycle)
CI2CRB_RUNMODE                = %00001000       ;   Bit 3:  Timer B run mode
CI2CRB_RUNMODE_OS               = %00001000     ;                                                 (1=one-shot   - stop after underflow)
CI2CRB_RUNMODE_CONT             = %11110111     ;                                                 (0=continuous - reload LATCHed value after underflow)
CI2CRB_LOAD                   = %00010000       ;   Bit 4:  Load LATCHed value into Timer B once  (1=force load STROBE - no data storage)
                                                ;                                                    will always read back a 1 
                                                ;                                                    writing a 0 has no effect
CI2CRB_INMODE                 = %01100000       ;   Bit 5…6: Timer B input mode
CI2CRB_INMODE_PHI2              = %00000000     ;            00 = Count system PHI2 clock pulses
CI2CRB_INMODE_CNT               = %00100000     ;            01 = Count positive transitions on CNT line at pin 4 of User Port
CI2CRB_INMODE_TA                = %01000000     ;            10 = Count underflows Timer A pulses (count down to zero)
CI2CRB_INMODE_TAC               = %01100000     ;            11 = Count underflows Timer A pulses while CNT-pin is high
CI2CRB_ALARM                  = %10000000       ;   Bit 7: Select Time of Day write
                                                ;          0 = WRITE to the TOD registers sets ALARM
                                                ;          1 = WRITE to the TOD registers sets TOD clock
; ------------------------------------------------------------------------------------------------------------- ;
; $DD10-$DDFF                                   ; CIA #2 Register Images - Mirror of $DD00-$DD0F
; ------------------------------------------------------------------------------------------------------------- ;
