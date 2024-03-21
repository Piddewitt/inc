; -------------------------------------------------------------------------------------------------------------- ;
; VIC 1541 - BAM Block Layout - 18,00
; -------------------------------------------------------------------------------------------------------------- ;
BAM_LINK                    = $00               ;       link to the next DIR block
BAM_LINK_TRK                  = $00             ;       TRACK location of the first DIR entry block
BAM_LINK_TRK_1541               = $12           ;       always 18
BAM_LINK_SEC                  = $01             ;       SECTOR location of the first DIR entry block
BAM_LINK_SEC_1541               = $01           ;       always 1
                            
BAM_FORMAT                  = $02               ;       DOS format type
BAM_FORMAT_1541               = "A"             ;       
                            
BAM_UNUSED                  = $03               ;       
; -------------------------------------------------------------------------------------------------------------- ;
; Global image bit pattern layout for each TRACK - groups of four bytes per TRACK
; -------------------------------------------------------------------------------------------------------------- ;
BAM_IMAGE_TRK_BLOCKS_FREE   = $00               ; offset number of free SECTORs on that TRACK
BAM_IMAGE_TRK_PATTERN_01    = $01               ; offset bit pattern SECTOR 00-07
BAM_IMAGE_TRK_PATTERN_02    = $02               ; offset bit pattern SECTOR 08-15
BAM_IMAGE_TRK_PATTERN_03    = $03               ; offset bit pattern SECTOR 16-24 (last unused)
BAM_IMAGE_LEN               = BAM_IMAGE_TRK_PATTERN_03 - BAM_IMAGE_TRK_BLOCKS_FREE + $01 ; BAM entry length
; -------------------------------------------------------------------------------------------------------------- ;
; Start BAM - bit pattern layout for each TRACK - groups of four bytes per TRACK
; -------------------------------------------------------------------------------------------------------------- ;
BAM_IMAGE                   = $04               ; 
; -------------------------------------------------------------------------------------------------------------- ;
; Zone 1 - TRACKs 00-17 - Outer TRACKs
; -------------------------------------------------------------------------------------------------------------- ;
BAM_IMAGE_ZONE_01             = BAM_IMAGE_LEN * $01 ; $04
BAM_IMAGE_ZONE_01_TRK_MIN       = $01               ; 01 - zone #1 start TRACK numer
BAM_IMAGE_ZONE_01_TRK_MAX       = $11               ; 17 - zone #1 final TRACK number
BAM_IMAGE_ZONE_01_SECTORS       = $15               ; 21 - zone #1 SECTORs per TRACK (00-20)
; -------------------------------------------------------------------------------------------------------------- ;
BAM_IMAGE_TRK_01              = BAM_IMAGE_LEN * $01 ; $04 - 1=free 0=allocated
BAM_IMAGE_TRK_02              = BAM_IMAGE_LEN * $02 ; $08
BAM_IMAGE_TRK_03              = BAM_IMAGE_LEN * $03 ; $0c
BAM_IMAGE_TRK_04              = BAM_IMAGE_LEN * $04 ; $10
BAM_IMAGE_TRK_05              = BAM_IMAGE_LEN * $05 ; $14
BAM_IMAGE_TRK_06              = BAM_IMAGE_LEN * $06 ; $18
BAM_IMAGE_TRK_07              = BAM_IMAGE_LEN * $07 ; $1c
BAM_IMAGE_TRK_08              = BAM_IMAGE_LEN * $08 ; $20
BAM_IMAGE_TRK_09              = BAM_IMAGE_LEN * $09 ; $24
BAM_IMAGE_TRK_00              = BAM_IMAGE_LEN * $0a ; $28
BAM_IMAGE_TRK_11              = BAM_IMAGE_LEN * $0b ; $2c
BAM_IMAGE_TRK_12              = BAM_IMAGE_LEN * $0c ; $30
BAM_IMAGE_TRK_13              = BAM_IMAGE_LEN * $0d ; $34
BAM_IMAGE_TRK_14              = BAM_IMAGE_LEN * $0e ; $38
BAM_IMAGE_TRK_15              = BAM_IMAGE_LEN * $0f ; $3c
BAM_IMAGE_TRK_16              = BAM_IMAGE_LEN * $10 ; $40
BAM_IMAGE_TRK_17              = BAM_IMAGE_LEN * $11 ; $44
; -------------------------------------------------------------------------------------------------------------- ;
; Zone 2 - TRACKS 18-24 
; -------------------------------------------------------------------------------------------------------------- ;
BAM_IMAGE_ZONE_02             = BAM_IMAGE_LEN * $12 ; $48
BAM_IMAGE_ZONE_02_TRK_MIN       = $12               ; 18 - zone #2 start TRACK numer
BAM_IMAGE_ZONE_02_TRK_MAX       = $18               ; 24 - zone #2 final TRACK number
BAM_IMAGE_ZONE_02_SECTORS       = $13               ; 19 - zone #2 SECTORs per TRACK (00-18)
; -------------------------------------------------------------------------------------------------------------- ;
BAM_IMAGE_TRK_18              = BAM_IMAGE_LEN * $12 ; $48 - 1=free 0=allocated
BAM_IMAGE_TRK_19              = BAM_IMAGE_LEN * $13 ; $4c
BAM_IMAGE_TRK_20              = BAM_IMAGE_LEN * $14 ; $50
BAM_IMAGE_TRK_21              = BAM_IMAGE_LEN * $15 ; $54
BAM_IMAGE_TRK_22              = BAM_IMAGE_LEN * $16 ; $58
BAM_IMAGE_TRK_23              = BAM_IMAGE_LEN * $17 ; $5c
BAM_IMAGE_TRK_24              = BAM_IMAGE_LEN * $18 ; $60
; -------------------------------------------------------------------------------------------------------------- ;
; Zone 3 - TRACKS 25-30
; -------------------------------------------------------------------------------------------------------------- ;
BAM_IMAGE_ZONE_03             = BAM_IMAGE_LEN * $19 ; $64
BAM_IMAGE_ZONE_03_MIN           = $19               ; 25 - zone #3 start TRACK numer
BAM_IMAGE_ZONE_03_MAX           = $1e               ; 30 - zone #3 final TRACK number
BAM_IMAGE_ZONE_03_NUM           = $12               ; 18 - zone #3 SECTORs per TRACK (00-17)
; -------------------------------------------------------------------------------------------------------------- ;
BAM_IMAGE_TRK_25              = BAM_IMAGE_LEN * $19 ; $64 - 1=free 0=allocated
BAM_IMAGE_TRK_26              = BAM_IMAGE_LEN * $1a ; $68
BAM_IMAGE_TRK_27              = BAM_IMAGE_LEN * $1b ; $6c
BAM_IMAGE_TRK_28              = BAM_IMAGE_LEN * $1c ; $70
BAM_IMAGE_TRK_29              = BAM_IMAGE_LEN * $1d ; $74
BAM_IMAGE_TRK_30              = BAM_IMAGE_LEN * $1e ; $78
; -------------------------------------------------------------------------------------------------------------- ;
; Zone 4 - TRACKS 31-35 - Inner TRACKS
; -------------------------------------------------------------------------------------------------------------- ;
BAM_IMAGE_ZONE_04             = BAM_IMAGE_LEN * $1f ; 
BAM_IMAGE_ZONE_04_TRK_MIN       = $1f               ; 31 - zone #4 start TRACK numer
BAM_IMAGE_ZONE_04_TRK_MAX       = $23               ; 35 - zone #4 final TRACK number
BAM_IMAGE_ZONE_04_SECTORS       = $11               ; 17 - zone #4 SECTORs per TRACK (00-16)
; -------------------------------------------------------------------------------------------------------------- ;
BAM_IMAGE_TRK_31              = BAM_IMAGE_LEN * $1f ; $7c - 1=free 0=allocated
BAM_IMAGE_TRK_32              = BAM_IMAGE_LEN * $20 ; $80
BAM_IMAGE_TRK_33              = BAM_IMAGE_LEN * $21 ; $84
BAM_IMAGE_TRK_34              = BAM_IMAGE_LEN * $22 ; $88
BAM_IMAGE_TRK_35              = BAM_IMAGE_LEN * $23 ; $8c
; -------------------------------------------------------------------------------------------------------------- ;
; Disk HEADER
; -------------------------------------------------------------------------------------------------------------- ;
BAM_DISK_HDR                = $90               ; 
BAM_DISK_NAME                 = $90             ; disk name padded with BAM_FILLER_CHAR
BAM_DISK_NAME_LEN             = BAM_FILLER - BAM_DISK_NAME - $01 ; 
                              
