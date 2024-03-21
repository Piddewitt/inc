; -------------------------------------------------------------------------------------------------------------- ;
; VIC 1541 - Data Block Layout
; -------------------------------------------------------------------------------------------------------------- ;
; The entire DATA_BLOCK including the SYNC is rewritten each time data is recorded on a Disk
; -------------------------------------------------------------------------------------------------------------- ;
DATA_SYNC                   = $00               ;       1-bits - indicate a HEADER or DATA block following
DATA_SYNC_VAL                 = %11111111       ;       
DATA_SYNC_LEN                 = $05             ;       NUMSYN
; -------------------------------------------------------------------------------------------------------------- ;


; -------------------------------------------------------------------------------------------------------------- ;
; DATA_BLOCK on Disk is GCR encoded to avoid two subesquent 0-bits and more than 9 subsequent 1-bits (SYNC)
; -------------------------------------------------------------------------------------------------------------- ;
; the original 260 8-bit bytes are
; --------------------------------
;   1 data block ID char
; 256 data bytes
;   1 data checksum
;   2 off bytes
; --------------------------------
; 260 BIN bytes ---> 325 GCR bytes
; -------------------------------------------------------------------------------------------------------------- ;
DATA_BLOCK                  = $0000             ; 
; -------------------------------------------------------------------------------------------------------------- ;
DATA_BLOCK_ID                 = $0000           ; flag: this is a data block
DATA_BLOCK_ID_VAL               = BID_DFLT      ;       normally $07
; -------------------------------------------------------------------------------------------------------------- ;
DATA_BLOCK_BYTES              = $0001           ;       256 data bytes
DATA_BLOCK_BYTES_LEN            = $ff           ; 
; -------------------------------------------------------------------------------------------------------------- ;
; checksum: calulated by EORing the DATA_BLOCK_BYTES_LEN  DATA_BLOCK_BYTES
; -------------------------------------------------------------------------------------------------------------- ;
DATA_BLOCK_CRC                = $0101           ;       checksum - ensures that a data block was read correctly
; -------------------------------------------------------------------------------------------------------------- ;
; $02 OFF bytes are used to complete $08 bytes
; a multiple of $04 bytes is needed to create a multiple of $05 GCR-bytes
; -------------------------------------------------------------------------------------------------------------- ;
DATA_BLOCK_OFF                = $0102           ;       DOS padding bytes during initial format - never referenced again
DATA_BLOCK_OFF1                 = $0102         ; 
DATA_BLOCK_OFF2                 = $0103         ; 
DATA_BLOCK_OFF_VAL                = $00         ; 
; -------------------------------------------------------------------------------------------------------------- ;
DATA_BLOCK_LEN                  = DATA_BLOCK_OFF2 - DATA_BLOCK ; $103 = 260 bytes
; -------------------------------------------------------------------------------------------------------------- ;


; -------------------------------------------------------------------------------------------------------------- ;
; the INTER-SECTOR-GAP or TAIL-GAP length varies from zone to zone
;   - between consectutive SECTORs is normally 4 to 12 bytes long
;   - between the last SECTOR and first SECTOR on a TRACK it is up to nearly SECTOR size (TRACKs 18-24)
;   - GAPs have to be long enough to prevent overwrites of the next SECTOR in case of Disk wobbels
; -------------------------------------------------------------------------------------------------------------- ;
; DATA gap (GAP2) - DTRCK contains the calculated variable GAP length between two SECTORs of a given TRACK
; -------------------------------------------------------------------------------------------------------------- ;
DATA_GAP                      = $00             ;       give DOS enough time to set-up between end of data block and start of next sector
TAIL_GAP                      = DATA_GAP        ;        
DATA_GAP_VAL                    = $ff           ;       
; -------------------------------------------------------------------------------------------------------------- ;
