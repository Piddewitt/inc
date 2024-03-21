; --------------------------------------------------------------------------------------------------------------------- ;
; C64 Memory Layout / Equates
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC and KERNAL system constant definitions
; --------------------------------------------------------------------------------------------------------------------- ;
SystemConstants             .include "c64.BASIC.const.asm"  ; Basic  system constants
                            .include "c64.KERNAL.const.asm" ; Kernal system constants
; --------------------------------------------------------------------------------------------------------------------- ;
; C64 CPU Zeropage 
; --------------------------------------------------------------------------------------------------------------------- ;
ZP_START                    = $00                         ; 
ZP_CPU                      = ZP_START + $00              ; 
                            .include "c64.CPU.ZP.asm"     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; C64 Standard Zeropage
; --------------------------------------------------------------------------------------------------------------------- ;
ZP_BASIC                    = ZP_START + $02              ; 
                            .include "c64.BASIC.ZP.asm"   ; 
ZP_KERNAL                   = ZP_START + $90              ; 
                            .include "c64.KERNAL.ZP.asm"  ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; C64 Stack
; --------------------------------------------------------------------------------------------------------------------- ;
STACK                       = $0100   ; - $01ff ; 6510 hardware stack area
; --------------------------------------------------------------------------------------------------------------------- ;
; before pushing stack values GETSTK ensures a least BAD_LEN bytes of free STACK memory
; BASIC cmd stack usage:
;   GOSUB     -->  5 bytes
;   FOR-NEXT  --> 18 bytes
;   DEF       -->  5 bytes
;   RETURN    -->  7 bytes
; --------------------------------------------------------------------------------------------------------------------- ;
BAD                         = STACK   ; - $013e ; TAPE pass 1/2 input error-log pointer table
                                                ;   Pointers to bytes read with error during datasette input
BAD_LEN                       = BSTACK - STACK - $01 ; $3e (62) bytes=31 entries
                            
