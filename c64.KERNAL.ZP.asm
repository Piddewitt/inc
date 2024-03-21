; ------------------------------------------------------------------------------------------------------------- ;
; C64 - KERNAL Zero Page Entries
; --------------------------------------------------------------------------------------------------------------------- ;
; ST status of I/O completion
; --------------------------------------------------------------------------------------------------------------------- ;
STATUS                      = $90               ;       I/O operation status word (ST) 
                                                ; --------------------------------------------------------------------- ;
                                                ;       SERIAL Device Errors
                                                ; --------------------------------------------------------------------- ;
STATUS_TIMEOUT_WRITE          = %00000001       ;       Timeout write
                                                ;           The serial device doesn't handshake within the allocated time
STATUS_TIMEOUT_READ           = %00000010       ;       Timeout read
                                                ;           The serial device doesn't handshake within the allocated time
STATUS_VERIFY                 = %00010000       ;       VERIFY error
                                                ;         The byte retrieved from the serial device does not match the byte in memory
STATUS_EOI                    = %01000000       ;       End of File
STATUS_NO_DEVICE              = %10000000       ;       Device not present
                                                ;         Device does not respond with the proper handshake sequence
                                                ; --------------------------------------------------------------------- ;
                                                ;       TAPE Errors
                                                ; --------------------------------------------------------------------- ;
STATUS_BLOCK_SHORT            = SBERR           ;       Block too short (shorter 192 bytes)
                                                ;         Tape read is reading leader bits between blocks 
                                                ;         while the byte action routine is still expecting to be reading bytes from the block
STATUS_BLOCK_LONG             = LBERR           ;       Block too long  (longer  192 bytes)
                                                ;         Tape read tries to read data bytes after the first block has already completed
STATUS_SECOND_PASS            = SPERR           ;       Second pass read error (unrecoverable error)
                                                ;         More than 31 errors were detected in block 1
                                                ;         READ or VERIFY errors for the same byte occurred in both blocks 1 and 2
STATUS_CHECKSUM               = CKERR           ;       Checksum error
                                                ;         Computed parity for the loaded area is not the same as the final byte of tape block 2
                                                ;        (the parity computed during the SAVE of the 2nd block)
STATUS_EOT                    = %10000000       ;       End of Tape
                                                ;         Set when doing CHRIN from tape for a sequential file
                                                ;         and the read-ahead byte in the tape buffer is $00
; --------------------------------------------------------------------------------------------------------------------- ;
; Row 7 keyboard matrix scan value
; --------------------------------------------------------------------------------------------------------------------- ;
STKEY                       = $91               ; Flag: <STOP> key pressed
STKEY_STOP                    = CIA_KEY_STOP    ;       $7f - .####### - <STOP>
STKEY_Q                       = CIA_KEY_Q       ;       $bf - #.###### - Q
STKEY_CMDRE                   = CIA_KEY_CMDRE   ;       $df - ##.##### - C=
STKEY_SPACE                   = CIA_KEY_SPACE   ;       $ef - ###.#### - <SPACE>
STKEY_2                       = CIA_KEY_2       ;       $f7 - ####.### - 2
STKEY_CTRL                    = CIA_KEY_CTRL    ;       $fb - #####.## - <CTRL>
STKEY_ARROW_L                 = CIA_KEY_ARROW_L ;       $fd - ######.# - <-
STKEY_1                       = CIA_KEY_1       ;       $fe - #######. - 1
                              
STKEY_NONE                    = CIAPRB_KEY_NONE ;       $ff - ######## - <NONE>
; --------------------------------------------------------------------------------------------------------------------- ;
; Adjustable timing constant for casette reads - allow for slight speed variations
;   - Represents the difference between the ACTUAL time required reading a bit and the STANDARD time
;   - Adjusts [CMP0] to compensate for minor variations in TAPE motor speed
; --------------------------------------------------------------------------------------------------------------------- ;
SVXT                        = $92               ;       Timing constant for slight speed variations between tapes
; --------------------------------------------------------------------------------------------------------------------- ;
; Destinguish between LOAD and VERIFY operations
; --------------------------------------------------------------------------------------------------------------------- ;
VERCK                       = $93               ; Flag: LOAD/VERIFY                                             
VERCK_LOAD                    = $00             ;       LOAD                                                    
VERCK_VERIFY                  = $01             ;       VERIFY                                                  
; --------------------------------------------------------------------------------------------------------------------- ;
; Serial output deferred character flag
;   indicates a char has been stored in [BSOUR] and waits to be sent
; --------------------------------------------------------------------------------------------------------------------- ;
C3P0                        = $94               ; Flag: IEEE Serial Bus Output deferred char waiting in [BSOUR]
C3P0_NO                       = %01111111       ;         bit_7 = 0 - a  char is waiting to be sent
C3P0_YES                      = %10000000       ;         bit_7 = 1 - no char is waiting to be sent
; --------------------------------------------------------------------------------------------------------------------- ;
; Buffered char for the serial bus
; [C3P0] indicates whether the current value here represents a char awaiting transmission
;   Buffer to send the last byte of a file with the <EOI> handshake to identify it as the final byte
;   A serial bus file opened for write must be closed otherwise the final byte with the <EOI> handshake won't be sent
; --------------------------------------------------------------------------------------------------------------------- ;
BSOUR                       = $95               ;       buffer the bits waiting to be sent over the serial bus
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE block synchronization number
; Indicates the system has read the leader bytes and is waiting for the end of the leader segment
; --------------------------------------------------------------------------------------------------------------------- ;
SYNO                        = $96               ;       TAPE block sync count
SYNO_INI                      = $00             ;       either no block is recognized yet
                                                ;       or     a block is recognized and data is being read from that block
SYNO_MAX                      = $10    ; - $7e  ;       has read at least 16 leader bits during read of the tape leader 
                                                ;       either before the first block or between blocks 1 and 2
                                                ;       and is now waiting for the word marker at the end of the leader
