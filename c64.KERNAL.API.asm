; ----------------------------------------------------------------------------------------------------------------------------------------- ;
; C64 - Kernal jump table - For a summary look at the OVERVIEW table at the end of this file
; ----------------------------------------------------------------------------------------------------------------------------------------- ;
; KERNAL routines error message list
; ----------------------------------------------------------------------------------------------------------------------------------------- ;
; NOTE: Some KERNAL I/O routines do not use these codes for error msgs
;       Errors are identified using the KERNAL READST routine then
; ------------+------+--------------------------+
; Success     ! .C=0 ! Flag                     !
; Errors      ! .C=1 ! Flag                     !
; ------------+------+--------------------------+------------------------------------------------------------+
;             ! CODE ! TEXT                     ! EXPLANATION                                                !
;             +------+--------------------------+------------------------------------------------------------+
;             !   0  ! BREAK                    ! Routine terminated by the <STOP> key                       !
;             !   1  ! TOO MANY FILES           ! More than 10 open files                                    !
;             !   2  ! FILE OPEN                ! File already open - Each file must have a its own number   !
;             !   3  ! FILE NOT OPEN            ! Each file must be opened before it can be accessed         !
;             !   4  ! FILE NOT FOUND           ! The requested file is not available                        !
;             !   5  ! DEVICE NOT PRESENT       ! The addressed device does not respond                      !
;             !   6  ! NOT INPUT FILE           ! No data can be read from a file opened for WRITE           !
;             !   7  ! NOT OUTPUT FILE          ! No data can be written to a file opened for READ           !
;             !   8  ! MISSING FILE NAME        ! A serial LOAD/SAVE requires a file name                    !
;             !   9  ! ILLEGAL DEVICE NUMBER    ! The chosen command is invalid for the requested device     !
; ------------+------+--------------------------+------------------------------------------------------------+
;             ! 240  ! $f0 - see MEMTCF         ! Top-of-memory change RS-232 buffer allocation/deallocation !
; ------------+------+--------------------------+-------------+----------------------------------------------+----------------------------- ;
CINT                        := $ff81            ; Purpose     ! Init the SCREEN editor and the VIC-2 video chip
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Init default I/O to KEYBOARD and SCREEN
                                                ;             ! Init the VIC II video controller chip from tab TVIC 
                                                ;             ! Init the SCREEN editor and KEYBOARD
                                                ;             ! Set COLOUR RAM pointer
                                                ;             ! Set PAL/NTSC switch
                                                ;             ! Set and start interrupt timer A
                                                ; ------------!---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! none
; ------------------------------------------------------------!---------------------------------------------------------------------------- ;
IOINIT                      := $ff84            ; Purpose     ! Initialize I/O devices
                                                ; ------------!---------------------------------------------------------------------------- ;
                                                ; Description ! Init CIA1 and CIA2
                                                ;             ! Init 6510 ports
                                                ;             ! Setup memory configuration
                                                ;             ! Set and start interrupt timer A
                                                ; ------------!---------------------------------------------------------------------------- ;
                                                ; Note        ! A PAL system is distinguished from a NTSC system
                                                ; ------------!---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------!---------------------------------------------------------------------------- ;
                                                ; Example     ! none
; ------------------------------------------------------------!---------------------------------------------------------------------------- ;
RAMTAS                      := $ff87            ; Purpose     ! Initialize RAM / Allocate tape buffer / Set screen $0400
                                                ; ------------!---------------------------------------------------------------------------- ;
                                                ; Description ! Clear $0002-$00ff - Zero Page
                                                ;             ! Clear $0200-$02ff - BASIC and KERNAL work / RS-232 work / FLAGs
                                                ;             ! Clear $0300-$03ff - Indirect vectors / TAPE buffers
                                                ;             ! Set the TAPE buffer pointer to $033C
                                                ;             ! Run a nondestructive memory test from VICSCN upwards
                                                ;             !   If a non-RAM address is reached (BASIC ROM at $a000) set MEMSIZK
                                                ;             ! Set RAMLOC to $0800 - start of BASIC program text
                                                ;             ! Set HIBASE to $0400 - start of screen memory
                                                ; ------------!---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------!---------------------------------------------------------------------------- ;
                                                ; Example     ! none
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
RESTOR                      := $ff8a            ; Purpose     ! Restore default KERNEL and interrupt vectors
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Fill the KERNEL indirect vector table with their default values
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ;         $00 ! CINV    = $0314 - Vector: Hardware IRQ Interrupt          address ($ea31)
                                                ;         $02 ! CNBINV  = $0316 - Vector: BRK instruction interrupt       address ($fe66)
                                                ;         $04 ! NMINV   = $0318 - Vector: Hardware NMI interrupt          address ($fe47)
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ;         $06 ! IOPEN   = $031a - Vector: Indirect entry to Kernal OPEN   routine ($f34a)
                                                ;         $08 ! ICLOSE  = $031c - Vector: Indirect entry to Kernal CLOSE  routine ($f291)
                                                ;         $0a ! ICHKIN  = $031e - Vector: Indirect entry to Kernal CHKIN  routine ($f20e)
                                                ;         $0c ! ICKOUT  = $0320 - Vector: Indirect entry to Kernal CHKOUT routine ($f250)
                                                ;         $0e ! ICLRCH  = $0322 - Vector: Indirect entry to Kernal CLRCHN routine ($f333)
                                                ;         $10 ! IBASIN  = $0324 - Vector: Indirect entry to Kernal CHRIN  routine ($f157)
                                                ;         $12 ! IBSOUT  = $0326 - Vector: Indirect entry to Kernal CHROUT routine ($f1ca)
                                                ;         $14 ! ISTOP   = $0328 - Vector: Indirect entry to Kernal STOP   routine ($f6ed)
                                                ;         $16 ! IGETIN  = $032a - Vector: Indirect entry to Kernal GETIN  routine ($f13e)
                                                ;         $18 ! ICLALL  = $032c - Vector: Indirect entry to Kernal CLALL  routine ($f32f)
                                                ;         $1a ! USRCMD  = $032e - Vector: User Defined                            ($fe66)
                                                ;         $1c ! ILOAD   = $0330 - Vector: Indirect entry to Kernal LOAD   routine ($f4a5)
                                                ;         $1e ! ISAVE   = $0332 - Vector: Indirect entry to Kernal SAVE   routine ($f5ed)
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
VECTOR                      := $ff8d            ; Purpose     ! Manage KERNEL and interrupt vectors
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Copy the KERNEL and interrupt from/into a user table
                                                ;             ! .C=1: Read  RAM vectors into a list pointed to by .X.Y
                                                ;             ! .C=0: Write RAM vectors from a list pointed to by .X.Y
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! Usage
                                                ;             !   - read the entire vector contents into a user area
                                                ;             !   - alter the desired vectors
                                                ;             !   - copy the contents back to the system vectors
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! Read    ldx #<User       ; 
                                                ;             !         ldy #>User       ; 
                                                ;             !         sec              ; .C=1 - read RAM vectors
                                                ;             !         jsr VECTOR       ; 
                                                ;             !                          ; 
                                                ;             ! Alter   lda #<myCHKIN    ; 
                                                ;             !         sta User+$0a     ; change CHKIN LO
                                                ;             !         lda #>myCHKIN    ; 
                                                ;             !         sta User+$0b     ; change CHKIN HI
                                                ;             +                          ; 
                                                ;             ! Write   ldx #<User       ; 
                                                ;             !         ldy #>User       ; 
                                                ;             !         clc              ; .C=0 - write RAM vectors
                                                ;             !         jsr VECTOR       ; 
                                                ;             !                          ; 
                                                ;             ! User  = *                ; 
                                                ;             ! UserX = User + $20       ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