BSTACK                      = $013f   ; - $01fb ; BASIC Stack Area
STKEND                      = $01fb             ; End of Stack
; --------------------------------------------------------------------------------------------------------------------- ;
; $01fb - $01ff BASIC line crunch work area
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC and KERNAL working storage - Memory pages $02 and $03
; --------------------------------------------------------------------------------------------------------------------- ;
BKWORK                      = $0200   ; - $02ff ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Buffers and Tables 
; --------------------------------------------------------------------------------------------------------------------- ;
BUF                         = $0200   ; - $0258 ;       BASIC input buffer for data read from screen
BUFLEN                        = LAT - BUF - $01 ;       $58 (88)
BUFPAG                        = >BUF            ; 
;BUFOFS                     = BUF / $100 * $100 ;       the amount to offset the low byte of the text pointer to
;                                               ;       get to BUF after TXTPTR has been setup to point into BUF
; --------------------------------------------------------------------------------------------------------------------- ;
; Open logical file number table
; --------------------------------------------------------------------------------------------------------------------- ;
LAT                         = $0259             ; Tab : active logical file numbers
LAT_LEN                       = FAT - LAT - $01 ;     : max $0a entries for each table
; --------------------------------------------------------------------------------------------------------------------- ;
; Open device file number table
; --------------------------------------------------------------------------------------------------------------------- ;
FAT                         = $0263             ; Tab : active primary   addresses (device numbers)
; --------------------------------------------------------------------------------------------------------------------- ;
; Open secondary address table
; --------------------------------------------------------------------------------------------------------------------- ;
SAT                         = $026d             ; Tab : active secondary addresses
; --------------------------------------------------------------------------------------------------------------------- ;
; System storage
; --------------------------------------------------------------------------------------------------------------------- ;
; RAM locations related to KEYBOARD processing
; --------------------------------------------------------------------------------------------------------------------- ;
; [STKEY]  - Bottom KEYBOARD row scan value
; [LSTX]   - Matrix coordinate of last key pressed
; [NDX]    - Number of chars ($00-$0a) in KEYBOARD buffer queue
; [SFDX]   - Matrix coordinate of current key pressed
; [BLNSW]  - Cursor blink switch
; [CRSW]   - Flag input origin from screen or KEYBOARD
; [QTSW]   - Flag to indicate if within <QUOTE> marks
; [INSRT]  - Number of outstanding inserts
; [KEYTAB] - Pointer to the KEYBOARD table being used
; XMAX     - Max number of chars in the KEYBOARD buffer
; RPTFLG   - KEYBOARD repeater flags
; KOUNT    - Delay before other than first repeat of key
; DELAY    - Delay before first repeat of key
; SHFLAG   - Current SHIFT keys pattern
; LSTSHF   - Previous SHIFT key pattern
; KEYLOG   - Pointer to the default KEYBOARD table setup routine
; MODE     - Flag to enable/disable combined SHIFT and C= keys
; --------------------------------------------------------------------------------------------------------------------- ;
; KEYBOARD buffer
; --------------------------------------------------------------------------------------------------------------------- ;
KEYD                        = $0277   ; - $0280 ;       IRQ KEYBOARD buffer (FIFO)
KEYD_LEN                      = MEMSTR - KEYD   ;       max $0a entries
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to start of user RAM memory
; --------------------------------------------------------------------------------------------------------------------- ;
MEMSTR                      = $0281             ; Ptr : start of BASIC memory after memory test
MEMSTR_LO                     = $0281           ; 
MEMSTR_HI                     = $0282           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to end of user RAM memory plus one
; --------------------------------------------------------------------------------------------------------------------- ;
MEMSIZK                     = $0283             ; Ptr : top of BASIC memory after memory test ($A000) - .hbu001. 'K' added (already used in BASIC ZP)
MEMSIZK_LO                    = $0283           ; 
MEMSIZK_HI                    = $0284           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to end of user RAM memory plus one
; --------------------------------------------------------------------------------------------------------------------- ;
MEMEND                      = MEMSIZK           ; Ptr : top of BASIC memory after memory test ($A000)
MEMEND_LO                     = $0283           ; 
MEMEND_HI                     = $0284           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Serial timeout enable/disable flag
; --------------------------------------------------------------------------------------------------------------------- ;
TIMOUT                      = $0285             ; Flag: IEEE timeout
TIMOUT_ON                     = $00             ; 
TIMOUT_OFF                    = $80             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; screen editor storage
; --------------------------------------------------------------------------------------------------------------------- ;
; Current foreground color selected by color keys
; --------------------------------------------------------------------------------------------------------------------- ;
COLOR                       = $0286             ;       current char colour - active color nybble
; --------------------------------------------------------------------------------------------------------------------- ;
; Cursor original color at this screen location
; --------------------------------------------------------------------------------------------------------------------- ;
GDCOL                       = $0287             ;       color under the cursor - char original color
; --------------------------------------------------------------------------------------------------------------------- ;
; Current screen memory page number
; --------------------------------------------------------------------------------------------------------------------- ;
HIBASE                      = $0288             ;       high byte base screen memory address ($04)
; --------------------------------------------------------------------------------------------------------------------- ;
; Max number of chars in the KEYBOARD buffer
; --------------------------------------------------------------------------------------------------------------------- ;
XMAX                        = $0289             ;       size (length) of KEYBOARD buffer
XMAX_MAX                      = KEYD_LEN        ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; KEYBOARD repeater flags
; --------------------------------------------------------------------------------------------------------------------- ;
RPTFLG                      = $028a             ; Flag: repeat keys - Bit_7 and Bit_6 are checked
RPTFLG_PGM                    = %00000000       ;       %00 - only default keys <CURSOR>s <INST/DEL> <SPACE> repeat
RPTFLG_NONE                   = %01000000       ;       %01 - no  keys repeat
RPTFLG_ALL                    = %10000000       ;       %10 - all keys repeat
; --------------------------------------------------------------------------------------------------------------------- ;
; Delay before other than first repeat of key
; --------------------------------------------------------------------------------------------------------------------- ;
KOUNT                       = $028b             ;       repeat key speed count
KOUNT_INIT                    = $04             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Delay before first repeat of key
; --------------------------------------------------------------------------------------------------------------------- ;
DELAY                       = $028c             ;       delay count before 1st repeat
DELAY_SHORT                   = $0a             ;       2nd and subsequent delays ar shorter than the 1st one
DELAY_LONG                    = $10             ;       1st delay is long
; --------------------------------------------------------------------------------------------------------------------- ;
; Current SHIFT keys pattern
; --------------------------------------------------------------------------------------------------------------------- ;
SHFLAG                      = $028d             ; Flag: <SHIFT> key indicator
SHFLAG_NONE                   = %00000000       ;       
SHFLAG_SHIFT                  = %00000001       ;       Bit0=1 - <SHIFT_R> <SHIFT_L> <SHIFT_LOCK>
SHFLAG_CBM                    = %00000010       ;       Bit1=1 - <C=>
SHFLAG_CTRL                   = %00000100       ;       Bit2=1 - <CTRL>
; --------------------------------------------------------------------------------------------------------------------- ;
; Previous SHIFT key pattern
; --------------------------------------------------------------------------------------------------------------------- ;
LSTSHF                      = $028e             ;       previous value of <SHIFT> key indicator - used for debouncing
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the default KEYBOARD table setup routine
; --------------------------------------------------------------------------------------------------------------------- ;
KEYLOG                      = $028f   ; - $0290 ; Ptr : indirect to SHFLOG routine for KEYBOARD table setup based on [SHFLAG]
KEYLOG_LO                     = $028f           ; 
KEYLOG_HI                     = $0290           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag to enable/disable combined SHIFT and C= keys
; --------------------------------------------------------------------------------------------------------------------- ;
MODE                        = $0291             ; Flag: <C=><SHIFT> switch - toggles uppercase/graphics and lowercase/uppercase mode
MODE_DISABLE                  = %10000000       ;       <C=><SHIFT> disabled
MODE_UNLOCK                   = %00000000       ;       <C=><SHIFT> enabled
; --------------------------------------------------------------------------------------------------------------------- ;
; Screen scroll-down enabled flag
; --------------------------------------------------------------------------------------------------------------------- ;
AUTODN                      = $0292             ; Flag: auto scroll down
AUTODN_ON                     = $00             ;       $00 - on  - insertion of line before current line 
                                                ;                   current line and all lines below must be scrolled 1 line down