; --------------------------------------------------------------------------------------------------------------------- ;
; Temporary .Y/.X save area during input from RS232/TAPE
; --------------------------------------------------------------------------------------------------------------------- ;
XSAV                        = $97               ;       save .X at NBASIN / save .Y at RS-232 NGETIN
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of currently open I/O files - index to the end of all the tables holding file num/device num/secondary addresses
; Storing LDTND_INI here effectively empties all the LAT FAT SAT tables
; --------------------------------------------------------------------------------------------------------------------- ;
LDTND                       = $98               ; Idx : index to end of file tables LAT, FAT, SAT
LDTND_INI                     = $00             ;       no I/O file open but not yet closed
LDTND_MAX                     = LAT_LEN         ;       max num ($0a) of currently open I/O files (table length)
; --------------------------------------------------------------------------------------------------------------------- ;
; Device number of the current input device
; --------------------------------------------------------------------------------------------------------------------- ;
DFLTN                       = $99               ;       default (current) input  device number
DFLTN_KEYBOARD                = DEVNUM_KEYBOARD ;       $00 - init (default)
DFLTN_TAPE                    = DEVNUM_TAPE     ;       $01
DFLTN_RS232C                  = DEVNUM_RS232C   ;       $02
DFLTN_SCREEN                  = DEVNUM_SCREEN   ;       $03
DFLTN_PRINTER                 = DEVNUM_PRINTER  ;       $04
DFLTN_DISK                    = DEVNUM_DISK     ;       $08
; --------------------------------------------------------------------------------------------------------------------- ;
; Device number of the current output device
; --------------------------------------------------------------------------------------------------------------------- ;
DFLTO                       = $9a               ;       default (current) output device number
DFLTO_TAPE                    = DEVNUM_TAPE     ;       $01
DFLTO_RS232C                  = DEVNUM_RS232C   ;       $02
DFLTO_SCREEN                  = DEVNUM_SCREEN   ;       $03 - init (default)
DFLTO_PRINTER                 = DEVNUM_PRINTER  ;       $04
DFLTO_DISK                    = DEVNUM_DISK     ;       $08
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE char parity
;   TAPE bytes have an extra parity bit added to make an odd total number of 1 bits (8 databits plus 1 parity)
;   Used to make sure that an odd total number of bits is read back for each character
; --------------------------------------------------------------------------------------------------------------------- ;
PRTY                        = $9b               ;       parity of byte output to tape
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE dipole switch / byte-received flag
; --------------------------------------------------------------------------------------------------------------------- ;
DPSW                        = $9c               ; Flag: byte received from Tape
DPSW_READ                     = $00             ;       $00 - bits are still being read
DPSW_REC                      = $01             ;       $xx - all bits received
; --------------------------------------------------------------------------------------------------------------------- ;
; KERNAL message control flag - 0 = suppress messages / 1 = display messages
; --------------------------------------------------------------------------------------------------------------------- ;
MSGFLG                      = $9d               ; Flag: KERNAL message control
MSGFLG_NONE                   = %00000000       ;       program mode - neither control or KERNAL messages
MSGFLG_IO                     = %01000000       ;                    - KERNAL "I/O ERROR #" <NUMBER> message only [MS1]
MSGFLG_CTRL                   = %10000000       ;       direct mode  - control messages only                      [MS2-MS18]
MSGFLG_FULL                   = %11000000       ;                    - both control messages and I/O error messages
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE Filename index / TAPE save header ID / TAPE or RS-232 write output char buffer
; --------------------------------------------------------------------------------------------------------------------- ;
T1                          = $9e               ; Temp:  TAPE / RS-232 work
                                                ;        TAPE block types - header ID values