SETMSG                      := $ff90            ; Purpose     ! Set the KERNAL ERROR and CONTROL messages switch in ZP MSGFLG
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! .A Bit 7 = 1: Error messages from the KERNAL are printed
                                                ;             ! .A Bit 6 = 1: Control messages are printed
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! C_MSG   lda #MSGFLG_IO   ; .#......
                                                ;             !         jsr SETMSG       ; turn on control messages
                                                ;             ! E_MSG   lda #MSGFLG_CTRL ; #.......
                                                ;             !         jsr SETMSG       ; turn on error messages
                                                ;             ! NO_MSG  lda #MSGFLG_NONE ; ........
                                                ;             !         jsr SETMSG       ; turn off all kernal messages
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
SECOND                      := $ff93            ; Purpose     ! Send a secondary address after a LISTEN to the serial bus
LSTNSA                      := SECOND           ;             ! 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Send an SA to an I/O device after is was commanded to LISTEN
                                                ;             ! Give information to a device before the I/O operation begins
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! The SA to be sent to a serial device must first be OR'd with $60
                                                ;             ! The device number in .A must be between $00 and $1f
                                                ;             ! Can NOT be used to send a secondary address after a TALK
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! LISTEN
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! See READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         lda FA           ; get device number
                                                ;             !         jsr LISTEN       ; command serial bus device to LISTEN
                                                ;             !                          ; 
                                                ;             !         lda STATUS       ; get status
                                                ;             !         bne Error        ; check: ok - no
                                                ;             !                          ; 
                                                ;             !         lda #$0f | $60   ; command channel number + $60
                                                ;             !         jsr SECOND       ; 
                                                ;             !                          ; 
                                                ;             !         lda STATUS       ; get status
                                                ;             !         bne Error        ; check: ok - no
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
TKSA                        := $ff96            ; Purpose     ! Send a secondary address after TALK to serial bus
TALKSA                      := TKSA             ;             ! 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Send a SA to an I/O device after is was commanded to TALK
                                                ;             ! Give information to a device before the I/O operation begins
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! The SA to be sent to a serial device must first be ORed with $60
                                                ;             ! The device number in .A must be between $00 and $1f
                                                ;             ! Can NOT be used to send a secondary address after a LISTEN
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         lda FA           ; get device number
                                                ;             !         jsr TALK         ; command serial bus device to TALK
                                                ;             !                          ; 
                                                ;             !         lda STATUS       ; get status
                                                ;             !         bne Error        ; check: ok - no
                                                ;             !                          ; 
                                                ;             !         lda #$0f | $60   ; command channel number + $60
                                                ;             !         jsr TKSA         ; 
                                                ;             !                          ; 
                                                ;             !         lda STATUS       ; get status
                                                ;             !         bne Error        ; check: ok - no
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! TALK
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! See READST
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
MEMTOP                      := $ff99            ; Purpose     ! Get/Set the end address of memory pointer
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Manage the top of memory pointer MEMSIZK
                                                ;             ! .C=1: contents of MEMSIZK will be loaded into .X.Y - defaults to ROMLOC ($a000)
                                                ;             ! .C=0: contents .X.Y are stored into MEMSIZK
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! Get     sec              ; move top of memory down one page
                                                ;             !         jsr MEMTOP       ; get memory top to .X.Y
                                                ;             !         dey              ; set prev page
                                                ;             ! Set     clc              ; 
                                                ;             !         jsr MEMTOP       ; set memory top to new value in .X.Y
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
MEMBOT                      := $ff9c            ; Purpose     ! Get/Set the bottom of memory pointer
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Manage the bottom of memory pointer MEMSTR
                                                ;             ! .C=1: contents of MEMSTR will be loaded into .X.Y - defaults to RAMLOC ($0800)
                                                ;             ! .C=0: contents of .X.Y are stored into MEMSTR
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! Get     sec              ; move bottom of memory up one page
                                                ;             !         jsr MEMBOT       ; get memory bottom to .X.Y
                                                ;             !         iny              ; set next page
                                                ;             ! Set     clc              ; 
                                                ;             !         jsr MEMBOT       ; set memory bottom to new value in .X.Y
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
SCNKEY                      := $ff9f            ; Purpose     ! Scan the KEYBOARD matrix
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Scan the KEYBOARD matrix to determine the key pressed
                                                ;             ! If a key is down its PETSCII value is placed in the KEYBOARD buffer
                                                ;             !   - Current matrix code           --> [SFDX] ($00CB)
                                                ;             !   - Current status of shift keys  --> SHFLAG ($028D)
                                                ;             !   - PETSCII code                  --> KEYD   ($0277) KEYBOARD buffer
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! IOINIT
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! GetKey  jsr SCNKEY       ; scan the KEYBOARD
                                                ;             !         jsr GETIN        ; get character from KEYBOARD buffer
                                                ;             !         cmp #$00         ; test no key pressed
                                                ;             !         beq GetKey       ; check: key pressed - no: continue wait
                                                ;             !                          ; 
                                                ;             !         jsr CHROUT       ; print it
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
SETTMO                      := $ffa2            ; Purpose     ! Set the serial (IEEE) bus timeout FLAG in TIMOUT
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! If TIMOUT is set the C64 will wait for a device on the IEEE bus for 64 milliseconds
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! Neither BASIC nor the Kernal refers to this vector
                                                ;             ! Necessary to tell a disk file not found on an OPEN attempt with an IEEE add-on card
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         lda #$00         ; enable timeout
                                                ;             !         jsr SETTMO       ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
