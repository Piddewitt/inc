; -------------------------------------------------------------------------------------------------------------- ;
; BASIC text and variable structure pointers
; -------------------------------------------------------------------------------------------------------------- ;
; 
; $ffff ! -------------------------- ! 
;       !                            ! 
;       !          ROM/RAM           ! 
;       !                            ! 
; $a000 ! -------------------------- ! <--- MEMSIZ ($37/$38) Ptr: Highest Address available to BASIC ($A000)
;       !                            ! 
;       !     character  strings     ! 
;       !                            ! 
;       ! -------------------------- ! <--- FRETOP ($33/$34) Ptr: Bottom of String space
;       !                            !                            Free Area (Reported by FRE(0))
;       !       free BASIC RAM       ! 
;       !                            ! 
;       ! -------------------------- ! <--- STREND ($31/$32) Ptr: Top    of BASIC Arrays + 1
;       !                            !                            String Text Area
;       !      indexed variables     !                            Strings build from top of memory down into free area
;       !                            ! 
;       ! -------------------------- ! <--- ARYTAB ($2f/$30) Ptr: Start  of BASIC Arrays
;       !                            !                            Array Variables
;       !      normal variables      ! 
;       !                            ! 
;       ! -------------------------- ! <--- VARTAB ($2d/$2e) Ptr: Start  of BASIC Variables
;       !                            !                            Non-Array Variables and String Descriptors
;       !        BASIC program       ! 
;       !                            ! 
;       ! -------------------------- ! <--- TXTTAB ($2b/$2c) Ptr: Start  of BASIC Text Area (default: $0801)
;       !            $00             !                       ID:  BASIC program follows     (default: $0800)
;       ! -------------------------- ! 
;       !                            ! 
;       !            RAM             ! 
;       !                            ! 
; $0000 ! -------------------------- ! 
;
; -------------------------------------------------------------------------------------------------------------- ;
; BASIC program structure - default start at $0801
; -------------------------------------------------------------------------------------------------------------- ;
BAS_TXT_LEAD                = RAMLOC                        ;       default: $0800
BAS_TXT_LEAD_ID               = RAMLOC_CONST                ; flag: BASIC code follows - must be $00 to be able to run a BASIC pgm
                            
BAS_TXT_START               = [BAS_TXT_LEAD + $01]          ;       BASIC code start (default: $0801)
                            
BAS_TXT_LIN_NEXT            = BAS_TXT_START                 ; ptr : BASIC start of next line      
BAS_TXT_LIN_NEXT_LO           = [BAS_TXT_START + $00]       ;       $00 = End of BASIC Line
BAS_TXT_LIN_NEXT_HI           = [BAS_TXT_START + $01]       ;       $00 = End of BASIC Program
                            
BAS_TXT_LIN_END               = $00                         ; flag: end of basic line

BAS_TXT_LIN_NUM             = [BAS_TXT_START + $02]         ; num : BASIC line number
BAS_TXT_LIN_NUM_LO            = [BAS_TXT_START + $02]       ; 
BAS_TXT_LIN_NUM_HI            = [BAS_TXT_START + $03]       ; 

BAS_TXT_CODE                = [BAS_TXT_START + $04]         ; off : start of BASIC code
BAS_TXT_TOKEN               = [BAS_TXT_START + $04]         ; off : BASIC token
                            
BAS_TXT_LIN_MAX               = $50                         ;       max 80 chars in max two lines of 40 chars each 
; -------------------------------------------------------------------------------------------------------------- ;