AUTODN_OFF                    = $01             ;       $xx - off - bottom of screen reached
                                                ;                   complete screen must be scrolled 1 line up
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 storage
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 pseudo-6551 control register
; --------------------------------------------------------------------------------------------------------------------- ;
M51CTR                      = $0293             ;       simulate the 6551 CONTROL register
M51CTR_BAUD                   = %00001111       ;       bit 0-3 : baud rate - transfer speed
M51CTR_BAUD_USER                = %00000000     ;               : nonstandard rate (user-defined) - not implemented
M51CTR_BAUD_50                  = %00000001     ;               :    50   bit/s
M51CTR_BAUD_75                  = %00000010     ;               :    75   bit/s
M51CTR_BAUD_110                 = %00000011     ;               :   110   bit/s
M51CTR_BAUD_134                 = %00000100     ;               :   134.5 bit/s
M51CTR_BAUD_150                 = %00000101     ;               :   150   bit/s
M51CTR_BAUD_300                 = %00000110     ;               :   300   bit/s
M51CTR_BAUD_600                 = %00000111     ;               :   600   bit/s
M51CTR_BAUD_1200                = %00001000     ;               :  1200   bit/s
M51CTR_BAUD_1800                = %00001001     ;               :  1800   bit/s
M51CTR_BAUD_2400                = %00001010     ;               :  2400   bit/s
M51CTR_BAUD_3600                = %00001011     ;               :  3600   bit/s
M51CTR_BAUD_4800                = %00001100     ;               :  4800   bit/s
M51CTR_BAUD_7200                = %00001101     ;               :  7200   bit/s
M51CTR_BAUD_9600                = %00001110     ;               :  9600   bit/s
M51CTR_BAUD_19200               = %00001111     ;               : 19200   bit/s
M51CTR_NOUSE                  = %00010000       ;       bit 4   : unused
M51CTR_SIZE                   = %01100000       ;       bit 5-6 : byte size - number of data bits per byte
M51CTR_SIZE_8                   = %00000000     ;               : 8 bit
M51CTR_SIZE_7                   = %00100000     ;               : 7 bit
M51CTR_SIZE_6                   = %01000000     ;               : 6 bit
M51CTR_SIZE_5                   = %01100000     ;               : 5 bit
M51CTR_STOP                   = %10000000       ;       bit 7   : number of stop bits
M51CTR_STOP_1                   = %00000000     ;               : 1 stop bit
M51CTR_STOP_2                   = %10000000     ;               : 2 stop bits
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 pseudo-6551 command register
; --------------------------------------------------------------------------------------------------------------------- ;
M51CDR                      = $0294             ;       simulate the 6551 COMMAND register
M51CDR_HANDSHAKE              = %00000001       ;       bit 0   : handshake protokoll
M51CDR_HANDSHAKE_3              = %00000000     ;               : 3 line  - no   handshaking
M51CDR_HANDSHAKE_X              = %00000001     ;               : x lines - full handshaking
M51CDR_NOUSE                  = %00001110       ;       bit 1-3 : unused
M51CDR_DUPLEX                 = %00010000       ;       bit 4   : duplex mode
M51CDR_DUPLEX_FULL              = %00000000     ;               : full duplex - can simultaneously send/receive data
M51CDR_DUPLEX_HALF              = %00010000     ;               : half duplex
M51CDR_PARITY                 = %11100000       ;       bit 5-7 : parity
M51CDR_PARITY_NONE              = %00000000     ;               : no    parity generated or received
M51CDR_PARITY_ODD               = %00100000     ;               : odd   parity transmitted and received
M51CDR_PARITY_EVEN              = %01100000     ;               : even  parity transmitted and received
M51CDR_PARITY_MARK              = %10100000     ;               : mark  parity transmitted and received
                                                ;               :       xmit parity bit always set to %1 - receive parity bit ignored
M51CDR_PARITY_SPACE             = %11100000     ;               : space parity transmitted and received
                                                ;               :       xmit parity bit always set to %0 - receive parity bit ignored
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 non standard bit timing specification
; --------------------------------------------------------------------------------------------------------------------- ;
M51AJB                      = $0295             ;       non standard [[bittime / 2] - 100] - if M51CTR_BAUD_USER is set
M51AJB_LO                     = $0295           ; 
M51AJB_HI                     = $0296           ; 
M51CTR_LEN                    = M51AJB_HI - M51CTR ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 status register
; --------------------------------------------------------------------------------------------------------------------- ;
RSSTAT                      = $0297             ;       RS-232 status register
RSSTAT_CLEAR                  = %00000000       ;       will be cleared always after being read        
RSSTAT_PARITY                 = %00000001       ;       Bit 0: - parity error
RSSTAT_FRAME                  = %00000010       ;       Bit 1: - framing error
RSSTAT_REC_BUF_FULL           = %00000100       ;       Bit 2: - receiver buffer overrun
RSSTAT_REC_BUF_EMPTY          = %00001000       ;       Bit 3: - receiver buffer empty
RSSTAT_CTS                    = %00010000       ;       Bit 4: - CTS (clear to send)  signal missing
                                                ;                                     from the RS-232 device during x-line handshaking
                                                ;                                     modem is not ready for data to be sent to it