ACPTR                       := $ffa5            ; Purpose     ! Get a data byte from serial bus
IECIN                       := ACPTR            ;             ! 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Get a data byte into .A from the current TALKer with full handshaking
                                                ;             !   TALK - call 1st to command the serial device to send data
                                                ;             !   TKSA - call 2nd if the input device needs a secondary command
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! TALK / TKSA
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! .C=1 and ST=2 if timeout (See READST)
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         jsr CLRCHN       ; close channels and restore defaults
                                                ;             !                          ; 
                                                ;             ! GetBlk  lda FA           ; get device number
                                                ;             !         jsr TALK         ; command the serial bus device to send data
                                                ;             !         lda #$02 | $60   ; get data channel number + $60
                                                ;             !         jsr TKSA         ; 
                                                ;             !                          ; 
                                                ;             !         ldy #$00         ; init buffer index
                                                ;             ! Loop    jsr ACPTR        ; get a byte
                                                ;             !         sta Buffer,y     ; store the byte read
                                                ;             !         iny              ; inc buffer index
                                                ;             !         bne Loop         ; check: max - no: get next
                                                ;             !                          ; 
                                                ;             !         jsr UNTLK        ; command the serial bus device to UNTALK
                                                ;             !                          ; 
                                                ;             ! Buffer  = *              ; memory to save the status string
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
CIOUT                       := $ffa8            ; Purpose     ! Output a byte to serial port 
IECOUT                      := CIOUT            ;             ! 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Send a data byte in .A to the current LISTENer with full handshaking
                                                ;             !   LISTEN call 1st to command a device on the serial bus to receive data
                                                ;             !   SECOND call 2nd if the input device needs a secondary command
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! Max $20 bytes allowed to xmit to a DISK drive following a LISTEN 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! LISTEN / SECOND
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! .C=1 and ST=3 if timeout (see READST)
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         jsr CLRCHN       ; close channels and restore defaults
                                                ;             !                          ; 
                                                ;             ! PutBlk  lda FA           ; get device number
                                                ;             !         jsr LISTEN       ; 
                                                ;             !         lda #$0f | $60   ; command channel number + $60
                                                ;             !         jsr SECOND       ; 
                                                ;             !                          ; 
                                                ;             !         ldx #$00         ; init offset
                                                ;             ! Loop    lda POScmd,x     ; get command byte
                                                ;             !         jsr CIOUT        ; send to disk command channel
                                                ;             !         inx              ; inc offset
                                                ;             !         cpx #POScmdX     ; test max len
                                                ;             !         bcc Loop         ; check: max len - no: continue
                                                ;             !                          ; 
                                                ;             !         jsr UNLSN        ; send last char on the bus with EOI and turn it off
                                                ;             !                          ; 
                                                ;             ! POScmd  .byte 'P'        ; position command
                                                ;             !         .byte $63        ; $60 + data channel number $03
                                                ;             ! RecLO   .byte $01        ; LO byte of record #1
                                                ;             ! RecHI   .byte $00        ; HI byte of record #1
                                                ;             ! Field   .byte $01        ; field pointer
                                                ;             !         .byte CR         ; <RETURN>
                                                ;             ! POScmdX = * - POScmd     ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
UNTLK                       := $ffab            ; Purpose     ! Command serial bus to UNTALK
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Sends an UNTALK command on the serial bus
                                                ;             ! ALL devices previously commanded to TALK will stop sending data
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! See READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! see ACPTR
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
UNLSN                       := $ffae            ; Purpose     ! Command serial bus to UNLISTEN
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Commands ALL devices on the serial bus to stop receiving data from the C64
                                                ;             ! All devices previously commanded to LISTEN stop receiving data
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! See READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! see CIOUT
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
LISTEN                      := $ffb1            ; Purpose     ! Command a device on the serial bus to listen
                                                ; ------------!---------------------------------------------------------------------------- ;
                                                ; Description ! Commands a device on the serial bus to receive data
                                                ;             ! .A must contain a device number between $00 and $1f
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! On return ATN is still active and will be reset only after SECOND
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! See READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! see CIOUT
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
TALK                        := $ffb4            ; Purpose     ! Command devices on the serial bus to TALK
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Commands a device on the serial bus to send data
                                                ;             ! .A must contain a device number between $00 and $1f
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! On return ATN is still active and will be reset only after TKSA
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! See READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! see ACPTR
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
READST                      := $ffb7            ; Purpose     ! Read I/O status word
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Returns the current status of the I/O devices in .A
                                                ;             ! Subroutine UDST inserts the error code into ZP STATUS
                                                ;             +----------+---------------------------------------------+ +------------------+
                                                ;             !          !                 STATUS                      ! !     RSSTAT       !
                                                ;             +----------+------------+---------------+----------------+ +------------------+
                                                ;             !   Bit    !   Value    !     TAPE      !  Serial Bus    | |     RS-232       |
                                                ;             +----------+------------+---------------+----------------+ +------------------+
                                                ;             ! .......1 !  $01   (1) !               !  Read Timeout  | |  Parity Error    |
                                                ;             !          !            !               !                | |                  |
                                                ;             !          !            !               !                | |                  |
                                                ;             +----------+------------+---------------+----------------+ +------------------+
                                                ;             ! ......1. !  $02   (2) !               ! Write Timeout  | |  Framing Error   |
                                                ;             !          !            !               !                | |                  |
                                                ;             +----------+------------+---------------+----------------+ +------------------+
                                                ;             ! .....1.. !  $04   (4) !  Short Block  !                | | Receiver Buffer  |
                                                ;             !          !            !   <192 Byte   !                | |    Overflow      |
                                                ;             +----------+------------+---------------+----------------+ +------------------+
                                                ;             ! ....1... !  $08   (8) !  Long  Block  !                | | Receiver Buffer  |
                                                ;             !          !            !   >192 Byte   !                | |      Empty       |
                                                ;             +----------+------------+---------------+----------------+ +------------------+
                                                ;             ! ...1.... !  $10  (16) ! Unrecoverable !     VERIFY     | |   CTS Signal     |
                                                ;             !          !            !  Read Error   !    Mismatch    | | (Clear to Send)  |
                                                ;             !          !            ! - errors >31  !                | |     Missing      |
                                                ;             !          !            ! - pass2 error !                | |                  |
                                                ;             +----------+------------+---------------+----------------+ +------------------+
                                                ;             ! ..1..... !  $20  (32) !   Checksum    !                | |                  |
                                                ;             !          !            !     error     !                | |                  |
                                                ;             +----------+------------+---------------+----------------+ +------------------+
                                                ;             ! .1...... !  $40  (64) !  End of File  !    EOI Line    | |   DSR Missing    |
                                                ;             !          !            !               !     (File)     | | (Data Set Ready) |
                                                ;             +----------+------------+---------------+----------------+ +------------------+
                                                ;             ! 1....... !  $80 (128) !  End of Tape  !   Device not   | |      BREAK       |
                                                ;             !          !            !               !     present    | |                  |
                                                ; ------------+----------+------------+---------------+----------------+ +------------------+
                                                ; Note        ! For RS-232 RSSTAT has to be checked - ZP STATUS will always return $00
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         jsr READST       ; check for end of file during read
                                                ;             !         and #$40         ; test EOI bit
                                                ;             !         bne EOF          ; check: end of file - yes                    
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
SETLFS                      := $ffba            ; Purpose     ! Set the logical file number, device number, and secondary address (command number)
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Must be called before OPEN
                                                ;             ! The logical file number is used as an index to the file tables created by OPEN
                                                ;             ! 
                                                ;             ! Logical file numbers can range from $00 to $ff
                                                ;             ! Device numbers       can range from $00 to $1e
                                                ;             ! Secondary addresses  can range from $00 to $1f
                                                ;             ! 
                                                ;             ! CBM device numbers:
                                                ;             ! --------------------------------------------------------------------------- ;
                                                ;             !  Number    Device
                                                ;             !    $00     KEYBOARD
                                                ;             !    $01     Datassette(TM)
                                                ;             !    $02     RS-232C device
                                                ;             !    $03     Screen (CRT) display
                                                ;             !
                                                ;             !    $04-$1f Serial bus devices
                                                ;             !    $04     Printer
                                                ;             !    $08     Disk drive
                                                ;             !    $09     Disk drive
                                                ;             ! --------------------------------------------------------------------------- ;
                                                ;             ! Secondary addresses (Commands):
                                                ;             ! --------------------------------------------------------------------------- ;
                                                ;             !  Number    Function
                                                ;             !    $00     LOAD a file to the address taken from the .X.Y registers
                                                ;             !    $01     LOAD a file to the address taken from the files disk header
                                                ;             !    $ff     No secondary address is used
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! For reading from serial use an even secondary address
                                                ;             ! For writing to   serial use an odd  secondary address
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         lda #$02         ; set logical file number
                                                ;             !         ldx #$08         ; set device number
                                                ;             !         ldy #$00         ; set secondary command number ($00 = new load address)
                                                ;             !         jsr SETLFS       ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