T1_ID_RELOCATABLE             = BLF             ;        $01 - basic load file
T1_ID_USER_DATA_RECORD        = BDF             ;        $02 - basic data file
T1_ID_NON_RELOCATABLE         = PLF             ;        $03 - fixed program type
T1_ID_USER_DATA_HEADER        = BDFH            ;        $04 - basic data file header
T1_ID_END_OF_TAPE             = EOT             ;        $05 - end of tape
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE data buffer index for filename
; --------------------------------------------------------------------------------------------------------------------- ;
T2                          = $9f               ; Temp: index filename in TAPE buffer header
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE read pass 1 error buffer index value
; 2 copies of each data block are written to TAPE (pass 1/pass 2)
;   When reading the 1st copy the address of any error byte is stored in the TAPE error log [BAD]
;   A 'SECOND PASS error' is set if the value exceeds $3C (60) indicating more than 30 errors
; --------------------------------------------------------------------------------------------------------------------- ;
PTR1                        = T1                ; Off:  TAPE pass 1 error buffer pointer --> next free two-byte adr slot in [BAD]
PTR1_MAX                      = BAD_LEN         ;       max [BAD] buffer size ($3e) = max $1f (31) errors
; --------------------------------------------------------------------------------------------------------------------- ;
; Used during read of the 2nd TAPE data block - contains the adr of the next byte needing correction in the 2nd pass
; --------------------------------------------------------------------------------------------------------------------- ;
PTR2                          = T2              ; Off:  TAPE pass 2 error buffer pointer --> next [BAD] entry to be processed
; --------------------------------------------------------------------------------------------------------------------- ;
; Jiffy real time clock
; --------------------------------------------------------------------------------------------------------------------- ;
TIME                        = $a0               ; Time: 24 hour clock in 1/60th seconds (JIFFY)
TIME_DAY                      = $4f1a00         ;       number of JIFFIES in 24h - reset to zero after 24h
TIME_HO                       = TIME + $00      ;       MSB
TIME_MO                       = TIME + $01      ;       ...
TIME_LO                       = TIME + $02      ;       LSB
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE write: Count down of bits remaining to be written for a byte
;           :   if $00 - time to set up the parity bit to be written
;           :   if $ff - prepare the next byte to be written
; TAPE read : Count down of bits remaining to be read for a byte
;           :   if $ff - parity bit has just been read --> time to check for a parity error
; --------------------------------------------------------------------------------------------------------------------- ;
PCNTR                       = $a3               ; Flag: TAPE read/write bit count
PCNTR_EOI                     = %10000000       ;       bit_7=1 - flag <EOI>
PCNTR_BITS                    = $08             ;       TAPE bit count before writing a parity bit
; --------------------------------------------------------------------------------------------------------------------- ;
; Serial EOI flag
; --------------------------------------------------------------------------------------------------------------------- ;
R2D2                        = PCNTR             ; Flag: serial <EOI> - last byte has been sent to the serial device
R2D2_EOI                        = $80           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Tape dipole number
; --------------------------------------------------------------------------------------------------------------------- ;
FIRT                        = $a4               ; Flag: TAPE half-cycle (dipole) indicator
FIRT_1ST                      = $00             ;       1st half
FIRT_2ND                      = $01             ;       2nd half
; --------------------------------------------------------------------------------------------------------------------- ;
; Serial input byte during LOAD or VERIFY
; --------------------------------------------------------------------------------------------------------------------- ;
BSOUR1                      = FIRT              ;       serial byte received
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE block synchronization char countdown
;   For the 1st block the count down chars (9-1) have bit7 on
;   For the 2nd block the count down chars (9-1) have bit7 off
; During tape load the block count down chars can be used to determine whether block 1 or block 2 is being read
; --------------------------------------------------------------------------------------------------------------------- ;
CNTDN                       = $a5               ;       TAPE sync byte count
CNTDN_CAS                     = $09             ;       TAPE sync byte count
; --------------------------------------------------------------------------------------------------------------------- ;
; Serial bit countdown
; --------------------------------------------------------------------------------------------------------------------- ;
COUNTK                      = CNTDN   ;.hbu001. ;       serial bit count - .hbu001. 'K' added because name already used in BASIC zero page
COUNTK_SER                    = $08             ;       number of serial bits left to be sent
COUNTK_SER_EOI                = $00             ;       flag <EOI> on timeout
; --------------------------------------------------------------------------------------------------------------------- ;
; Offset current byte in the TAPE buffer - count of chars in the TAPE buffer
; --------------------------------------------------------------------------------------------------------------------- ;
BUFPT                       = $a6               ; Idx : TAPE buffer index
BUFPT_MAX                     = BUFSZ           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE write leader count / read block reverse counter
; --------------------------------------------------------------------------------------------------------------------- ;
SHCNL                       = $a7               ; Flag: pass 1/pass 2
SHCNL_SYNCS                   = $50             ;       TAPE write leader count - put 80 TAPE syncs at end tape
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Bit0 is the temporary RS-232 receiver storage for input bit
; --------------------------------------------------------------------------------------------------------------------- ;
INBIT                       = SHCNL             ;       RS-232: current data bit received
; --------------------------------------------------------------------------------------------------------------------- ;
; SAVE: switch for word marker write
;   $00 = writing the long time for a word marker dipole
;   $01 = the long time for a word marker dipole has already been written
; --------------------------------------------------------------------------------------------------------------------- ;
RER                         = $a8               ; Flag: TAPE  : READ ERROR / half cycle indicator for write (leader start bit cycle dipole)
RER_WRITE                     = $00             ;             : start bit 1st cycle about to be written
RER_DONE                      = $01             ;             : start bit 1st cycle done
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 input byte bit count and output new byte
; --------------------------------------------------------------------------------------------------------------------- ;
BITCI                       = RER               ;       RS-232: receiver input bit count
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE save - switch for word marker write
;             $00 - write the 1 time (medium time) for a word marker dipole
;             $01 - the 1 time for a word marker dipole has already been written
; TAPE load - balanced counter
;               each time a 0 dipole is read this value is incremented
;               each time a 1 dipole is read this value is decremented
; --------------------------------------------------------------------------------------------------------------------- ;
REZ                         = $a9               ; Flag: TAPE  : number of TAPE 0_bits read / write start bit check flag
REZ_WAIT                      = $00             ;             : start bit check received: $00 - start bit incomplete - still waiting for start bit
REZ_DONE                      = $01             ;             :                           $xx - start bit received
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 input flag for checking a start bit
; --------------------------------------------------------------------------------------------------------------------- ;
RINONE                      = REZ               ; Flag: RS-232: receiver flag for start bit check
RINONE_DONE                   = $00             ;             : $00 - start bit received
RINONE_WAIT                   = $90             ;             : $90 - start bit incomplete - still waiting for start bit
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE input status flags / sync countdown
; --------------------------------------------------------------------------------------------------------------------- ;
RDFLG                       = $aa               ; Flag: TAPE  : read mode
RDFLG_WAIT                    = %00000000       ;             : $00   - wait for sync
RDFLG_COUNT                   = %00001111       ;             : Mask: - count down until real data can be received
                                                ;             :         block count down chars are being read
RDFLG_DATA                    = %01000000       ;             : bit_6 - load the byte 
                                                ;             :         valid block count down chars have arrived
                                                ;             :         the byte received is treated as a valid data byte
