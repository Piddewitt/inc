; -------------------------------------------------------------------------------------------------------------- ;
; VIC 1541 - File Data Block Layout
; -------------------------------------------------------------------------------------------------------------- ;
; Global File Structure
; -------------------------------------------------------------------------------------------------------------- ;
FILE_LINK                   = $00               ;       link to the next PGM file data block
FILE_LINK_TRK                 = $00             ;       TRACK location of the next PGM file data block
FILE_LINK_TRK_LAST              = $00           ; Flag: last file data block
FILE_LINK_SEC                 = $01             ;       SECTOR location of the next PGM file data block
FILE_DATA                   = $02               ;       payload data start
; -------------------------------------------------------------------------------------------------------------- ;
; Structure of the different File Types
; -------------------------------------------------------------------------------------------------------------- ;


; -------------------------------------------------------------------------------------------------------------- ;
; Program File Data Block
; -------------------------------------------------------------------------------------------------------------- ;
PRG_LINK                    = $00               ;       link to the next PGM file data block
PRG_LINK_TRK                  = $00             ;       TRACK location of the next PGM file data block
PRG_LINK_TRK_LAST               = $00           ; Flag: last PGM file data block
                                                ;       PRG_LINK_SEC then contains the offset of the last byte used
PRG_LINK_SEC                  = $01             ;       SECTOR location of the next PGM file data block
; -------------------------------------------------------------------------------------------------------------- ;
; Next File Data Blocks - no load address
; -------------------------------------------------------------------------------------------------------------- ;
PRG_DATA_NEXT               = $02               ;       start of data subsequent PGM file blocks
PRG_DATA_NEXT_MAX             = $fe             ; Num : amount of PGM data bytes
; -------------------------------------------------------------------------------------------------------------- ;
; First File Data Block - load address
; -------------------------------------------------------------------------------------------------------------- ;
PRG_LOAD_ADR                = $02               ;       program load address (only available in 1st PRG block)
PRG_LOAD_ADR_LO               = $02             ; 
PRG_LOAD_ADR_HI               = $03             ; 
; -------------------------------------------------------------------------------------------------------------- ;
; First File Data Block - load address
; -------------------------------------------------------------------------------------------------------------- ;
PRG_DATA_FIRST              = $04               ;       start of data 1st PGM file block
PRG_DATA_FIRST_MAX            = $fc             ; Num : amount of PGM data bytes
; -------------------------------------------------------------------------------------------------------------- ;


; -------------------------------------------------------------------------------------------------------------- ;
; Sequential File Data Block
; -------------------------------------------------------------------------------------------------------------- ;
SEQ_LINK                    = $00               ;       link to the next SEQ file data block
SEQ_LINK_TRK                  = $00             ;       TRACK  location of the next SEQ file data block
SEQ_LINK_LAST                   = $00           ; Flag: last SEQ file data block
                                                ;       SEQ_LINK_SEC then contains the offset of the last byte used
SEQ_LINK_SEC                  = $01             ;       SECTOR location of the next SEQ file data block
; -------------------------------------------------------------------------------------------------------------- ;
SEQ_DATA                    = $02               ;       start of SEQ file data
SEQ_DATA_MAX                  = $fe             ; Num : SEQ file data part length (without SEQ_LINK)
; -------------------------------------------------------------------------------------------------------------- ;


; -------------------------------------------------------------------------------------------------------------- ;
; Relative File DATA Block - Contains Fixed Length Records
; -------------------------------------------------------------------------------------------------------------- ;
REL_DATA_LINK               = $00               ;       link to the next REL file data block
REL_DATA_LINK_TRK             = $00             ;       TRACK location of the next REL file data block
REL_DATA_LINK_TRK_LAST          = $00           ; Flag: last REL file data block
REL_DATA_LINK_SEC             = $01             ;       SECTOR location of the next REL file data block
                                                ;       REL_DATA_LINK_SEC then contains the offset of the last byte used
; -------------------------------------------------------------------------------------------------------------- ;
REL_DATA_RECORDS            = $02               ;       start of RECORD data
REL_DATA_MAX                  = $fe             ; Num : REL file data part length (without REL_DATA_LINK)
; -------------------------------------------------------------------------------------------------------------- ;


; -------------------------------------------------------------------------------------------------------------- ;
; Relative File SIDE SECTOR Block
; -------------------------------------------------------------------------------------------------------------- ;
REL_SS_LINK                 = $00               ;       link to the next REL file SIDE SECTOR block
REL_SS_LINK_TRK               = $00             ;       TRACK location of the next REL file SIDE SECTOR block
REL_SS_LINK_TRK_LAST            = $00           ; Flag: last REL file data block
                                                ;       REL_SS_LINK_SEC then contains the offset of the last byte used
REL_SS_LINK_SEC               = $01             ;       SECTOR location of the next REL file SIDE SECTOR block
; -------------------------------------------------------------------------------------------------------------- ;
REL_SS_CTRL                 = $02               ;       SIDE SECTOR block control
REL_SS_CTRL_BLOCK_NUM         = $02             ; Num : side sector block number - count starts with $00
REL_SS_CTRL_REC_LEN           = $03             ; Num : record length
; -------------------------------------------------------------------------------------------------------------- ;
; REL File SIDE SECTOR Block - TRACK and SECTOR link list of $06 side sector blocks
; -------------------------------------------------------------------------------------------------------------- ;
REL_SS_LINK_LIST            = $04               ;       TRACK/SECTOR list of links for 6 side sector blocks
REL_SS_LINK_LIST_MAX          = $06             ; Num : max 6 TRACK/SECTOR entries in list
REL_SS_LINK_LIST_LEN          = REL_SS_LINK_LIST_MAX * $02 ; $0c
REL_SS_LINK_LIST_IDX        .brept REL_SS_LINK_LIST_MAX ; 
REL_SS_LINK_LIST_TRK          = REL_SS_LINK_LIST + REL_SS_LINK_LIST_IDX + $00 ; TRACK  side sector #00-#05
REL_SS_LINK_LIST_SEC          = REL_SS_LINK_LIST + REL_SS_LINK_LIST_IDX + $01 ; SECTOR side sector #00-#05
                            .next               ; 
; -------------------------------------------------------------------------------------------------------------- ;
; REL File SIDE SECTOR Block - TRACK and SECTOR link list of $78 (120) data blocks
; -------------------------------------------------------------------------------------------------------------- ;
REL_DATA_LINK_LIST          = $10               ;       TRACK/SECTOR link list for data blocks
REL_DATA_LINK_LIST_MAX        = $78             ; Num : max 120 TRACK/SECTOR link entries in list
REL_DATA_LINK_LIST_LEN      = REL_DATA_LINK_LIST_MAX * $02 ; $f0
REL_DATA_LINK_LIST_IDX      .brept REL_DATA_LINK_LIST_MAX ; 
REL_DATA_LINK_LIST_TRK        = REL_DATA_LINK_LIST + REL_DATA_LINK_LIST_IDX + $00 ; TRACK  of data block #00-#120
REL_DATA_LINK_LIST_SEC        = REL_DATA_LINK_LIST + REL_DATA_LINK_LIST_IDX + $01 ; SECTOR of data block #00-#120
                            .next               ; 
; -------------------------------------------------------------------------------------------------------------- ;