SETNAM                      := $ffbd            ; Purpose     ! Set a file name
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Set the file name for the OPEN, SAVE, or LOAD routines
                                                ;             !   .A   = the file name length
                                                ;             !   .X.Y = the address of the file name
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! If no file name is desired
                                                ;             !   .A   = $00 - zero file length
                                                ;             !   .X.Y = any address
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         lda #Name_X-Name ; load .A   with the file name length
                                                ;             !         ldx #<Name       ; load .X.Y with the file name address
                                                ;             !         ldy #>Name       ; 
                                                ;             !         jsr SETNAM       ; 
                                                ;             !                          ; 
                                                ;             ! Name    .byte 'FileName' ; 
                                                ;             ! Name_X  = *              ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
OPEN                        := $ffc0            ; Purpose     ! Open a logical file
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Create the entries in the logical file tables
                                                ;             ! Set up the logical file for I/O operations
                                                ;             ! 
                                                ; Channel #   ! $00     - reserved: LOAD
                                                ;             ! $01     - reserved: SAVE
                                                ;             ! $02-$0e - free
                                                ;             ! $0f     - reserved: COMMAND channel/get ERROR MSG
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! SETLFS / SETNAM
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! .C=0 - OK
                                                ;             ! .C=1 - Error --> .A = 1, 2, 4, 5, 6 (if file no = $00), 240, READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         jsr CLALL        ; close all files
                                                ;             !                          ; 
                                                ;             ! Cmd     lda #$00         ; no file name
                                                ;             !         jsr SETNAM       ; set filename parameters
                                                ;             !                          ; 
                                                ;             !         lda #$0f         ; get logical file number
                                                ;             !         ldx #$08         ; get device number
                                                ;             !         ldy #$0f         ; get command channel
                                                ;             !         jsr SETLFS       ; set logical file parameters
                                                ;             !         jsr OPEN         ; open a logical file
                                                ;             !         bcs DiskError    ; check: disk error - yes: exit
                                                ;             !                          ; 
                                                ;             ! Data    lda #$01         ; length data set name
                                                ;             !         ldx #<Name       ; '#'
                                                ;             !         ldy #>Name       ; 
                                                ;             !         jsr SETNAM       ; Set Filename Parameters
                                                ;             !                          ; 
                                                ;             !         lda #$02         ; get logical file number
                                                ;             !         ldx #$08         ; get device number
                                                ;             !         ldy #$02         ; get data channel number
                                                ;             !         jsr SETLFS       ; set logical file parameters
                                                ;             !         jsr OPEN         ; open a logical file
                                                ;             !         bcs DiskError    ; check: disk error - yes: exit
                                                ;             !                          ; 
                                                ;             ! Name    .byte "#"        ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
