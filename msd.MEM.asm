; -------------------------------------------------------------------------------------------------------------- ;
; Stolen from: R Carlsen - MSD SD-2 operating manual and schematic 
; http://personalpages.tds.net/~rcarlsen/cbm/msd/
; -------------------------------------------------------------------------------------------------------------- ;
; Section V - Useful RAM Locations - Zero Page
; -------------------------------------------------------------------------------------------------------------- ;
MSD_ZP_43           = $43         ; <unknown>
MSD_ZP_DRVNUM       = $54         ; Current drive number
MSD_ZP_TRACK        = $55         ; Current track search number
MSD_ZP_SECTOR       = $56         ; Current sector search number
MSD_ZP_DIRBUF       = $69         ; pointer: last buffer used for directory search
MSD_ZP_DIRBUF_LO    = $69         ; 
MSD_ZP_DIRBUF_HI    = $6a         ; 
MSD_ZP_76           = $76         ; <unknown>
MSD_ZP_LSNADR       = $77         ; Serial/IEEE LISTEN address (device number + $20 - usually $28)
MSD_ZP_LSNADR_DFLT    = $28       ; 
MSD_ZP_43           = $43         ; 
MSD_ZP_TLKADR       = $78         ; Serial/IEEE TALK   address (device number + $40 - usually $48)
MSD_ZP_TLKADR_DFLT    = $48       ; 
; -------------------------------------------------------------------------------------------------------------- ;
MSD_ZP_BUFTAB       = $7A         ; 24 byte table of buffer pointers (2 bytes * 12 buffers)
MSD_ZP_BUFTAB0        = $7a       ; pointer: next byte in buffer #0
MSD_ZP_BUFTAB0_LO     = $7a       ; 
MSD_ZP_BUFTAB0_HI     = $7b       ; 
MSD_ZP_BUFTAB1        = $7c       ; pointer: next byte in buffer #1
MSD_ZP_BUFTAB1_LO     = $7c       ; 
MSD_ZP_BUFTAB1_HI     = $7d       ; 
MSD_ZP_BUFTAB2        = $7e       ; pointer: next byte in buffer #2
MSD_ZP_BUFTAB2_LO     = $7e       ; 
MSD_ZP_BUFTAB2_HI     = $7f       ; 
MSD_ZP_BUFTAB3        = $80       ; pointer: next byte in buffer #3
MSD_ZP_BUFTAB3_LO     = $80       ; 
MSD_ZP_BUFTAB3_HI     = $81       ; 
MSD_ZP_BUFTAB4        = $82       ; pointer: next byte in buffer #4
MSD_ZP_BUFTAB4_LO     = $82       ; 
MSD_ZP_BUFTAB4_HI     = $83       ; 
MSD_ZP_BUFTAB5        = $84       ; pointer: next byte in buffer #5
MSD_ZP_BUFTAB5_LO     = $84       ; 
MSD_ZP_BUFTAB5_HI     = $85       ; 
MSD_ZP_BUFTAB6        = $86       ; pointer: next byte in buffer #6
MSD_ZP_BUFTAB6_LO     = $86       ; 
MSD_ZP_BUFTAB6_HI     = $87       ; 
MSD_ZP_BUFTAB7        = $88       ; pointer: next byte in buffer #7
MSD_ZP_BUFTAB7_LO     = $88       ; 
MSD_ZP_BUFTAB7_HI     = $89       ; 
MSD_ZP_BUFTAB8        = $8a       ; pointer: next byte in buffer #8
MSD_ZP_BUFTAB8_LO     = $8a       ; 
MSD_ZP_BUFTAB8_HI     = $8b       ; 
MSD_ZP_BUFTAB9        = $8c       ; pointer: next byte in buffer #9
MSD_ZP_BUFTAB9_LO     = $8c       ; 
MSD_ZP_BUFTAB9_HI     = $8d       ; 
MSD_ZP_BUFTABA        = $8e       ; pointer: next byte in buffer #a - drive 0 BAM
MSD_ZP_BUFTABA_LO     = $8e       ; 
MSD_ZP_BUFTABA_HI     = $8f       ; 
MSD_ZP_BUFTABB        = $90       ; pointer: next byte in buffer #b - drive 1 BAM
MSD_ZP_BUFTABB_LO     = $90       ; 
MSD_ZP_BUFTABB_HI     = $91       ; 
; -------------------------------------------------------------------------------------------------------------- ;
MSD_ZP_BUFTABCMD    = $92         ; pointer: to the command buffer
MSD_ZP_BUFTABCMD_LO = $92         ; 
MSD_ZP_BUFTABCMD_HI = $93         ; 
MSD_ZP_BUFTABERR    = $94         ; pointer: to the error buffer
MSD_ZP_BUFTABERR_LO = $94         ; 
MSD_ZP_BUFTABERR_HI = $95         ; 
MSD_ZP_IMG          = $a8         ; RAM image of the hardware latch at $a000
MSD_ZP_DRIVE        = $b0         ; active drive
MSD_ZP_DRIVE_0        = $00       ; 
MSD_ZP_DRIVE_1        = $01       ; 
MSD_ZP_JOBN         = $b6         ; current job number being executed by the controller
MSD_ZP_DRVCNT       = $b7         ; Number of active drives
MSD_ZP_DRVCNT1        = $00       ; single
MSD_ZP_DRVCNT2        = $01       ; dual)
; -------------------------------------------------------------------------------------------------------------- ;
; Section V - Useful RAM Locations - RAM
; -------------------------------------------------------------------------------------------------------------- ;
MSD_BUF0            = $4000       ; Buffer #0
MSD_BUF1            = $4100       ; Buffer #1
MSD_BUF2            = $4200       ; Buffer #2
MSD_BUF3            = $4300       ; Buffer #3
MSD_BUF4            = $4400       ; Buffer #4
MSD_BUF5            = $4500       ; Buffer #5
MSD_BUF6            = $4600       ; Buffer #6
MSD_BUF7            = $4700       ; Buffer #7
MSD_BUF8            = $4800       ; Buffer #8
MSD_BUF9            = $4900       ; Buffer #9
MSD_BUFA            = $4a00       ; Buffer #a - drive 0 BAM
MSD_BUFB            = $4b00       ; Buffer #b - drive 1 BAM
; -------------------------------------------------------------------------------------------------------------- ;
MSD_JOBCODES        = $4c00       ; table: JOB queue for 12 buffers
MSD_JOB_CODE0         = $4c00     ; 
MSD_JOB_CODE1         = $4c01     ; 
MSD_JOB_CODE2         = $4c02     ; 
MSD_JOB_CODE3         = $4c03     ; 
MSD_JOB_CODE4         = $4c04     ; 
MSD_JOB_CODE5         = $4c05     ; 
MSD_JOB_CODE6         = $4c06     ; 
MSD_JOB_CODE7         = $4c07     ; 
MSD_JOB_CODE8         = $4c08     ; 
MSD_JOB_CODE9         = $4c09     ; 
MSD_JOB_CODEA         = $4c0a     ; 
MSD_JOB_CODEB         = $4c0b     ; 
; -------------------------------------------------------------------------------------------------------------- ;
MSD_JOBTRACKS       = $4c0c       ; table: TRACK number for the 12 jobs
MSD_JOB_TRA0          = $4c0c     ; 
MSD_JOB_TRA1          = $4c0d     ; 
MSD_JOB_TRA2          = $4c0e     ; 
MSD_JOB_TRA3          = $4c0f     ; 
MSD_JOB_TRA4          = $4c10     ; 
MSD_JOB_TRA5          = $4c11     ; 
MSD_JOB_TRA6          = $4c12     ; 
MSD_JOB_TRA7          = $4c13     ; 
MSD_JOB_TRA8          = $4c14     ; 
MSD_JOB_TRA9          = $4c15     ; 
MSD_JOB_TRAA          = $4c16     ; 
MSD_JOB_TRAB          = $4c17     ; 
; -------------------------------------------------------------------------------------------------------------- ;
MSD_JOBSECTORS      = $4c18       ; table: SECTOR number for the 12 jobs
MSD_JOB_SEC0          = $4c18     ; 
MSD_JOB_SEC1          = $4c19     ; 
MSD_JOB_SEC2          = $4c1a     ; 
MSD_JOB_SEC3          = $4c1b     ; 
MSD_JOB_SEC4          = $4c1c     ; 
MSD_JOB_SEC5          = $4c1d     ; 
MSD_JOB_SEC6          = $4c1e     ; 
MSD_JOB_SEC7          = $4c1f     ; 
MSD_JOB_SEC8          = $4c20     ; 
MSD_JOB_SEC9          = $4c21     ; 
MSD_JOB_SECA          = $4c22     ; 
MSD_JOB_SECB          = $4c23     ; 
; -------------------------------------------------------------------------------------------------------------- ;
MSD_DISKID_CHR1     = $4c24       ; disk ID - 1st byte
MSD_DISKID0_CHR1      = $4c24     ; disk ID - 1st byte drive 0
MSD_DISKID1_CHR1      = $4c25     ; disk ID - 1st byte drive 1
MSD_DISKID_CHR2     = $4c26       ; disk ID - 2nd byte
MSD_DISKID0_CHR2      = $4c26     ; disk ID - 2nd byte drive 0
MSD_DISKID1_CHR2      = $4c27     ; disk ID - 2nd byte drive 1
; -------------------------------------------------------------------------------------------------------------- ;
; Five byte HEADER image (used after read & before write)
; -------------------------------------------------------------------------------------------------------------- ;
MSD_HEADER          = $4c28       ; header block ID     - from header of sector last read from disk
MSD_HEADER_CHR1       = $4c28     ;                       1st ID char
MSD_HEADER_CHR2       = $4c29     ;                       2nd ID char
MSD_HEADER_TRK        = $4c2a     ; header block track  - track  number from header of sector last read from disk
MSD_HEADER_SEC        = $4c2b     ; header block sector - sector number from header of sector last read from disk
MSD_HEADER_CRC        = $4c2c     ; header block parity - checksum from header of sector last read from disk
; -------------------------------------------------------------------------------------------------------------- ;
MSD_WPSW            = $4c2d       ; flag: drive #0 - disk changed
WPSW_FLAG             = %00000001 ; 
WPSW_SAME             = $00       ; disk has not changed
WPSW_DIFF             = $01       ; disk has changed
MSD_WPSW1           = $4c2e       ; flag: drive #1 - disk changed
MSD_LWPT            = $4c2f       ; flag: drive #0 - last position of write protect
MSD_LWPT1           = $4c30       ; flag: drive #1 - last position of write protect
MSD_LWPT_ON           = %00010000 ; 
MSD_LWPT_OFF          = %11101111 ; 
MSD_LWPT_NO           = %00000000 ; 
MSD_LWPT_YES          = %00010000 ; 
MSD_NMI             = $4c31       ; pointer: user vector for NMI interrupt
MSD_NMI_LO          = $4c31       ; 
MSD_NMI_HI          = $4c32       ; 
MSD_SECINC          = $4c35       ; sector interleave count
MSD_SECINC_DFLT       = $0a       ; 
MSD_REVCNT          = $4c36       ; error recovery count
MSD_REVCNT_MASK       = %00111111 ; number of retries
MSD_REVCNT_AHT        = %01000000 ; retry on adjacent halftracks
MSD_REVCNT_BUMP       = %10000000 ; bump head
MSD_REVCNT_AHT_NO     = %10111111 ; do not retry on adjacent halftracks
MSD_REVCNT_BUMP_NO    = %01111111 ; do not bump head
MSD_REVCNT_DFLT       = %00000101 ; 
MSD_RTRN            = $4c37       ; flag: for head "landing"
                                  ;       when the motor stops the drive head normally goes to track 40
                                  ;       to override this feature set this byte to a non-zero number
