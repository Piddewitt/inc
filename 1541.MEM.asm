; --------------------------------------------------------------------------------------------------------------------- ;
; VIC 1541 - Zeropage / Extended Zeropage / Stack / Vectors / Buffers
; --------------------------------------------------------------------------------------------------------------------- ;
SystemConstants             .include "1541.DOS.const.asm" ; system constant definitions
; --------------------------------------------------------------------------------------------------------------------- ;
ZP_DOS                      = $00               ;       Zeropage - JOB queue / Constants / Pointers / Work Area
; --------------------------------------------------------------------------------------------------------------------- ;
; JOBSTCC0 - JOBSTCC5                           ;       Interface Main Program - Disc Controller
;                                               ;         main program writes 
;                                               ;           - job command codes
;                                               ;           - TRACK/sector numbers of the block to be processed (if necessary)
;                                               ;         into the appropriate job cmd memory area
;                                               ;           - bit7 set   - job will be executed with the next interrupt
;                                               ;           - bit7 clear - bit0-bit6 contain the jobs status code
;                                               ;       
;                                               ;           Addresses and the assigned buffers
;                                               ;         +-----+-------+--------+-------------+
;                                               ;         ! JOB ! TRACK ! SECTOR !   BUFFER    !
;                                               ;         +-----+-------+--------+-------------+
;                                               ;         ! $00 !  $06  !  $07   ! $0300-$03ff !
;                                               ;         ! $01 !  $08  !  $09   ! $0400-$04ff !
;                                               ;         ! $02 !  $0a  !  $0b   ! $0500-$05ff !
;                                               ;         ! $03 !  $0c  !  $0d   ! $0600-$06ff !
;                                               ;         ! $04 !  $0e  !  $0f   ! $0700-$07ff !
;                                               ;         ! $05 !  $10  !  $11   ! -<no ram>-- !
; --------------------------------------------------------------------------------------------------------------------- ;
; Job Queue
; --------------------------------------------------------------------------------------------------------------------- ;
JOBS                        = $00               ;       command code
JOBS_0                        = $00             ;       Command code for BUFF0 - command and status registers: HDRS_0_TRA/HDRS_0_SEC
JOBS_1                        = $01             ;       Command code for BUFF1 - command and status registers: HDRS_1_TRA/HDRS_1_SEC
JOBS_2                        = $02             ;       Command code for BUFF2 - command and status registers: HDRS_2_TRA/HDRS_2_SEC
JOBS_3                        = $03             ;       Command code for BUFF3 - command and status registers: HDRS_3_TRA/HDRS_3_SEC
JOBS_4                        = $04             ;       Command code for BUFF4 - command and status registers: HDRS_4_TRA/HDRS_4_SEC
JOBS_5                        = $05             ;       Command code for BUFF5 - command and status registers: HDRS_5_TRA/HDRS_5_SEC - unused: no RAM

JOBS_FLAG_CODE                = %10000000       ; Flag: bit7=1 - job   code
JOBS_FLAG_ERROR               = %01111111       ; Flag: bit7=0 - error code
                              
JOBS_DRIVE_NUM                = %00000001       ;       bit0   - drive number
; --------------------------------------------------------------------------------------------------------------------- ;
JOBS_CODE_MASK                = %11110000       ;       bits 4-7: command  code
JOBS_CODE_READ                = %10000000       ;         $80 - Read   a sector
JOBS_CODE_WRITE               = %10010000       ;         $90 - Write  a sector
JOBS_CODE_VERIFY              = %10100000       ;         $a0 - Verify a sector
JOBS_CODE_SEEK                = %10110000       ;         $b0 - Seek   a sector - read in SECTOR header - fetch HEADER ID
JOBS_CODE_BUMP                = %11000000       ;         $c0 - Bump head - find TRACK 01
JOBS_CODE_JUMP                = %11010000       ;         $d0 - Exec program in buffer
JOBS_CODE_EXECUTE             = %11100000       ;         $e0 - Read in SECTOR and exec program in buffer
JOBS_CODE_HEADER              = %11110000       ;         $f0 - Read in SECTOR header
; --------------------------------------------------------------------------------------------------------------------- ;
JOBS_ERR_MASK                 = %00001111       ;       bits 0-3: error code
JOBS_ERR_DECODE               = %00000000       ;         $00 - Error during disk format     24, READ ERROR
JOBS_ERR_NONE                 = %00000001       ;         $01 - JOB completed successfully   00, OK
JOBS_ERR_NOHDR                = %00000010       ;         $02 - Header block not found       20, READ ERROR
JOBS_ERR_NOSYNC               = %00000011       ;         $03 - SYNC not found               21, READ ERROR
JOBS_ERR_NODATA               = %00000100       ;         $04 - Data block not found         22, READ ERROR
JOBS_ERR_CHECKSUM_DATA        = %00000101       ;         $05 - Data block checksum error    23, READ ERROR
JOBS_ERR_FORMAT               = %00000110       ;         $06 - Format error                 24, READ ERROR        (unused)
JOBS_ERR_VERIFY               = %00000111       ;         $07 - Verify error                 25, WRITE ERROR
JOBS_ERR_PROTECTED            = %00001000       ;         $08 - Disk write protected         26, WRITE PROTECT ON
JOBS_ERR_CHECKSUM_HDR         = %00001001       ;         $09 - Header block checksum error  27, READ ERROR
JOBS_ERR_LONGDATA             = %00001100       ;         $0a - Data block too long          28, READ ERROR        (unused)
JOBS_ERR_MISMATCH             = %00001011       ;         $0b - Id mismatch                  29, DISK ID MISMATCH
JOBS_ERR_NODISC               = %00001111       ;         $0f - Disk not inserted            74, DRIVE NOT READY
; --------------------------------------------------------------------------------------------------------------------- ;
; Header Table
; TRACKs and SECTORs to be used for the JOBS in the JOB queue
; TRACKs and SECTORs are not needed for BUMP or JUMP jobs
; --------------------------------------------------------------------------------------------------------------------- ;
HDRS                        = $06               ; Tab : TRACK/sector area for JOBS
HDRS_TRA                      = $06             ; 
HDRS_SEC                      = $07             ; 
                      
HDRS_0_TRA                    = $06             ;       BUFF0 TRACK
HDRS_0_SEC                    = $07             ;       BUFF0 sector
HDRS_1_TRA                    = $08             ;       BUFF1 TRACK
HDRS_1_SEC                    = $09             ;       BUFF1 sector
HDRS_2_TRA                    = $0a             ;       BUFF2 TRACK
HDRS_2_SEC                    = $0b             ;       BUFF2 sector
HDRS_3_TRA                    = $0c             ;       BUFF3 TRACK
HDRS_3_SEC                    = $0d             ;       BUFF3 sector
HDRS_4_TRA                    = $0e             ;       BUFF4 TRACK
HDRS_4_SEC                    = $0f             ;       BUFF4 sector
                              
HDRS_5_TRA                    = $10             ;       BUFF5 TRACK  - unused: no RAM
HDRS_5_SEC                    = $11             ;       BUFF5 sector - unused: no RAM
; --------------------------------------------------------------------------------------------------------------------- ;
; Master copy of disk ID (specified when disk was formatted) - updated with any JOBS_CODE_SEEK
; --------------------------------------------------------------------------------------------------------------------- ;
DSKID                       = $12               ;       drive #0 - expected sector header ID
DSKID_CHR1                    = $12             ; 
DSKID_CHR2                    = $13             ; 
                              
