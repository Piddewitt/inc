; -------------------------------------------------------------------------------------------------------------- ;
; VIC 1541 - Directory Block Layout
; -------------------------------------------------------------------------------------------------------------- ;
; Always on TRACK 18 (Zone 2)
; Zone 2 TRACKs (18-24) hold 19 SECTORs per TRACK (00-18)
; BAM at SECTOR (00)
; 18 SECTORs free for file entries
; Max 144 files per diskette (18 SECTORs with 8 entries each)
; Unsued (NULL) entries filled up with $00
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILE_ENTRY_01           = $00               ;       1st file entry - bytes $00-$1f ($20)
DIR_FILE_ENTRY_01_OFF         = $00             ;       entry offset
DIR_FILE_ENTRY_01_LEN         = DIR_FILE_ENTRY_LEN ;    entry length
; -------------------------------------------------------------------------------------------------------------- ;
; DIR Link Address
; -------------------------------------------------------------------------------------------------------------- ;
DIR_LINK                      = $00             ;       link to the next DIR block
DIR_LINK_TRK                    = $00           ;       TRACK location of next DIR block
DIR_LINK_TRK_LAST                 = $00         ; Flag: last DIR data block
                                                ;       DIR_LINK_SEC then contains the offset of the last byte used
DIR_LINK_SEC                    = $01           ;       SECTOR location of next DIR block
; -------------------------------------------------------------------------------------------------------------- ;
; DIR Data 1st Entry
; -------------------------------------------------------------------------------------------------------------- ;
DIR_DATA                      = $02             ;       DIR data start
; -------------------------------------------------------------------------------------------------------------- ;
; File types
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILTYP                      = $02           ;       actual file type
DIR_FILTYP_MASK                   = %00000111   ;       file types
DIR_FILTYP_MASK_X                 = %00001111   ;       file types extended (with unused bit3)
                                  