MSD_DSKVER          = $4c88       ; disk version drive #0 from Track 18 Sector 0
MSD_DSKVER1         = $4c89       ; disk version drive #1 from Track 18 Sector 0
; -------------------------------------------------------------------------------------------------------------- ;
MSD_SBUSMODE        = $4cf1       ; talk delay byte for serial communications
                                  ;   - normally a $0d in the "C64" mode
                                  ;   - set to   a $01 in the "VIC" mode
MSD_IEEATN          = $4cf2       ; pointer: IEEE attention service vector
MSD_IEEATN_LO       = $4cf2       ; 
MSD_IEEATN_HI       = $4cf3       ; 
MSD_IECATN          = $4cf4       ; pointer: Serial attention service vector
MSD_IECATN_LO       = $4cf4       ; 
MSD_IECATN_HI       = $4cf5       ; 
MSD_DTRK            = $4cf6       ; maximum track # for both drives +1
MSD_DTRK_DFLT         = $24       ; 36
; -------------------------------------------------------------------------------------------------------------- ;
MSD_BUFU            = $4d00       ; USER buffer - unused RAM available to user
MSD_BUFUX           = $4dff       ; 
; -------------------------------------------------------------------------------------------------------------- ;
MSD_CMDBUF          = $4e00       ; input buffer for command string from computer (COMMAND buffer SA=15)
MSD_CMDBUFX         = $4e28       ; 
MSD_CMDBUF_LEN      = [MSD_CMDBUFX - MSD_CMDBUF] ; input buffer size
; -------------------------------------------------------------------------------------------------------------- ;
MSD_ERRBUF          = $4e64       ; error message buffer
MSD_ERRBUFX         = $4e87       ; 
MSD_ERRBUF_LEN      = [MSD_ERRBUFX - MSD_ERRBUF] ; 
; -------------------------------------------------------------------------------------------------------------- ;
MSD_DRVTRK          = $4e88       ; current physical track number of Drive 0
MSD_DRVTRK1         = $4e89       ; current physical track number of Drive 1
MSD_AF              = $4e8c       ; delay count for head step in mS (normally 5)
MSD_AF_DFLT           = $05       ; 
MSD_HBID            = $4ea2       ; header block ID byte (normally $08)
MSD_HBID_DFLT         = $08       ; 
MSD_NXTTRK          = $4ea5       ; next track  the current job requests
MSD_NXTSEC          = $4ea6       ; next sector the current job requests
MSD_JOBNUM          = $4ea9       ; current job number (0-11)
MSD_BID             = $4eac       ; data block ID byte
MSD_BID_DFLT          = $07       ; 
; -------------------------------------------------------------------------------------------------------------- ;
; Section VI - Useful ROM Subroutines (2.3)
; -------------------------------------------------------------------------------------------------------------- ;
MSD_DOSVER          = $c000       ; DOS Version Number
MSD_DOSVER_TXT        = "2.3"     ; 
MSD_DOSVERX         = $c002       ; 
; -------------------------------------------------------------------------------------------------------------- ;
MSD_SETLDA          = $c003       ; turns on  LED #0 or LED #1 based on DRVNUM
MSD_ERROFF          = $c00f       ; kills any error status on the LEDs
MSD_SETLDA1         = $c018       ; turns off LED #0 or LED #1 based on DRVNUM
MSD_ERRON           = $c036       ; invokes an error flash on LED #0 or LED #1 based on DRVNUM
; -------------------------------------------------------------------------------------------------------------- ;
MSD_DSKINT          = $e83f       ; start of RESET code (jump here to reset drive)
; -------------------------------------------------------------------------------------------------------------- ;
MSD_SEAK            = $f46c       ; search for header in MSD_HEADER
                                  ;   return with .z=1 if not found
                                  ;   return with .z=0 if found