RDFLG_SKIP                    = %10000000       ;             : bit_7 - ignore bytes until [REZ] is set
                                                ;             :         1st block has been loaded - search is proceeding for the 2nd lock
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 byte assembly (input byte buffer)
; --------------------------------------------------------------------------------------------------------------------- ;
RIDATA                      = RDFLG             ;       RS-232: bit buffer - received bits are shifted in here until the byte is complete
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE write leader counter / TAPE read checksum comparison
; --------------------------------------------------------------------------------------------------------------------- ;
SHCNH                       = $ab               ;       TAPE  : leader cycle count / store for calculating parity byte
SHCNH_LEAD_BLK                 = $00            ; write count leader between blocks
SHCNH_LEAD_BLK_ONE             = $14            ; write count leader 1st block
SHCNH_LEAD_HDR                 = $69            ; write count header leader
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 input parity / checksum bit storage
; --------------------------------------------------------------------------------------------------------------------- ;
RIPRTY                      = SHCNH             ;       RS-232: receiver parity bit
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE / Serial start address for LOAD/SAVE/VERIFY
;   adr current byte to be saved/loaded to/from tape/disk
; 
; Address start line in SCREEN scrolling routine SCRLIN - text chars
; --------------------------------------------------------------------------------------------------------------------- ;
SAL                         = $ac               ; Ptr : LO
SAH                         = $ad               ;       HI
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE  : end  address for LOAD/SAVE/VERIFY
; Serial: load address for LOAD/VERIFY/SAVE end address plus 1
; 
; Address start line in SCREEN scrolling routine SCRLIN - text colors
; --------------------------------------------------------------------------------------------------------------------- ;
EAL                         = $ae               ; Ptr : LO
EAH                         = $af               ;       HI
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE dipole timing adjustment values
;   indicates whether the current baseline time (time allotted for a particular type of dipole) in [SVXT]
;   needs to be slightly increased or decreased - allows compensation for slight variations in TAPE speed
; --------------------------------------------------------------------------------------------------------------------- ;
CMP0                        = $b0               ;       TAPE adjustable baseline compensation factor
; --------------------------------------------------------------------------------------------------------------------- ;
; Tape dipole timing timer 2 difference
; --------------------------------------------------------------------------------------------------------------------- ;
TEMP                        = $b1               ;       working storage for baseline compensation factor computation
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to TAPE buffer address - must be .GE. $0200 - otherwise ILLEGAL DEVICE NUMBER error
; --------------------------------------------------------------------------------------------------------------------- ;
TAPE1                       = $b2               ; Ptr : TAPE buffer start pointer - points to TBUFFR ($033C)
TAPE1_LO                      = $b2             ; 
TAPE1_HI                      = $b3             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; transmitter storage
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE : load routines flag when they are ready to receive data bytes
; --------------------------------------------------------------------------------------------------------------------- ;
SNSW1                       = $b4               ; Flag: TAPE  : byte sync switch (leader/data flag)
SNSW1_OFF                     = $00             ;             : $00 - TAPE byte sync switch off - wait for start of data block
SNSW1_ON                      = $01             ;             : $xx - TAPE byte sync switch on  - reading data from block
; --------------------------------------------------------------------------------------------------------------------- ;
; RS232: transmit bit count / timer enable flag / parity and stop bit manipulation
; --------------------------------------------------------------------------------------------------------------------- ;
BITTS                       = SNSW1             ;       RS-232: various uses
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE : indicate the part of a block currently being read
; --------------------------------------------------------------------------------------------------------------------- ;
DIFF                        = $b5               ; Flag: TAPE  : end of a leader segment has been reached (leader completed)
DIFF_YES                      = $00             ;             : $00 - word marker at the end of a leader has been read
                                                ;             :       data bytes are being read from the block
DIFF_NO                       = $01             ;             : $xx - tape is before a block of data
                                                ;             :       waiting for a word marker at the end of the leader bits
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 next bit to be sent or EOT
; --------------------------------------------------------------------------------------------------------------------- ;
NXTBIT                      = DIFF              ;       RS-232: next bit to be sent
NXTBIT_SEND                   = %00000100       ;             : bit_2 holds the next bit to be send
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE accumulator for number of read errors
; --------------------------------------------------------------------------------------------------------------------- ;
PRP                         = $b6               ; Flag: TAPE  : READ error / end of block flag
PRP_OK                        = $00             ;             :   byte has been read successfully
PRP_ERR                       = $01             ;             :   byte has not been read successfully
PRP_EOB                       = %10000000       ;       TAPE  : write end of block
; --------------------------------------------------------------------------------------------------------------------- ;
; RS232 byte disassembly area ro each byte to be sent from the xmit buffer pointed to by [ROBUF]
; --------------------------------------------------------------------------------------------------------------------- ;
RODATA                        = PRP             ;       RS-232: output byte buffer (sent out bit by bit)
; --------------------------------------------------------------------------------------------------------------------- ;
; storage for the current I/O operation (current file)
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of chars in filename
;   disk  filenames len = 01 to  16 chars - a disk file is always referenced by its name
;   TAPE  filenames len = 00 to 187 chars - a name longer 16 chars will be truncated by the "SEARCHING"/"FOUND" msgs
;                                           but will still be present with its full length on the TAPE
;   RS232 filenames len = 00 to  04 chars - pseudo filename represents BAUD RATE/BYTE SIZE/PROTOKOLL/PARITY - copied to M51CTR-M51AJB
; --------------------------------------------------------------------------------------------------------------------- ;
FNLEN                       = $b7               ;       filename length
; --------------------------------------------------------------------------------------------------------------------- ;
; Current logical file number being used
;   range $01-$ff
;   if .GE. $80 a <LF> char is sent to the file following any <CR> chars (see BASIC routine CRDO)
;   primarily an index into
;     LAT - File number table
;     FAT - Device number table
;     SAT - Secondary address table
; --------------------------------------------------------------------------------------------------------------------- ;
LA                          = $b8               ;       logical file number
; --------------------------------------------------------------------------------------------------------------------- ;
; Current secondary address being used
; --------------------------------------------------------------------------------------------------------------------- ;
SA                          = $b9               ;       secondary address
; --------------------------------------------------------------------------------------------------------------------- ;
; any device which can have more than one file open at the same time
; distinguishes between these files by using the SA when OPENing a disk file
;
;   SCREEN   - ignores a SA
;   KEYBOARD - ignores a SA
;   RS232C   -       0
;   DISK     - save: 0 = BASIC file from the current BASIC start address
;            -       1 = PGM file from given address
;            - load: 0 = BASIC file to the current BASIC start address
;            -       1 = PGM file to its saved address
;   PRINTER  -       0 = capital letters/gfx symbols
;            -       7 = capital letters/small Letters
;   TAPE     - open: 0 = READ
;            -       1 = WRITE
;            -       2 = WRITE followed by an EOT (End Of Tape) mark on CLOSE
;            - save: 0 = an EVEN secondary address
;                          causes a tape ID header of 1 - indicates a relocatable program
;            -               file will load at the current BASIC start address unless the LOAD uses a SA of 1
;                            then it will be loaded at the address specified in the header
;            -       1 = an ODD secondary address
;                          causes a tape ID header of 3 - indicates a non relocatable program
;            -               PGM file will always load at the address specified in the header
;            - load: 0 = BASIC file at current BASIC start address
;            -       1 = PGM file to its saved address
; --------------------------------------------------------------------------------------------------------------------- ;
SA_RELOC                      = $00             ;       DISK: BASIC file at current BASIC start address (default)
                                                ;       TAPE: an even SA results in a relocatable program - BASIC file at $0801 (default)