CLOSE                       := $ffc3            ; Purpose     ! Close a logical file
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Remove an entry from the logical file tables
                                                ;             ! .A = the logical file number of the file to be closed
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! 0 (Tape write), 240, READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         lda #$0f  ; get logical file number
                                                ;             !         jsr CLOSE ; close logical file
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
CHKIN                       := $ffc6            ; Purpose     ! Specify a logical file as source of input in preparation for CHRIN or GETIN
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Must be called before data can be recieved with the CHRIN or GETIN
                                                ;             ! Any OPEN'd logical file can be defined as an input channel
                                                ;             ! The OPEN'd device must be an input device
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! For KEYBOARD input OPEN and CHKIN calls are not necessary
                                                ;             ! CHKIN will automatically send a TALK/SECOND to a serial device
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! OPEN
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! 0 (Tape read), 3, 5, 6 (see ErrorCodes)
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         jsr CLRCHN       ; close channels and restore defaults
                                                ;             !                          ; 
                                                ;             !         ldx #$0f         ; get command channel number
                                                ;             !         jsr CHKOUT       ; define an Output Channel
                                                ;             !         bcs DiskErr      ; check: disk error - yes: exit
                                                ;             !                          ; 
                                                ;             !         ldy #$00         ; init cmd string offset
                                                ;             ! CmdOut  lda BRCmd,y      ; read disk cmd string
                                                ;             !         beq DataGet      ; check: End Of Command - yes
                                                ;             !                          ; 
                                                ;             !         jsr CHROUT       ; output a character
                                                ;             !         iny              ; inc cmd string offset
                                                ;             !         bne CmdOut       ; always (hopefully)
                                                ;             !                          ; 
                                                ;             ! DataGet ldx #$02         ; get data channel number
                                                ;             !         jsr CHKIN        ; define an input channel
                                                ;             !         bcs DiskError    ; check: disk error - yes: exit
                                                ;             !                          ; 
                                                ;             !         ldy #$00         ; init count/data buffer offset
                                                ;             ! DataIn  jsr CHRIN        ; input a character
                                                ;             !         sta Data,y       ; store disk data byte into data buffer
                                                ;             !         iny              ; inc count/data buffer offset
                                                ;             !         bne DataIn       ; check: disk block read - no: continue
                                                ;             !                          ; 
                                                ;             ! BRCmd   .byte "u1:02 0 03 00" ; user cmd READ
                                                ;             !         .byte CR         ; <ENTER>
                                                ;             !         .byte $00        ; <END> of string
                                                ;             !                          ; 
                                                ;             ! Data    = *              ; 256 byte block data buffer
                                                ;             ! DiskErr = *              ; disk error handler
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
CHKOUT                      := $ffc9            ; Purpose     ! Specify a logical file as recipient of output in preparation for CHROUT
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Must be called before data can be send with the CHROUT
                                                ;             ! Any OPEN'd logical file can be defined as an output channel
                                                ;             ! The OPEN'd device must be an output device
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! For SCREEN output OPEN and CHKOUT calls are not necessary
                                                ;             ! CHKOUT will automatically send a LISTEN/SECOND to a serial device
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! OPEN
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! 0 (Tape write), 3, 5, 7 (see ErrorCodes)
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         jsr CLRCHN       ; close channels and restore defaults
                                                ;             !                          ; 
                                                ;             !         ldx #$02         ; get data channel number
                                                ;             !         jsr CHKOUT       ; define an output channel
                                                ;             !         bcs DiskErr      ; check: disk error - yes: exit
                                                ;             !                          ;        
                                                ;             !         ldy #$00         ; init count/data buffer offset
                                                ;             ! DataOut lda Data,y       ; get data byte
                                                ;             !         jsr CHROUT       ; output a character
                                                ;             !         iny              ; inc count/data buffer offset
                                                ;             !         bne DataOut      ; check: all data out - no: continue
                                                ;             !                          ; 
                                                ;             !         ldx #$0f         ; get command channel number
                                                ;             !         jsr CHKOUT       ; define an output channel
                                                ;             !                          ; 
                                                ;             !         ldy #$00         ; init cmd string offset
                                                ;             ! CmdOut  lda BWCmd,y      ; write disk block: u2:02_0_tt_ss<RETURN>
                                                ;             !         beq Exit         ; check: End Of Command - yes
                                                ;             !                          ; 
                                                ;             !         jsr CHROUT       ; output a character
                                                ;             !         iny              ; inc cmd string offset
                                                ;             !         bne CmdOut       ; always (hopefully)
                                                ;             !                          ; 
                                                ;             ! Exit    rts              ; 
                                                ;             ! 
                                                ;             ! BWCmd   .byte "u2:02 0 03 00" ; user cmd WRITE
                                                ;             !         .byte CR         ; <ENTER>
                                                ;             !         .byte $00        ; <END> of string
                                                ;             !                          ; 
                                                ;             ! Data    = *              ; 256 byte block data buffer
                                                ;             ! DiskErr = *              ; disk error handler
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
CLRCHN                      := $ffcc            ; Purpose     ! Clear all open channels
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Restore the I/O channels to their default values
                                                ;             !   Send UNTALK   1st to to a non default serial input channel
                                                ;             !   Send UNLISTEN 1st to to a non default serial output channel
                                                ;             !   Set default input  device to 0 - KEYBOARD
                                                ;             !   Set default output device to 3 - SCREEN
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! Automatically called by CLALL
                                                ;             ! By not calling this routine (and leaving listeners active on the serial bus)
                                                ;             !   several devices can receive the same data from the C64 at the same time
                                                ;             ! One way to take advantage of this would be to command the printer to TALK and the
                                                ;             !   disk to LISTEN. This would allow direct printing of a disk file
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! see CHKIN/CHKOUT
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
CHRIN                       := $ffcf            ; Purpose     ! Get a byte from the current logical input file set up by CHKIN
BASIN                       := CHRIN            ;             ! 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Fill .A with the next byte of data available from the current input device
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! If CHKIN was NOT called all input data is read from the KEYBOARD
                                                ;             ! The channel is left open after the call
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! If not KEYBOARD: OPEN and CHKIN
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! See READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! see CHKIN
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
CHROUT                      := $ffd2            ; Purpose     ! Send a byte to the logical file currently set up for output by CHKOUT
BSOUT                       := CHROUT           ;             ! 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Send the content of .A to the current output device
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! If CHKOUT was NOT called all output data is sent to the SCREEN
                                                ;             ! The channel is left open after the call
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; NOTE        ! The data is sent to all open output channels on the serial bus
                                                ;             ! To prevent this all other open output channels must be closed by CLRCHN first
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! If not SCREEN: OPEN and CHKOUT
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! See READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! see CHKOUT
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
LOAD                        := $ffd5            ; Purpose     ! Load/Verify RAM from a device 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Load data bytes from any input device directly into RAM
                                                ;             !   .A = $00 - LOAD
                                                ;             !   .A = $01 - VERIFY
                                                ;             ! SETLFS and SETNAM must be called in prepaparation
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! If the input device is OPEN'd with a SA of $00
                                                ;             !    the header info from the device is ignored
                                                ;             !    .X.Y must contain the starting load address
                                                ;             ! If the input device is OPEN'd with a SA of $01
                                                ;             !   the data is loaded to the location specified by the file header
                                                ;             ! The address of the highest RAM location loaded is returned in .X.Y.
                                                ;             ! No LOAD from KEYBOARD (0), RS-232 (2) or the SCREEN (3)
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! SETLFS / SETNAM
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! 0, 4, 5, 8 (bus only), 9, READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         lda #$02         ; set logical file number
                                                ;             !         ldx #$08         ; set device number
                                                ;             !         ldy #$00         ; set secondary command number (new load address)
                                                ;             !         jsr SETLFS       ; 
                                                ;             !                          ; 
                                                ;             !         lda #Name_X-Name ; load a with number of characters in file name
                                                ;             !         ldx #<Name       ; load x and y with address of file name
                                                ;             !         ldy #>Name       ; 
                                                ;             !         jsr SETNAM       ; 
                                                ;             !                          ; 
                                                ;             !         lda #$00         ; flag: load
                                                ;             !         ldx #<Start      ; alternate start address
                                                ;             !         ldy #>Start      ; 
                                                ;             !         jsr LOAD         ; 
                                                ;             !                          ; 
                                                ;             ! Name    .byte 'FileName' ; 
                                                ;             ! Name_X  = *              ; 
                                                ;             ! Start   = $2000          ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