MSD_SYNC            = $f4a6       ; search up to 30mS for a SYNC
                                  ;   return with .c=1 if not found
                                  ;   return with .c=0 if found
MSD_IDLE            = $f68a       ; wait loop - waits for .X milliseconds
                                  ; 
                                  ;   example: lda #100     ; set up a 100 mS delay
                                  ;            jsr MSD_IDLE ;
                                  ;                                     
MSD_MOVHD           = $f693       ; move the head of drive # in MSD_ZP_DRIVE to the track number in .A
                                  ; also sets read density after head is moved
                                  ; 
                                  ;   example: lda #MSD_ZP_DRIVE_0  ; drive 0
                                  ;            sta MSD_ZP_DRIVE     ; store drive 0
                                  ;            lda #20              ; target = track 20
                                  ;            jsr MSD_MOVHD        ; move there
                                  ; 
MSD_MOVHD0          = $f700       ; move the head of drive # in MSD_ZP_DRIVE to track $00
                                  ; also sets read density after head is moved
                                  ; 
                                  ;   example: lda #MSD_ZP_DRIVE_0  ; drive 0
                                  ;            sta MSD_ZP_DRIVE     ; store drive 0
                                  ;            jsr MSD_MOVHD        ; move to track 0
                                  ; 
MSD_TURNON          = $f754       ; turn on Drive #0 and turn off Drive #1
MSD_TRNOFF          = $f759       ; turn off both drives
MSD_TURNON1         = $f767       ; turn on Drive #1 and turn off Drive #0
                                  ; 
MSD_PBIEEE          = $fe11       ; set Port B to IEEE   mode (See section II E)
MSD_PBKILL          = $fe1a       ; set Port B to Read   mode (See section II E)
MSD_PBSTAT          = $fe25       ; set Port B to Status mode (See section II E)
; -------------------------------------------------------------------------------------------------------------- ;