RSSTAT_DCD                    = %00100000       ;       Bit 5: - DCD (data carrier detect) missing - unused
RSSTAT_DSR                    = %01000000       ;       Bit 6: - DSR (data set ready) signal missing
                                                ;                                     from the RS-232 device during x-line handshaking
                                                ;                                     modem is not free for next task
RSSTAT_BREAK                  = %10000000       ;       Bit 7: - break detected
                                                ;                Set if the check for a stop bit finds a 0 rather than a 1
                                                ;                and the data bits received so far are all 0's
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 number of bits to be sent/received
; --------------------------------------------------------------------------------------------------------------------- ;
BITNUM                      = $0298             ;       number of bits prior the parity/stop bits for each char received/xmitted (fast response)
                                                ;         xmit    : value is copied to BITTS (countdown bits to send)
                                                ;         receive : value is copied to BITCI (countdown bits to receive)
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 system clock divided by baudrate - Result is expressed in microseconds
; --------------------------------------------------------------------------------------------------------------------- ;
BAUDOF                      = $0299             ;       full bit timing_constant (created by open) - timing_constant = [clock_frequency / baud_rate]
BAUDOF_LO                     = $0299           ;       the number of system clock cycles required to send or receive each bit at the specified baud rate
BAUDOF_HI                     = $029a           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 reciever storage - 256-byte input buffer
;   Dynamic index to the end of the receive buffer
; --------------------------------------------------------------------------------------------------------------------- ;
                                                ;       INBIT  - input bit storage
                                                ;       BITCI  - bit count in
                                                ;       RINONE - flag for start bit check
                                                ;       RIDATA - byte in buffer
                                                ;       RIPRTY - byte in parity storage
; --------------------------------------------------------------------------------------------------------------------- ;
RIDBE                       = $029b             ; Idx : offset end   of receive buffer - store  the next char received (input buffer index to end)
RIDBS                       = $029c             ; Idx : offset start of receive buffer - remove the next char xmitted  (input buffer index to start)
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 transmitter storage - 256-byte output buffer
;   Dynamic index to the start of the transmit buffer
; --------------------------------------------------------------------------------------------------------------------- ;
                                                ;       BITTS  - number of bits to be sent
                                                ;       NXTBIT - next bit to be sent
                                                ;       ROPRTY - parity of byte sent
                                                ;       RODATA - byte buffer out
; --------------------------------------------------------------------------------------------------------------------- ;
RODBS                       = $029d             ; Idx : offset start of xmit buffer - remove the next char xmitted  (output buffer index to start)
RODBE                       = $029e             ; Idx : offset end   of xmit buffer - store  the next char received (output buffer index to end)
; --------------------------------------------------------------------------------------------------------------------- ;
; Temporary SAVE area for the normal IRQ vector during tape I/O
; --------------------------------------------------------------------------------------------------------------------- ;
IRQTMP                      = $029f   ; - $02A0 ;       save area for IRQ vector during TAPE I/O - holds IRQ during TAPE operations
IRQTMP_LO                     = $029f           ; 
IRQTMP_HI                     = $02a0           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 temp space for vic-40 variables
; --------------------------------------------------------------------------------------------------------------------- ;
ENABL                       = $02a1             ;       active NMI flags byte for CI2ICR - RS-232 enables (replaces IER)
ENABL_EDGE                    = %00010000       ;       bit_4: %1 - waiting for receiver edge
ENABL_RECEIVE                 = %00000010       ;       bit_1: %1 - receiving data
ENABL_XMIT                    = %00000001       ;       bit_0: %1 - transmitting data
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
CASTON                      = $02a2             ;       TOD sense during TAPE I/O
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
KIKA26                      = $02a3             ;       temp VIA #1 ICR for TAPE read routine
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
STUPID                      = $02a4             ;       temp T1 IRQ indicator for TAPE read
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
LINTMP                      = $02a5             ; Idx : temp to next 40-col line for screen scrolling
; --------------------------------------------------------------------------------------------------------------------- ;
PALNTS                      = $02a6             ; Flag: TV standard
PALNTS_NTSC                   = $00             ;       NTSC
PALNTS_PAL                    = $01             ;       PAL

