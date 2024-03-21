; ------------------------------------------------------------------------------------------------------------- ;
; MOS6567 - Video Interface Chip (VIC-II) Registers - $D000-$D02F
; ------------------------------------------------------------------------------------------------------------- ;
VIC2                        = $D000             ; Base Address
VIC2_LEN                      = XSCAN - VIC2    ; VIC2 address space  - $40 ($2f used / remaining $11 unused)
; ------------------------------------------------------------------------------------------------------------- ;
; Sprite Horizontal and Vertical Position Registers - specified is the position of the top left corner
; ------------------------------------------------------------------------------------------------------------- ;
M0X                         = VIC2 + $00        ; Sprite 0 PosX (Bits 7…0 - Bit 8(MSB) stored in MSIGX  ($D010)
M0X0                          = %00000001       ; 
M0X1                          = %00000010       ; 
M0X2                          = %00000100       ; 
M0X3                          = %00001000       ; 
M0X4                          = %00010000       ; 
M0X5                          = %00100000       ; 
M0X6                          = %01000000       ; 
M0X7                          = %10000000       ; 
SP0X                        = M0X               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M0Y                         = VIC2 + $01        ; Sprite 0 PosY (Bits 7…0)
M0Y0                          = %00000001       ; 
M0Y1                          = %00000010       ; 
M0Y2                          = %00000100       ; 
M0Y3                          = %00001000       ; 
M0Y4                          = %00010000       ; 
M0Y5                          = %00100000       ; 
M0Y6                          = %01000000       ; 
M0Y7                          = %10000000       ; 
SP0Y                        = M0Y               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M1X                         = VIC2 + $02        ; Sprite 1 PosX (Bits 7…0 - Bit 8(MSB) stored in MSIGX  ($D010)
M1X0                          = %00000001       ; 
M1X1                          = %00000010       ; 
M1X2                          = %00000100       ; 
M1X3                          = %00001000       ; 
M1X4                          = %00010000       ; 
M1X5                          = %00100000       ; 
M1X6                          = %01000000       ; 
M1X7                          = %10000000       ; 
SP1X                        = M1X               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M1Y                         = VIC2 + $03        ; Sprite 1 PosY (Bits 7…0)
M1Y0                          = %00000001       ; 
M1Y1                          = %00000010       ; 
M1Y2                          = %00000100       ; 
M1Y3                          = %00001000       ; 
M1Y4                          = %00010000       ; 
M1Y5                          = %00100000       ; 
M1Y6                          = %01000000       ; 
M1Y7                          = %10000000       ; 
SP1Y                        = M1Y               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M2X                         = VIC2 + $04        ; Sprite 2 PosX (Bits 7…0 - Bit 8(MSB) stored in MSIGX  ($D010)
M2X0                          = %00000001       ; 
M2X1                          = %00000010       ; 
M2X2                          = %00000100       ; 
M2X3                          = %00001000       ; 
M2X4                          = %00010000       ; 
M2X5                          = %00100000       ; 
M2X6                          = %01000000       ; 
M2X7                          = %10000000       ; 
SP2X                        = M2X               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M2Y                         = VIC2 + $05        ; Sprite 2 PosY (Bits 7…0)
SP2Y                        = M2Y               ; 
M2Y0                          = %00000001       ; 
M2Y1                          = %00000010       ; 
M2Y2                          = %00000100       ; 
M2Y3                          = %00001000       ; 
M2Y4                          = %00010000       ; 
M2Y5                          = %00100000       ; 
M2Y6                          = %01000000       ; 
M2Y7                          = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
M3X                         = VIC2 + $06        ; Sprite 3 PosX (Bits 7…0 - Bit 8(MSB) stored in MSIGX  ($D010)
SP3X                        = M3X               ; 
M3X0                          = %00000001       ; 
M3X1                          = %00000010       ; 
M3X2                          = %00000100       ; 
M3X3                          = %00001000       ; 
M3X4                          = %00010000       ; 
M3X5                          = %00100000       ; 
M3X6                          = %01000000       ; 
M3X7                          = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
M3Y                         = VIC2 + $07        ; Sprite 3 PosY (Bits 7…0)
M3Y0                          = %00000001       ; 
M3Y1                          = %00000010       ; 
M3Y2                          = %00000100       ; 
M3Y3                          = %00001000       ; 
M3Y4                          = %00010000       ; 
M3Y5                          = %00100000       ; 
M3Y6                          = %01000000       ; 
M3Y7                          = %10000000       ; 
SP3Y                        = M3Y               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M4X                         = VIC2 + $08        ; Sprite 4 PosX (Bits 7…0 - Bit 8(MSB) stored in MSIGX  ($D010)
M4X0                          = %00000001       ; 
M4X1                          = %00000010       ; 
M4X2                          = %00000100       ; 
M4X3                          = %00001000       ; 
M4X4                          = %00010000       ; 
M4X5                          = %00100000       ; 
M4X6                          = %01000000       ; 
M4X7                          = %10000000       ; 
SP4X                        = M4X               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M4Y                         = VIC2 + $09        ; Sprite 4 PosY (Bits 7…0)
M4Y0                          = %00000001       ; 
M4Y1                          = %00000010       ; 
M4Y2                          = %00000100       ; 
M4Y3                          = %00001000       ; 
M4Y4                          = %00010000       ; 
M4Y5                          = %00100000       ; 
M4Y6                          = %01000000       ; 
M4Y7                          = %10000000       ; 
SP4Y                        = M4Y               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M5X                         = VIC2 + $0a        ; Sprite 5 PosX (Bits 7…0 - Bit 8(MSB) stored in MSIGX  ($D010)
M5X0                          = %00000001       ; 
M5X1                          = %00000010       ; 
M5X2                          = %00000100       ; 
M5X3                          = %00001000       ; 
M5X4                          = %00010000       ; 
M5X5                          = %00100000       ; 
M5X6                          = %01000000       ; 
M5X7                          = %10000000       ; 
SP5X                        = M5X               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M5Y                         = VIC2 + $0b        ; Sprite 5 PosY (Bits 7…0)
M5Y0                          = %00000001       ; 
M5Y1                          = %00000010       ; 
M5Y2                          = %00000100       ; 
M5Y3                          = %00001000       ; 
M5Y4                          = %00010000       ; 
M5Y5                          = %00100000       ; 
M5Y6                          = %01000000       ; 
M5Y7                          = %10000000       ; 
SP5Y                        = M5Y               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M6X                         = VIC2 + $0c        ; Sprite 6 PosX (Bits 7…0 - Bit 8(MSB) stored in MSIGX  ($D010)
M6X0                          = %00000001       ; 
M6X1                          = %00000010       ; 
M6X2                          = %00000100       ; 
M6X3                          = %00001000       ; 
M6X4                          = %00010000       ; 
M6X5                          = %00100000       ; 
M6X6                          = %01000000       ; 
M6X7                          = %10000000       ; 
SP6X                        = M6X               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M6Y                         = VIC2 + $0d        ; Sprite 6 PosY (Bits 7…0)
M6Y0                          = %00000001       ; 
M6Y1                          = %00000010       ; 
M6Y2                          = %00000100       ; 
M6Y3                          = %00001000       ; 
M6Y4                          = %00010000       ; 
M6Y5                          = %00100000       ; 
M6Y6                          = %01000000       ; 
M6Y7                          = %10000000       ; 
SP6Y                        = M6Y               ; 
; ------------------------------------------------------------------------------------------------------------- ;
M7X                         = VIC2 + $0e        ; Sprite 7 PosX (Bits 7…0 - Bit 8(MSB) stored in MSIGX  ($D010)
SP7X                        = M7X               ; 
M7X0                          = %00000001       ; 
M7X1                          = %00000010       ; 
M7X2                          = %00000100       ; 
M7X3                          = %00001000       ; 
M7X4                          = %00010000       ; 
M7X5                          = %00100000       ; 
M7X6                          = %01000000       ; 
M7X7                          = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
M7Y                         = VIC2 + $0f        ; Sprite 7 PosY (Bits 7…0)
M7Y0                          = %00000001       ; 
M7Y1                          = %00000010       ; 
M7Y2                          = %00000100       ; 
M7Y3                          = %00001000       ; 
M7Y4                          = %00010000       ; 
M7Y5                          = %00100000       ; 
M7Y6                          = %01000000       ; 
M7Y7                          = %10000000       ; 
SP7Y                        = M7Y               ; 
; ------------------------------------------------------------------------------------------------------------- ;
MSIGX                       = VIC2 + $10        ; Most Significant Bit (MSB) of PosX Sprites 0-7
MSIGX_M0X8                    = %00000001       ; Bit 0: MSB PosX Sprite 0
MSIGX_M1X8                    = %00000010       ; Bit 1: MSB PosX Sprite 1
MSIGX_M2X8                    = %00000100       ; Bit 2: MSB PosX Sprite 2
MSIGX_M3X8                    = %00001000       ; Bit 3: MSB PosX Sprite 3
MSIGX_M4X8                    = %00010000       ; Bit 4: MSB PosX Sprite 4
MSIGX_M5X8                    = %00100000       ; Bit 5: MSB PosX Sprite 5
MSIGX_M6X8                    = %01000000       ; Bit 6: MSB PosX Sprite 6
MSIGX_M7X8                    = %10000000       ; Bit 7: MSB PosX Sprite 7
                                                ; 
MSIGX_SP0                     = MSIGX_M0X8      ; 
MSIGX_SP1                     = MSIGX_M1X8      ; 
MSIGX_SP2                     = MSIGX_M2X8      ; 
MSIGX_SP3                     = MSIGX_M3X8      ; 
MSIGX_SP4                     = MSIGX_M4X8      ; 
MSIGX_SP5                     = MSIGX_M5X8      ; 
MSIGX_SP6                     = MSIGX_M6X8      ; 
MSIGX_SP7                     = MSIGX_M7X8      ; 
; ------------------------------------------------------------------------------------------------------------- ;
; Soft scrolling                                ;       Graphic Modes       ! SCROLY    ! SCROLX
; --------------------------------------------- ; --------------------------+-----------+------------------
; Bits 0-2 scroll the position of the graphics  ; Standard   Text    Mode   ! ECM  BMM  !  MCM    = 0, 0, 0
; inside the display window in single-pixel     ; Multicolor Text    Mode   ! ECM  BMM  !  MCM    = 0, 0, 1
; units up to 7 pixels to the bottom            ; Standard   BitMap  Mode   ! ECM  BMM  !  MCM    = 0, 1, 0
; The position of the display window itself     ; Multicolor BitMap  Mode   ! ECM  BMM  !  MCM    = 0, 1, 1
; does not change                               ; ECM        Text    Mode   ! ECM  BMM  !  MCM    = 1, 0, 0
; To keep the graphics aligned with the display ; --------------------------+-----------+------------------
; window XSCROLL/YSCROLL have to be set to:     ; Invalid    Text    Mode   ! ECM  BMM  !  MCM    = 1, 0, 1
;   0/3 for 25 rows/40 cols                     ; Invalid    Bitmap  Mode 1 ! ECM  BMM  !  MCM    = 1, 1, 0
;   7/7 for 24 rows/38 cols                     ; Invalid    Bitmap  Mode 2 ! ECM  BMM  !  MCM    = 1, 1, 1
; ----------------------------------------------+---------------------------+-----------+---------------------- ;
; The graphics are displayed in an unmovable window in the middle of the visible screen area (the 'Display Window')
; The area outside the display window is covered by the screen border and is displayed in the border color EXTCOL
; The height and width of the borders are set with SCROLY_RSEL and SCROLX_CSEL
; 
; +--------+--------------------------+------------+------------+ 
; ! SCROLY !  Display window height   ! First line ! Last line  ! 
; !  RSEL  !                          !            !            ! 
; +--------+--------------------------+------------+------------+ 
; !    0   ! 24 text lines/192 pixels !  $37 (55)  ! $f6 (246)  ! 
; !    1   ! 25 text lines/200 pixels !  $33 (51)  ! $fa (250)  ! 
; +--------+--------------------------+------------+------------+ 
; ! SCROLX !   Display window width   !  First X   !  Last X    ! 
; !  CSEL  !                          ! coordinate ! coordinate ! 
; +--------+--------------------------+------------+------------+ 
; !    0   ! 38 characters/304 pixels !  $1f (31)  ! $14e (334) ! 
; !    1   ! 40 characters/320 pixels !  $18 (24)  ! $157 (343) ! 
; +--------+--------------------------+------------+------------+ 
;
; ------------------------------------------------------------------------------------------------------------- ;
SCROLY                      = VIC2 + $11        ; Control Register 1 / Vertical Fine Scrolling
SCROLY_YSCROLL                = %00000111       ; Bit 0…2: Fine scroll vertically by $00-$07 scan lines
SCROLY_YSCROLL_Y0               = %00000001     ; Bit 0: 
SCROLY_YSCROLL_Y1               = %00000010     ; Bit 1: 
SCROLY_YSCROLL_Y2               = %00000100     ; Bit 2: 
SCROLY_YSCROLL_INIT_25            = %00000011   ;        initial value for 25 rows / 40 columns
SCROLY_YSCROLL_INIT_24            = %00000111   ;        initial value for 24 rows / 38 columns
SCROLY_RSEL                   = %00001000       ; Bit 3: Select text row display      .......... (1=25 / 0=24 rows)
SCROLY_RSEL_25                  = SCROLY_RSEL   ;      : Select a 25-row text display
SCROLY_RSEL_24                  = ~SCROLY_RSEL  ;      : Select a 24-row text display
                                                ;      : RSEL=0: the upper border is extended by 4 pixels
                                                ;      :         the lower border is extended by 4 pixels
                                                ;      : The display windows position and resolution do not change
                                                ;      : Only the starting and ending pos of the border display is changed
                                                ;      : The size of the video matrix stays constantly at 40×25 chars
SCROLY_DEN                    = %00010000       ; Bit 4: Display Enable ........................ (1=enable / 0=disable)
SCROLY_DEN_ON                   = SCROLY_DEN    ;      : Display Enable
SCROLY_DEN_OFF                  = ~SCROLY_DEN   ;      : Display Disable
SCROLY_BMM                    = %00100000       ; Bit 5: Bitmap Mode         (BMM) ............. (1=bitmap mode / 0=text mode)
SCROLY_BMM_ON                   = SCROLY_BMM    ;      : Bitmap Mode
SCROLY_BMM_OFF                  = ~SCROLY_BMM   ;      : Text   Mode
SCROLY_ECM                    = %01000000       ; Bit 6: Extended Color Mode (ECM) ............. (1=on / 0=off)
SCROLY_ECM_ON                   = SCROLY_ECM    ;      : 
SCROLY_ECM_OFF                  = ~SCROLY_ECM   ;      : 
                                                ; 
SCROLY_RST8                   = %10000000       ; Bit 7: MSB (Bit 8) of RASTER register  ($D012)
SCROLY_RST8_INIT                = %10000000     ;      : Initial value set in KERNAL routine TVIC (with RASTER_INIT = $137)
                              
SCROLY_INIT                   = SCROLY_RST8_INIT | SCROLY_DEN_ON | SCROLY_RSEL_25 | SCROLY_YSCROLL_INIT_25 ; set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
RASTER                      = VIC2 + $12        ; Read : Current Raster Scan Line (Bits 7…0)
RASTER_RC0                    = %00000001       ;          NTSC: $106 horizontal lines (262) - Bit8 is RST8 of SCROLY
RASTER_RC1                    = %00000010       ;          PAL : $138 horizontal lines (312) - Bit8 is RST8 of SCROLY
RASTER_RC2                    = %00000100       ; Write: Set compare line for Raster IRQ       
RASTER_RC3                    = %00001000       ; 
RASTER_RC4                    = %00010000       ; 
RASTER_RC5                    = %00100000       ;        
RASTER_RC6                    = %01000000       ;        
RASTER_RC7                    = %10000000       ; 
                                                ; 
RASTER_INIT                   = $37             ; set in KERNAL routine TVIC (with MSB SCROLY_RST8_INIT = $137)
; ------------------------------------------------------------------------------------------------------------- ;
; Light Pen Registers - The values in these registers are updated once every screen frame (60 times per second)
; ------------------------------------------------------------------------------------------------------------- ;
LPENX                       = VIC2 + $13        ; Light Pen Horizontal Screen Position
LPENX_LPX                   = LPENX             ; 
LPENX_LPX1                    = %00000001       ;   Only 8 bits available for $140 (320) possible positions
LPENX_LPX2                    = %00000010       ;   The value in here will range from $00-$a0 (160)
LPENX_LPX3                    = %00000100       ;   Accurate only to every 2nd dot position
LPENX_LPX4                    = %00001000       ;   Must be multiplied by 2 to give a close position approximation
LPENX_LPX5                    = %00010000       ; 
LPENX_LPX6                    = %00100000       ; 
LPENX_LPX7                    = %01000000       ; 
LPENX_LPX8                    = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
LPENY                       = VIC2 + $14        ; Light Pen Vertical Screen Position
LPENY_LPY                   = LPENY             ;   8 bits are good for $c8 (200) possible positions
LPENY_LPY0                    = %00000001       ;   The value in here holds the exact current raster scan line
LPENY_LPY1                    = %00000010       ; 
LPENY_LPY2                    = %00000100       ; 
LPENY_LPY3                    = %00001000       ; 
LPENY_LPY4                    = %00010000       ; 
LPENY_LPY5                    = %00100000       ; 
LPENY_LPY6                    = %01000000       ; 
LPENY_LPY7                    = %10000000       ; 
; ------------------------------------------------------------------------------------------------------------- ;
SPENA                       = VIC2 + $15        ; Sprite Enable Register
SPENA_M0E                     = %00000001       ; Bit 0: Enable Sprite 0
SPENA_M1E                     = %00000010       ; Bit 1: Enable Sprite 1
SPENA_M2E                     = %00000100       ; Bit 2: Enable Sprite 2
SPENA_M3E                     = %00001000       ; Bit 3: Enable Sprite 3
SPENA_M4E                     = %00010000       ; Bit 4: Enable Sprite 4
SPENA_M5E                     = %00100000       ; Bit 5: Enable Sprite 5
SPENA_M6E                     = %01000000       ; Bit 6: Enable Sprite 6
SPENA_M7E                     = %10000000       ; Bit 7: Enable Sprite 7
                                                ; 
SPENA_ALL_ON                  = %11111111       ; All Sprites enabled
SPENA_ALL_OFF                 = %00000000       ; All Sprites disabled
; ------------------------------------------------------------------------------------------------------------- ;
; Soft scrolling                                ;    Graphic Modes with     !  SCROLY   ! SCROLX
; ----------------------------------------------+---------------------------+-----------+---------------------- ;
; Bits 0-2 scroll the position of the graphics  ; Standard   Text    Mode   ! ECM  BMM  !  MCM    = 0, 0, 0
; inside the display window in single-pixel     ; Multicolor Text    Mode   ! ECM  BMM  !  MCM    = 0, 0, 1
; units up to 7 pixels to the right             ; Standard   BitMap  Mode   ! ECM  BMM  !  MCM    = 0, 1, 0
; The position of the display window itself     ; Multicolor BitMap  Mode   ! ECM  BMM  !  MCM    = 0, 1, 1
; does not change                               ; ECM        Text    Mode   ! ECM  BMM  !  MCM    = 1, 0, 0
; To keep the graphics aligned with the display ; --------------------------+-----------+------------------
; window XSCROLL/YSCROLL have to be set to:     ; Invalid    Text    Mode   ! ECM  BMM  !  MCM    = 1, 0, 1
;   0/3 for 25 rows/40 cols                     ; Invalid    Bitmap  Mode 1 ! ECM  BMM  !  MCM    = 1, 1, 0
;   7/7 for 24 rows/38 cols                     ; Invalid    Bitmap  Mode 2 ! ECM  BMM  !  MCM    = 1, 1, 1
; ----------------------------------------------+---------------------------+-----------+---------------------- ;
SCROLX                      = VIC2 + $16        ; Control Register 2 / Horizontal Fine Scrolling
SCROLX_XSCROLL                = %00000111       ; Bit 0…2: Fine scroll display horizontically by $00-$07 scan lines
SCROLX_XSCROLL_X0               = %00000001     ; Bit 0: 
SCROLX_XSCROLL_X1               = %00000010     ; Bit 1: 
SCROLX_XSCROLL_X2               = %00000100     ; Bit 2: 
SCROLX_XSCROLL_INIT_25            = %00000000   ;        initial value for 25 rows / 40 columns
SCROLX_XSCROLL_INIT_24            = %00000111   ;        initial value for 24 rows / 38 columns
                                                ; 
SCROLX_CSEL                   = %00001000       ; Bit 3: Select text column display .......... (1=40 / 0=38 columns)
SCROLX_CSEL_40                  = SCROLX_CSEL   ;      : Select a 40-column text display
SCROLX_CSEL_38                  = ~SCROLX_CSEL  ;      : Select a 38-column text display
                                                ;      : CSEL=0: the left  border is extended by 7 pixels and
                                                ;      :         the right border is extended by 9 pixels
                                                ;      : The display windows position and resolution do not change
                                                ;      : Only the starting and ending pos of the border display is changed
                                                ;      : The size of the video matrix stays constantly at 40×25 chars
SCROLX_MCM                    = %00010000       ; Bit 4: Multi Color Mode for Text or Bitmap
SCROLX_MCM_ON                   = SCROLX_MCM    ;      :                                
SCROLX_MCM_OFF                  = ~SCROLX_MCM   ;      : 
SCROLX_RES                    = %00100000       ; Bit 5: Control the VIC-II chip reset line
SCROLX_RES_OFF                  = SCROLX_RES    ;      : VIC completely off
SCROLX_RES_ON                   = ~SCROLX_RES   ;      : VIC normal operation
                                                ; 
                              ;  .1......       ; Bit 6: <not used>
                              ;  1.......       ; Bit 7: <not used>
                                                ; 
SCROLX_INIT                   = $00 & SCROLX_RES_ON & SCROLX_MCM_OFF | SCROLX_CSEL_40 | SCROLX_XSCROLL_INIT_25 ; set in KERNAL routine TVIC
; ----------------------------------------------+---------------------------+-----------+---------------------- ;
YXPAND                      = VIC2 + $17        ; Sprite Vertical Expansion Register
YXPAND_M0YE                   = %00000001       ; Bit 0: Sprite 0 double height
YXPAND_M1YE                   = %00000010       ; Bit 1: Sprite 1 double height
YXPAND_M2YE                   = %00000100       ; Bit 2: Sprite 2 double height
YXPAND_M3YE                   = %00001000       ; Bit 3: Sprite 3 double height
YXPAND_M4YE                   = %00010000       ; Bit 4: Sprite 4 double height
YXPAND_M5YE                   = %00100000       ; Bit 5: Sprite 5 double height
YXPAND_M6YE                   = %01000000       ; Bit 6: Sprite 6 double height
YXPAND_M7YE                   = %10000000       ; Bit 7: Sprite 7 double height
                                                ; 
YXPAND_ALL_ON                 = %11111111       ; All Sprites double height
YXPAND_ALL_OFF                = ~YXPAND_ALL_ON  ; All Sprites normal height
; ------------------------------------------------------------------------------------------------------------- ;
VMCSB                       = VIC2 + $18        ; VIC Chip Memory Control Register
; ------------------------------------------------------------------------------------------------------------- ;
; Internal registers - used to generate the addresses for accessing the video matrix and the character generator/bitmap
; 
; VC (video counter)    - 10 bit - counts 1000 addresses of the video matrix within the display frame
; RC (row counter)      -  3 bit - counts 8 pixel lines of each text line
; MC (MOB data counter) -  6 bit - counts 63 sprite data bytes
; ------------------------------------------------------------------------------------------------------------- ;
; Internal Buffer
; 
; 40×12 bit video matrix/color line buffer - stores the data read from the video matrix
; ------------------------------------------------------------------------------------------------------------- ;
; Address Bus
;   14 bit video address bus to address 16KB of memory
; Data Bus
;   12 bit data bus
;   The lower 8 bits are connected to the main memory and the processor data bus
;   The upper 4 bits are connected to the Color RAM
; ------------------------------------------------------------------------------------------------------------- ;
; 
; 
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; Standard text mode (ECM/BMM/MCM=0/0/0) - Address Bits 14…15 - Bits 0…1 of CI2PRA ($DD00)
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; 
; c-address: access Video Matrix and Color RAM                              c-data: 12Bit Video Matrix
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+----+----+----+----+
; !VM13!VM12!VM11!VM10! VC9! VC8! VC7! VC6! VC5! VC4! VC3! VC2! VC1! VC0!   !      Color of     ! D7 ! D6 ! D5 ! D4 ! D3 ! D2 ! D1 ! D0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !      1 pixels     !    !    !    !    !    !    !    !    !
; ! VM Base Address   ! Internal Video Counter                          !   +-------------------+----+----+----+----+----+----+----+----+
; 
; g-adress: access Character Generator                                      g-Data
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; !CB13!CB12!CB11! D7 ! D6 ! D5 ! D4 ! D3 ! D2 ! D1 ! D0 ! RC2! RC1! RC0!   !         8 pixels (1 bit/pixel)        !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !                                       !
; ! Char Base Adr! Character Generator Address           ! Row Counter  !   !  0 - Background color 0 - BGCOL0      !
;                                                                           !  1 - Color from bits 8…11 of c-data   !
;                                                                           +---------------------------------------+
; 
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; Multicolor text mode (ECM/BMM/MCM=0/0/1) - Address Bits 14…15 - Bits 0…1 of CI2PRA ($DD00)
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; 
; c-address: access Video Matrix and Color RAM                              c-data: 12Bit Video Matrix
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+----+----+----+----+
; !VM13!VM12!VM11!VM10! VC9! VC8! VC7! VC6! VC5! VC4! VC3! VC2! VC1! VC0!   ! MC !   Color of   ! D7 ! D6 ! D5 ! D4 ! D3 ! D2 ! D1 ! D0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !flag!  11  pixels  !    !    !    !    !    !    !    !    !
; ! VM Base Address   ! Internal Video Counter                          !   +----+--------------+----+----+----+----+----+----+----+----+
; 
; g-adress: access Character Generator                                      g-Data
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; !CB13!CB12!CB11! D7 ! D6 ! D5 ! D4 ! D3 ! D2 ! D1 ! D0 ! RC2! RC1! RC0!   !         8 pixels (1 bit/pixel)        !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !                                       ! MC flag = 0
; ! Char Base Adr!                                       ! Row Counter  !   !  0 - Background color 0 - BGCOL0      !
;                                                                           !  1 - Color from bits 8…10 of c-data   !
;                                                                           +---------------------------------------+
;                                                                           !         4 pixels (2 bits/pixel)       !
;                                                                           !                                       !
;                                                                           ! 00 - Background color 0 - BGCOL0      ! MC flag = 1
;                                                                           ! 01 - Background color 1 - BGCOL1      !
;                                                                           ! 10 - Background color 2 - BGCOL2      !
;                                                                           ! 11 - Color from bits 8…10 of c-data   !
;                                                                           +---------------------------------------+
; 
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; ECM text mode (ECM/BMM/MCM=1/0/0) - Address Bits 14…15 - Bits 0…1 of CI2PRA ($DD00)
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; 
; c-address: access Video Matrix and Color RAM                              c-data: 12Bit Video Matrix
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+----+----+----+----+
; !VM13!VM12!VM11!VM10! VC9! VC8! VC7! VC6! VC5! VC4! VC3! VC2! VC1! VC0!   !     Color of      ! Backgr  ! D5 ! D4 ! D3 ! D2 ! D1 ! D0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !     1 pixels      ! Color   !    !    !    !    !    !    !
; ! VM Base Address   ! Internal Video Counter                          !   +-------------------+---------+----+----+----+----+----+----+
;
; g-adress:access Character Generator                                       g-Data
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; !CB13!CB12!CB11!  0 !  0 ! D5 ! D4 ! D3 ! D2 ! D1 ! D0 ! RC2! RC1! RC0!   !         8 pixels (1 bit/pixel)        !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !                                       !
; ! Char Base Adr!                                       ! Row Counter  !   ! 0 - Depending on bits 6…7 of c-data   !
;                                                                           !     00 - Background color 0 - BGCOL0  !
;                                                                           !     01 - Background color 1 - BGCOL1  !
;                                                                           !     10 - Background color 2 - BGCOL2  !
;                                                                           !     11 - Background color 3 - BGCOL3  !
;                                                                           ! 1 - Color from bits 8…11 of c-data    !
;                                                                           +---------------------------------------+
; 
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; Standard bitmap mode (ECM/BMM/MCM=0/1/0) - Address Bits 14…15 - Bits 0…1 of CI2PRA ($DD00)
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; 
; c-address: access Video Matrix                                            c-data: 12Bit Video Matrix
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+----+----+----+----+
; !VM13!VM12!VM11!VM10! VC9! VC8! VC7! VC6! VC5! VC4! VC3! VC2! VC1! VC0!   !       unused      !     Color of      !     Color of      !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !                   !     1 pixels      !     0 pixels      !
; ! VM Base Address   ! Internal Video Counter                          !   +-------------------+-------------------+-------------------+
; 
; g-adress: access Bitmap                                                   g-Data
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; !CB13! VC9! VC8! VC7! VC6! VC5! VC4! VC3! VC2! VC1! VC0! RC2! RC1! RC0!   !         8 pixels (1 bit/pixel)        !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !                                       !
; !Base! Internal Video Counter                          ! Row Counter  !   ! 0 - Color from bits 0…3 of c-data     !
;                                                                           ! 1 - Color from bits 4…7 of c-data     !
;                                                                           +---------------------------------------+
; 
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; Multicolor bitmap mode (ECM/BMM/MCM=0/1/1) - Address Bits 14…15 - Bits 0…1 of CI2PRA ($DD00)
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; 
; c-address: access Video Matrix                                            c-data: 12Bit Video Matrix
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+----+----+----+----+
; !VM13!VM12!VM11!VM10! VC9! VC8! VC7! VC6! VC5! VC4! VC3! VC2! VC1! VC0!   !     Color of      !     Color of      !     Color of      !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !    11  pixels     !    01  pixels     !    10  pixels     !
; ! VM Base Address   ! Internal Video Counter                          !   +-------------------+-------------------+-------------------+
;
; g-adress: access Bitmap                                                   g-Data
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; !CB13! VC9! VC8! VC7! VC6! VC5! VC4! VC3! VC2! VC1! VC0! RC2! RC1! RC0!   !         4 pixels (2 bits/pixel)       !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !                                       !
; !Base! Internal Video Counter                          ! Row Counter  !   ! 00 - Background color 0   - BGCOL0    !
;                                                                           ! 01 - Color from bits 4…7  of c-data   !
;                                                                           ! 10 - Color from bits 0…3  of c-data   !
;                                                                           ! 11 - Color from bits 8…11 of c-data   !
;                                                                           +---------------------------------------+
; 
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; Sprites - Address Bits 14…15 - Bits 0…1 of CI2PRA ($DD00)
; --------------------------------------------------------------------------------------------------------------------------------------- ;
; 
; p-address: access Sprite Data pointer                                     p-data
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; !VM13!VM12!VM11!VM10!  1 !  1 !  1 !  1 !  1 !  1 !  1 !Sprite number !   ! MP7! MP6! MP5! MP4! MP3! MP2! MP1! MP0!
; +----+----+----+----+----+----+----+----+----+----+----+--------------+   +----+----+----+----+----+----+----+----+
; ! VM Base Address   ! Sprite Pointer Offset ($03f8)    ! $00…$07      !   ! Sprite Data Block Number              !
;
; s-address: âccess Sprite Data                                             s-data
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; ! 13 ! 12 ! 11 ! 10 !  9 !  8 !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !   !  7 !  6 !  5 !  4 !  3 !  2 !  1 !  0 !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
; ! MP7! MP6! MP5! MP4! MP3! MP2! MP1! MP0! MC5! MC4! MC3! MC2! MC1! MC0!   !         8 pixels (1 bit/pixel)        !
; +----+----+----+----+----+----+----+----+----+----+----+----+----+----+   !                                       ! MxMC = 0
; ! Sprite Data Block Number              ! Sprite Data Counter         !   !  0 - Transparent                      !
;                                                                           !  1 - Sprite color ($d027-$d02e)       !
;                                                                           +---------------------------------------+
;                                                                           !         4 pixels (2 bits/pixel)       !
;                                                                           !                                       !
;                                                                           ! 00 - Transparent                      ! MxMC = 1
;                                                                           ! 01 - Sprite multicolor 0 - SPMC0      !
;                                                                           ! 10 - Sprite color        - SPnCOL     !
;                                                                           ! 11 - Sprite multicolor 1 - SPMC1      !
;                                                                           +---------------------------------------+
; 
; ------------------------------------------------------------------------------------------------------------- ;
                                                ;   Note:
                                                ;     A VIC read for sprite/bitmap/screen data from $1000-$1fff
                                                ;     in bank 0/2 is always from the CHAR ROM instead from RAM
                                                ;     sprite/bitmap/screen data cannot be read from here
                                                ; 
                                                ;     $1000-$1fff - Bank 0
                                                ;     $9000-$9fff - Bank 2
                                                ;-------------------------------------------------------------- ;
                              ;  .......1       ; Bit 0: <not used>
                                                ; 
VMCSB_CB_MASK                 = %00001110       ; Bits 1…3: Character Set Base address within the VIC-II address space
VMCSB_CB11                      = %00000010     ; 
VMCSB_CB12                      = %00000100     ; 
VMCSB_CB13                      = %00001000     ; 
                                                ; 
VMCSB_CB_0000                   = %00000000     ;  .... $00: $0000-$07ff
VMCSB_CB_0800                   = %00000010     ;  ..#. $02: $0800-$0fff
VMCSB_CB_1000                   = %00000100     ;  .#.. $04: $1000-$17ff - Char ROM  mirror in bank 0 or 2 / no mirror in bank 1 or 3
VMCSB_CB_1800                   = %00000110     ;  .##. $06: $1800-$1fff
VMCSB_CB_2000                   = %00001000     ;  #... $08: $2000-$27ff
VMCSB_CB_2800                   = %00001010     ;  #.#. $0a: $2800-$2fff
VMCSB_CB_3000                   = %00001100     ;  ##.. $0c: $3000-$37ff
VMCSB_CB_3800                   = %00001110     ;  ###. $0e: $3800-$3fff 
                                                ; 
VMCSB_VM_MASK                 = %11110000       ; Bits 4…7: Video Matrix Base address within the VIC-II address space
VMCSB_VM10                      = %00010000     ; 
VMCSB_VM11                      = %00100000     ; 
VMCSB_VM12                      = %01000000     ; 
VMCSB_VM13                      = %10000000     ; 
                                                ; 
VMCSB_VM_0000                   = %00000000     ; ....  $00: $0000-$03e7 - Sprite Pointers: $03f8…$03ff - possible bitmap start
VMCSB_VM_0400                   = %00010000     ; ...#  $10: $0400-$07e7 - Sprite Pointers: $07f8…$07ff
VMCSB_VM_0800                   = %00100000     ; ..#.  $20: $0800-$0be7 - Sprite Pointers: $0bf8…$0bff
VMCSB_VM_0C00                   = %00110000     ; ..##  $30: $0c00-$0fe7 - Sprite Pointers: $0ff8…$0fff
VMCSB_VM_1000                   = %01000000     ; .#..  $40: $1000-$13e7 - Sprite Pointers: $13f8…$13ff
VMCSB_VM_1400                   = %01010000     ; .#.#  $50: $1400-$17e7 - Sprite Pointers: $17f8…$17ff
VMCSB_VM_1800                   = %01100000     ; .##.  $60: $1800-$1be7 - Sprite Pointers: $1bf8…$1bff
VMCSB_VM_1C00                   = %01110000     ; .###  $70: $1c00-$1fe7 - Sprite Pointers: $1ff8…$1fff
VMCSB_VM_2000                   = %10000000     ; #...  $80: $2000-$23e7 - Sprite Pointers: $23f8…$23ff - possible bitmap start
VMCSB_VM_2400                   = %10010000     ; #..#  $90: $2400-$27e7 - Sprite Pointers: $27f8…$27ff
VMCSB_VM_2800                   = %10100000     ; #.#.  $a0: $2800-$2be7 - Sprite Pointers: $2bf8…$2bff
VMCSB_VM_2C00                   = %10110000     ; #.##  $b0: $2c00-$2fe7 - Sprite Pointers: $2ff8…$2fff
VMCSB_VM_3000                   = %11000000     ; ##..  $c0: $3000-$33e7 - Sprite Pointers: $33f8…$33ff
VMCSB_VM_3400                   = %11010000     ; ##.#  $d0: $3400-$37e7 - Sprite Pointers: $37f8…$37ff
VMCSB_VM_3800                   = %11100000     ; ###.  $e0: $3800-$3be7 - Sprite Pointers: $3bf8…$3bff
VMCSB_VM_3C00                   = %11110000     ; ####  $f0: $3c00-$3fe7 - Sprite Pointers: $3ff8…$3fff
                                                ; 
VMCSB_INIT                    = VMCSB_VM_0400 | VMCSB_CB_0800 ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
VICIRQ                      = VIC2 + $19        ; Interrupt Flag Register
VICIRQ_IRST                   = %00000001       ; Bit 0: Raster Compare IRQ               (1=yes)
VICIRQ_IMBC                   = %00000010       ; Bit 1: Sprite-Background collision IRQ  (1=yes)
VICIRQ_IMMC                   = %00000100       ; Bit 2: Sprite-Sprite     collision IRQ  (1=yes)
VICIRQ_ILP                    = %00001000       ; Bit 3: Light pen trigger IRQ            (1=yes)

                              ;  ...1....       ; Bit 4: <not used>
                              ;  ..1.....       ; Bit 5: <not used>
                              ;  .1......       ; Bit 6: <not used>
                                                ; 
VICIRQ_IRQ                    = %10000000       ; Bit 7: At least one IRQ's has happened  (1=yes)
                                                ; 
VICIRQ_CLEAR                  = %11111111       ; LATCHed flags are cleared if set to 1
; ------------------------------------------------------------------------------------------------------------- ;
IRQMASK                     = VIC2 + $1a        ; IRQ Mask Register
IRQMASK_ERST                  = %00000001       ; Bit 0: Enable Raster Compare              IRQ  (1=yes)
IRQMASK_EMBC                  = %00000010       ; Bit 1: Enable Sprite-Background collision IRQ  (1=yes)
IRQMASK_EMMC                  = %00000100       ; Bit 2: Enable Sprite-Sprite     collision IRQ  (1=yes)
IRQMASK_ELP                   = %00001000       ; Bit 3: Enable Light Pen                   IRQ  (1=yes)
                                                ; 
                              ;  ...1....       ; Bit 4: <not used>
                              ;  ..1.....       ; Bit 5: <not used>
                              ;  .1......       ; Bit 6: <not used>
                              ;  1.......       ; Bit 7: <not used>
                                                ; 
IRQMASK_ALL_ENA               = %00001111       ; All IRQs enabled
IRQMASK_INIT                  = IRQMASK_ALL_ENA ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SPBGPR                      = VIC2 + $1b        ; Sprite to Background Display Priority Register
                                                ;   0 = sprite will be displayed behind      the background graphics data
                                                ;   1 = sprite will be displayed in front of the background graphics data
SPBGPR_M0DP                   = %00000001       ; Bit 0: Sprite 0 display priority
SPBGPR_M1DP                   = %00000010       ; Bit 1: Sprite 1 display priority
SPBGPR_M2DP                   = %00000100       ; Bit 2: Sprite 2 display priority
SPBGPR_M3DP                   = %00001000       ; Bit 3: Sprite 3 display priority
SPBGPR_M4DP                   = %00010000       ; Bit 4: Sprite 4 display priority
SPBGPR_M5DP                   = %00100000       ; Bit 5: Sprite 5 display priority
SPBGPR_M6DP                   = %01000000       ; Bit 6: Sprite 6 display priority
SPBGPR_M7DP                   = %10000000       ; Bit 7: Sprite 7 display priority
                
SPBGPR_ALL_BG                 = %11111111       ; All Sprites display priority behind background
SPBGPR_ALL_FG                 = %00000000       ; All Sprites display priority in front of background
                                                ; 
                                                ; Each lower-numberd sprite has priority over all higher-numbered sprites
                                                ; 
                                                ; Note: 
                                                ;   +------------+-------+--------+
                                                ;   !            ! MCM=0 ! MCM=1  ! Multi Color Mode
                                                ;   +------------+-------+--------+
                                                ;   ! Background !   0   ! 00, 01 !
                                                ;   ! Foreground !   1   ! 10, 11 !
                                                ;   +------------+-------+--------+
                                                ;   In MCM mode the '01' bit-pair displays a background color BEHIND
                                                ;   the sprite graphics even if the background graphics data takes priority
; ------------------------------------------------------------------------------------------------------------- ;
SPMC                        = VIC2 + $1c        ; Sprite Multicolor Register
SPMC_M0MC                     = %00000001       ; Bit 0: Sprite 0 multicolor mode  (1=multicolor, 0=hi-res)
SPMC_M1MC                     = %00000010       ; Bit 1: Sprite 1 multicolor mode  (1=multicolor, 0=hi-res)
SPMC_M2MC                     = %00000100       ; Bit 2: Sprite 2 multicolor mode  (1=multicolor, 0=hi-res)
SPMC_M3MC                     = %00001000       ; Bit 3: Sprite 3 multicolor mode  (1=multicolor, 0=hi-res)
SPMC_M4MC                     = %00010000       ; Bit 4: Sprite 4 multicolor mode  (1=multicolor, 0=hi-res)
SPMC_M5MC                     = %00100000       ; Bit 5: Sprite 5 multicolor mode  (1=multicolor, 0=hi-res)
SPMC_M6MC                     = %01000000       ; Bit 6: Sprite 6 multicolor mode  (1=multicolor, 0=hi-res)
SPMC_M7MC                     = %10000000       ; Bit 7: Sprite 7 multicolor mode  (1=multicolor, 0=hi-res)
                                                ; 
SPMC_ALL_ON                   = %11111111       ; All Sprites multicolor mode on
SPMC_ALL_OFF                  = ~SPMC_ALL_ON    ; All Sprites multicolor mode off
                                                ; 
                                                ; Each 2 bits of the sprite data display dot colors from this sources
                                                ;   00 - Background Color  Register 0 (transparent)
                                                ;   01 - Sprite Multicolor Register 0 (SPMC0)
                                                ;   10 - Sprite Color Registers       (SPnCOL)
                                                ;   11 - Sprite Multicolor Register 1 (SPMC1)
; ------------------------------------------------------------------------------------------------------------- ;
XXPAND                      = VIC2 + $1d        ; Sprite Horizontal Expansion Register
XXPAND_M0XE                   = %00000001       ; Bit 0: Sprite 0 double width  (1=double-width, 0=normal width)
XXPAND_M1XE                   = %00000010       ; Bit 1: Sprite 1 double width  (1=double-width, 0=normal width)
XXPAND_M2XE                   = %00000100       ; Bit 2: Sprite 2 double width  (1=double-width, 0=normal width)
XXPAND_M3XE                   = %00001000       ; Bit 3: Sprite 3 double width  (1=double-width, 0=normal width)
XXPAND_M4XE                   = %00010000       ; Bit 4: Sprite 4 double width  (1=double-width, 0=normal width)
XXPAND_M5XE                   = %00100000       ; Bit 5: Sprite 5 double width  (1=double-width, 0=normal width)
XXPAND_M6XE                   = %01000000       ; Bit 6: Sprite 6 double width  (1=double-width, 0=normal width)
XXPAND_M7XE                   = %10000000       ; Bit 7: Sprite 7 double width  (1=double-width, 0=normal width)
                                                ; 
XXPAND_ALL_ON                 = %11111111       ; All Sprites double width
XXPAND_ALL_OFF                = ~XXPAND_ALL_ON  ; All Sprites normal width
; ------------------------------------------------------------------------------------------------------------- ;
SPSPCL                      = VIC2 + $1e        ; Sprite to Sprite Collision Register
SPSPCL_M0M                    = %00000001       ; Bit 0: Sprite 0 collided with another sprite  (1=yes)
SPSPCL_M1M                    = %00000010       ; Bit 1: Sprite 1 collided with another sprite  (1=yes)
SPSPCL_M2M                    = %00000100       ; Bit 2: Sprite 2 collided with another sprite  (1=yes)
SPSPCL_M3M                    = %00001000       ; Bit 3: Sprite 3 collided with another sprite  (1=yes)
SPSPCL_M4M                    = %00010000       ; Bit 4: Sprite 4 collided with another sprite  (1=yes)
SPSPCL_M5M                    = %00100000       ; Bit 5: Sprite 5 collided with another sprite  (1=yes)
SPSPCL_M6M                    = %01000000       ; Bit 6: Sprite 6 collided with another sprite  (1=yes)
SPSPCL_M7M                    = %10000000       ; Bit 7: Sprite 7 collided with another sprite  (1=yes)
                                                ; 
                                                ; Note:
                                                ;   SPSPCL is cleared on read
; ------------------------------------------------------------------------------------------------------------- ;
SPBGCL                      = VIC2 + $1f        ; Sprite to Background Collision Register
SPBGCL_M0D                    = %00000001       ; Bit 0: Sprite 0 collided with background  (1=yes)
SPBGCL_M1D                    = %00000010       ; Bit 1: Sprite 1 collided with background  (1=yes)
SPBGCL_M2D                    = %00000100       ; Bit 2: Sprite 2 collided with background  (1=yes)
SPBGCL_M3D                    = %00001000       ; Bit 3: Sprite 3 collided with background  (1=yes)
SPBGCL_M4D                    = %00010000       ; Bit 4: Sprite 4 collided with background  (1=yes)
SPBGCL_M5D                    = %00100000       ; Bit 5: Sprite 5 collided with background  (1=yes)
SPBGCL_M6D                    = %01000000       ; Bit 6: Sprite 6 collided with background  (1=yes)
SPBGCL_M7D                    = %10000000       ; Bit 7: Sprite 7 collided with background  (1=yes)
                                                ; 
                                                ; Note:
                                                ;   SPBGCL is cleared on read
                                                ; 
                                                ;   Bit combinations belonging to fore- or background
                                                ;   +------------+-------+--------+
                                                ;   !            ! MCM=0 ! MCM=1  !
                                                ;   +------------+-------+--------+
                                                ;   ! Background !   0   ! 00, 01 !
                                                ;   ! Foreground !   1   ! 10, 11 !
; --------------------------------------------------+------------+-------+--------+---------------------------- ;
; Color Registers                               ; $D020-$D02E
; ------------------------------------------------------------------------------------------------------------- ;
EXTCOL                      = VIC2 + $20        ; Border Color Register
EXTCOL_EC_MASK                = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
EXTCOL_EC0                    = %00000001       ; Bit 0: 
EXTCOL_EC1                    = %00000010       ; Bit 1: 
EXTCOL_EC2                    = %00000100       ; Bit 2: 
EXTCOL_EC3                    = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
EXTCOL_INIT                   = LT_BLUE         ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
BGCOL0                      = VIC2 + $21        ; Background Color Register 0
BGCOL0_B0C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
BGCOL0_B0C0                   = %00000001       ; Bit 0: 
BGCOL0_B0C1                   = %00000010       ; Bit 1: 
BGCOL0_B0C2                   = %00000100       ; Bit 2: 
BGCOL0_B0C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
BGCOL0_INIT                   = BLUE            ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
BGCOL1                      = VIC2 + $22        ; Background Color Register 1
                                                ;   Color for the '01' bit-pair of the Extended Colour Mode
                                                ;   Background color for chars with screen codes $40-$7f
                                                ;     in extended background color text mode
BGCOL1_B1C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
BGCOL1_B1C0                   = %00000001       ; Bit 0: 
BGCOL1_B1C1                   = %00000010       ; Bit 1: 
BGCOL1_B1C2                   = %00000100       ; Bit 2: 
BGCOL1_B1C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
BGCOL1_INIT                   = WHITE           ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
BGCOL2                      = VIC2 + $23        ; Background Color Register 2
                                                ;   Color for the '10' bit-pair of the Extended Colour Mode
                                                ;   Background color for chars with screen codes $80-$bf
                                                ;     in extended background color text mode
BGCOL2_B2C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
BGCOL2_B2C0                   = %00000001       ; Bit 0: 
BGCOL2_B2C1                   = %00000010       ; Bit 1: 
BGCOL2_B2C2                   = %00000100       ; Bit 2: 
BGCOL2_B2C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
BGCOL2_INIT                   = RED             ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
BGCOL3                      = VIC2 + $24        ; Background Color Register 3
                                                ;   Background color for chars with screen codes $c0-$ff
                                                ;     in extended background color text mode
BGCOL3_B3C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
BGCOL3_B3C0                   = %00000001       ; Bit 0: 
BGCOL3_B3C1                   = %00000010       ; Bit 1: 
BGCOL3_B3C2                   = %00000100       ; Bit 2: 
BGCOL3_B3C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
BGCOL3_INIT                   = CYAN            ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SPMC0                       = VIC2 + $25        ; Sprite Multicolor Register 0
                                                ;   Color for the '01' bit-pair
SPMC0_MM0_MASK                = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
SPMC0_MM00                    = %00000001       ; Bit 0: 
SPMC0_MM01                    = %00000010       ; Bit 1: 
SPMC0_MM02                    = %00000100       ; Bit 2: 
SPMC0_MM03                    = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
SPMC0_INIT                   = PURPLE           ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SPMC1                       = VIC2 + $26        ; Sprite Multicolor Register 1
                                                ;   Color for the '11' bit-pair
SPMC1_MM1_MASK                = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
SPMC1_MM10                    = %00000001       ; Bit 0: 
SPMC1_MM11                    = %00000010       ; Bit 1: 
SPMC1_MM12                    = %00000100       ; Bit 2: 
SPMC1_MM13                    = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
SPMC1_INIT                   = BLACK            ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SP0COL                      = VIC2 + $27        ; Color Sprite 0
                                                ;   Color displayed by data bits=1 or the multicolor '10' bit-pair
SP0COL_M0C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
SP0COL_M0C0                   = %00000001       ; Bit 0: 
SP0COL_M0C1                   = %00000010       ; Bit 1: 
SP0COL_M0C2                   = %00000100       ; Bit 2: 
SP0COL_M0C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
SP0COL_INIT                   = WHITE           ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SP1COL                      = VIC2 + $28        ; Color Sprite 1
                                                ;   Color displayed by data bits=1 or the multicolor '10' bit-pair
SP1COL_M1C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
SP1COL_M1C0                   = %00000001       ; Bit 0: 
SP1COL_M1C1                   = %00000010       ; Bit 1: 
SP1COL_M1C2                   = %00000100       ; Bit 2: 
SP1COL_M1C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
SP1COL_INIT                   = RED             ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SP2COL                      = VIC2 + $29        ; Color Sprite 2
                                                ;   Color displayed by data bits=1 or the multicolor '10' bit-pair
SP2COL_M2C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
SP2COL_M2C0                   = %00000001       ; Bit 0: 
SP2COL_M2C1                   = %00000010       ; Bit 1: 
SP2COL_M2C2                   = %00000100       ; Bit 2: 
SP2COL_M2C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
SP2COL_INIT                   = CYAN            ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SP3COL                      = VIC2 + $2a        ; Color Sprite 3
                                                ;   Color displayed by data bits=1 or the multicolor '10' bit-pair
SP3COL_M3C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
SP3COL_M3C0                   = %00000001       ; Bit 0: 
SP3COL_M3C1                   = %00000010       ; Bit 1: 
SP3COL_M3C2                   = %00000100       ; Bit 2: 
SP3COL_M3C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
SP3COL_INIT                   = PURPLE          ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SP4COL                      = VIC2 + $2b        ; Color Sprite 4
                                                ;   Color displayed by data bits=1 or the multicolor '10' bit-pair
SP4COL_M4C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
SP4COL_M4C0                   = %00000001       ; Bit 0: 
SP4COL_M4C1                   = %00000010       ; Bit 1: 
SP4COL_M4C2                   = %00000100       ; Bit 2: 
SP4COL_M4C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
SP4COL_INIT                   = GREEN           ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SP5COL                      = VIC2 + $2c        ; Color Sprite 5
                                                ;   Color displayed by data bits=1 or the multicolor '10' bit-pair
SP5COL_M5C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
SP5COL_M5C0                   = %00000001       ; Bit 0: 
SP5COL_M5C1                   = %00000010       ; Bit 1: 
SP5COL_M5C2                   = %00000100       ; Bit 2: 
SP5COL_M5C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
SP5COL_INIT                   = BLUE            ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SP6COL                      = VIC2 + $2d        ; Color Sprite 6
                                                ;   Color displayed by data bits=1 or the multicolor '10' bit-pair
SP6COL_M6C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
SP6COL_M6C0                   = %00000001       ; Bit 0: 
SP6COL_M6C1                   = %00000010       ; Bit 1: 
SP6COL_M6C2                   = %00000100       ; Bit 2: 
SP6COL_M6C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
SP6COL_INIT                   = YELLOW          ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
SP7COL                      = VIC2 + $2e        ; Color Sprite 7
                                                ;   Color displayed by data bits=1 or the multicolor '10' bit-pair
SP7COL_M7C_MASK               = %00001111       ; Only the lower 4 bits are connected - the upper 4 bits should be masked out
SP7COL_M7C0                   = %00000001       ; Bit 0: 
SP7COL_M7C1                   = %00000010       ; Bit 1: 
SP7COL_M7C2                   = %00000100       ; Bit 2: 
SP7COL_M7C3                   = %00001000       ; Bit 3: 
                                                ; 
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
                                                ; 
SP7COL_INIT                   = GREY            ; Initial value set in KERNAL routine TVIC
; ------------------------------------------------------------------------------------------------------------- ;
; $D02F-$D03F                                   ; Not Connected - always $ff when read even after writes
; ------------------------------------------------------------------------------------------------------------- ;
; VIC-IIe only  (C128)
; ------------------------------------------------------------------------------------------------------------- ;
; Three output lines are used to scan the three keyboard columns containing the
; 24 keys in the numeric keypad and top row of control keys
; ------------------------------------------------------------------------------------------------------------- ;
XSCAN                       = VIC2 + $2f        ; Extended keyboard scan-line control register
VIC2_KCR                    = XSCAN             ; 
XSCAN_K0                      = %00000001       ; VIC output line K0
XSCAN_K1                      = %00000010       ; VIC output line K1
XSCAN_K2                      = %00000100       ; VIC output line K2
                                                ; 
                              ;  ....1...       ; Bit 3: <not connected>
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
; ------------------------------------------------------------------------------------------------------------- ;
CLKRATE                     = VIC2 + $30        ; Processor clock rate control register
VIC2_FAST                   = CLKRATE           ; 
CLKRATE_SPEED                 = %00000001       ; 1=2MhZ 0=1MHZ
CLKRATE_TEST                  = %00000010       ; 
                                                ; 
                              ;  .....1..       ; Bit 3: <not connected>
                              ;  ....1...       ; Bit 3: <not connected>
                              ;  ...1....       ; Bit 4: <not connected>
                              ;  ..1.....       ; Bit 5: <not connected>
                              ;  .1......       ; Bit 6: <not connected>
                              ;  1.......       ; Bit 7: <not connected>
; ------------------------------------------------------------------------------------------------------------- ;
; $D040-$D3FF                                   ; VIC II registers are repeated each $40 bytes in the area $d040-$d3ff
; ------------------------------------------------------------------------------------------------------------- ;