BAM_FILLER                    = $a0             ; 
BAM_FILLER_1                    = $a0           ; 
BAM_FILLER_1_1541                 = BAM_FILLER_CHAR ; 
BAM_FILLER_2                    = $a1           ; 
BAM_FILLER_2_1541                 = BAM_FILLER_CHAR ; 
BAM_FILLER_CHAR                   = $a0         ; <shift space>
                              
BAM_DISK_ID                   = $a2             ; 
BAM_DISK_ID1                    = $a2           ; 
BAM_DISK_ID1_1541                 = $30         ; default: '0'
BAM_DISK_ID2                    = $a3           ; 
BAM_DISK_ID2_1541                 = $30         ; default: '0'
                              
BAM_DOS_TYPE                  = $a5             ; DOS version and format type
BAM_DOS_VERSION                 = $a5           ; 
BAM_DOS_VERSION_1541              = $32         ; '2'
BAM_DOS_FORMAT                  = $a6           ; 
BAM_DOS_FORMAT_1541               = $41         ; 'A'
                              
BAM_DISK_HDR_LEN              = BAM_PAD - BAM_DISK_HDR - $01 ; 
; -------------------------------------------------------------------------------------------------------------- ;
BAM_PAD                     = $a7               ; filled with BAM_FILLER_CHAR
BAM_PAD_LEN                 = BAM_FREE - BAM_PAD - $01 ; 
; -------------------------------------------------------------------------------------------------------------- ;
BAM_FREE                    = $ab               ; unsused - sometimes set to 'BLOCKS FREE'
BAM_END                     = $ff               ; 
; -------------------------------------------------------------------------------------------------------------- ;
