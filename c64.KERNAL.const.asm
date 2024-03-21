; --------------------------------------------------------------------------------------------------------------------- ;
; C64 KERNAL - Constants
; --------------------------------------------------------------------------------------------------------------------- ;
TIMRB                         = $19             ;       6526 CRB enable one-shot timer CIACRB
COLM                          = CIAPRA          ;       keyboard matrix ROWs
ROWS                          = CIAPRB          ;       keyboard matrix COLUMNs
; --------------------------------------------------------------------------------------------------------------------- ;
; KERNAL vectors constants
; --------------------------------------------------------------------------------------------------------------------- ;
KV_LOAD_LOAD                  = $00             ;       flag: load
KV_LOAD_VERIFY                = $01             ;       flag: verify
  
KV_SETLFS_RELOC               = $00             ;       flag: load to the address the .X.Y registers
KV_SETLFS_FIX                 = $01             ;       flag: load to the address of in PRG_LOAD_ADR
KV_SETLFS_SA_NONE             = $ff             ;       flag: no secondary address
  
KV_SETNAM_FILENAM_NONE        = $00             ;       flag: no filename (open a cmd channel)
; --------------------------------------------------------------------------------------------------------------------- ;
; adjustment to make next T2 hit near center of the next bit - aprox the time to service a CB1 NMI
; --------------------------------------------------------------------------------------------------------------------- ;
CBIT                          = $64             ;       100 cycles
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE block types
; --------------------------------------------------------------------------------------------------------------------- ;
BLF                           = $01             ;       basic load file
BDF                           = $02             ;       basic data file
PLF                           = $03             ;       fixed program type
BDFH                          = $04             ;       basic data file header
EOT                           = $05             ;       end of tape
; --------------------------------------------------------------------------------------------------------------------- ;
; TAPE errors
; --------------------------------------------------------------------------------------------------------------------- ;
SBERR                         = %00000100       ;       Block too short (shorter 192 bytes)
LBERR                         = %00001000       ;       Block too long  (longer  192 bytes)
SPERR                         = %00010000       ;       Second pass read error
CKERR                         = %00100000       ;       Checksum error
; --------------------------------------------------------------------------------------------------------------------- ;
; global variables
; --------------------------------------------------------------------------------------------------------------------- ;
DEVNUM_KEYBOARD               = $00             ; 
DEVNUM_TAPE                   = $01             ; 
DEVNUM_RS232C                 = $02             ; 
DEVNUM_SCREEN                 = $03             ; 
DEVNUM_PRINTER                = $04             ; 
DEVNUM_PLOTTER                = $06             ; 
DEVNUM_DISK                   = $08     ; - $0f ; 
DEVNUM_IEE                    = $04     ; - $1e ;       any type of serial device
DEVNUM_RESERVED               = $1f     ;   $1f ;       Device #31 is reserved as a command to all devices
                                                ;       Device $1f is reserved as a command to all devices - devices cannot ignore a command to $1f
                                                ;         Sending a TALK   command to $1f means UNTALK
                                                ;         Sending a LISTEN command to $1f means UNLISTEN
                                                ;         This however is just a statement found on the web and has not been verified by other sources
; --------------------------------------------------------------------------------------------------------------------- ;
SIXTY                         = $4295           ;       NTSC sixty hertz value (17045)
SIXTYP                        = $4025           ;       PAL  sixty hertz value (16421)
; --------------------------------------------------------------------------------------------------------------------- ;
; SCREEN EDITOR constants
; --------------------------------------------------------------------------------------------------------------------- ;
LLEN                          = $28             ;       single line  = 40 columns
LLEN2                         = $50             ;       double line  = 80 columns
NLINES                        = $19             ;       screen lines = 25 rows
CR                            = $0d             ;       carriage return
;LINLEN                       = $28             ;       VIC screen size (why?)
; --------------------------------------------------------------------------------------------------------------------- ;
MAXCHR                        = $50             ; 
NWRAP                         = $02             ;       max number of physical lines per logical line
; --------------------------------------------------------------------------------------------------------------------- ;
; SCREEN line addresses
; --------------------------------------------------------------------------------------------------------------------- ;
LINZ0                         = VICSCN          ;       $0400
LINZ1                         = [LINZ0  + LLEN] ;       $0428
LINZ2                         = [LINZ1  + LLEN] ;       $0450
LINZ3                         = [LINZ2  + LLEN] ;       $0478
LINZ4                         = [LINZ3  + LLEN] ;       $04a0
LINZ5                         = [LINZ4  + LLEN] ;       $04c8
LINZ6                         = [LINZ5  + LLEN] ;       $04f0
LINZ7                         = [LINZ6  + LLEN] ;       $0518
LINZ8                         = [LINZ7  + LLEN] ;       $0540
LINZ9                         = [LINZ8  + LLEN] ;       $0568
LINZ10                        = [LINZ9  + LLEN] ;       $0590
LINZ11                        = [LINZ10 + LLEN] ;       $05b8
LINZ12                        = [LINZ11 + LLEN] ;       $05e0
LINZ13                        = [LINZ12 + LLEN] ;       $0608
LINZ14                        = [LINZ13 + LLEN] ;       $0630
LINZ15                        = [LINZ14 + LLEN] ;       $0658
LINZ16                        = [LINZ15 + LLEN] ;       $0680
LINZ17                        = [LINZ16 + LLEN] ;       $06a8
LINZ18                        = [LINZ17 + LLEN] ;       $06d0
LINZ19                        = [LINZ18 + LLEN] ;       $06f8
LINZ20                        = [LINZ19 + LLEN] ;       $0720
LINZ21                        = [LINZ20 + LLEN] ;       $0748
LINZ22                        = [LINZ21 + LLEN] ;       $0770
LINZ23                        = [LINZ22 + LLEN] ;       $0798
LINZ24                        = [LINZ23 + LLEN] ;       $07c0
; --------------------------------------------------------------------------------------------------------------------- ;
; virtual regs for machine language monitor
; --------------------------------------------------------------------------------------------------------------------- ;
PCH                           = $02             ; 
PCL                           = $03             ; 
FLGS                          = $04             ; 
ACC                           = $05             ; 
XR                            = $06             ; 
YR                            = $07             ; 
SP                            = $08             ; 
INVH                          = $09             ;       User modifiable IRQ
INVL                          = $0a             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