TVSFLG                      = PALNTS            ; Flag: TV Standard:
TVSFLG_NTSC                   = $00             ;       NTSC
TVSFLG_PAL                    = $01             ;       PAL
; --------------------------------------------------------------------------------------------------------------------- ;
UNUSED                   .var $02a7   ; - $02ff ;       unused $58 bytes
; --------------------------------------------------------------------------------------------------------------------- ;
; if the VIC-II chip is banked to the lowest 16K of memory (default) this is one of the few free areas
; available for storing sprite or character data without interfering with BASIC program text or variables
; --------------------------------------------------------------------------------------------------------------------- ;
SPR11                       = $02c0   ; - $02ff ;       Sprite #11 Data Area
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC indirect vectors - initialized from table BVTRS
; --------------------------------------------------------------------------------------------------------------------- ;
IERROR                      = $0300             ; Vect: BASIC ERROR/READY message and warm start - .X=offset error msg tab [ERRTAB]
IERROR_LO                     = $0300           ; 
IERROR_HI                     = $0301           ; 
IERROR_INI                    = $e38b           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
IMAIN                       = $0302             ; Vect: BASIC warm start
IMAIN_LO                      = $0302           ; 
IMAIN_HI                      = $0303           ; 
IMAIN_INI                     = $a483           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
ICRNCH                      = $0304             ; Vect: BASIC crunch tokens
ICRNCH_LO                     = $0304           ; 
ICRNCH_HI                     = $0305           ; 
ICRNCH_INI                    = $a57c           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
IQPLOP                      = $0306             ; Vect: BASIC uncrunch tokens
IQPLOP_LO                     = $0306           ; 
IQPLOP_HI                     = $0307           ; 
IQPLOP_INI                    = $a71a           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
IGONE                       = $0308             ; Vect: BASIC read and execute the next statement
IGONE_LO                      = $0308           ; 
IGONE_HI                      = $0309           ; 
IGONE_INI                     = $a7e4           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
IEVAL                       = $030a             ; Vect: BASIC get an arithmetic term in expression
IEVAL_LO                      = $030a           ; 
IEVAL_HI                      = $030b           ; 
IEVAL_INI                     = $ae86           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Register Save Area
; --------------------------------------------------------------------------------------------------------------------- ;
SAREG                       = $030c             ;       Storage .A during SYS
SXREG                       = $030d             ;       Storage .X during SYS
SYREG                       = $030e             ;       Storage .Y during SYS
SPREG                       = $030f             ;       Storage Status Register during SYS
; --------------------------------------------------------------------------------------------------------------------- ;
; User routine JMP instruction
; --------------------------------------------------------------------------------------------------------------------- ;
USRPOK                      = $0310             ;       JMP instruction to USR Routine
USRPOK_OPCODE                 = $0310           ;         USR Function JMP Instruction ($4c)
USRPOK_LO                     = $0311           ;         USR Address LO - default: <FCERR - ILLEGAL QUANTITY error
USRPOK_HI                     = $0312           ;         USR Address HI - default: >FCERR
; --------------------------------------------------------------------------------------------------------------------- ;
UNUSED                   .var $0313             ;       unused $01 byte
; --------------------------------------------------------------------------------------------------------------------- ;
; KERNEL indirect vectors - initialized from table VECTSS
; --------------------------------------------------------------------------------------------------------------------- ;
CINV                        = $0314             ; Vect: hardware IRQ interrupt address
CINV_LO                       = $0314           ; 
CINV_HI                       = $0315           ; 
CINV_INI                      = $ea31           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
CNBINV                      = $0316             ; Vect: BRK instruction interrupt address
CNBINV_LO                     = $0316           ; 
CNBINV_HI                     = $0317           ; 
CNBINV_INI                    = $fe66           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
NMINV                       = $0318             ; Vect: hardware NMI interrupt address
NMINV_LO                      = $0318           ; 
NMINV_HI                      = $0319           ; 
NMINV_INI                     = $fe47           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
IOPEN                       = $031a             ; Vect: KERNAL OPEN routine
IOPEN_LO                      = $031a           ; 
IOPEN_HI                      = $031b           ; 
IOPEN_INI                     = $f34a           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
ICLOSE                      = $031c             ; Vect: KERNAL CLOSE routine
ICLOSE_LO                     = $031c           ; 
ICLOSE_HI                     = $031d           ; 
ICLOSE_INI                    = $f291           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
ICHKIN                      = $031e             ; Vect: KERNAL CHKIN routine
ICHKIN_LO                     = $031e           ; 
ICHKIN_HI                     = $031f           ; 
ICHKIN_INI                    = $f20e           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
ICKOUT                      = $0320             ; Vect: KERNAL CHKOUT routine
ICKOUT_LO                     = $0320           ; 
ICKOUT_HI                     = $0321           ; 
ICKOUT_INI                    = $f250           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
ICLRCH                      = $0322             ; Vect: KERNAL CLRCHN routine
ICLRCH_LO                     = $0322           ; 
ICLRCH_HI                     = $0323           ; 
ICLRCH_INI                    = $f333           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
IBASIN                      = $0324             ; Vect: KERNAL CHRIN routine
IBASIN_LO                     = $0324           ; 
IBASIN_HI                     = $0325           ; 
IBASIN_INI                    = $f157           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
IBSOUT                      = $0326             ; Vect: KERNAL CHROUT routine
IBSOUT_LO                     = $0326           ; 
IBSOUT_HI                     = $0327           ; 
IBSOUT_INI                    = $f1ca           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
ISTOP                       = $0328             ; Vect: KERNAL STOP routine
ISTOP_LO                      = $0328           ; 
ISTOP_HI                      = $0329           ; 
ISTOP_INI                     = $f6ed           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
IGETIN                      = $032a             ; Vect: KERNAL GETIN routine
IGETIN_LO                     = $032a           ; 
IGETIN_HI                     = $032b           ; 
IGETIN_INI                    = $f13e           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
ICLALL                      = $032c             ; Vect: KERNAL CLALL routine
ICLALL_LO                     = $032c           ; 
ICLALL_HI                     = $032d           ; 
ICLALL_INI                    = $f32f           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
USRCMD                      = $032e             ; Vect: user defined routine
USRCMD_LO                     = $032e           ; 
USRCMD_HI                     = $032f           ; 
USRCMD_INI                    = $fe66           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
ILOAD                       = $0330             ; Vect: KERNAL LOAD routine
ILOAD_LO                      = $0330           ; 
ILOAD_HI                      = $0331           ; 
ILOAD_INI                     = $f4a5           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
ISAVE                       = $0332             ; Vect: KERNAL SAVE routine
ISAVE_LO                      = $0332           ; 
ISAVE_HI                      = $0333           ; 
ISAVE_INI                     = $f5ed           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
UNUSED                   .var $0334   ; - $033b ;       unused $07 bytes
; --------------------------------------------------------------------------------------------------------------------- ;
; Tape buffer area - $c0 (192) bytes for headers and BASIC file data
; --------------------------------------------------------------------------------------------------------------------- ;
TBUFFR                      = $033c             ;       TAPE I/O DATA BUFFER
; --------------------------------------------------------------------------------------------------------------------- ;
; Tape Buffer for Header Data
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE header ID byte
; --------------------------------------------------------------------------------------------------------------------- ;
TPHDRID                       = TBUFFR          ; Flag: Tape header ID
TPHDRID_RELOC                   = $01           ;       Relocatable
                                                ;         secondary address on SAVE was 0 or any even number
                                                ;         program is to be loaded to the memory of pointer [TXTTAB]