SAVE                        := $ffd8            ; Purpose     ! Save contents of RAM to an I/O device
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Save the RAM contents to a logical file residing on DISK or TAPE
                                                ;             !   .A   = pointer to the ZP address containg the start address
                                                ;             !   .X.Y = pointer to the end address + $01
                                                ;             ! SETLFS and SETNAM must be called in prepaparation
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; NOTE        ! You can NOT SAVE to the KEYBOARD (0), RS-232 (2) or the SCREEN (3)
                                                ;             ! A file name is not required to SAVE to TAPE
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! SETLFS / SETNAM
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! 5, 8 (bus only), 9, READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         lda #$01         ; set logical file number
                                                ;             !         ldx #$08         ; set device number
                                                ;             !         ldy #$00         ; set secondary command number (none)
                                                ;             !         jsr SETLFS       ; 
                                                ;             !                          ; 
                                                ;             !         lda #NameX-Name  ; get file name length
                                                ;             !         ldx #<Name       ; get file name address
                                                ;             !         ldy #>Name       ; 
                                                ;             !         jsr SETNAM       ; 
                                                ;             !                          ; 
                                                ;             !         ldx #<Data       ; get start address
                                                ;             !         ldy #>Data       ; 
                                                ;             !         stx $fb          ; set Zero-Page start address
                                                ;             !         sty $fc          ; 
                                                ;             !                          ; 
                                                ;             !         lda #$fb         ; get indirect pointer to Zero-Page start address
                                                ;             !         ldx #<DataX      ; get end address + $01
                                                ;             !         ldy #>DataX      ; 
                                                ;             !         jsr SAVE         ; 
                                                ;             !         bcs error        ; check: disk error - yes: exit
                                                ;             !                          ; 
                                                ;             ! Name    .byte "FileName" ; 
                                                ;             ! NameX   = *              ; 
                                                ;             ! Data    .byte "The Data" ; 
                                                ;             ! DataX   = *              ; end + $01
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
SETTIM                      := $ffdb            ; Purpose     ! Set the real time (jiffy) clock
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Set the value of the software jiffy clock in ZP TIME
                                                ;             ! The clock's resolution is a 1/60th of a second (a jiffy)
                                                ;             ! The specified value should be less than $4F1A01 (24:00:00 hours)
                                                ;             !   .A = the most  significant byte
                                                ;             !   .X = the next  significant byte
                                                ;             !   .Y = the least significant byte
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         lda #00          ; MSB
                                                ;             !         ldx #>3600       ; set the clock to 10 minutes = 3600 jiffies
                                                ;             !         ldy #<3600       ; LSB
                                                ;             !         jsr SETTIM       ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
RDTIM                       := $ffde            ; Purpose     ! Read the real time (jiffy) clock 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Read the value of the software jiffy clock from ZP TIME
                                                ;             ! The clock's resolution is a 1/60th of a second (a jiffy)
                                                ;             !   .A contains the most  significant byte
                                                ;             !   .X contains the next  significant byte
                                                ;             !   .Y contains the least significant byte
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         jsr RDTIM        ; read clock
                                                ;             !         sty Time+$00     ; LSB
                                                ;             !         stx Time+$01     ; 
                                                ;             !         sta Time+$02     ; MSB
                                                ;             !                          ; 
                                                ;             ! Time    = *              ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
STOP                        := $ffe1            ; Purpose     ! Check if <STOP> key is pressed
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! If the <STOP> key was pressed during a UDTIM call the .Z-Flag is set
                                                ;             ! All other flags remain unchanged
                                                ;             ! The channels will be reset to their default values
                                                ;             ! If the <STOP> key is not pressed
                                                ;             !   .A will contain a byte representing the last row of the KEYBOARD scan
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! Certain other keys can be checked this way
                                                ;             !   - indicator at ZP STKEY
                                                ;             !   - if pressed call CLRCHN and clear KEYBOARD buffer
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example 1   !          jsr UDTIM       ; scan for <STOP>
                                                ;             !          jsr STOP        ; test <STOP>
                                                ;             !          bne Cont        ; check: <STOP> key - no
                                                ;             !          jmp Break       ; was <STOP>
                                                ;             !                          ; 
                                                ;             ! Cont     = *             ; 
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example 2   ! SHFLAG   = $028d         ; %001 - <SHIFT>, %010 - <CONTROL>, %100 - <C=> key
                                                ;             !                          ; 
                                                ;             !          ldx #$08        ; get logical file number
                                                ;             !          jsr CHKIN       ; 
                                                ;             !          bcs EndRead     ; check: error - yes: exit
                                                ;             !                          
                                                ;             ! ReadLoop jsr CHRIN       ; get a character from serial bus
                                                ;             !          bcs EndRead     ; check: error - yes: exit
                                                ;             !                          ; 
                                                ;             !          jsr CHROUT      ; print the character
                                                ;             !          jsr READST      ; get the status byte for last I/O
                                                ;             !          bne EndRead     ; check: <EOF> or disk error - yes: quit
                                                ;             !                          ; 
                                                ;             !          jsr STOP        ; check the <STOP> key
                                                ;             !          beq EndRead     ; check: <STOP> pressed - yes: quit
                                                ;             !                          ; 
                                                ;             ! Pause    lda SHFLAG      ; check <SHIFT>, <CONTROL> or <C=> key pressed
                                                ;             !          bne Pause       ; check: pressed - no: SHFLAG_NONE - pause until one of them is held down
                                                ;             !          beq ReadLoop    ; always - continue
                                                ;             !                          ; 
                                                ;             ! EndRead  jsr CLRCHN      ; clear the bus
                                                ;             !          lda #$08        ; get logical file #
                                                ;             !          jsr CLOSE       ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