DIR_FILTYP_DEL                    = %00000000   ;       scratched file entry
DIR_FILTYP_SEQ                    = %00000001   ;       sequential file entry
DIR_FILTYP_PRG                    = %00000010   ;       program file entry
DIR_FILTYP_USR                    = %00000011   ;       special access file entry
DIR_FILTYP_REL                    = %00000100   ;       direct access file entry
; -------------------------------------------------------------------------------------------------------------- ;
; DIR_FILTYP Layout
; -------------------------------------------------------------------------------------------------------------- ;
; Bit0-Bit2: filetype
;     : 000 (0) - DEL
;     : 001 (1) - SEQ
;     : 010 (2) - PRG
;     : 011 (3) - USR
;     : 100 (4) - REL
; Bit3: unused
; Bit4: unused
; Bit5: Flag: Replace (file replacement: only present during a 'save-@' or '@0:')
; Bit6: Flag: Locked  (if set    : produces ">" locked files)
; Bit7: Flag: Closed  (if not set: produces "*" splat  files)
; -------------------------------------------------------------------------------------------------------------- ;
; $00-$04 - Flag: UNCLOSED filetype (bit7=0)
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILTYP_OPEN                   = %00000000 ; $00 - unclosed filetype (bit7=0) --> '*PRG'
DIR_FILTYP_MASK_OPEN                = DIR_FILTYP_OPEN   | DIR_FILTYP_MASK                     ; %00000111 ; 
DIR_FILTYP_DEL_OPEN                 = DIR_FILTYP_OPEN   | DIR_FILTYP_DEL                      ; %00000000 ; $00 - *DEL
DIR_FILTYP_SEQ_OPEN                 = DIR_FILTYP_OPEN   | DIR_FILTYP_SEQ                      ; %00000001 ; $01 - *SEQ
DIR_FILTYP_PRG_OPEN                 = DIR_FILTYP_OPEN   | DIR_FILTYP_PRG                      ; %00000010 ; $02 - *PRG
DIR_FILTYP_USR_OPEN                 = DIR_FILTYP_OPEN   | DIR_FILTYP_USR                      ; %00000011 ; $03 - *USR
DIR_FILTYP_REL_OPEN                 = DIR_FILTYP_OPEN   | DIR_FILTYP_REL                      ; %00000100 ; $04 - *REL <-- cannot occur
; -------------------------------------------------------------------------------------------------------------- ;
; $80-$84 - Flag: CLOSED filetype (bit7=1)
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILTYP_CLOSED                 = %10000000 ; $80 - closed filetype (bit7=1) --> 'PRG'
DIR_FILTYP_MASK_CLOSED              = DIR_FILTYP_CLOSED | DIR_FILTYP_MASK                     ; %10000111 ; 
DIR_FILTYP_DEL_CLOS                 = DIR_FILTYP_CLOSED | DIR_FILTYP_DEL                      ; %10000000 ; $80 - DEL
DIR_FILTYP_SEQ_CLOS                 = DIR_FILTYP_CLOSED | DIR_FILTYP_SEQ                      ; %10000001 ; $81 - SEQ
DIR_FILTYP_PRG_CLOS                 = DIR_FILTYP_CLOSED | DIR_FILTYP_PRG                      ; %10000010 ; $82 - PRG
DIR_FILTYP_USR_CLOS                 = DIR_FILTYP_CLOSED | DIR_FILTYP_USR                      ; %10000011 ; $83 - USR
DIR_FILTYP_REL_CLOS                 = DIR_FILTYP_CLOSED | DIR_FILTYP_REL                      ; %10000100 ; $84 - REL
; -------------------------------------------------------------------------------------------------------------- ;
; $a0-$a4 - Flag: REPLACE filetype if CLOSE - only present during a 'save-@' or "@0:" file replacement
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILTYP_SAVING                 = %00100000 ; $20 - replacing filetype (bit5=1) --> '@PRG'
DIR_FILTYP_MASK_SAVE                = DIR_FILTYP_CLOSED | DIR_FILTYP_SAVING | DIR_FILTYP_MASK ; %10100111 ; 
DIR_FILTYP_DEL_SAVE                 = DIR_FILTYP_CLOSED | DIR_FILTYP_SAVING | DIR_FILTYP_DEL  ; %10100000 ; $a0 - DEL
DIR_FILTYP_SEQ_SAVE                 = DIR_FILTYP_CLOSED | DIR_FILTYP_SAVING | DIR_FILTYP_SEQ  ; %10100001 ; $a1 - SEQ
DIR_FILTYP_PRG_SAVE                 = DIR_FILTYP_CLOSED | DIR_FILTYP_SAVING | DIR_FILTYP_PRG  ; %10100010 ; $a2 - PRG
DIR_FILTYP_USR_SAVE                 = DIR_FILTYP_CLOSED | DIR_FILTYP_SAVING | DIR_FILTYP_USR  ; %10100011 ; $a3 - USR
DIR_FILTYP_REL_SAVE                 = DIR_FILTYP_CLOSED | DIR_FILTYP_SAVING | DIR_FILTYP_REL  ; %10100100 ; $a4 - REL <-- cannot occur
; -------------------------------------------------------------------------------------------------------------- ;
; $c0-$c4 - Flag: LOCKed filetype if CLOSE - Protection - must be set manually as noc DOS handling functions exist
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILTYP_LOCKED                 = %01000000 ; $40 - locked filetype (bit6=1) --> 'PRG<'
DIR_FILTYP_MASK_LOCK                = DIR_FILTYP_CLOSED | DIR_FILTYP_LOCKED | DIR_FILTYP_MASK ; %11000111 ; 
DIR_FILTYP_DEL_LOCK                 = DIR_FILTYP_CLOSED | DIR_FILTYP_LOCKED | DIR_FILTYP_DEL  ; %11000000 ; $c0 - DEL<
DIR_FILTYP_SEQ_LOCK                 = DIR_FILTYP_CLOSED | DIR_FILTYP_LOCKED | DIR_FILTYP_SEQ  ; %11000001 ; $c1 - SEQ<
DIR_FILTYP_PRG_LOCK                 = DIR_FILTYP_CLOSED | DIR_FILTYP_LOCKED | DIR_FILTYP_PRG  ; %11000010 ; $c2 - PRG<
DIR_FILTYP_USR_LOCK                 = DIR_FILTYP_CLOSED | DIR_FILTYP_LOCKED | DIR_FILTYP_USR  ; %11000011 ; $c3 - USR<
DIR_FILTYP_REL_LOCK                 = DIR_FILTYP_CLOSED | DIR_FILTYP_LOCKED | DIR_FILTYP_REL  ; %11000100 ; $c4 - REL<
; -------------------------------------------------------------------------------------------------------------- ;
; File name and start location
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILE                        = $03           ;       location first block of file
DIR_FILE_START_TRK                = $03         ;       1st TRACK number of file
DIR_FILE_START_SEC                = $04         ;       1st SECTOR number of file
DIR_FILE_NAME                   = $05           ;       filename padded with <shift_space> ($a0)
DIR_FILE_NAME_START               = $05         ;       start of file name
DIR_FILE_NAME_END                 = $14         ;       end of file name
DIR_FILE_NAME_LEN               = DIR_FILE_NAME_END - DIR_FILE_NAME ; 16 character max length
; -------------------------------------------------------------------------------------------------------------- ;
; REL file side SECTOR blocks start / record lengths (REL file only)
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILE_REL                    = $15           ; 
DIR_FILE_REL_SS_TRK               = $15         ;       REL file starting TRACK  1st set of of side-sector blocks ($00)
DIR_FILE_REL_SS_SEC               = $16         ;       REL file starting SECTOR 1st set of of side-sector blocks ($00)
DIR_FILE_REL_RECL                 = $17         ;       REL file record length                                    ($00)
; -------------------------------------------------------------------------------------------------------------- ;
; Free
; -------------------------------------------------------------------------------------------------------------- ;
DIR_UNUSED                      = $18           ;       $00
DIR_UNUSED1                       = $18         ;       $00
DIR_UNUSED2                       = $19         ;       $00
DIR_UNUSED3                       = $1a         ;       $00
DIR_UNUSED4                       = $1b         ;       $00
; -------------------------------------------------------------------------------------------------------------- ;
; File replacement work area
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILE_REPL                   = $1c           ;       TRACK/SECTOR of a new file when overwritten with 'save-@' or "@0:"
DIR_FILE_REPL_TRK                 = $1c         ;       used during @-replacement - TRACK  number start of new replacement file
DIR_FILE_REPL_SEC                 = $1d         ;       used during @-replacement - SECTOR number start of new replacement file
; -------------------------------------------------------------------------------------------------------------- ;
; File block size
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILE_SIZE                   = $1e           ;       file size in blocks
DIR_FILE_SIZE_LO                  = $1e         ;       
DIR_FILE_SIZE_HI                  = $1f         ;       
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILE_ENTRY_LEN          = DIR_FILE_SIZE_HI + $01 ; 
; -------------------------------------------------------------------------------------------------------------- ;
; DIR Data of the next 7 Entries - now the 1st $02 DIR_LINK bytes of each entry are unused and should be $00/$00
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILE_ENTRY_02           = $01                                          ; 2nd file entry - bytes $20-$3f ($20)
DIR_FILE_ENTRY_02_OFF         = DIR_FILE_ENTRY_LEN * DIR_DIR_FILE_ENTRY_02 ; entry offset
DIR_FILE_ENTRY_02_LEN         = DIR_FILE_ENTRY_LEN                         ; entry length
DIR_FILE_ENTRY_03           = $02                                          ; 3rd file entry - bytes $40-$5f ($20)
DIR_FILE_ENTRY_03_OFF         = DIR_FILE_ENTRY_LEN * DIR_DIR_FILE_ENTRY_03 ; entry offset
DIR_FILE_ENTRY_03_LEN         = DIR_FILE_ENTRY_LEN                         ; entry length
DIR_FILE_ENTRY_04           = $03                                          ; 4th file entry - bytes $60-$7f ($20)
DIR_FILE_ENTRY_04_OFF         = DIR_FILE_ENTRY_LEN * DIR_DIR_FILE_ENTRY_04 ; entry offset
DIR_FILE_ENTRY_04_LEN         = DIR_FILE_ENTRY_LEN                         ; entry length
DIR_FILE_ENTRY_05           = $04                                          ; 5th file entry - bytes $80-$9f ($20)
DIR_FILE_ENTRY_05_OFF         = DIR_FILE_ENTRY_LEN * DIR_DIR_FILE_ENTRY_05 ; entry offset
DIR_FILE_ENTRY_05_LEN         = DIR_FILE_ENTRY_LEN                         ; entry length
DIR_FILE_ENTRY_06           = $05                                          ; 6th file entry - bytes $a0-$bf ($20)
DIR_FILE_ENTRY_06_OFF         = DIR_FILE_ENTRY_LEN * DIR_DIR_FILE_ENTRY_06 ; entry offset
DIR_FILE_ENTRY_06_LEN         = DIR_FILE_ENTRY_LEN                         ; entry length
DIR_FILE_ENTRY_07           = $06                                          ; 7th file entry - bytes $c0-$df ($20)
DIR_FILE_ENTRY_07_OFF         = DIR_FILE_ENTRY_LEN * DIR_DIR_FILE_ENTRY_07 ; entry offset
DIR_FILE_ENTRY_07_LEN         = DIR_FILE_ENTRY_LEN                         ; entry length
DIR_FILE_ENTRY_08           = $07                                          ; 8th file entry - bytes $e0-$ff ($20)
DIR_FILE_ENTRY_08_OFF         = DIR_FILE_ENTRY_LEN * DIR_DIR_FILE_ENTRY_08 ; entry offset
DIR_FILE_ENTRY_08_LEN         = DIR_FILE_ENTRY_LEN                         ; entry length
; -------------------------------------------------------------------------------------------------------------- ;
DIR_FILE_ENTRY_MAX          = DIR_FILE_ENTRY_08 + $01                      ; max number of DIR entries
; -------------------------------------------------------------------------------------------------------------- ;
DIR_LEN                     = DIR_FILE_ENTRY_LEN * DIR_FILE_ENTRY_MAX - $01 ; 
; -------------------------------------------------------------------------------------------------------------- ;