TPHDRID_BASIC_DATA              = $02           ;       BASIC Program Data Block Followed by 191 bytes of data
TPHDRID_FIX                     = $03           ;       Non-relocatable
                                                ;         secondary address on SAVE was 1 or any odd number
                                                ;         program always loads to the address contained in TPHBGN
                                                ;         any start-of-load pointer passed to the KERNAL is ignored
TPHDRID_BASIC_DATA_HDR          = $04           ;       BASIC Program Data Header
                                                ;         data written by a BASIC program follows in 192-byte blocks
                                                ;           each with an TPHDRID_BASIC_DATA ID as the first byte
TPHDRID_EOT                     = $05           ;       Logical End of Tape
                                                ;         KERNAL stops searching the tape
                                                ;         Additional files may be stored after this point
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE LOAD starting address
; --------------------------------------------------------------------------------------------------------------------- ;
TPHBGN                        = TBUFFR + $01    ; Ptr:  Starting address for TAPE LOAD
TPHBGN_LO                        = TPHBGN + $00 ; 
TPHBGN_HI                        = TPHBGN + $01 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE LOAD ending address
; --------------------------------------------------------------------------------------------------------------------- ;
TPHEND                        = TBUFFR + $03    ; Ptr:  Ending address for TAPE LOAD
TPHEND_LO                     = TPHEND + $00    ; 
TPHEND_HI                        = TPHEND + $01 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE data file name
; --------------------------------------------------------------------------------------------------------------------- ;
TPHNAME                       = TBUFFR + $05    ;       Filename of tape data padded with <BLANK>s
TPHNAME_X                     = TBUFFR + BUFSZ  ; 
TPHNAME_LEN                   = TPHNAME_X - TPHNAME ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE Buffer for BASIC program data
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE BASIC program data block identifier
; --------------------------------------------------------------------------------------------------------------------- ;
TPBLOCK                       = TBUFFR + $01    ;       block buffer for PRINT#, INPUT#, GET#
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE block of $bf (191) user data bytes from a BASIC program
; --------------------------------------------------------------------------------------------------------------------- ;
TNOUSE                        = $03fc ; - $03ff ;       unused $04 bytes
BUFSZ                         = TNOUSE - TBUFFR ;       $c0 - buffer size
; --------------------------------------------------------------------------------------------------------------------- ;
; If the VIC-II chip is banked to the lowest 16K of memory (default) this is one of the few free areas
;   available for storing sprite or char data without interfering with BASIC program text or variables
; 
; If the tape is not in use these locations can be used as sprite data blocks
; --------------------------------------------------------------------------------------------------------------------- ;
SPR13                         = $0340 ; - $037e ;       Data Sprite #13
SPR14                         = $0380 ; - $03be ;       Data Sprite #14
SPR15                         = $03c0 ; - $03fe ;       Data Sprite #15
; --------------------------------------------------------------------------------------------------------------------- ;
; standard SCREEN / SPRITE pointers honz
; --------------------------------------------------------------------------------------------------------------------- ;
VICSCN                        = $0400           ;       default screen memory
VICSCNX                         = VICSCN + (VICSCN_LLEN * VICSCN_NLINES) - $01 ; $07e7
VICSCN_LEN                      = VICSCNX - VICSCN                             ; $03e7
VICSCN_LLEN                     = LLEN          ;       single line  = $28 (40) columns
VICSCN_LLEN2                    = LLEN2         ;       double line  = $50 (80) columns
VICSCN_NLINES                   = NLINES        ;       screen lines = $19 (25) rows
; --------------------------------------------------------------------------------------------------------------------- ;
; The Display Window dimensions for PAL
; --------------------------------------------------------------------------------------------------------------------- ;
; The height and width of the VIC2 display window can each be set with the bits SCROLY_RSEL and SCROLX_CSEL
; 
; +--------+--------------------------+------------+------------+ 
; ! SCROLY !  Display window height   ! First line ! Last line  ! 
; !  RSEL  !                          !            !            ! 
; +--------+--------------------------+------------+------------+ 
; !    0   ! 24 text lines/192 pixels !  $37 (55)  ! $f6 (246)  ! 
; !    1   ! 25 text lines/200 pixels !  $33 (51)  ! $fa (250)  ! 
; +--------+--------------------------+------------+------------+ 
; ! SCROLX !   Display window width   !  First X   !  Last X    ! 
; !  CSEL  !                          ! coordinate ! coordinate ! 
; +--------+--------------------------+------------+------------+ 
; !    0   ! 38 characters/304 pixels !  $1f (31)  ! $14e (334) ! 
; !    1   ! 40 characters/320 pixels !  $18 (24)  ! $157 (343) ! 
; +--------+--------------------------+------------+------------+------------------------------------------------------ ;
VICSCN_WIDTH_40                 = $140                              ; $140 (320)
VICSCN_WIDTH_38                 = $130                              ; $130 (304)
; --------------------------------------------------------------------------------------------------------------------- ;
VICSCN_MINY_25                  = $33                               ;  $33 ( 51)
VICSCN_MINY_24                  = VICSCN_MINY_25 + $04              ;  $37 ( 55)
                                