GETIN                       := $ffe4            ; Purpose     ! Get a char from the default default input device in ZP DFLTN
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! KEYBOARD: get a char from KEYD KEYBOARD buffer
                                                ;             !           .A = 1st char (an ASCII value) of the KEYBOARD buffer KEYD 
                                                ;             !                the rest of the chars are moved up one position
                                                ;             !           .A = $00 if KEYD is empty (.Z = 1)
                                                ;             ! RS-232  : get byte from the RS-232 receive buffer
                                                ;             ! others  : get byte via CHRIN
                                                ;             !           CHRIN does not retrieve anything until <RETURN>
                                                ;             !           then returns a char from the logical screen line
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! If not KEYBOARD: OPEN and CHKIN
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; RC          ! See READST
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! see SCNKEY
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
CLALL                       := $ffe7            ; Purpose     ! Close all files and select default I/O channels
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! The pointers into the open file table are reset thus closing all files
                                                ;             ! If the current output device is a serial device send an UNLISTEN
                                                ;             ! If the current input  device is a serial device send an UNTALK
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! CLRCHN is automatically called to reset the I/O channels
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     ! see OPEN
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
UDTIM                       := $ffea            ; Purpose     ! Increment real time (jiffy) clock
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Update the system clock
                                                ;             ! Normally called every 1/60th second
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! A user program with IRQ disabled must call UDTIM to update the time
                                                ;             ! In addition STOP must be called if the <STOP> key is to remain functional
                                                ;             !   - Update Time of Day [TIME] (software clock)
                                                ;             !   - Update <STOP< key indicator [STKEY]
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
SCREEN                      := $ffed            ; Purpose     ! Return the number of the screen columns and rows
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Return the format of the screen (40 columns in .X and 25 lines in .Y)
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Note        ! Can be used to determine what machine a program is running on
                                                ;             ! Implemented on the C64 to help upward compatibility of a program
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         jsr SCREEN       ; 
                                                ;             !         stx MaxCol       ; 
                                                ;             !         sty MaxRow       ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
PLOT                        := $fff0            ; Purpose     ! Read/Set X,Y cursor position on screen
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! .C = 1 / get the current position of the cursor on the screen
                                                ;             !   .Y = cursor col (0-39)
                                                ;             !   .X = cursor row (0-24)
                                                ;             ! .C = 0 - move the cursor to the position specified in .X.Y
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         ldx #$02         ; get row 2
                                                ;             !         ldy #$05         ; get col 5
                                                ;             !         clc              ; set FLAG move the cursor
                                                ;             !         jsr PLOT         ; 
; ------------------------------------------------------------+---------------------------------------------------------------------------- ;
IOBASE                      := $fff3            ; Purpose     ! Returns the base address of the I/O registers that control the CIA chips
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Description ! Set .X.Y to the RAM address where the memory mapped I/O devices are located
                                                ;             ! The address can then be used as an offset to access the memory mapped I/O devices
                                                ;             !   .X = LO address
                                                ;             !   .Y = HI address
                                                ;             ! May ensure a PGMs compatibilty with future versions of the C64
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Preps       ! none
                                                ; RC          ! none
                                                ; ------------+---------------------------------------------------------------------------- ;
                                                ; Example     !         jsr IOBASE       ; 
                                                ;             !         stx Base         ; set address register pointer
                                                ;             !         sty Base + $01   ; 
                                                ;             !                          ; 
                                                ;             !         ldy #$02         ; get offset for CIDDRA of the user port
                                                ;             !         lda #$00         ; 
                                                ;             !         sta (Base),y     ; set CIDDRA to $00