SA_FIX                        = $01             ;       DISK: PGM file at the address specified in the files PRG_LOAD_ADR
                                                ;       TAPE: an odd  SA results in a non relocatable program - PGM file
                              
SA_CHANNEL_READ               = $00             ;       LOAD and DIR read channel (reserved)
SA_CHANNEL_WRITE              = $01             ;       SAVE channel              (reserved)
SA_CHANNEL_DATA               = $02     ; - $0e ;       DATA channels             (free)
SA_CHANNEL_CMD                = $0f             ;       COMMAND channel           (reserved)
                              
SA_TAPE_READ                  = $00             ;       open file for READ
SA_TAPE_WRITE                 = $01             ;       open file for WRITE
SA_TAPE_WRITE_EOT             = $02             ;       open file for WRITE - write EOT marker on CLOSE
                              
SA_PRT_UC_GFX                 = $00             ;       capital letters/gfx symbols
SA_PRT_UC_LC                  = $07             ;       capital letters/small Letters (default)
; --------------------------------------------------------------------------------------------------------------------- ;
; Serial Bus Control Codes if in Command Mode (Serial Attention line held LO)
;   the IEEE has two modes of operation
;     Select mode - the C64 calls all devices and asks for a specific device to remain connected after the call
;                   invoked by the use of the "Attention" or ATN control line
;     Data mode   - the actual information is transmitted
; 
;   in Select mode any device can called in but there may be the need to do more before data transmission
;     - several disk files are in progress (writing some/reading others)
;     - for the disk device still need to specify which "part" of the disk you want to reach (subchannel 3/subchannel 15/...)
;       for this a "secondary address" is used
;         - usually signals a subsystem within a specific device
;         - goes in as part of the command during Select mode
; --------------------------------------------------------------------------------------------------------------------- ;
SA_MASK_CMD                 = %11100000         ;       IEE control code part
SA_MASK_CHANNEL             = %00001111         ;       channel number ($00-$0f) for OPEN/CLOSE
SA_MASK_DEVICE              = %00011111         ;       device  number ($00-$1e) for LISTEN/TALK ($1f disallowed)
                            
SA_LISTEN                   = $20       ; - $3e ;       $20 + device number ($00-$1e)
SA_UNLISTEN                 = $3f               ;             all devices
SA_TALK                     = $40       ; - $5e ;       $40 + device number ($00-$1e)
SA_UNTALK                   = $5f               ;             all devices
      
SA_DATA                     = $60       ; - $6f ;       $60 + SA or channel number            ($00-$0f)
SA_DATA_MASK                = %00011111         ;       
                                  
SA_CLOSE                    = $e0       ; - $ef ;       $e0 + SA or channel number for CLOSE  ($00-$0f)
SA_OPEN                     = $f0       ; - $ff ;       $f0 + SA or channel number for OPEN   ($00-$0f)
; --------------------------------------------------------------------------------------------------------------------- ;
; Current device number being used
; --------------------------------------------------------------------------------------------------------------------- ;
FA                          = $ba               ;       primary address (device number)
FA_KEYBOARD                   = DEVNUM_KEYBOARD ;       $00      
FA_TAPE                       = DEVNUM_TAPE     ;       $01      
FA_RS232C                     = DEVNUM_RS232C   ;       $02      
FA_SCREEN                     = DEVNUM_SCREEN   ;       $03      
FA_PRINTER                    = DEVNUM_PRINTER  ;       $04 - $05
FA_PLOTTER                    = DEVNUM_PLOTTER  ;       $06 - $07
FA_DISK                       = DEVNUM_DISK     ;       $08 - $0f
FA_IEE                        = DEVNUM_IEE      ;       $04 - $1e - any other type of serial device
FA_RESERVED                   = DEVNUM_RESERVED ;       $1f      
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to current filename
; --------------------------------------------------------------------------------------------------------------------- ;
FNADR                       = $bb               ; Ptr : address of file name
FNADR_LO                      = $bb             ; 
FNADR_HI                      = $bc             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Tape byte just read / shifting byte currently being written
; --------------------------------------------------------------------------------------------------------------------- ;
OCHAR                       = $bd               ;       most recently byte written/read to/from TAPE
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 send parity calculation work byte
;   indicate whether an even or odd number of 1 bits have been sent in the current character
; --------------------------------------------------------------------------------------------------------------------- ;
ROPRTY                      = OCHAR             ;       RS-232: send parity buffer
; --------------------------------------------------------------------------------------------------------------------- ;
; Which copy of TAPE block remains to be read/written
;   flags which of the two images of the current block is currently being read/written
; --------------------------------------------------------------------------------------------------------------------- ;
FSBLK                       = $be               ; Flag: TAPE copies count
FSBLK_VERIFY                  = $00             ;       data   - verify copy - both copies of block are done
FSBLK_LOAD                    = $01             ;       data   - the last copy of block remains to save/load
FSBLK_HEADER                  = $02             ;       header - both copies of block remain to save/load
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE input byte buffer
; --------------------------------------------------------------------------------------------------------------------- ;
MYCH                        = $bf               ;       TAPE assembly storage for the byte being read bit by bit
; --------------------------------------------------------------------------------------------------------------------- ;
; Tape motor interlock switch
; 
; A non-zero value (only possibleo if some tape buttons are pressed down) prevents any change of the tape motor switch
;
; KEY4 of IRQ tests the TAPE buttons via the R6510_TAP_SENSE bit
;   no button pressed - CAS1 is set to CAS1_UNLOCK and R6510_TAP_MTR to R6510_TAP_MTR_OFF
;   a  button pressed - CAS1 is checked
;                       if CAS1_UNLOCK then turn on the TAPE motor
; 
; The TAPE motor can't be powered when no button is pressed or CAS1 contains CAS1_UNLOCK
;   When [CAS1] is set to any nonzero value (CAS1_LOCK) the R6510_TAP_MTR bit is not affected by the IRQ
;     So as long as a TAPE button is pressed the motor can be turned on and off changing bit R6510_TAP_MTR
;     To control the motor via software CAS1 must be set to a nonzero value (CAS1_LOCK) after a TAPE button has been pressed
; --------------------------------------------------------------------------------------------------------------------- ;
CAS1                        = $c0               ; Flag: TAPE motor interlock - control the R6510_TAP_MTR bit
CAS1_UNLOCK                   = $00             ;       motor is off/no TAPE key pressed
                                                ;       allow TAPE motor to be switched on if a TAPE key is pressed