VICSCN_MAXY_25                  = $fa                               ;  $fa (250)
VICSCN_MAXY_24                  = VICSCN_MAXY_25 - $04              ;  $f6 (246)
                                
VICSCN_MINX_40                  = $18                               ;  $18 ( 24)
VICSCN_MINX_38                  = VICSCN_MINX_40 + $07              ;  $1f ( 31)
                                
VICSCN_MAXX_40                  = $157                              ; $157 (343)
VICSCN_MAXX_38                  = VICSCN_MAXX_40 - $09              ; $14e (334)
; --------------------------------------------------------------------------------------------------------------------- ;
UNUSED                     .var $07e8 ; - $07f7 ;       unused $10 bytes
; --------------------------------------------------------------------------------------------------------------------- ;
; Sprite Pointers
; --------------------------------------------------------------------------------------------------------------------- ;
; Sprite pointers are stored in the last 8 bytes of the video matrix
; Sprite data is $03 bytes wide * $15 bytes high = $3f bytes
; A sprite data block has $40 bytes ($3f + $01 byte)
; The C64 memmory can be devided into $40 sprite data blocks
; The sprite data has to start at one of these memory blocks
; The sprite pointer contains the sprite data memory block number
; --------------------------------------------------------------------------------------------------------------------- ;
SPNTR                       = VICSCN + $10 + VICSCN_LLEN * VICSCN_NLINES ; default sprite data pointers
SPNTR_00                      = SPNTR + $00     ;       $07f8
SPNTR_01                      = SPNTR + $01     ;       $07f9
SPNTR_02                      = SPNTR + $02     ;       $07fa
SPNTR_03                      = SPNTR + $03     ;       $07fb
SPNTR_04                      = SPNTR + $04     ;       $07fc
SPNTR_05                      = SPNTR + $05     ;       $07fd
SPNTR_06                      = SPNTR + $06     ;       $07fe
SPNTR_07                      = SPNTR + $07     ;       $07ff
SPNTR_X                       = SPNTR_07        ;       $07ff - last one
SPNTR_LEN                     = SPNTR_X - SPNTR ;             - length of sprite pointers
SPNTR_OFFSET                  = SPNTR - VICSCN  ;       $03f8 - offset from screen start address
; --------------------------------------------------------------------------------------------------------------------- ;
; Common Sprite Definitions
; --------------------------------------------------------------------------------------------------------------------- ;
SPRT_ROWS                     = $15             ; 21 bit height
SPRT_COLS                     = $18             ; 24 bit width
SPRT_SIZE_X                   = SPRT_ROWS       ; $15 bytes
SPRT_SIZE_Y                   = SPRT_COLS / $08 ; $03 bytes
SPRT_BLK_LEN                  = SPRT_SIZE_X * SPRT_SIZE_Y + $01 ; $40 (64) - used: $3f (63) - last byte always $00
; --------------------------------------------------------------------------------------------------------------------- ;