DSKID1                      = $14               ;       drive #1 - expected sector header ID                   (unused)
DSKID1_CHR1                   = $14             ; 
DSKID1_CHR2                   = $15             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Image of current HEADER - stored on disk in the opposite sequence
; --------------------------------------------------------------------------------------------------------------------- ;
HEADER                      = $16               ;       header block - contains the header of the sector last read from disk
HEADER_CHR1                   = $16             ;       header block ID     - 1st ID char
HEADER_CHR2                   = $17             ;       header block ID     - 2nd ID char
HEADER_TRK                    = $18             ;       header block TRACK  - TRACK  number from header of sector last read from disk
HEADER_SEC                    = $19             ;       header block sector - sector number from header of sector last read from disk
HEADER_CRC                    = $1a             ;       header block parity - checksum      from header of sector last read from disk
; --------------------------------------------------------------------------------------------------------------------- ;
ACTJOB                      = $1b               ;       controllers active job                                 (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag for  disk change
; --------------------------------------------------------------------------------------------------------------------- ;
WPSW                        = $1c               ; Flag: drive #0 - disk change indicator
WPSW_FLAG                     = %00000001       ; 
WPSW_SAME                     = %00000000       ;         disk not changed
WPSW_CHANGED                  = $00000001       ;         disk changed (statuts write protect photocell has changed)
                            
WPSW1                       = $1d               ; Flag: drive #1 - disk change indicator                       (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag for write protect sense
; --------------------------------------------------------------------------------------------------------------------- ;
LWPT                        = $1e               ; Flag: drive #0 - previous state of write protect photocell (write protect sense)
LWPT_ON                       = %00010000       ; 
LWPT_OFF                      = %11101111       ; 
LWPT1                       = $1f               ; Flag: drive #1 - previous state of write protect photocell   (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; Current drive status
; --------------------------------------------------------------------------------------------------------------------- ;
DRVST                       = $20               ; Tab : drives current status (disk and step motor)
DRVST_0                       = $20             ;       drive #0 - disk drive status
                              
DRVST_CLEAR                   = %00000000       ;       reset status
DRVST_MASK                    = %11110000       ; 
                              
DRVST_MOTOR_STOPS             = %00010000       ;       shut down drive motor    (0 = yes, 1 = no)
DRVST_MOTOR_STOPS_NO            = %00010000     ; 
DRVST_MOTOR_STOPS_YES           = %11101111     ; 
DRVST_MOTOR_RUNS              = %00100000       ;       drive motor is on        (1 = yes, 0 = no)
DRVST_MOTOR_RUNS_YES            = %00100000     ; 
DRVST_MOTOR_RUNS_NO             = %11011111     ; 
DRVST_HEAD_STEPS              = %01000000       ;       read/write head stepping (1 = yes, 0 = no)
DRVST_HEAD_STEPS_YES            = %01000000     ; 
DRVST_HEAD_STEPS_NO             = %10111111     ; 
DRVST_MOTOR_ACCELERATE        = %10000000       ;       drive motor accelerating (1 = yes, 0 = no)
DRVST_MOTOR_ACCELERATE_YES      = %10000000     ; 
DRVST_MOTOR_ACCELERATE_DONE     = %01111111     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
                                                ;       bits 7 6 5 4  3 2 1 0
                                                ;            ! ! ! !
                                                ;            ! ! ! '-- timeout
                                                ;            ! ! '---- running
                                                ;            ! '------ stepping
                                                ;            '-------- accelerating
                                                ;       
                                                ;       $00 - ........ no drive active
                                                ;       $10 - ...#.... stopping
                                                ;       $20 - ..#..... running
                                                ;       $30 - ..##.... running and timeout
                                                ;       $50 - .#.#.... stepping and stopping
                                                ;       $60 - .##..... stepping and running
                                                ;       $80 - #....... accelerating
                                                ;       $a0 - #.#..... accelerating and running
                                                ; --------------------------------------------------------------------- ;
DRVST_1                     = $21               ;       drive #1 - disk drive status                           (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; TRACK currently under R/W head
; --------------------------------------------------------------------------------------------------------------------- ;
DRVTRK                      = $22               ;       drive #0 - current TRACK under head
DRVTRK1                     = $23               ;       drive #1 - current TRACK under head                    (unused) but: see next line
; --------------------------------------------------------------------------------------------------------------------- ;
SLFLAG                      = $23               ; Flag: serial bus communication speed (0=1541 /<>0=1540)
SLFLAG_C64                    = $00             ;         C64    mode - lower speed (extra waits are needed as compensation for the delays caused by sprite DMA in the host)
SLFLAG_VC20                   = $01   ; - $ff   ;         VIC-20 mode - higher speed ($01-$ff)
; --------------------------------------------------------------------------------------------------------------------- ;
; Scratch Pad Area of GCR conversion / storage for BIN -> GCR conversions
; --------------------------------------------------------------------------------------------------------------------- ;
STAB                        = $24               ;       storage table for BIN --> GCR conversion
STAB_X                      = $2d               ; 
STAB_LEN                    = STAB_X - STAB - $01 ;     $09 ($00 - $08)
; --------------------------------------------------------------------------------------------------------------------- ;
; Temporary storage of pointers
; --------------------------------------------------------------------------------------------------------------------- ;
SAVPNT                      = $2e               ; Ptr : current byte in buffer during GCR-encoding/decoding
SAVPNT_LO                     = $2e             ; 
SAVPNT_HI                     = $2f             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
BUFPNT                      = $30               ; Ptr : start of currently active buffer
BUFPNT_LO                     = $30             ; 
BUFPNT_HI                     = $31             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
HDRPNT                      = $32               ; Ptr : TRACK and sector registers of current buffer
HDRPNT_TT                     = $32             ; Ptr : active TRACK
HDRPNT_SS                     = $33             ; Ptr : active sector
; --------------------------------------------------------------------------------------------------------------------- ;
GCRPNT                      = $34               ; Ptr : last converted byte during GCR-encoding/decoding
; --------------------------------------------------------------------------------------------------------------------- ;
GCRERR                      = $35               ;       indicate GCR error code                                (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
BYTCNT                      = $36               ;       byte counter during GCR-encoding/decoding
; --------------------------------------------------------------------------------------------------------------------- ;
BITCNT                      = $37               ;       bit counter                                            (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; Data block ID
; --------------------------------------------------------------------------------------------------------------------- ;
BID                         = $38               ;       ID byte of data block
BID_DFLT                      = $07             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Header block ID
; --------------------------------------------------------------------------------------------------------------------- ;
HBID                        = $39               ;       ID byte of block header
HBID_DFLT                     = $08             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Data/header checksum
; --------------------------------------------------------------------------------------------------------------------- ;
CHKSUM                      = $3a               ;       computed data or header checksum
; --------------------------------------------------------------------------------------------------------------------- ;
HINIB                       = $3b               ;                                                              (unused)
BYTE                        = $3c               ;                                                              (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
DRIVE                       = $3d               ;       drive number - always $00 on 1541
DRIVE_0                       = $00             ; 
DRIVE_1                       = $01             ;                                                              (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
CDRIVE                      = $3e               ;       current (active) drive number
CDRIVE_0                      = $00             ; 
CDRIVE_1                      = $01             ;                                                              (unused)
CDRIVE_NONE                   = $ff             ;       no active drive: motor is off - must spin up before seeking
; --------------------------------------------------------------------------------------------------------------------- ;
; Position of last JOB in JOB queue (0-5)
; --------------------------------------------------------------------------------------------------------------------- ;
JOBN                        = $3f               ;       current JOB number (buffer num for disk controller)
JOBN_0                        = $00             ; 
JOBN_1                        = $01             ; 
JOBN_2                        = $02             ; 
JOBN_3                        = $03             ; 
JOBN_4                        = $04             ; 
JOBN_5                        = $05             ;       buffer #5 does not exist                               (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
TRACC                       = $40               ; Work: TRACK number
; --------------------------------------------------------------------------------------------------------------------- ;
; Position of next job in job queue (0-5)
; --------------------------------------------------------------------------------------------------------------------- ;
NXTJOB                      = $41               ;       position of next job in queue
NXTJOB_0                      = $00             ; 
NXTJOB_1                      = $01             ; 
NXTJOB_2                      = $02             ; 
NXTJOB_3                      = $03             ; 
NXTJOB_4                      = $04             ; 
NXTJOB_5                      = $05             ;       buffer #5 does not exist                               (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; Next TRACK to move head to
; --------------------------------------------------------------------------------------------------------------------- ;
NXTRK                       = $42               ;       destination (next) TRACK to move head to
; --------------------------------------------------------------------------------------------------------------------- ;
; SECTOR counter of format routine
; --------------------------------------------------------------------------------------------------------------------- ;
SECTR                       = $43               ;       max number of SECTORs current TRACK for formatting
; --------------------------------------------------------------------------------------------------------------------- ;
; Temp workspace
; --------------------------------------------------------------------------------------------------------------------- ;
WORK                        = $44               ;       scratch pad
; --------------------------------------------------------------------------------------------------------------------- ;
; Temporary storage of job code
; --------------------------------------------------------------------------------------------------------------------- ;
JOB                         = $45               ;       temp storage of JOB code
JOB_READ                      = %00000000       ;         JOB code read
JOB_WRITE                     = %00010000       ;         JOB code write
JOB_VERIFY                    = %00100000       ;         JOB code verify
JOB_SEEK_SECTOR               = %00110000       ;         JOB code seek a SECTOR
JOB_BUMP                      = %01000000       ;         JOB code bump
JOB_NON_EXISTENT              = %01010000       ;         JOB code ???
JOB_EXEC_PGM                  = %01100000       ;         JOB code exec program in buffer
JOB_FORMAT                    = %01110000       ;         JOB code format
; --------------------------------------------------------------------------------------------------------------------- ;
CTRACK                      = $46               ;                                                              (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; Data block ID ($07)
; --------------------------------------------------------------------------------------------------------------------- ;
DBID                        = $47               ;       data block ID code
                                                ;         - init to DBID_DFLT ($07) on reset drive
                                                ;         - may be changed
                                                ;           - write/read data blocks with different data block ID codes
                                                ;         - 1st nibble of the data block ID code should always be a zero ($0-)
                                                ;           otherwise the controller will have difficulty detecting the 
                                                ;           end of the SYNC mark and the start of the DBID
                                                ;       if a sector is read whose DBID is different from the value stored here
                                                ;       the disk controller puts JOBS_ERR_NODATA ($04) in the job queue and
                                                ;       the drive will report a #22 error (DATA BLOCK NOT FOUND)
DBID_DFLT                     = $07             ;       default
DBID_MIN                      = $00             ;       allowed values: $00-$0f
DBID_MAX                      = $0f             ;       allowed values: $00-$0f
; --------------------------------------------------------------------------------------------------------------------- ;
; Timer for head acceleration
; --------------------------------------------------------------------------------------------------------------------- ;
ACLTIM                      = $48               ;       acceleration time delay (counter head R/W movement)
                                                ;         - timer for acceleration of head movement
; --------------------------------------------------------------------------------------------------------------------- ;
; Temporary storage of stack pointer
; --------------------------------------------------------------------------------------------------------------------- ;
SAVSP                       = $49               ;       temp save of stack pointer
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of steps to move the head to get to the desired TRACK
; --------------------------------------------------------------------------------------------------------------------- ;
STEPS                       = $4a               ;       number of steps to move head to desired TRACK
                                                ;         $00-$7f - move head out (from disk centre)
                                                ;         $80-$ff - move head in  (to disk centre)
STEPS_BUMP                    = $a4             ;                   step 45 TRACKs inwards ($ff - (2 * 46))
; --------------------------------------------------------------------------------------------------------------------- ;
; temporary storage
; --------------------------------------------------------------------------------------------------------------------- ;
TMP                         = $4b               ;       retry counter for reading sector header / temporary storage during seeking
; --------------------------------------------------------------------------------------------------------------------- ;
; Last sector read
; --------------------------------------------------------------------------------------------------------------------- ;
CSECT                       = $4c               ;       current sector
; --------------------------------------------------------------------------------------------------------------------- ;
; Next sector to service
; --------------------------------------------------------------------------------------------------------------------- ;
NEXTS                       = $4d               ;       next sector to read
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to GCR source buffer to be converted to BIN .hbu
; --------------------------------------------------------------------------------------------------------------------- ;
NXTBF                       = $4e               ; Ptr : HI byte - GCR source buffer to be converted to BIN
                                                ;           GCR bytes in the overflow buffer are translated 1st
                                                ;           points to the buffer that holds the rest of them
NXTPNT                      = $4f               ; Off : LO byte - offset next GCR source byte location in buffer
; --------------------------------------------------------------------------------------------------------------------- ;
; Indicate data in the currently active buffer still in GCR form
; --------------------------------------------------------------------------------------------------------------------- ;
GCRFLG                      = $50               ; Flag: some buffer data still in GCR-encoded form
GCRFLG_OFF                    = $00             ;         Data in normal form
GCRFLG_GCR                    = $01   ; - $ff   ;         Data in GCR-encoded form - must be decoded
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of the TRACK currently being formatted
; --------------------------------------------------------------------------------------------------------------------- ;
FTNUM                       = $51               ;       current TRACK number for FORMAT
FTNUM_MIN                     = $01             ; 
FTNUM_MAX                     = $24             ;       36
FTNUM_END                     = $ff             ; Flag: End of Format
; --------------------------------------------------------------------------------------------------------------------- ;
; Staging area for the 4 BIN bytes being converted to GCR (PUT4BG) or from GCR (GET4BG)
; --------------------------------------------------------------------------------------------------------------------- ;
BTAB                        = $52               ; Tab : BIN temp area for 4 data bytes during GCR-BIN encoding/decoding
BTAB_0                        = $52             ; 
BTAB_1                        = $53             ; 
BTAB_2                        = $54             ; 
BTAB_3                        = $55             ; 
BTAB_X                        = BTAB_3          ; 
BTAB_LEN                    = BTAB_X - BTAB     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Staging area for the 5 GCR bytes being converted from BIN (PUT4BG) or to BIN (GET4BG)
; --------------------------------------------------------------------------------------------------------------------- ;
GTAB                        = $56               ; Tab : GCR temp area for data nybbles/5 GCR bytes during GCR-BIN encoding/decoding
GTAB_0                        = $56             ; 
GTAB_1                        = $57             ; 
GTAB_2                        = $58             ; 
GTAB_3                        = $59             ; 
GTAB_4                        = $5a             ; 
GTAB_5                        = $5b             ; 
GTAB_6                        = $5c             ; 
GTAB_7                        = $5d             ; 
GTAB_X                        = GTAB_7          ; 
GTAB_LEN                    = GTAB_X - GTAB     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of steps to accelerate or decelerate when stepping the head
; --------------------------------------------------------------------------------------------------------------------- ;
AS                          = $5e               ;       acceleration/deceleration number of steps (half TRACKs)
AS_DFLT                       = $04             ;       twice this value must be less than value of MINSTP
; --------------------------------------------------------------------------------------------------------------------- ;
; Acceleration/deceleration factor
; --------------------------------------------------------------------------------------------------------------------- ;
AF                          = $5f               ;       acceleration/deceleration factor
AF_DFLT                       = $04             ;       value of DSKCNT(T1LH2) plus/minus value of AS times
                                                ;       must not be: too low  – below ~12-20 (depends on drive mechanics)
                                                ;                    too high – above 255
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of steps left to accelerate/decelerate when stepping the head
; --------------------------------------------------------------------------------------------------------------------- ;
ACLSTP                      = $60               ;       number of steps left to accelerate/decelerate
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of steps left to step the head in fast stepping (RUN) mode
; --------------------------------------------------------------------------------------------------------------------- ;
RSTEPS                      = $61               ;       number of steps left in RUN mode
; --------------------------------------------------------------------------------------------------------------------- ;
; pointer to call the proper stepper motor routine
; --------------------------------------------------------------------------------------------------------------------- ;
NXTST                       = $62               ; Ptr : head stepping routine 
NXTST_LO                      = $62             ;       normally point to INACT - head stepping control
NXTST_HI                      = $63             ;     
; --------------------------------------------------------------------------------------------------------------------- ;
; Minimum steps for the head to move to make the use of the fast stepping mode useful
; If fewer steps needed use the slow stepping mode
; --------------------------------------------------------------------------------------------------------------------- ;
MINSTP                      = $64               ;       minimum number of steps required for fast stepping (RUN) mode
MINSTP_DFLT                   = $c8             ;       200
; --------------------------------------------------------------------------------------------------------------------- ;
;UIPNT                      = $65               ; Ptr : warm start ('UI' command) routine [$EB22]
;UIPNT_LO                     = $65             ; 
;UIPNT_HI                     = $66             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to start of NMI routine (DIAGOK)
; --------------------------------------------------------------------------------------------------------------------- ;
VNMI                       = $65                ; Ptr : warm start ('UI' command) routine [$EB22]
VNMI_LO                      = $65              ;       --< all same name as in C64 mapping >-- use UIPNT instead to avoid conflicts
VNMI_HI                      = $66              ; 
; --------------------------------------------------------------------------------------------------------------------- ;
NMIFLG                      = $67               ; Flag: NMI in progress
; --------------------------------------------------------------------------------------------------------------------- ;
AUTOFG                      = $68               ; Flag: enable/disable automatic disk init on ID MISMATCH (read BAM)
AUTOFG_YES                    = $00             ; 
AUTOFG_NO                     = $01             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Sector increment for use by FNDNXT routine
; --------------------------------------------------------------------------------------------------------------------- ;
SECINC                      = $69               ;       soft interleave - distance (in sectors) for allocating the next sector for files
SECINC_DIR                    = $03             ;         DIRECORY interleave
SECINC_FILE                   = $0a             ;         FILE     interleave
; --------------------------------------------------------------------------------------------------------------------- ;
; Counter for error recovery (number of attempts so far)
; --------------------------------------------------------------------------------------------------------------------- ;
REVCNT                      = $6a               ;       number of retries on DOS commands in case of an error
REVCNT_DFLT                   = $05             ;       default
REVCNT_MASK                   = %00111111       ; 
REVCNT_AHT                    = %01000000       ; Flag: head is on full TRACK
REVCNT_AHT_NO                 = %10111111       ;       head is on adjacent half TRACK
REVCNT_BUMP                   = %10000000       ; Flag: bump head is on
REVCNT_BUMP_NO                = %01111111       ;       bump head is off
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer table adresses user commands (UBLOCK)
; --------------------------------------------------------------------------------------------------------------------- ;
USRJMP                      = $6b               ; Ptr : start of user jump table for 'Ux' commands
USRJMP_LO                     = $6b             ; 
USRJMP_HI                     = $6c             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer start of BAM bitmap
; --------------------------------------------------------------------------------------------------------------------- ;
BMPNT                       = $6d               ; Ptr : start of BAM bitmap BUFF1 - set when a disk is initialized
BMPNT_LO                      = $6d             ; 
BMPNT_HI                      = $6e             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Temporary Work Area
; --------------------------------------------------------------------------------------------------------------------- ;
TEMP                        = $6f               ; 
T0                            = $6f             ; Ptr : address m & B commands HI      
T1                            = $70             ; Ptr : address m & B commands LO      
T2                            = $71             ; 
T3                            = $72             ; 
T4                            = $73             ; 
T5                            = $74             ; 
TEMP_X                        = T5              ; 
TEMP_LEN                    = TEMP_X - TEMP     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
IP                          = $75               ; Ptr : indirect current byte during memory test
                                                ;       exec address current 'Ux' user command
IP_LO                         = $75             ; 
IP_HI                         = $76             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
LSNADR                      = $77               ;       LISTENer address (device number + $20) - $28 on reset = unit #8
LSNADR_DFLT                   = $28             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
TLKADR                      = $78               ;       TALKer   address (device number + $40) - $48 on reset = unit #8
TLKADR_DFLT                   = $48             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
LSNACT                      = $79               ; Flag: active LISTENer
LSNACT_YES                    = $01   ; - $ff   ;         a LISTEN command currently active
LSNACT_NO                     = $00             ;         no LISTEN command active
; --------------------------------------------------------------------------------------------------------------------- ;
TLKACT                      = $7a               ; Flag: active TALKer
TLKACT_YES                    = $01   ; - $ff   ;         a TALK command currently active
TLKACT_NO                     = $00             ;         no TALK command active
; --------------------------------------------------------------------------------------------------------------------- ;
ADRSED                      = $7b               ; Flag: addressing mode                                        (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; Attention pending flag
; --------------------------------------------------------------------------------------------------------------------- ;
ATNPND                      = $7c               ; Flag: ATN pending - still receiving from serial bus
ATNPND_YES                    = $01   ; - $ff   ;         ATN signal arrived
ATNPND_NO                     = $00             ;         ATN inactive
ATNACT                      = $7d               ; Flag: end of command (6502 in attention mode)
ATNACT_YES                    = $00             ;         Command fully arrived - ATN became inactive
ATNACT_NO                     = $01   ; - $ff   ;         Command still transferring
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag a program was already accessed - used when opening '*'
; --------------------------------------------------------------------------------------------------------------------- ;
PRGTRK                      = $7e               ; Flag: TRACK number of previously opened file 
PRGTRK_NONE                   = $00             ;         no file has been opened yet
PRGTRK_YES                    = $01   ; - $ff   ;         a  file has been opened before    
; --------------------------------------------------------------------------------------------------------------------- ;
DRVNUM                      = $7f               ;       current drive number (always 0 for 1541)
DRVNUM_MASK                   = %00000001       ; 
DRVNUM_BAD                    = %10000000       ; 
; --------------------------------------------------------------------------------------------------------------------- ;
TRACK                       = $80               ;       current TRACK number  ($00 after use)
; --------------------------------------------------------------------------------------------------------------------- ;
SECTOR                      = $81               ;       current sector number ($00 after use)
; --------------------------------------------------------------------------------------------------------------------- ;
; Logical index
; --------------------------------------------------------------------------------------------------------------------- ;
LINDX                       = $82               ; Idx : current channel number
LINDX_MASK                    = %00111111       ;         all buffers
LINDX_0                       = $00             ;         buffer #00
LINDX_1                       = $01             ;         buffer #01
LINDX_2                       = $02             ;         buffer #02
LINDX_3                       = $03             ;         buffer #03
LINDX_4                       = $04             ;         buffer #04
LINDX_5                       = $05             ;         buffer #05 - error message
; --------------------------------------------------------------------------------------------------------------------- ;
; Current secondary address
; --------------------------------------------------------------------------------------------------------------------- ;
SA                          = $83               ;       current secondary address
SA_MASK                       = %00001111       ; 
SA_MAX                        = LINTAB_LEN      ; 
SA_LOAD                       = %00000000       ; 
SA_SAVE                       = %00000001       ; 
SA_CMD                        = LINTAB_NUM_CMD  ;         15 - command channel
SA_ERR                        = LINTAB_NUM_ERROR;         16 - error channel
SA_READ                       = LINTAB_NUM_READ ;         17 - internal read
SA_WRITE                      = LINTAB_NUM_WRITE;         18 - internal write
; --------------------------------------------------------------------------------------------------------------------- ;
; Original secondary address
; --------------------------------------------------------------------------------------------------------------------- ;
ORGSA                       = $84               ;       original secondary address
ORGSA_ID                      = %01100000       ;       id: valid secondary address = $60 + num($01-$0f)
ORGSA_DFLT                    = ORGSA_ID  | ORGSA_CMD ; $6f - command channel
                              
ORGSA_MASK                    = %00001111       ; 
ORGSA_LOAD_BASIC              = %00000000       ;       read data to BASIC start
ORGSA_LOAD_ABS                = %00000001       ;       read data to address stored in PRG_LOAD_ADR of the PRG file
                              
ORGSA_CMD                     = %00001111       ;       $0f (15) - command channel
                              
ORGSA_FLAG_OC                 = %10000000       ;       flag OPEN/CLOSE
                              
ORGSA_MASK_OC                 = %11110000       ;       mask OPEN/CLOSE commands
ORGSA_OPEN                    = %11110000       ; 
ORGSA_CLOSE                   = %11100000       ; 
; --------------------------------------------------------------------------------------------------------------------- ;
DATA                        = $85               ;       temporary (current) data byte
R0                          = $86               ;       temporary result
R1                          = $87               ;       temporary result
R2                          = $88               ;       temporary result
R3                          = $89               ;       temporary result
R4                          = $8a               ;       temporary result
; --------------------------------------------------------------------------------------------------------------------- ;
; Result Area                     
; --------------------------------------------------------------------------------------------------------------------- ;
RESULT                      = $8b               ; 
RESULT_0                      = $8b             ; 
RESULT_1                      = $8c             ; 
RESULT_2                      = $8d             ; 
RESULT_3                      = $8e             ; 
RESULT_X                      = RESULT_3        ; 
RESULT_LEN                  = RESULT_X - RESULT ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Accumulator                     
; --------------------------------------------------------------------------------------------------------------------- ;
ACCUM                       = $8f               ; 
ACCUM_0                       = $8f             ;                
ACCUM_1                       = $90             ; 
ACCUM_2                       = $91             ; 
ACCUM_3                       = $92             ; 
ACCUM_4                       = $93             ; 
ACCUM_X                       = ACCUM_4         ; 
ACCUM_LEN                   = ACCUM_X - ACCUM   ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the start of the active buffer
; --------------------------------------------------------------------------------------------------------------------- ;
DIRBUF                      = $94               ; Ptr : start current buffer - DIR buffer ($0205)
                                                ; Note: sometimes DIRBUF does NOT point to the data buffer star                                                ;     : but to FILE_DATA behind the FILE_LINK
DIRBUF_LO                     = $94             ; 
DIRBUF_HI                     = $95             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
ICMD                        = $96               ; IEEE command in (not used on 1541)                     (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
MYPA                        = $97               ; MY PA flag $00  (not used on 1541)                     (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
CONT                        = $98               ; bit counter during serial bus input/output
; --------------------------------------------------------------------------------------------------------------------- ;
; Buffer Byte Pointers - Point to the next byte to be used of each buffer - set by the B-P command
; --------------------------------------------------------------------------------------------------------------------- ;
BUFTAB                      = $99               ; Tab : pointer to next byte in buffers #0-#4 - normally: $0300-$0700
BUFTAB_LO                     = $99             ; 
BUFTAB_HI                     = $9a             ; 
                              
BUFTAB_0                      = $99             ; Ptr : next byte in buffer #0 - default : $0300 [BUFF0]
BUFTAB_0_LO                     = $99           ; 
BUFTAB_0_HI                     = $9a           ; 
BUFTAB_1                      = $9b             ; Ptr : next byte in buffer #1 - default : $0400 [BUFF1]
BUFTAB_1_LO                     = $9b           ; 
BUFTAB_1_HI                     = $9c           ; 
BUFTAB_2                      = $9d             ; Ptr : next byte in buffer #2 - default : $0500 [BUFF2]
BUFTAB_2_LO                     = $9d           ; 
BUFTAB_2_HI                     = $9e           ; 
BUFTAB_3                      = $9f             ; Ptr : next byte in buffer #3 - default : $0600 [BUFF3]
BUFTAB_3_LO                     = $9f           ; 
BUFTAB_3_HI                     = $a0           ; 
BUFTAB_4                      = $a1             ; Ptr : next byte in buffer #4 - default : $0700 [BUFF4]
BUFTAB_4_LO                     = $a1           ; 
BUFTAB_4_HI                     = $a2           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
BUFTAB_CB                     = $a3             ; Ptr : next byte in command buffer - default: $0200
BUFTAB_CB_LO                    = $a3           ; 
BUFTAB_CB_HI                    = $a4           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
BUFTAB_EB                     = $a5             ; Ptr : next byte in error message buffer - default: $02D5
BUFTAB_EB_LO                    = $a5           ; 
BUFTAB_EB_HI                    = $a6           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
CB                            = BUFTAB_CB       ; Ptr : next byte in command buffer   - default: $0200 - CMDBUF
CB_LO                           = BUFTAB_CB_LO  ; 
CB_HI                           = BUFTAB_CB_HI  ; 
; --------------------------------------------------------------------------------------------------------------------- ;
EB                            = BUFTAB_EB       ; Ptr : next byte in error msg buffer - default: $02D5 - ERRBUF
EB_LO                           = BUFTAB_EB_LO  ; 
EB_HI                           = BUFTAB_EB_HI  ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Table of channel numbers assigned to each of the primary buffers
; --------------------------------------------------------------------------------------------------------------------- ;
BUF0                        = $a7               ; Tab : primary buffer number assigned to channels
BUF_NUM_MASK                  = %00111111       ;       bit0-bit5: buffer number
BUF_NUM_MASK_SHORT            = %00001111       ;       bit0-bit3: buffer number
BUF_FLAG_MASK                 = %11000000       ;       bit6-bit7: buffer status flags
BUF_FLAG_MASK_LONG            = %11100000       ;       bit5-bit7: buffer status flags
BUF_INACT                     = %10000000       ;       bit7     : 1 = buffer inactive
BUF_DIRTY                     = %01000000       ;       bit6     : 1 = buffer 'dirty'
BUF_UNUSED                    = %11111111       ;                :     buffer still unused
                              
BUF0_0                        = $a7             ; 
BUF0_1                        = $a8             ; 
BUF0_2                        = $a9             ; 
BUF0_3                        = $aa             ; 
BUF0_4                        = $ab             ; 
BUF0_5                        = $ac             ; 
BUF0_6                        = $ad             ; 
BUF0_X                        = BUF0_6          ; 
BUF0_LEN                    = BUF0_X - BUF0 + $01 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Table of channel numbers assigned to each of the secondary buffers
; --------------------------------------------------------------------------------------------------------------------- ;
BUF1                        = $ae               ; Tab : secondary buffer number assigned to channels
BUF1_0                        = $ae             ; 
BUF1_1                        = $af             ; 
BUF1_2                        = $b0             ; 
BUF1_3                        = $b1             ; 
BUF1_4                        = $b2             ; 
BUF1_5                        = $b3             ; 
BUF1_6                        = $b4             ; 
BUF1_X                        = BUF1_6          ; 
BUF1_LEN                    = BUF1_X - BUF1 + $01 ; 
                            
BUF_LEN                     = BUF1_X - BUF0 + $01 ;   length BUF0 + BUF1
; --------------------------------------------------------------------------------------------------------------------- ;
; Table LO bytes of record numbers for each buffer
; --------------------------------------------------------------------------------------------------------------------- ;
RECL                        = $b5               ; Tab : REL files: number of records LO
RECL_0                        = $b5             ; 
RECL_1                        = $b6             ; 
RECL_2                        = $b7             ; 
RECL_3                        = $b8             ; 
RECL_4                        = $b9             ; 
RECL_5                        = $ba             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Table HI bytes of record numbers for each buffer
; --------------------------------------------------------------------------------------------------------------------- ;
RECH                        = $bb               ; Tab : REL files: number of records HI
RECH_0                        = $bb             ; 
RECH_1                        = $bc             ; 
RECH_2                        = $bd             ; 
RECH_3                        = $be             ; 
RECH_4                        = $bf             ; 
RECH_5                        = $c0             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
NBKL                        = RECL              ;       number of blocks LO - length of file
NBKH                        = RECH              ;       Number of Blocks HI - length of file
; --------------------------------------------------------------------------------------------------------------------- ;
; Table of next record numbers for buffers
; --------------------------------------------------------------------------------------------------------------------- ;
NR                          = $c1               ; Tab : REL files: offset next data byte in buffer assigned to channels
NR_0                          = $c1             ; 
NR_1                          = $c2             ; 
NR_2                          = $c3             ; 
NR_3                          = $c4             ; 
NR_4                          = $c5             ; 
NR_5                          = $c6             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Table of record size for each buffer
; --------------------------------------------------------------------------------------------------------------------- ;
RS                          = $c7               ; Tab : REL files: record length in buffer assigned to channels
RS_0                          = $c7             ; 
RS_1                          = $c8             ; 
RS_2                          = $c9             ; 
RS_3                          = $ca             ; 
RS_4                          = $cb             ; 
RS_5                          = $cc             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Table of side sectors for each buffer
; --------------------------------------------------------------------------------------------------------------------- ;
SS                          = $cd               ; Tab : buffer number holding side sector of REL file assigned to channels
SS_NUM_MASK                   = %01111111       ;         bit0-bit6: buffer number
SS_ACT_MASK                   = %10000000       ;         bit7     : 1 = no buffer assigned to channel
SS_0                          = $cd             ; 
SS_1                          = $ce             ; 
SS_2                          = $cf             ; 
SS_3                          = $d0             ; 
SS_4                          = $d1             ; 
SS_5                          = $d2             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
F1PTR                       = $d3               ; Off : file stream 1 pointer
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer start of record
; --------------------------------------------------------------------------------------------------------------------- ;
RECPTR                      = $d4               ; Off : current byte in REL file record
; --------------------------------------------------------------------------------------------------------------------- ;
SSNUM                       = $d5               ;       side sector number belonging to current REL file record
; --------------------------------------------------------------------------------------------------------------------- ;
SSIND                       = $d6               ; Off : TRACK/sector number of current REL file record in side sector
; --------------------------------------------------------------------------------------------------------------------- ;
RELPTR                      = $d7               ; Off : record in relative file data sector
; --------------------------------------------------------------------------------------------------------------------- ;
; SECTOR of directory entries
; --------------------------------------------------------------------------------------------------------------------- ;
ENTSEC                      = $d8               ; Tab : sector number of DIR entries
ENTSEC_0                      = $d8             ; 
ENTSEC_1                      = $d9             ; 
ENTSEC_2                      = $da             ; 
ENTSEC_3                      = $db             ; 
ENTSEC_4                      = $dc             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Index of directory entries
; --------------------------------------------------------------------------------------------------------------------- ;
ENTIND                      = $dd               ; Tab : buffer offset (index) of DIR entries
ENTIND_0                      = $dd             ; 
ENTIND_1                      = $de             ; 
ENTIND_2                      = $df             ; 
ENTIND_3                      = $e0             ; 
ENTIND_4                      = $e1             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Drive number of files
; --------------------------------------------------------------------------------------------------------------------- ;
FILDRV                      = $e2               ; Tab : drive number of files
FILDRV_NUM                    = %00000001       ;         bit0: drive number
FILDRV_DEFAULT                = %10000000       ;         bit7: 1 = no drive number explicitly specified in CMD - must try both units
FILDRV_0                      = $e2             ; 
FILDRV_1                      = $e3             ; 
FILDRV_2                      = $e4             ; 
FILDRV_3                      = $e5             ; 
FILDRV_4                      = $e6             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; File type and file status flags
; --------------------------------------------------------------------------------------------------------------------- ;
PATTYP                      = $e7               ; Tab : file type / file status flags
PATTYP_MASK                   = %00000111       ;       file type
PATTYP_DEL                    = %00000000       ;       file type is DEL
PATTYP_SEQ                    = %00000001       ;       file type is SEQ
PATTYP_PRG                    = %00000010       ;       file type is PRG
PATTYP_USR                    = %00000011       ;       file type is USR
PATTYP_REL                    = %00000100       ;       file type is REL
                              
PATTYP_OPEN                   = %00100000       ;       1 = file is OPEN / 0 = file has been CLOSED
PATTYP_PROTECT                = %01000000       ;       1 = file is write protected
PATTYP_PATTERN                = %10000000       ;       1 = wildcard present in file name
                              
PATTYP_CLEAR                  = %00000000       ;       reset all flags
                              
PATTYP_0                      = $e7             ; 
PATTYP_1                      = $e8             ; 
PATTYP_2                      = $e9             ; 
PATTYP_3                      = $ea             ; 
PATTYP_4                      = $eb             ; 
PATTYP_X                      = PATTYP_4        ; 
PATTYP_LEN                  = PATTYP_X - PATTYP ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Drive number file type and flags file status of files assigned to channels
; --------------------------------------------------------------------------------------------------------------------- ;
FILTYP                      = $ec               ; Tab : channel drive number / file type / file status flags
FILTYP_DRIVE                  = %00000001       ;       drive number
                      
FILTYP_TYPE_MASK              = %00001110       ;       file type
FILTYP_DEL                    = %00000000       ;       file type is DEL
FILTYP_SEQ                    = %00000010       ;       file type is SEQ
FILTYP_PRG                    = %00000100       ;       file type is PRG
FILTYP_USR                    = %00000110       ;       file type is USR
FILTYP_REL                    = %00001000       ;       file type is REL
FILTYP_DIRECT                 = %00001110       ;       file type is '#' - direct disk access
                      
FILTYP_STATUS_MASK            = %11100000       ;       file type status
FILTYP_EOR                    = %00100000       ;       end of record
FILTYP_EOF                    = %01000000       ;       end of file
FILTYP_LRE                    = %10000000       ;       last record
                              
FILTYP_0                      = $ec             ; 
FILTYP_1                      = $ed             ; 
FILTYP_2                      = $ee             ; 
FILTYP_3                      = $ef             ; 
FILTYP_4                      = $f0             ; 
FILTYP_5                      = $f1             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; channel input/output flags
; --------------------------------------------------------------------------------------------------------------------- ;
CHNRDY                      = $f2               ; Tab : channel input/output flags
CHNRDY_CLEAR                  = %00000000       ;       reset all flags
CHNRDY_LISTEN                 = %00000001       ;       bit0 - 1 = ready to LISTEN
CHNRDY_EOI                    = %00001000       ;       bit3 - 0 = end of input
CHNRDY_TALK                   = %10000000       ;       bit7 - 1 = ready to TALK
                              
CHNRDY_0                      = $f2             ; 
CHNRDY_1                      = $f3             ; 
CHNRDY_2                      = $f4             ; 
CHNRDY_3                      = $f5             ; 
CHNRDY_4                      = $f6             ; 
CHNRDY_5                      = $f7             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
EOIFLG                      = $f8               ; Flag: end of file indicator current channel
EOIFLG_YES                    = $00             ;         end of file
EOIFLG_NO                     = $08   ; - $ff   ;         
EOIFLG_NONE                   = $80             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
JOBNUM                      = $f9               ;       current (active) buffer number
; --------------------------------------------------------------------------------------------------------------------- ;
LRUTBL                      = $fa               ; Tab : least used channel number
LRUTBL_0                      = $fa             ; 
LRUTBL_1                      = $fb             ; 
LRUTBL_2                      = $fc             ; 
LRUTBL_3                      = $fd             ; 
LRUTBL_4                      = $fe             ; 
LRUTBL_X                      = LRUTBL_4        ; 
LRUTBL_LEN                  = LRUTBL_X - LRUTBL ; 
; --------------------------------------------------------------------------------------------------------------------- ;
NODRV                       = $ff               ; Flag: table: drive #0/#1 status
NODRV0                        = $ff             ; Flag: drive #0 status
NODRV_READY                   = %00000000       ;         drive #0 ready
NODRV_NONE                    = %11111111       ;         drive #0 not ready (no disk)
NODRV1                      = $0100             ; Flag: drive #1 status                                        (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; Extended Zero Page - Stacks / Work Areas / GCR Overflow Buffer
; --------------------------------------------------------------------------------------------------------------------- ;
OVRBUF                      = $0100             ;       base address overflow buffer for GCR decode/encode
OVRBUF_OFF                    = TOPWRT          ; Off:  overflow buffer
; --------------------------------------------------------------------------------------------------------------------- ;
; Drives DOS version taken from TRACK 18 sector 00 BAM_DOS_VRS ($02)
; --------------------------------------------------------------------------------------------------------------------- ;
DSKVER                      = $0101             ; Tab : drives DOS version
DSKVER_0                      = $0101           ;       drive #0 DOS version
DSKVER_1                      = $0102           ;       drive #1 DOS version                                   (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
ZPEND                       = $0103             ;       end of zero page                                       (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; Stack area
; --------------------------------------------------------------------------------------------------------------------- ;
STACK_1541                  = $0104             ; 
STACK_1541_TOP                = OVRBUF + TOPWRT ;       $45 - top of stack - stack pointer init value
STACK_1541_LEN              = STACK_1541_TOP - OVRBUF ; 
                      
STACK_1541_FREE             = STACK_1541_TOP + $01 ;    $146
STACK_1541_FREE_X           = BUFGCR - $01      ;       $1ba
; --------------------------------------------------------------------------------------------------------------------- ;
; Overflow buffer for GCR/BIN decode/encode
; --------------------------------------------------------------------------------------------------------------------- ;
BUFGCR                      = $01bb             ;       overflow buffer start address
BUFGCR_OFF                    = <BUFGCR         ; Off : overflow buffer from OVRBUF
BUFGCR_LEN                  = CMDBUF - BUFGCR   ;       $45 - overflow buffer length
; --------------------------------------------------------------------------------------------------------------------- ;
; Storage for disk commands sent to the disk drive from the computer over the serial bus
; --------------------------------------------------------------------------------------------------------------------- ;
CMDBUF                      = $0200             ;       command buffer for input string from computer
CMDBUF_X                    = $0229             ; 
CMDBUF_LEN                  = CMDBUF_X - CMDBUF ;       input buffer size
; --------------------------------------------------------------------------------------------------------------------- ;
; CMD code number - offset into CMDTBL
; --------------------------------------------------------------------------------------------------------------------- ;
CMDNUM                      = $022a             ;       number of the CMD to be executed
CMDNUM_VAL                    = $00             ;       VALIDATE
CMDNUM_INI                    = $01             ;       INITIALIZE
CMDNUM_DUP                    = $02             ;       DUPLICATE (not used)
CMDNUM_MEM                    = $03             ;       MEMORY
CMDNUM_BLK                    = $04             ;       BLOCK
CMDNUM_USR                    = $05             ;       USER
CMDNUM_POS                    = $06             ;       POSITION
CMDNUM_UTI                    = $07             ;       UTILITY LOADER (&-Command)
; --------------------------------------------------------------------------------------------------------------------- ;
; CMD numbers tested with STRUCT
; --------------------------------------------------------------------------------------------------------------------- ;
CMDNUM_CPY                    = $08             ;       COPY
CMDNUM_REN                    = $09             ;       RENAME
CMDNUM_SCR                    = $0a             ;       SCRATCH
CMDNUM_NEW                    = $0b             ;       NEW
; --------------------------------------------------------------------------------------------------------------------- ;
; CMD number load DIR
; --------------------------------------------------------------------------------------------------------------------- ;
CMDNUM_DIR                    = $0c             ;       LOAD "$"

CMDNUM_MAX                    = CMDNUM_DIR      ;       
; --------------------------------------------------------------------------------------------------------------------- ;
CMDNUM_BFL                    = $80   ; - $fe   ; Flag: B-x commands
CMDNUM_ERR                    = $ff             ; Flag: error - command too long
; --------------------------------------------------------------------------------------------------------------------- ;
; Channel number and current status of each data channel (secondary address)
; --------------------------------------------------------------------------------------------------------------------- ;
LINTAB                      = $022b             ; Tab : current status of each data channel (secondary address)
LINTAB_NUM_MASK               = %00001111       ;       mask channel numbers
LINTAB_NUM_MASK_LONG          = %00111111       ;       mask channel numbers
                              
LINTAB_INACT                  = %11111111       ;       inactive (no channel assigned)
LINTAB_OPEN_MASK              = %11000000       ;       ..
LINTAB_OPEN_R                 = %00000000       ;       00 - open for read
LINTAB_OPEN_RW                = %01000000       ;       01 - open for read/write
LINTAB_OPEN_W                 = %10000000       ;       10 - open for write
; --------------------------------------------------------------------------------------------------------------------- ;
; data channels
; --------------------------------------------------------------------------------------------------------------------- ;
LINTAB_01                     = $022b           ;       logical index channel # $01 - internal READ
LINTAB_02                     = $022c           ;       logical index channel # $02 - internal WRITE
LINTAB_03                     = $022d           ;       logical index channel # $03 - data channel
LINTAB_04                     = $022e           ;       logical index channel # $04 - data channel
LINTAB_05                     = $022f           ;       logical index channel # $05 - data channel
LINTAB_06                     = $0230           ;       logical index channel # $06 - data channel
LINTAB_07                     = $0231           ;       logical index channel # $07 - data channel
LINTAB_08                     = $0232           ;       logical index channel # $08 - data channel
LINTAB_09                     = $0233           ;       logical index channel # $09 - data channel
LINTAB_0A                     = $0234           ;       logical index channel # $10 - data channel
LINTAB_0B                     = $0235           ;       logical index channel # $11 - data channel
LINTAB_0C                     = $0236           ;       logical index channel # $12 - data channel
LINTAB_0D                     = $0237           ;       logical index channel # $13 - data channel
LINTAB_0E                     = $0238           ;       logical index channel # $14 - data channel
LINTAB_NUM_DATA_MAX           = LINTAB_0E - LINTAB + $01 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; command channel
; --------------------------------------------------------------------------------------------------------------------- ;
LINTAB_0F                     = $0239           ;       logical index channel # $15
LINTAB_NUM_CMD                  = LINTAB_0F - LINTAB + $01 ;                        - command channel
; --------------------------------------------------------------------------------------------------------------------- ;
; special channels
; --------------------------------------------------------------------------------------------------------------------- ;
LINTAB_10                     = $023a           ;       logical index channel # $16
LINTAB_NUM_ERROR                = LINTAB_10 - LINTAB + $01 ;                        - error channel
LINTAB_11                     = $023b           ;       logical index channel # $17
LINTAB_NUM_READ                 = LINTAB_11 - LINTAB + $01 ;                        - internal READ
LINTAB_12                     = $023c           ;       logical index channel # $18
LINTAB_NUM_WRITE                = LINTAB_12 - LINTAB + $01 ;                        - internal WRITE
                              
LINTAB_13                      = $023d           ;      logical index channel # $19
LINTAB_LEN                  = LINTAB_13 - LINTAB + $01 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; The data byte to be READ/WRITE for each channel
; --------------------------------------------------------------------------------------------------------------------- ;
CHNDAT                      = $023e             ; Tab : channel data byte
CHNDAT_0                      = $023e           ;       for BUFF0
CHNDAT_1                      = $023f           ;       for BUFF1
CHNDAT_2                      = $0240           ;       for BUFF2
CHNDAT_3                      = $0241           ;       for BUFF3
CHNDAT_4                      = $0242           ;       for BUFF4
CHNDAT_5                      = $0243           ;       for BUFF5 - Temporary area of next data byte to be written from error message buffer
CHNDAT_X                      = CHNDAT_5        ; 
CHNDAT_LEN                  = CHNDAT_X - CHNDAT ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Offset last data byte read or written in buffers for each channel
; --------------------------------------------------------------------------------------------------------------------- ;
LSTCHR                      = $0244             ; Tab : channel last character pointer
LSTCHR_0                      = $0244           ;       BUFF0
LSTCHR_1                      = $0245           ;       BUFF1
LSTCHR_2                      = $0246           ;       BUFF2
LSTCHR_3                      = $0247           ;       BUFF3
LSTCHR_4                      = $0248           ;       BUFF4
LSTCHR_5                      = $0249           ;       BUFF5
LSTCHR_X                      = LSTCHR_5        ; 
LSTCHR_LEN                  = LSTCHR_X - LSTCHR ; 
; --------------------------------------------------------------------------------------------------------------------- ;
TYPE                        = $024a             ;       current (active) file type
TYPE_MASK                     = %00000111       ;       file type
TYPE_DEL                      = %00000000       ;       file type is DEL
TYPE_SEQ                      = %00000001       ;       file type is SEQ
TYPE_PRG                      = %00000010       ;       file type is PRG
TYPE_USR                      = %00000011       ;       file type is USR
TYPE_REL                      = %00000100       ;       file type is REL
TYPE_DIRECT                   = %00000111       ;         file type is '#' - direct disk access
; --------------------------------------------------------------------------------------------------------------------- ;
STRSIZ                      = $024b             ;       command string size
; --------------------------------------------------------------------------------------------------------------------- ;
TEMPSA                      = $024c             ;       temp area for secondary address
; --------------------------------------------------------------------------------------------------------------------- ;
CMD                         = $024d             ;       temp area for DC job command
; --------------------------------------------------------------------------------------------------------------------- ;
LSTSEC                      = $024e             ;       work area to find the best sector
; --------------------------------------------------------------------------------------------------------------------- ;
; Buffer allocation status
; --------------------------------------------------------------------------------------------------------------------- ;
BUFUSE                      = $024f             ;       buffer allocation register
BUFUSE_0                      = $024f           ;       buffer allocation register - drive #0
BUFUSE_1                      = $0250           ;       buffer allocation register - drive #1
                            
BUFUSE_FREE                   = %11100000       ;         set all buffers to unused
BUFUSE_ALLOC                  = %11111111       ;         set all buffers to allocated
BUFUSE_BUF0                   = %00000001       ;         buffer #0 is being used
BUFUSE_BUF1                   = %00000010       ;         buffer #1 is being used
BUFUSE_BUF2                   = %00000100       ;         buffer #2 is being used
BUFUSE_BUF3                   = %00001000       ;         buffer #3 is being used
BUFUSE_BUF4                   = %00010000       ;         buffer #4 is being used
BUFUSE_ERROR                  = %00100000       ;         error message buffer is being used
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag BAM status
; --------------------------------------------------------------------------------------------------------------------- ;
MDIRTY                      = $0251             ; Flag: BAM changed drives (dirty)
MDIRTY_0                      = $0251           ; Flag: BAM changed drive #0
MDIRTY_1                      = $0252           ; Flag: BAM changed drive #1                                   (unused)
MDIRTY_NO                     = $00             ;       BAM unchanged
MDIRTY_YES                    = $01   ; - $ff   ;       BAM has been changed - must be written to disk
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag DIR entry found
; --------------------------------------------------------------------------------------------------------------------- ;
ENTFND                      = $0253             ; Flag: DIR entry found
ENTFND_NO                     = $ff             ;         bit7=1   : a file matching the name has NOT been found in the DIR
ENTFND_YES                    = $00             ;         bit7=0   : a file matching the name has     been found in the DIR
                                                ;         bit0-bit2: current entry number
; --------------------------------------------------------------------------------------------------------------------- ;
DIRLST                      = $0254             ; Flag: DIR listing
DIRLST_NO                     = $00             ;         DATA file is being LOADed
DIRLST_YES                    = $01   ; - $ff   ;         DIR is being LOADed
; --------------------------------------------------------------------------------------------------------------------- ;
CMDWAT                      = $0255             ; Flag: command waiting
CMDWAT_NO                     = $00             ;         no command waiting
CMDWAT_YES                    = $01             ;         command waiting
; --------------------------------------------------------------------------------------------------------------------- ;
LINUSE                      = $0256             ;       LINDX channel allocation
                                                ;         bit1-bit4=1 - related channel free
                                                ;         bit1-bit4=0 - related channel used
LINUSE_FREE_ALL               = %00001111       ;           all channels are free
                              
LINUSE_FREE_0                 = %00000001       ;         channel #0 is free
LINUSE_FREE_1                 = %00000010       ;         channel #1 is free
LINUSE_FREE_2                 = %00000100       ;         channel #2 is free
LINUSE_FREE_3                 = %00001000       ;         channel #3 is free
                                  
LINUSE_0                      = %11111110       ;         channel #0 is used
LINUSE_1                      = %11111101       ;         channel #1 is used
LINUSE_2                      = %11111011       ;         channel #2 is used
LINUSE_3                      = %11110111       ;         channel #3 is used
; --------------------------------------------------------------------------------------------------------------------- ;
; Last buffer used
; --------------------------------------------------------------------------------------------------------------------- ;
LBUSED                      = $0257             ;       last used buffer / temp area for channel number
                                                ;         $00-$06: assigned buffer number in primary   table BUF0 ($a7-$ad)
                                                ;         $07-$0D: assigned buffer number in secondary table BUF1 ($ae-$b4)
; --------------------------------------------------------------------------------------------------------------------- ;
REC                         = $0258             ;       record length of current relative file
; --------------------------------------------------------------------------------------------------------------------- ;
TRKSS                       = $0259             ;       side sector TRACK
; --------------------------------------------------------------------------------------------------------------------- ;
SECSS                       = $025a             ;       side sector SECTOR
; --------------------------------------------------------------------------------------------------------------------- ;
; Last JOB codes for buffers #0-#4
; --------------------------------------------------------------------------------------------------------------------- ;
LSTJOB                      = $025b             ; Tab : last JOB by buffer
LSTJOB_DRIVE_MASK             = %00000001       ;       drive number
                              
LSTJOB_0                      = $025b           ; 
LSTJOB_1                      = $025c           ; 
LSTJOB_2                      = $025d           ; 
LSTJOB_3                      = $025e           ; 
LSTJOB_4                      = $025f           ; 
LSTJOB_X                      = LSTJOB_4        ; 
LSTJOB_LEN                  = LSTJOB_X - LSTJOB ; 
; --------------------------------------------------------------------------------------------------------------------- ;
DSEC                        = $0260             ; Tab : sector number of DIR entry of files specified in command
DSEC_0                        = $0260           ; 
DSEC_1                        = $0261           ; 
DSEC_2                        = $0262           ; 
DSEC_3                        = $0263           ; 
DSEC_4                        = $0264           ; 
DSEC_5                        = $0265           ; 
DSEC_X                        = DSEC_5          ; 
DSEC_LEN                    = DSEC_X - DSEC     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
DIND                        = $0266             ; Tab : offset (index) of DIR entry of files specified in command
DIND_0                        = $0266           ; 
DIND_1                        = $0267           ; 
DIND_2                        = $0268           ; 
DIND_3                        = $0269           ; 
DIND_4                        = $026a           ; 
DIND_5                        = $026b           ; 
DIND_X                        = DIND_5          ; 
DIND_LEN                    = DIND_X - DIND     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
ERWORD                      = $026c             ; Flag: an error has occurred
ERWORD_FLASH                  = $01   ; - $ff   ;         error - value used for LED flash timer
ERWORD_FLASH_50               = $50             ;      
ERWORD_NEW                    = %10000000       ;         new error
ERWORD_NONE                   = $00             ;         no error
; --------------------------------------------------------------------------------------------------------------------- ;
ERLED                       = $026d             ; Flag: drive LED error flashing
ERLED_OFF                     = $00             ;         switch LED off
ERLED_ON                      = $08             ;         switch LED on
; --------------------------------------------------------------------------------------------------------------------- ;
PRGDRV                      = $026e             ;       drive  number of last opened file (used when opening '*')
; --------------------------------------------------------------------------------------------------------------------- ;
PRGSEC                      = $026f             ;       sector number of last opened file (used when opening '*')
; --------------------------------------------------------------------------------------------------------------------- ;
; temp store for LINDX channel number
; --------------------------------------------------------------------------------------------------------------------- ;
WLINDX                      = $0270             ;       temp store for channel number (write LINDX)
RLINDX                      = $0271             ;       temp store for channel number (read  LINDX)
; --------------------------------------------------------------------------------------------------------------------- ;
NBTEMP                      = $0272             ;       Tab : BASIC line number for entries sent to host during LOAD '$'
                                                ;         for header: drive number
                                                ;         for files : length of file in blocks
                                                ;         for footer: number of free blocks
NBTEMP_LO                     = $0272           ; 
NBTEMP_HI                     = $0273           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; CMD string size
; --------------------------------------------------------------------------------------------------------------------- ;
CMDSIZ                      = $0274             ;       length of CMD input string
CMDSIZ_MAX                    = CMDBUF_LEN      ; 
                      
CMDSIZ_ME_LEN                 = $05             ;       M-E AdrLo AdrHi                     - Memory-Execute
CMDSIZ_MR_LEN                 = $06             ;       M-R AdrLo AdrHi Num                 - Memory-Read
CMDSIZ_MW_LEN                 = $06             ;       M-W AdrLo AdrHi Num(max $23)        - Memory-Write
CMDSIZ_MW_MAX                 = CMDBUF_LEN - CMDSIZ_MW_LEN ; CMDSTR_MW_LEN ; 
                      
CMDSIZ_BR_LEN                 = $07             ;       B-R Channel# Drive# TRACK# Sector#  - Block-Read (do not use)
CMDSIZ_U1_LEN                 = $06             ;        U1 Channel# Drive# TRACK# Sector#  - Block-Read
                      
CMDSIZ_BW_LEN                 = $07             ;       B-R Channel# Drive# TRACK# Sector#  - Block-Write (do not use)
CMDSIZ_U2_LEN                 = $06             ;        U2 Channel# Drive# TRACK# Sector#  - Block-Write
                      
CMDSIZ_BA_LEN                 = $06             ;       B-A Drive# TRACK# Sector#           - Block-Allocate in BAM
CMDSIZ_BE_LEN                 = $06             ;       B-E Drive# TRACK# Sector#           - Block-Execute
CMDSIZ_BF_LEN                 = $06             ;       B-F Drive# TRACK# Sector#           - Block-Free in BAM
CMDSIZ_BP_LEN                 = $03             ;       B-P Channel# Position#              - Buffer-Pointer
; --------------------------------------------------------------------------------------------------------------------- ;
CHAR                        = $0275             ;       actual character to search for in input buffer
; --------------------------------------------------------------------------------------------------------------------- ;
LIMIT                       = $0276             ; Idx : end of file name in command buffer (1st char after file name in command)
; --------------------------------------------------------------------------------------------------------------------- ;
F1CNT                       = $0277             ; Work: file stream 1 count   (count input string)
F2CNT                       = $0278             ; Work: file stream 2 count   (count input string)
F2PTR                       = $0279             ; Work: file stream 2 pointer (pointer input string)
; --------------------------------------------------------------------------------------------------------------------- ;
; Parser Table Area ($027a - $0289)
; --------------------------------------------------------------------------------------------------------------------- ;
; File name pointers
; --------------------------------------------------------------------------------------------------------------------- ;
FILTBL                      = $027a             ; Tab : offsets file name in input string (last offset specifies end of command)
FILTBL_DEFAULT                = %10000000       ; Flag: use default drive - no drive number in input string found for this file
FILTBL_DRIVENUM               = %00000001       ;       drive number
                              
FILTBL_0                      = $027a           ; 
FILTBL_1                      = $027b           ; 
FILTBL_2                      = $027c           ; 
FILTBL_3                      = $027d           ; 
FILTBL_4                      = $027e           ; 
FILTBL_5                      = $027f           ; 
FILTBL_X                    = FILTBL_5          ; 
FILTBL_LEN                    = FILTBL_X - FILTBL ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; File link TRACK 1st file
; --------------------------------------------------------------------------------------------------------------------- ;
FILTRK                      = $0280             ; Tab : TRACK number 1st file link
FILTRK_NFND                   = $00             ;         $00    : file not yet found in DIR
                                                ;         $01-$ff: TRACK number of 1st file block
                                                ;       for 'B-x' cmds: high byte of parameters
FILTRK_0                      = $0280           ;     
FILTRK_1                      = $0281           ;     
FILTRK_2                      = $0282           ;     
FILTRK_3                      = $0283           ;     
FILTRK_4                      = $0284           ;     
FILTRK_X                      = FILTRK_4        ;     
FILTRK_LEN                  = FILTRK_X - FILTRK ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; File link SECTOR 1st file
; --------------------------------------------------------------------------------------------------------------------- ;
FILSEC                      = $0285             ; Tab : sector number 1st file link
FILSEC_NFND                   = $00             ;         $00    : file not yet found in DIR
                                                ;         $01-$ff: sector number of 1st file block
                                                ; for 'B-x' cmds: low byte of parameters
FILSEC_0                      = $0285           ; 
FILSEC_1                      = $0286           ; 
FILSEC_2                      = $0287           ; 
FILSEC_3                      = $0288           ; 
FILSEC_4                      = $0289           ; 
FILSEC_X                      = FILSEC_4        ; 
FILSEC_LEN                  = FILSEC_X - FILSEC ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag pattern present in file name
; --------------------------------------------------------------------------------------------------------------------- ;
PATFLG                      = $028a             ; Flag: pattern present (number of wildcards found in current file name)
PATFLG_NO                     = %00000000       ; 
PATFLG_YES                    = %10000000       ; 
PATFLG_COUNT                  = %01111111       ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Result of SMD syntax check
; --------------------------------------------------------------------------------------------------------------------- ;
IMAGE                       = $028b             ; Flag: file stream image
IMAGE_00                      = %00000000       ;       init
                                                ;        .--------------------------.  file stream #2
IMAGE_N2                      = %00000001       ;       ! filename given             ! equation marks are present in the input string
IMAGE_D2                      = %00000010       ;       ! Drive # specified          ! 
IMAGE_G2                      = %00000100       ;       ! more then one file implied ! commas    after  equation marks are present in the input string
IMAGE_P2                      = %00001000       ;       ! found wildcard             ! wildcards after  equation marks are present in the input string
                                                ;       +----------------------------+ file stream #1       
IMAGE_N1                      = %00010000       ;       ! filename given             ! equation marks are present in the input string
IMAGE_D1                      = %00100000       ;       ! Drive # specified          ! 
IMAGE_G1                      = %01000000       ;       ! more then one file implied ! commas    before equation marks are present in the input string
IMAGE_P1                      = %10000000       ;       ! found wildcard             ! wildcards before equation marks are present in the input string
                                                ;       ` --------------------------´  
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of drives in searches
; --------------------------------------------------------------------------------------------------------------------- ;
DRVCNT                      = $028c             ;       number of drives to process
DRVCNT_MASK                   = %00000011       ;       
DRVCNT_ONE                    = %00000000       ;         one drive  to check
DRVCNT_TWO                    = %00000001       ;         two drives to check
                              
DRVCNT_2ND                    = %00000010       ;         2nd drive available
                              
DRVCNT_CMD                    = %01000000       ;         bit6=1:take drive num from CMD string
DRVCNT_TAB                    = %00000000       ;         bit6=0:take drive num from SCHTBL bit7
                              
DRVCNT_DR0                    = %00000000       ;         bit7=0: drive number #0
DRVCNT_DR1                    = %10000000       ;         bit7=1: drive number #1
; --------------------------------------------------------------------------------------------------------------------- ;
DRVFLG                      = $028d             ; Flag: drive search during DIR read
DRVFLG_ONE                    = $00             ;         one drive available
DRVFLG_TWO                    = $01             ;         2nd drive available
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of last drive accessed without error
; --------------------------------------------------------------------------------------------------------------------- ;
LSTDRV                      = $028e             ;       last drive number without error during reading the DIR (used as default drive)
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag all files found during DIR seach
; --------------------------------------------------------------------------------------------------------------------- ;
FOUND                       = $028f             ; Flag: all files found in DIR searches (indicator to keep searching in the DIR)
FOUND_NO                      = $00             ;         still more files to be searched for
FOUND_YES                     = $ff             ;         all files have been found - no need to continue search
; --------------------------------------------------------------------------------------------------------------------- ;
DIRSEC                      = $0290             ;       current DIR sector number
; --------------------------------------------------------------------------------------------------------------------- ;
; SECTOR number of 1st entry available
; --------------------------------------------------------------------------------------------------------------------- ;
DELSEC                      = $0291             ;       DIR sector number to read (sector number of 1st available file)
DELSEC_1ST                    = $00             ;         1st DIR sector is to be read
DELSEC_NEXT                   = $01   ; - $ff   ;         sector number of next DIR to read
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag DIR serach type
; --------------------------------------------------------------------------------------------------------------------- ;
DELIND                      = $0292             ; Flag: DIR search type
                                                ;       if found: offset current DIR entry in DIR sector (index of 1st available file)
DELIND_VALID                  = $00             ;         look for a valid DIR entry
DELIND_FREE                   = $01             ;         look for a free DIR entry (unused/deleted)
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag end of DIR
; --------------------------------------------------------------------------------------------------------------------- ;
LSTBUF                      = $0293             ; Flag: end of DIR
LSTBUF_YES                    = $00             ;         current DIR sector is the last one
LSTBUF_NO                     = $01   ; - $ff   ;         more DIR sectors are present
; --------------------------------------------------------------------------------------------------------------------- ;
INDEX                       = $0294             ;       Off : current DIR entry in buffer
; --------------------------------------------------------------------------------------------------------------------- ;
FILCNT                      = $0295             ;       number of remaining DIR entries in DIR sector minus 1
                                                ;         $00-$07: number of remaining DIR entries
FILCNT_NONE                   = $ff             ;         $ff    : no more entries left
; --------------------------------------------------------------------------------------------------------------------- ;
TYPFLG                      = $0296             ; Flag: file type match of file being searched in DIR
TYPFLG_NONE                   = $00             ;         file type was NOT specified in command - any file type will match
                              
TYPFLG_MASK                   = %00000111       ;         file type
TYPFLG_DEL                    = %00000000       ;         file type is DEL
TYPFLG_SEQ                    = %00000001       ;         file type is SEQ
TYPFLG_PRG                    = %00000010       ;         file type is PRG
TYPFLG_USR                    = %00000011       ;         file type is USR
TYPFLG_REL                    = %00000100       ;         file type is REL
TYPFLG_DIRECT                 = %00000111       ;         file type is '#' - direct disk access
                              
TYPFLG_VALID                  = %10000000       ;         file is valid
; --------------------------------------------------------------------------------------------------------------------- ;
; Active file open mode
; --------------------------------------------------------------------------------------------------------------------- ;
MODE                        = $0297             ;       file open mode
MODE_READ                     = $00             ;         'R' - read   or LOAD a file
MODE_WRITE                    = $01             ;         'W' - write  or SAVE a file
MODE_APPEND                   = $02             ;         'A' - append a file
MODE_MODIFY                   = $03             ;         'M' - read an open file - modify or salvage an improperly closed file
; --------------------------------------------------------------------------------------------------------------------- ;
JOBRTN                      = $0298             ; Flag: message display for disk errors
JOBRTN_MSG_NONE               = %00000000       ;         bit7=0: silently ignore the following errors when executing disk commands
                                                ;                 '26,WRITE PROTECT ON'
                                                ;                 '29,DISK ID MISMATCH'
                                                ;                 '74,DRIVE NOT READY' 
JOBRTN_MSG_ALL                = %11111111       ;         bit7=1: display the error messages above
; --------------------------------------------------------------------------------------------------------------------- ;
EPTR                        = $0299             ; Off : current byte in half TRACK seek table during retry disk operations on adjacent half TRACKs
; --------------------------------------------------------------------------------------------------------------------- ;
TOFF                        = $029a             ; Off : direction of seeking back to original half TRACK during retry disk operations on adjacent half TRACKs
; --------------------------------------------------------------------------------------------------------------------- ;
BAMLU                       = $029b             ; Tab : TRACK number current BAM entry (last BAM update pointer)
BAMLU_0                       = $029b           ;         TRACK number current BAM entry of drive #0
BAMLU_1                       = $029c           ;         TRACK number current BAM entry of drive #1           (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
BAMIS                       = $029d             ; Tab : TRACK numbers of two cached BAM entries of drives
BAMIS_0_TRACK0                = $029d           ;         1st TRACK num of two cached BAM entries of drive #0
BAMIS_0_TRACK1                = $029e           ;         2nd TRACK num of two cached BAM entries of drive #0
BAMIS_1_TRACK0                = $029f           ;         1st TRACK num of two cached BAM entries of drive #1  (unused)
BAMIS_1_TRACK1                = $02a0           ;         2nd TRACK num of two cached BAM entries of drive #1  (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; BAM Image Buffer
; --------------------------------------------------------------------------------------------------------------------- ;
BAMI                        = $02a1             ; Buf : BAM image
BAMI_X                      = $02b0             ; 
BAMI_LEN                    = BAMI_X - BAMI     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; OUTPUT BUFFERS ($02bl-$02f8)
; --------------------------------------------------------------------------------------------------------------------- ;
; DIR Buffer
; --------------------------------------------------------------------------------------------------------------------- ;
NAMBUF                      = $02b1             ; Buf : DIR listing line output
NAMBUFFIN                   = $02c9             ; 
NAMBUF_LINE_LEN             = NAMBUFFIN - NAMBUF; 
NAMBUF_X                    = $02d4             ; 
NAMBUF_LEN                  = NAMBUF_X - NAMBUF ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Error Message Buffer
; --------------------------------------------------------------------------------------------------------------------- ;
ERRBUF                      = $02d5             ; Buf : error message output
ERRBUF_X                    = $02f8             ; 
ERRBUF_LEN                  = ERRBUF_X - ERRBUF ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag do not write BAM
; --------------------------------------------------------------------------------------------------------------------- ;
WBAM                        = $02f9             ; Flag: write BAM - disk update upon BAM change necessary
                                                ;       reset to WBAM_CLEAR before and after each command 
WBAM_CLEAR                    = %00000000       ;       clear flags
WBAM_WRITE_NO                 = %00000001       ;       don't write BAM
WBAM_DIRTY                    = %01000000       ;       BAM 'dirty'
WBAM_WRITE_PENDING            = %10000000       ;       write BAM pending
; --------------------------------------------------------------------------------------------------------------------- ;
; Number of disk blocks free LO/HI
; --------------------------------------------------------------------------------------------------------------------- ;
NDBL                        = $02fa             ; Tab : number of disk blocks free for drives LO
NDBL0                         = $02fa           ;         number of disk blocks free for drive #0 LO      
NDBL1                         = $02fb           ;         number of disk blocks free for drive #1 LO           (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
NDBH                        = $02fc             ; Tab : number of disk blocks free for drives HI
NDBH0                         = $02fc           ;         number of disk blocks free for drive #0 HI
NDBH1                         = $02fd           ;         number of disk blocks free for drive #1 HI           (unused)
; --------------------------------------------------------------------------------------------------------------------- ;
; Current phase of head stepper motor
; --------------------------------------------------------------------------------------------------------------------- ;
PHASE                       = $02fe             ; Tab : move dir to adjacent half TRACK
PHASE_0                       = $02fe           ;       move dir to adjacent half TRACK drive #0
PHASE_1                       = $02ff           ;       move dir to adjacent half TRACK drive #1                (unused)
PHASE_STOP                    = $00             ;         no move
PHASE_OUT                     = $01             ;         move a half TRACK outwards
PHASE_DONE                    = $02             ;         half TRACK move complete - head on TRACK
PHASE_IN                      = $ff             ;         move a half TRACK inwards
; --------------------------------------------------------------------------------------------------------------------- ;
; Data Buffers
; --------------------------------------------------------------------------------------------------------------------- ;
BUFS                        = $0300             ;       start of data buffers
BUFF0                         = $0300           ;       MAIN: main working buffer
BUFF1                         = $0400           ;       DIR : contains the actual part of the DIR
BUFF2                         = $0500           ;       USER: normally free
BUFF3                         = $0600           ;       DIR : contains the last DIR block
BUFF4                         = $0700           ;       BAM : contains block 18,0 after init
                              
BUFF5                         = $0700           ;       NONE: no RAM available - set to BUFF4
                            
BUFS_X                      = BUFF4             ;       end of buffers
BUFS_MAX                      = >BUFS_X - BUFS  ;       max number of available buffers
; --------------------------------------------------------------------------------------------------------------------- ;
END_OF_RAM                  = $07ff             ;       no ram from $0800 - $bfff
; --------------------------------------------------------------------------------------------------------------------- ;
; Variables needed for FORMAT
; --------------------------------------------------------------------------------------------------------------------- ;
CNT                         = BUFF3 + $20       ;       error counter: decrements from CNT_MAX
CNT_MAX                       = $0a             ; 
FMTVAR                      = CNT               ;       format variable
; --------------------------------------------------------------------------------------------------------------------- ;
NUM                         = CNT + $01         ;       number between SYNC and NON-SYNC
NUM_LO                        = CNT +$01        ; 
NUM_HI                        = CNT +$02        ; 
NUM_ESTIMATE                    = $0fa0         ;       1st estimation of a TRACK half capacity (4000)
; --------------------------------------------------------------------------------------------------------------------- ;
TRYS                        = CNT + $03         ;       number of tries in verify format
TRYS_DFLT                     = $c8             ;       default tries in verify format(200)
TRAL                        = CNT + $04         ;       counter: number of bytes in NON-SYNC segment
TRAL_HI                       = CNT + $04       ; 
TRAL_LO                       = CNT + $05       ; 
; --------------------------------------------------------------------------------------------------------------------- ;
DTRCK                       = CNT + $06         ;       inter SECTOR gap size
DTRCK_MIN                     = $66             ;       min block size = 282*5/4 - 256 = 85 
REMDR                       = CNT + $07         ;       remainder of size
SECT                        = CNT + $08         ;       sector number counter
; --------------------------------------------------------------------------------------------------------------------- ;
; ROM start addresses
; --------------------------------------------------------------------------------------------------------------------- ;
ROMLOC                      = $c000             ;       DOS  ROM
                            .include "1541.DOS.routines.asm" ; BASIC Routines entry points $a000-$bfff
; --------------------------------------------------------------------------------------------------------------------- ;
; VIAs
; --------------------------------------------------------------------------------------------------------------------- ;
VIA1REG                     = $1800             ; 
                            .include "1541.VIA1.asm" ;   $1800-$180F - Serial Bus Controller Port
VIA2REG                     = $dd00             ; 
                            .include "1541.VIA2.asm" ;   $1C00-$1C0F - Disk Controller Port: motor and read/write head control
; --------------------------------------------------------------------------------------------------------------------- ;
; SYSTEM hardware vectors
; --------------------------------------------------------------------------------------------------------------------- ;
                            .weak               ; avoid error: duplicate definition
; --------------------------------------------------------------------------------------------------------------------- ;
; Any symbols defined inside can be overridden by “stronger” symbols in the same scope from outside
; --------------------------------------------------------------------------------------------------------------------- ;
SYSJMP                      = $ffe6             ; table: system jump vectors             (unused)
SYSFORMT                      = SYSJMP + $00    ;        FORMAT a disk handler           $C8C6
SYSTMOFF                      = SYSJMP + $02    ;        Turn OFF drive motor            $F98F
; --------------------------------------------------------------------------------------------------------------------- ;
UBLOCK                      = $ffea             ; table: adresses user commands
UBLKUA                        = UBLOCK + $00    ;        U1 UA Vektor - Block read       $CD5F
UBLKUB                        = UBLOCK + $02    ;        U2 UB Vektor - Block write      $CD97
UBLKUC                        = UBLOCK + $04    ;        U3 UC Vektor - user program     $0500 - BUFF2 + $00
UBLKUD                        = UBLOCK + $06    ;        U4 UD Vektor - user program     $0503 - BUFF2 + $03
UBLKUE                        = UBLOCK + $08    ;        U5 UE Vektor - user program     $0506 - BUFF2 + $06
UBLKUF                        = UBLOCK + $0a    ;        U6 UF Vektor - user program     $0509 - BUFF2 + $09
UBLKUG                        = UBLOCK + $0c    ;        U7 UG Vektor - user program     $050C - BUFF2 + $0c
UBLKUH                        = UBLOCK + $0e    ;        U8 UH Vektor - user program     $050F - BUFF2 + $0f
; --------------------------------------------------------------------------------------------------------------------- ;
NMI                         = $fffa             ;       U9 UI Vektor - NMI-Vektor        $FF01
NMI_LO                        = NMI             ; 
NMI_HI                        = NMI + $01       ; 
                                                ; 
DSKINT                      = $fffc             ;       U: UJ Vektor - RESET-Vektor      $EAA0
DSKINT_LO                     = DSKINT          ; 
DSKINT_HI                     = DSKINT + $01    ; 
                                                ; 
SYSIRQ                      = $fffe             ;       IRQ-Vektor                       $FE67
SYSIRQ_LO                     = SYSIRQ          ; 
SYSIRQ_HI                     = SYSIRQ + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
                            .endweak ; 
; --------------------------------------------------------------------------------------------------------------------- ;