CAS1_LOCK                     = $1f             ;       motor is on
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE/Serial pointer to the start of the I/O area
; --------------------------------------------------------------------------------------------------------------------- ;
STAL                        = $c1               ; Ptr : memory start address LO byte for tape/disk save/load 
STAH                        = $c2               ;       memory start address HI byte for tape/disk save/load
; --------------------------------------------------------------------------------------------------------------------- ;
; Work area find the lowest RAM by INITMEM / RAM test by TESTMEM
; --------------------------------------------------------------------------------------------------------------------- ;
TMP0                        = STAL              ; Ptr : memory adr during memory test
TMP0_LO                       = TMP0 + $00      ; 
TMP0_HI                       = TMP0 + $01      ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Work pointer KERNAL indirect vector table
; --------------------------------------------------------------------------------------------------------------------- ;
TMP2                        = $c3               ; Ptr : adr KERNAL indirect vector table VECTSS
TMP2_LO                       = $c3             ; 
TMP2_HI                       = $c4             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the RAM area being loaded
; --------------------------------------------------------------------------------------------------------------------- ;
MEMUSS                      = TMP2              ; Ptr : start address buffer for KERNAL LOAD ram
MEMUSS_LO                     = MEMUSS + $00    ; 
MEMUSS_HI                     = MEMUSS + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; KERNAL SCREEN editor
; --------------------------------------------------------------------------------------------------------------------- ;
; Page $00/$02 locations used by the KERNAL SCREEN editor
; --------------------------------------------------------------------------------------------------------------------- ;
; [DFLTN]   -       default (current) input  device number
; [DFLTO]   -       default (current) output device number
; [SAL/SAH] -       adr start line in SCREEN scrolling routine SCRLIN - text chars
; [EAL/EAH] -       adr start line in SCREEN scrolling routine SCRLIN - text colors
; [RVS]     - Flag: reverse mode
; [INDX]    - Idx : pointer to end of text on current logical line for input
; [LSXP]    -       current cursor INPUT logical line number - X-Pos
; [LSTP]    -       current cursor INPUT col - Y-Pos
; [BLNSW]   - Flag: cursor blink switch
; [BLNCT]   - Time: count down time for cursor blink toggle
; [GDBLN]   -       SCREEN code char under cursor for a restore if the cursor moves on
; [BLNON]   - Time: count down time for cursor blink toggle
; [CRSW]    - Flag: Input Origin from SCREEN or KEYBOARD - input versus get flag
; [PNT]     - Ptr : adr start of SCREEN line where the cursor is currently positioned
; [PNTR]    - Idx : cursor column on current SCREEN line
; [QTSW]    - Flag: <QUOTE> mode switch
; [LNMX]    -       current logical  SCREEN line max length ($27/$4f)
; [TBLX]    -       current physical SCREEN line number     ($00-$18)
; [DATA]    -       temp INPUT char/last OUTPUT char/CHECKSUM
; [INSRT]   -       number of spaces that has been opened up with the <INS> key
; [LDTB1]   -       SCREEN line link table
; [USER]    - Ptr : adr start of current physical SCREEN lines color RAM area
; COLOR     -       current char colour - active color nybble
; GDCOL     -       color under the cursor - char original color
; HIBASE    -       high byte base current SCREEN memory address ($04)
; MODE      - Flag: <C=><SHIFT> switch - toggles uppercase/graphics and lowercase/uppercase mode
; AUTODN    - Flag: auto scroll down
; --------------------------------------------------------------------------------------------------------------------- ;
; Matrix coordinate of last key pressed
; --------------------------------------------------------------------------------------------------------------------- ;
LSTX                        = $c5               ;       debounce: keyboard matrix value last key pressed
LSTX_NONE                     = $40             ;                 no key pressed - for othe values see [SFDX]
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of chars ($00-$0a) in the keyboard buffer queue
; --------------------------------------------------------------------------------------------------------------------- ;
NDX                         = $c6               ; Idx : keyboard buffer index
NDX_MAX                       = $0a             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag for reversed SCREEN chars
; --------------------------------------------------------------------------------------------------------------------- ;
RVS                         = $c7               ; Flag: reverse mode
RVS_OFF                       = $00             ;       reset with <CTRL><RVS-OFF> and <CARRIAGE RETURN>
RVS_ON                        = $12             ;       set   with <CTRL><RVS-ON>
RVS_UPPER                     = $40             ;       upper case/gfx char
RVS_REVERSE                   = $80             ;       reverse char
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to end of text on current logical line for input
;   Column number of the last nonblank character on the logical input line ($00-4f)
; --------------------------------------------------------------------------------------------------------------------- ;
INDX                        = $c8               ; Idx : INPUT <EOL> pointer - last non <SPACE> char on logical line
; --------------------------------------------------------------------------------------------------------------------- ;
; Current cursor INPUT logical X-Y position (line, column)
; --------------------------------------------------------------------------------------------------------------------- ;
LSXP                        = $c9               ;       current cursor INPUT logical line number - X-Pos
LSTP                        = $ca               ;       current cursor INPUT column number - Y-Pos
; --------------------------------------------------------------------------------------------------------------------- ;
; Matrix coordinate of current key pressed
; --------------------------------------------------------------------------------------------------------------------- ;
SFDX                        = $cb               ;       
SFDX_NONE                     = $40             ;       no key pressed
                                                ;       keyboard matrix value last key pressed
                                                ;       +-----+---------+-----+---------+-----+---------+-----+----------+-----+--------+ 
                                                ;       ! #   ! key     ! #   ! key     ! #   ! key     ! #   ! key      ! #   ! key    ! 
                                                ;       +-----+---------+-----+---------+-----+---------+-----+----------+-----+--------+  
                                                ;       ! $00 ! INS/DEL ! $10 ! 5       ! $20 ! 9       ! $30 ! £        ! $40 ! [NONE] ! 
                                                ;       ! $01 ! RETURN  ! $11 ! R       ! $21 ! I       ! $31 ! *        +-----+--------+  
                                                ;       ! $02 ! CSR_R   ! $12 ! D       ! $22 ! J       ! $32 ! ;        ! 
                                                ;       ! $03 ! F7      ! $13 ! 6       ! $23 ! 0       ! $33 ! CLR/HOME ! 
                                                ;       ! $04 ! F1      ! $14 ! C       ! $24 ! M       ! $34 ! SHFT_R   ! 
                                                ;       ! $05 ! F3      ! $15 ! F       ! $25 ! K       ! $35 ! =        ! 
                                                ;       ! $06 ! F5      ! $16 ! T       ! $26 ! O       ! $36 ! ↑        ! 
                                                ;       ! $07 ! CSR_D   ! $17 ! X       ! $27 ! N       ! $37 ! /        ! 
                                                ;       ! $08 ! 3       ! $18 ! 7       ! $28 ! +       ! $38 ! 1        ! 
                                                ;       ! $09 ! W       ! $19 ! Y       ! $29 ! P       ! $39 ! ←        ! 
                                                ;       ! $0a ! A       ! $1a ! G       ! $2a ! L       ! $3a ! CTRL     ! 
                                                ;       ! $0b ! 4       ! $1b ! 8       ! $2b ! –       ! $3b ! 2        ! 
                                                ;       ! $0c ! Z       ! $1c ! B       ! $2c ! .       ! $3c ! SPACE    ! 
                                                ;       ! $0d ! S       ! $1d ! H       ! $2d ! :       ! $3d ! C=       ! 
                                                ;       ! $0e ! E       ! $1e ! U       ! $2e ! @       ! $3e ! Q        ! 
                                                ;       ! $0f ! SHFT_L  ! $1f ! V       ! $2f ! ,       ! $3f ! RUN/STOP ! 
                                                ;       +-----+---------+-----+---------+-----+---------+-----+----------+
                                                ;       keyboard matrix values not placed here
                                                ;       SHIFT L   - $0f 
                                                ;       SHIFT R   - $34 
                                                ;       CTRL      - $3a 
                                                ;       COMMODORE - $3d 