; ------------------------------------------------------------'---------------------------------------------------------------------------- ;
; OVERVIEW
; -------+------+--------+------+-----------------------------------+----------------------------------------+---------------------+-------+
; Label  ! Jump ! Vector ! Real ! Function Description              ! Function Input/Output Parameters       !   Register Usage    ! Stack ! 
;        ! addr !  addr  ! code !                                   !                                        ! entry  return used  !       ! 
; -------+------+--------+------+-----------------------------------+----------------------------------------+---------------------+-------+
; CINT   ! ff81 !  ----  ! ff5b ! init VIC & screen editor          !                                        ! - - -  - - -  A X Y !   4   ! 
; IOINIT ! ff84 !  ----  ! fda3 ! initialize CIA & IRQ              !                                        ! - - -  - - -  A X Y !   4   ! 
; RAMTAS ! ff87 !  ----  ! fd50 ! RAM test & search RAM end         !                                        ! - - -  - - -  A X Y !   4   ! 
; RESTOR ! ff8a !  ----  ! fd15 ! restore default I/O vectors       !                                        ! - - -  - - -  A - Y !   2   ! 
; VECTOR ! ff8d !  ----  ! fd1a ! read/set I/O vectors              ! in : C=0 moves from Y/X to vectors     ! - X Y  - X -  A - Y !   2   ! 
;        !      !        !      !                                   !      C=1 moves vectors to Y/X          ! - X Y  - X -  A - Y !       ! 
; SETMSG ! ff90 !  ----  ! fe18 ! enable/disable KERNAL messages    ! in : A bit7=1 error msgs on            ! A - -  - - -  A - - !   2   ! 
;        !      !        !      !                                   !        bit6=1 control msgs on          !                     !       ! 
; SECOND ! ff93 !  ----  ! edb9 ! send secondary addr after listen  ! in : A=secondary address               ! A - -  - - -  A - - !   8   ! 
; TKSA   ! ff96 !  ----  ! edc7 ! send secondary addr after talk    ! in : A=secondary address               ! A - -  - - -  A - - !   8   ! 
; MEMTOP ! ff99 !  ----  ! fe25 ! read/set top of memory            ! in : C=0; Y/X address                  ! - X Y  - X Y  - - - !   2   ! 
;        !      !        !      !                                   ! out: C=1; Y/X address                  ! - - -  - X Y  - X Y !       ! 
; MEMBOT ! ff9c !  ----  ! fe34 ! read/set bottom of memory         ! in : C=0; Y/X address                  ! - X Y  - X Y  - - - !   0   ! 
;        !      !        !      !                                   ! out: C=1; Y/X address                  ! - - -  - X Y  - X Y !       ! 
; SCNKEY ! ff9f !  ----  ! ea87 ! scan keyboard                     !                                        ! - - -  - - -  A X Y !   5   ! 
; SETTMO ! ffa2 !  ----  ! fe21 ! set IEEE timeout                  ! in : A bit7=1 disable, bit7=0 enable   ! A - -  A - -  - - - !   2   ! 
; ACPTR  ! ffa5 !  ----  ! ee13 ! input byte from SERIAL            ! out: A=byte, C=1 and ST=2 if timeout   ! - - -  A - -  A - - !  13   ! 
; CIOUT  ! ffa8 !  ----  ! eddd ! output byte to SERIAL             ! in : A=byte, C=1 and ST=3 if timeout   ! A - -  A - -  - - - !   5   ! 
; UNTLK  ! ffab !  ----  ! edef ! untalk all SERIAL devices         !                                        ! - - -  - - -  A - - !   8   ! 
; UNLSN  ! ffae !  ----  ! edfe ! unlisten all SERIAL devices       !                                        ! - - -  - - -  A - - !   8   ! 
; LISTEN ! ffb1 !  ----  ! ed0c ! make SERIAL device listen         ! in : A=device number                   ! A - -  - - -  A - - !   0   ! 
; TALK   ! ffb4 !  ----  ! ed09 ! make SERIAL device talk           ! in : A=device number                   ! A - -  - - -  A - - !   8   ! 
; READST ! ffb7 !  ----  ! fe07 ! read I/O status byte              ! out: A=status byte                     ! - - -  A - -  A - - !   2   ! 
; SETLFS ! ffba !  ----  ! fe00 ! set file parameters               ! in : A=logical file number             ! A X Y  A X Y  - - - !   2   ! 
;        !      !        !      !                                   !      X=device number                   !                     !       ! 
;        !      !        !      !                                   !      Y=secondary addr                  !                     !       ! 
; SETNAM ! ffbd !  ----  ! fdf9 ! set file name                     ! in : A=length of filename              ! A X Y  A X Y  - - - !   2   ! 
;        !      !        !      !                                   !      Y/X=pointer to name addr          !                     !       ! 
; OPEN   ! ffc0 !  031a  ! f34a ! open a logical file after         ! out: A=error# if C=1                   ! - - -  - - -  A X Y !   0   ! 
;        !      !        !      ! SETLFS and SETNAM                 !                                        !                     !       !
; CLOSE  ! ffc3 !  031c  ! f291 ! close a logical file              ! in : A=logical file number             ! A - -  - - -  A X Y !   2+  ! 
; CHKIN  ! ffc6 !  031e  ! f20e ! open channel for input            ! in : X=logical file number             ! - X -  - - -  A X - !   0   ! 
; CHKOUT ! ffc9 !  0320  ! f250 ! open channel for output           ! in : X=logical file number             ! - X -  - - -  A X - !   4+  ! 
; CLRCHN ! ffcc !  0322  ! f333 ! restore default devices           !                                        ! - - -  - - -  A X - !   9   ! 
; CHRIN  ! ffcf !  0324  ! f157 ! input character                   ! out: A=character, C=1 and ST=error     ! - - -  A - -  A - - !   7+  ! 
; CHROUT ! ffd2 !  0326  ! f1ca ! output character                  ! in : A=character, C=1 and ST=error     ! A - -  A - -  - - - !   8+  ! 
; LOAD   ! ffd5 !  0330  ! f49e ! load after call SETLFS and SETNAM ! in : A=0 load, a=1 verify              ! A X Y  A X Y  A X Y !   0   ! 
;        !      !        !      !                                   !      Y/X = dest.addr if sec.addr=0     !                     !       ! 
; SAVE   ! ffd8 !  0332  ! f5dd ! save after call SETLFS,SETNAM     ! in : A=zero page pointer to start.addr ! A X Y  - - -  A X Y !   0   ! 
;        !      !        !      !                                   !      Y/X=ending address                !                     !       ! 
; SETTIM ! ffdb !  ----  ! f6e4 ! set jiffy clock                   ! in : A=MSB, X=middle, Y=LSB            ! A X Y  - - -  - - - !   2   ! 
; RDTIM  ! ffde !  ----  ! f6dd ! read jiffy clock                  ! out: A=MSB, X=middle, Y=LSB            ! - - -  A X Y  A X Y !   2   ! 
; STOP   ! ffe1 !  0328  ! f6ed ! check stop key                    ! out: Z=0 if STOP not used; X unchanged ! - - -  A - -  A - - !   0   ! 
;        !      !        !      !                                   !      Z=1 if STOP used; X changed       ! - - -  A - -  A X - !       ! 
;        !      !        !      !                                   !      A=last line of keyboard matrix    !                     !       ! 
; GETIN  ! ffe4 !  032a  ! f13e ! get a byte from channel           ! out: keyboard:A=0 if puffer empty      ! - - -  A - -  A X Y !   7+  ! 
;        !      !        !      !                                   !      RS232 : status byte               ! - - -  A - -  A - - !       ! 
;        !      !        !      !                                   !      serial: status byte               ! - - -  A - -  A - - !       ! 
;        !      !        !      !                                   !      tape  : status byte               ! - - -  A - -  A - Y !       ! 
; CLALL  ! ffe7 !  032c  ! f32f ! close or abort all files          !                                        ! - - -  - - -  A X - !  11   ! 
; UDTIM  ! ffea !  ----  ! f69b ! update jiffy clock                !                                        ! - - -  - - -  A X - !   2   ! 
; SCREEN ! ffed !  ----  ! e505 ! return screen size                ! out: X=columns, Y=rows                 ! - - -  - X Y  - X Y !   2   ! 
; PLOT   ! fff0 !  ----  ! e50a ! read/set cursor position          ! in : C=0, X=row, Y=column              ! - X Y  - X Y  - - - !   2   ! 
;        !      !        !      !                                   ! out: C=1, X=row, Y=column              ! - - -  - X Y  - X Y !       ! 
; IOBASE ! fff3 !  ----  ! e500 ! returns the addr of I/O devices   ! out: Y/X=addr($DC00)                   ! - - -  - X Y  - X Y !   2   ! 
; -------+------+--------+------+-----------------------------------+----------------------------------------+---------------------+-------+