; --------------------------------------------------------------------------------------------------------------------- ;
; default BASIC code area
; --------------------------------------------------------------------------------------------------------------------- ;
RAMLOC                      = $0800             ;       BASIC code area start
RAMLOC_CONST                  = $00             ;       BASIC code area start constant
RAMSTR                      = RAMLOC + $01      ;       BASIC program start
RAMEND                      = ROMLOC - $01      ;       BASIC code area end
; --------------------------------------------------------------------------------------------------------------------- ;
; cartidge ROM
; --------------------------------------------------------------------------------------------------------------------- ;
CRTLOC                      = $8000             ;       cartidge ROM
CRTRES                        = CRTLOC + $0000  ;       autostart ROM RESET vector
CRTNMI                        = CRTLOC + $0002  ;       autostart ROM NMI vector
CRTIDS                        = CRTLOC + $0004  ;       autostart ROM ID 'CBM80' (bit7 set)
CRTSTR                        = CRTLOC + $0009  ;       autostart ROM code start
CRTEND                        = CRTLOC + $1fff  ;       autostart ROM code end
; --------------------------------------------------------------------------------------------------------------------- ;
; ROM start addresses
; --------------------------------------------------------------------------------------------------------------------- ;
ROMLOC                      = $a000             ;       BASIC  ROM
                            .include "c64.BASIC.routines.asm" ; BASIC Routines entry points $a000-$bfff
ROMLOC2                     = $e000             ;       BASIC  ROM continued
                            .include "c64.KERNAL.routines.asm" ; KERNAL Routines entry points $e000-$ffff
KERLOC                      = $e4d3             ;       KERNAL ROM start - PRTYP routine
; --------------------------------------------------------------------------------------------------------------------- ;
; standard CHARSETS
; --------------------------------------------------------------------------------------------------------------------- ;
CHARGEN                     = $d000             ;       character generator ROM
CHARGEN_UG                    = $d000           ;       upper case/gfx
CHARGEN_UGR                   = $d400           ;       upper case/gfx - reversed
CHARGEN_UL                    = $d800           ;       upper/lower case
CHARGEN_ULR                   = $dc00           ;       upper/lower case - reversed
; --------------------------------------------------------------------------------------------------------------------- ;
; I/O devices
; --------------------------------------------------------------------------------------------------------------------- ;
VICREG                      = $d000             ; 
                            .include "c64.VIC.asm" ;    $d000-$d02e - VIC registers
SIDREG                      = $d400             ; 
                            .include "c64.SID.asm" ;    $d400-$d41c - SID registers
; --------------------------------------------------------------------------------------------------------------------- ;
; VIC colour RAM
; --------------------------------------------------------------------------------------------------------------------- ;
COLORLOC                    = $d800             ; 
                            .include "c64.color.asm" ; $d800-$dbff - COLORAM and color equates
; --------------------------------------------------------------------------------------------------------------------- ;

; --------------------------------------------------------------------------------------------------------------------- ;
; CIAs
; --------------------------------------------------------------------------------------------------------------------- ;
CIA1REG                     = $dc00             ; 
                            .include "c64.CIA1.asm" ;   $dc00-$dc0f - Complex Interface Adapter (CIA) #1 Registers
CIA2REG                     = $dd00             ; 
                            .include "c64.CIA2.asm" ;   $dd00-$dd0f - Complex Interface Adapter (CIA) #2 Registers
; --------------------------------------------------------------------------------------------------------------------- ;
; KERNAL jump table
; --------------------------------------------------------------------------------------------------------------------- ;
KERNAL_API                  = $ff81             ;       
                            .include "c64.KERNAL.API.asm" ; $ff81-$fff5 - Kernal jump table KERJTB 
; --------------------------------------------------------------------------------------------------------------------- ;
; SYSTEM hardware vectors
; --------------------------------------------------------------------------------------------------------------------- ;
                            .weak               ; avoid error: duplicate definition
; --------------------------------------------------------------------------------------------------------------------- ;
; Any symbols defined inside can be overridden by “stronger” symbols in the same scope from outside
; --------------------------------------------------------------------------------------------------------------------- ;
SHV                         = $fffa             ;       SYSTEM hardware vectors VECTSH
SHV_NMI                     = $fffa             ;       NMI   ($fe43) - NMI
SHV_NMI_LO                    = SHV_NMI         ;       Push PC and STATUS onto the STACK
SHV_NMI_HI                    = SHV_NMI + $01   ; 
                                                ; 
SHV_RESET                   = $fffc             ;       START ($fce2) - Cold start
SHV_RESET_LO                  = SHV_RESET       ; 
SHV_RESET_HI                  = SHV_RESET + $01 ; 
                                                ; 
SHV_IRQ                     = $fffe             ;       PULS  ($ff48) - IRQ and Break
SHV_IRQ_LO                    = SHV_IRQ         ;       Push PC and STATUS onto the STACK
SHV_IRQ_HI                    = SHV_IRQ + $01   ; 
                                                ; 
SHV_BRK                     = SHV_IRQ           ;       PULS  ($ff48) - IRQ and Break
SHV_BRK_LO                    = SHV_IRQ_LO      ;       Push PC and STATUS onto the STACK
SHV_BRK_HI                    = SHV_IRQ_HI      ;       Set B-Flag in the copy of the STATUS register
; --------------------------------------------------------------------------------------------------------------------- ;
                            .endweak ; 
; --------------------------------------------------------------------------------------------------------------------- ;