; --------------------------------------------------------------------------------------------------------------------- ;
; Cursor blink switch
;   Cursor blink is turned off when there are chars in the keyboard buffer or when a program is running
; --------------------------------------------------------------------------------------------------------------------- ;
BLNSW                       = $cc               ; Flag: cursor blink enable (visibility switch)
BLNSW_ENAB                    = $00             ;       $00 - enabled
BLNSW_DISAB                   = $01             ;       $xx - disabled - a nonzero value turns the cursor blink off 
; --------------------------------------------------------------------------------------------------------------------- ;
; Cursor count down before blink
; --------------------------------------------------------------------------------------------------------------------- ;
BLNCT                       = $cd               ; Time: count down time for cursor blink toggle
BLNCT_MIN                     = $02             ; 
BLNCT_INIT                    = $0c             ; 
BLNCT_START                   = $14             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Char under cursor in SCREEN code
; --------------------------------------------------------------------------------------------------------------------- ;
GDBLN                       = $ce               ;       SCREEN code char under cursor for a restore if the cursor moves on
; --------------------------------------------------------------------------------------------------------------------- ;
; Cursor char blink status
; --------------------------------------------------------------------------------------------------------------------- ;
BLNON                       = $cf               ; Flag: cursor blink phase
BLNON_OFF                     = $00             ;       $00 - cursor off phase
BLNON_ON                      = $01             ;       $xx - cursor on  phase
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag input origin from SCREEN or keyboard / current input line length
; --------------------------------------------------------------------------------------------------------------------- ;
CRSW                        = $d0               ; Flag: Input Origin - input versus get flag
CRSW_KEYBOARD                = $00              ;       $00 - input from keyboard
CRSW_SCREEN                  = $01              ;       $xx - input from SCREEN  
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the start of the logical line the cursor is on
; --------------------------------------------------------------------------------------------------------------------- ;
PNT                         = $d1               ; Ptr : adr start of SCREEN line where the cursor is currently positioned
PNT_LO                        = $d1             ; 
PNT_HI                        = $d2             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Cursor position within the logical SCREEN line
; --------------------------------------------------------------------------------------------------------------------- ;
PNTR                        = $d3               ; Idx : cursor column on current SCREEN line
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag to indicate if within <QUOTE> marks - <QUOTE> mode
;   toggled every time <QUOTE> is typed in on a given line
;   CTRL chars ar replaced by their reversed equivalent
;   NOTE: the difference between <QUOTE> and <INSERT> mode
;         the <DEL> key will function normally in <QUOTE> mode while the <INS> key will leave a printed equivalent
; --------------------------------------------------------------------------------------------------------------------- ;
QTSW                        = $d4               ; Flag: <QUOTE> mode switch
QTSW_OFF                      = $00             ;       editor not in <QUOTE> mode
QTSW_ON                       = $01             ;       editor is  in <QUOTE> mode
; --------------------------------------------------------------------------------------------------------------------- ;
; Current SCREEN line logical length
; --------------------------------------------------------------------------------------------------------------------- ;
LNMX                        = $d5               ;       current logical  SCREEN line max length ($27/$4f)
; --------------------------------------------------------------------------------------------------------------------- ;
; Current physical SCREEN line number the cursor is on
; --------------------------------------------------------------------------------------------------------------------- ;
TBLX                        = $d6               ;       current physical SCREEN line number     ($00-$18)
; --------------------------------------------------------------------------------------------------------------------- ;
; ASCII value of the last key pressed
; --------------------------------------------------------------------------------------------------------------------- ;
DATA                        = $d7               ;       temp INPUT char/last OUTPUT char/CHECKSUM
; --------------------------------------------------------------------------------------------------------------------- ;
; INSERT mode - Number of outstanding inserts
;   the <INS> key
;     - shifts the line to the right (allocates another physical line to the logical line if necessary and possible)
;     - updates the SCREEN line length in [LNMX]
;     - adjusts the SCREEN line link table [LDTB1]
;   until the counted spaces here are filled the editor acts as if in <QUOTE> mode
;   NOTE: the difference between <INSERT> and <QUOTE> mode
;         the <DEL> key will leave a printed equivalent in <INSERT> mode while the <INS> key will insert spaces as normal
; --------------------------------------------------------------------------------------------------------------------- ;
INSRT                       = $d8               ;       number of spaces that has been opened up with the <INS> key
; --------------------------------------------------------------------------------------------------------------------- ;
; SCREEN line link table
; --------------------------------------------------------------------------------------------------------------------- ;
LDTB1                       = $d9   ; - $f2     ;       SCREEN line link table / line flags / endspace
LDTB1_LIN_1ST                 = %10000000       ; Flag: 1st (or only) half of a logical line
LDTB1_LIN_2ND                 = %01111111       ;     : 2nd           half of a logical line
LDTB1_PAGE                    = %00000011       ; Mask: logical line memory page number
LDTB1_EOT                     = $ff             ;     : end of table marker       
;                           = $d9   ; - $df     ;     : $84, $84, $84, $84, $84, $84, $84 ; init lines $00-$06
;                           = $e0   ; - $e5     ;     : $85, $85, $85, $85, $85, $85      ; init lines $07-$0c
;                           = $e6   ; - $ec     ;     : $86, $86, $86, $86, $86, $86, $86 ; init lines $0d-$13
;                           = $ed   ; - $f2     ;     : $87, $87, $87, $87, $87, $87      ; init lines $14-$19
;                           = $f3               ;     : $ff                               ; end of table (overwritten)
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to start of current physical SCREEN lines color map area
; --------------------------------------------------------------------------------------------------------------------- ;
USER                        = $f3               ; Ptr : adr current SCREEN editor colour RAM
USER_LO                       = $f3             ;     : synchronized with [PNT] in SCOLOR subroutine
USER_HI                       = $f4             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the keyboard table being used
; --------------------------------------------------------------------------------------------------------------------- ;
KEYTAB                      = $f5               ; Ptr : current keyboard decoding (keyscan) table
KEYTAB_LO                     = $f5             ;     : -------+--------------
KEYTAB_HI                     = $f6             ;     : tables ! content
;                                               ;     : -------+--------------
;                                               ;     : MODE1  ! unshifted chars
;                                               ;     : MODE2  ! shifted   chars
;                                               ;     : MODE3  ! C=        chars
;                                               ;     : CONTRL ! control   chars
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 - an open of the RS232 channel creates two buffers of $ff bytes length at top of memory
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 pointer to start of receiving buffer
; --------------------------------------------------------------------------------------------------------------------- ;
RIBUF                       = $f7               ; Ptr : RS-232 INPUT  buffer pointer
RIBUF_LO                      = $f7             ; 
RIBUF_HI                      = $f8             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; RS-232 pointer to the start of the transmitting buffer
; --------------------------------------------------------------------------------------------------------------------- ;
ROBUF                       = $f9               ; Ptr : RS-232 OUTPUT buffer pointer
ROBUF_LO                      = $f9             ; 
ROBUF_HI                      = $fa             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Four bytes of unused zero page space
; --------------------------------------------------------------------------------------------------------------------- ;
FREKZP                      = $fb   ; - $fe     ;       free zero page entry for User Programs
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC temporary area for floating point to ASCII conversion
; --------------------------------------------------------------------------------------------------------------------- ;
BASZPT                      = $ff               ;       BASIC: temp storage convert [FAC] to ASCII
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
LOFBUF                      = BASZPT            ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
FBUFFR                      = $0100 ; - $010a   ;       
; --------------------------------------------------------------------------------------------------------------------- ;
