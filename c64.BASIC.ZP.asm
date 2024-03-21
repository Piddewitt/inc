; --------------------------------------------------------------------------------------------------------------------- ;
; C64 - BASIC Zero Page Entries
; --------------------------------------------------------------------------------------------------------------------- ;
CBZ_02                      = $02               ; unused
; --------------------------------------------------------------------------------------------------------------------- ;
; Vector to the address of the BASIC routine converting a floating point number to an integer - not used in BASIC
; --------------------------------------------------------------------------------------------------------------------- ;
ADRAY1                      = $03               ; Vect: to routine FLPINT - Convert [FAC] to Integer in .A/.Y    unused
ADRAY1_LO                     = $03             ; 
ADRAY1_HI                     = $04             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Vector to the address of the BASIC routine converting an integer to a floating point number - not used in BASIC
; --------------------------------------------------------------------------------------------------------------------- ;
ADRAY2                      = $05               ; Vect: to routine GIVAYF - Convert Integer in .A/.Y to [FAC]    unused
ADRAY2_LO                     = $05             ; 
ADRAY2_HI                     = $06             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Temp integer for functions AND, OR and power function FPWRT
; --------------------------------------------------------------------------------------------------------------------- ;
INTEGR                      = $07               ;       
INTEGR_LO                     = $07             ;       first integer operand LO during AND/OR
INTEGR_HI                     = $08             ;       first integer operand HI during AND/OR
; --------------------------------------------------------------------------------------------------------------------- ;
; Input buffer scan character looking for line ends, colons, quotes, commas and other special characters
; --------------------------------------------------------------------------------------------------------------------- ;
CHARAC                      = INTEGR            ;       search char for scanning BASIC text input
ENDCHR                      = $08               ; flag: <QUOTE> or scan character for statement termination
; --------------------------------------------------------------------------------------------------------------------- ;
; Cursor column position before the last TAB() or SPC() is moved here from Kernal ZP PNTR  
; used to calculate where the cursor ends up after TAB() or SPC()
;
; shows the position of the cursor on a logical line
; one logical line can be up to $02 physical lines so the value ranges from $00 to $4f
; --------------------------------------------------------------------------------------------------------------------- ;
TRMPOS                      = $09               ;       save cursor column pos before the last TAB() or SPC()
; --------------------------------------------------------------------------------------------------------------------- ;
; Determine between LOAD/VERIFY - passed to Kernal LOAD routine which saves it in Kernal ZP VERCK  
; --------------------------------------------------------------------------------------------------------------------- ;
BVERCK                      = $0a               ; flag: LOAD/VERIFY                                            .hbu001.
BVERCK_LOAD                   = $00             ;         LOAD
BVERCK_VERIFY                 = $01 ; - $ff     ;         VERIFY
; --------------------------------------------------------------------------------------------------------------------- ;
; Crunch token / Buffer index / Aarray dimensions
;  - current token during tokenization
;    - after tokenizing contains the length of the tokenized line including 4 bytes for BAS_TXT_LIN_NEXT / BAS_TXT_LIN_NUM
;  - len of BASIC line during insertion of line
;  - number of DIMensions during ARRAY operations
;  - number of subscripts when referencing an ARRAY element
;  - AND/OR switch
; --------------------------------------------------------------------------------------------------------------------- ;
COUNT                       = $0b               ;       line crunch/array access/logic operators
COUNT_AND                     = $00             ;         $00 = AND
COUNT_OR                      = $ff             ;         $ff = OR
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag for building an array or referencing an existing array
;   - check if a variable is in an ARRAY
;   - check if the ARRAY has already been DIMed
;   - check if a new ARRAY should assume the default size
; --------------------------------------------------------------------------------------------------------------------- ;
DIMFLG                      = $0c               ; Flag: default array dimension
DIMFLG_NONE                   = $00             ;         operation was not called by DIM
DIMFLG_DIM                    = $40 ; - $7F     :         operation was called by DIM
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag type of variable
; --------------------------------------------------------------------------------------------------------------------- ;
VALTYP                      = $0d               ; Flag: type of variable
VALTYP_NUM                    = $00             ;         NUMERIC
VALTYP_STR                    = $ff             ;         STRING
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag numeric type of variable
; --------------------------------------------------------------------------------------------------------------------- ;
INTFLG                      = $0e               ; Flag: numeric type of variable
INTFLG_FLOAT                  = $00             ;         FLOATING POINT
INTFLG_INTEGER                = $80             ;         INTEGER
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag to indicate a GARBAGE COLLECTION has already been tried before adding a new string
; --------------------------------------------------------------------------------------------------------------------- ;
GARBFL                      = $0f               ; Flag: Garbage Collection already tried
GARBFL_DONE                   = $80             ;       Garbage Collection already took place
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag to prevent detokenization of a BASIC char string
;   LIST: indicate a char STRING in <QUOTE>s
;   DATA: indicate a DATA STRING
; --------------------------------------------------------------------------------------------------------------------- ;
DORES                       = GARBFL            ; Flag: prevent uncrunch of a BASIC char strin
DORES_NORMAL                  = %00000000       ;       both: normal mode
DORES_QUOTe                   = %10000000       ;       LIST: bit7 = 1 - <QUOTE> mode (open quote)
DORES_DATA                    = %01000000       ;       DATA: bit6 = 1 - DATA mode
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag variable is an ARRAY variable or a user-defined FUNCTION
; --------------------------------------------------------------------------------------------------------------------- ;
SUBFLG                      = $10               ; Flag: subscript reference/user function (FNx) call
SUBFLG_SUBSCRIPT              = $00             ;       subscript
SUBFLG_FNX                    = $80             ;       user function (DEF FN)
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag to distinguish between INPUT/GET/READ - Determine the appropriate error message
;   - line number if DATA statement
;   - 'REDO FROM START' if incorrect INPUT data
;   - 'EXTRA IGNORED'
; --------------------------------------------------------------------------------------------------------------------- ;
INPFLG                      = $11               ; Flag: input mode
INPFLG_INPUT                  = $00             ;         INPUT
INPFLG_GET                    = $40             ;         GET
INPFLG_READ                   = $98             ;         READ
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag comparison evaluation A <=> B
;   If more than one comparison operator was used the value here will be a combination of the above values
; --------------------------------------------------------------------------------------------------------------------- ;
DOMASK                      = $12               ; Flag: comparison evaluation
DOMASK_GT                     = %00000001       ;         $01 - A > B
DOMASK_EQ                     = %00000010       ;         $02 - A = B
DOMASK_LT                     = %00000100       ;         $04 - A < B
; --------------------------------------------------------------------------------------------------------------------- ;
; Resultant sign of a SIN/COS/ATN/TAN function
; --------------------------------------------------------------------------------------------------------------------- ;
TANSGN                      = DOMASK            ;       ATN sign
TANSGN_NEGATIVE               = $ff             ; 
TANSGN_POSITIVE               = $00             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Current channel number for BASIC input/output routines
; Device numbers
;   keyboard  = $00
;   datasette = $01
;   rs232c    = $02
;   screen    = $03
;   iee       = $04-$1f
;     printer = $04-$05
;     disk    = $08-$0f
; --------------------------------------------------------------------------------------------------------------------- ;
CHANNL                      = $13               ;       number current I/O channel
CHANNL_DEFAULT                = $00             ; Flag: default input=KEYBOARD (0) / default output=SCREEN (3)
; --------------------------------------------------------------------------------------------------------------------- ;
; Memory address during PEEK/POKE/WAIT/SYS
; --------------------------------------------------------------------------------------------------------------------- ;
POKER                       = $14               ; Ptr:  address for PEEK/POKE/WAIT/SYS
POKER_LO                      = $14             ; 
POKER_HI                      = $15             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Line number
;   - target line number for GOTO/ON/GOSUB
;   - second line number (highest line numer to be listed) during LIST
;   - number of a BASIC line to be added or replaced
; --------------------------------------------------------------------------------------------------------------------- ;
LINNUM                      = POKER             ; Ptr:  integer line number value for GOTO/LIST/ON/GOSUB
LINNUM_LO                     = POKER_LO        ; 
LINNUM_HI                     = POKER_HI        ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to next available slot in the temporary string descriptor stack TEMPST  
; --------------------------------------------------------------------------------------------------------------------- ;
TEMPPT                      = $16               ; Offset: next available space in the temporary descriptor stack TEMPST  
TEMPPT_1ST                    = (TEMPST + (STRSIZ * $00)) ; possible values: $19
TEMPPT_2ND                    = (TEMPST + (STRSIZ * $01)) ;                  $1c
TEMPPT_3RD                    = (TEMPST + (STRSIZ * $02)) ;                  $1f
TEMPPT_END                    = (TEMPST + (STRSIZ * $03)) ;                  $22
                            
NUMTMP                        = $03             ;       count  TEMPST   entries
STRSIZ                        = $03             ;       length TEMPST   entry
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the last string descriptor used in the temporary string descriptor stack TEMPST  
; --------------------------------------------------------------------------------------------------------------------- ;
LASTPT                      = $17               ; Ptr:  address previous string in the descriptor stack TEMPST  
LASTPT_LO                     = $17             ; 
LASTPT_HI                     = $18             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Descriptor stack for three temporary STRINGS - STRINGS which have not yet been assigned to a STRING variable
; --------------------------------------------------------------------------------------------------------------------- ;
TEMPST                      = $19   ; - $21     ;       descriptor stack for temporary strings ($09 bytes = $03 entries)
TEMPST_ENTRY_1ST              = $19 ; - $1b     ;       length   string in string heap 
;                             = $1a             ;       adr low  string in string heap - if descriptor has a length <> $00
;                             = $1b             ;       adr high string in string heap
                            
TEMPST_ENTRY_2ND              = $1c ; - $1e     ;       length   string in string heap 
;                             = $1d             ;       adr low  string in string heap - if descriptor has a length <> $00
;                             = $1e             ;       adr high string in string heap
                            
TEMPST_ENTRY_3RD              = $1f ; - $21     ;       length   string in string heap 
;                             = $20             ;       adr low  string in string heap - if descriptor has a length <> $00
;                             = $21             ;       adr high string in string heap
; --------------------------------------------------------------------------------------------------------------------- ;
; Misc temp pointers and calculation results
; --------------------------------------------------------------------------------------------------------------------- ;
INDEX                       = $22               ;       misc temp byte
INDEX_LO                      = INDEX + $00     ; 
INDEX_HI                      = INDEX + $01     ; 

INDEX1                      = INDEX             ;       misc temp byte
INDEX1_LO                     = INDEX1 + $00    ; 
INDEX1_HI                     = INDEX1 + $01    ; 
                            
INDEX2                      = $24               ;       misc temp byte
INDEX2_LO                     = INDEX2 + $00    ;       misc temp byte
INDEX2_HI                     = INDEX2 + $01    ;       misc temp byte
; --------------------------------------------------------------------------------------------------------------------- ;
; FLOATING POINT multiplication work area
; --------------------------------------------------------------------------------------------------------------------- ;
RESHO                       = $26               ;       temp mantissa 1
RESMOH                      = $27               ;       temp mantissa 2
RESMO                       = $28               ;       temp mantissa 3
RESLO                       = $29               ;       temp mantissa 4
; --------------------------------------------------------------------------------------------------------------------- ;
CBZ_2a                      = $2a               ;       unused
; --------------------------------------------------------------------------------------------------------------------- ;
; Work area for array size computations
; --------------------------------------------------------------------------------------------------------------------- ;
ADDEND                      = RESMO             ;       work array dimension size
ADDEND_LO                     = RESMO + $00     ; 
ADDEND_HI                     = RESMO + $01     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the start of the tokenized BASIC program
; --------------------------------------------------------------------------------------------------------------------- ;
TXTTAB                      = $2b               ; Ptr:  start of BASIC text area
TXTTAB_LO                     = TXTTAB + $00    ;         default: $0801
TXTTAB_HI                     = TXTTAB + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the start of the BASIC variable memory (Pointer to the end of the tokenized BASIC program)
; --------------------------------------------------------------------------------------------------------------------- ;
VARTAB                      = $2d               ; Ptr:  start of BASIC variables
VARTAB_LO                     = VARTAB + $00    ;       End of BASIC Program + $01
VARTAB_HI                     = VARTAB + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the start of the BASIC array memory (Pointer to the end of the BASIC variable memory)
; --------------------------------------------------------------------------------------------------------------------- ;
ARYTAB                      = $2f               ; Ptr:  start of BASIC arrays
ARYTAB_LO                     = ARYTAB + $00    ; 
ARYTAB_HI                     = ARYTAB + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; pointer to start of free RAM (Pointer to the end of the BASIC array memory)
; --------------------------------------------------------------------------------------------------------------------- ;
STREND                      = $31               ; Ptr:  start of free memory
STREND_LO                     = STREND + $00    ; 
STREND_HI                     = STREND + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the bottom of BASIC active strings space
; current end of the STRING text area and the top of free RAM (STRINGs stored bottom up in the STRING text area)
; points to the 1st byte of the last STRING referenced
; --------------------------------------------------------------------------------------------------------------------- ;
FRETOP                      = $33               ; Ptr:  top of the available free memory
FRETOP_LO                     = FRETOP + $00    ; 
FRETOP_HI                     = FRETOP + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Temp pointer to the most current STRING added in memory
; --------------------------------------------------------------------------------------------------------------------- ;
FRESPC                      = $35               ; Ptr:  memory allocated for current STRING variable
FRESPC_LO                     = FRESPC + $00    ; 
FRESPC_HI                     = FRESPC + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the highest address + $01 used by BASIC
; Pointer is decreased by 512 bytes when an RS-232 channel is opened to create two 256-byte buffers for input/output
; --------------------------------------------------------------------------------------------------------------------- ;
MEMSIZ                      = $37               ; Ptr:  highest address available to BASIC (default: $A000)
MEMSIZ_LO                     = MEMSIZ + $00    ; 
MEMSIZ_HI                     = MEMSIZ + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Line number of the BASIC statement currently executed ($ff in CURLIN_HI marks BASIC direct mode)
; --------------------------------------------------------------------------------------------------------------------- ;
CURLIN                      = $39               ; Ptr:  current BASIC line number
CURLIN_LO                     = CURLIN + $00    ;         $0000-$f9ff: line number (0-63999)
CURLIN_HI                     = CURLIN + $01    ;         $ff00-$ffff: direct mode - no BASIC program is being executed
CURLIN_DIRECT_MODE            = $ff             ; Flag: In BASIC direct mode
; --------------------------------------------------------------------------------------------------------------------- ;
; Previous line number executed when BASIC program execution ends/stops
; --------------------------------------------------------------------------------------------------------------------- ;
OLDLIN                      = $3b               ; Ptr:  previous BASIC line number for CONT
OLDLIN_LO                     = OLDLIN + $00    ; 
OLDLIN_HI                     = OLDLIN + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the the BASIC statement that is currently executed
; Updated each time a new BASIC statement begins execution
; --------------------------------------------------------------------------------------------------------------------- ;
OLDTXT                      = $3d               ; Ptr:  current BASIC statement for CONT
OLDTXT_LO                     = OLDTXT + $00    ;         $0000-$00ff: CONT not possible
OLDTXT_HI                     = OLDTXT + $01    ;         $0100-$ffff: pointer to next BASIC instruction
OLDTXT_CONT_NONE              = $00             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Line number of the current DATA statement being READ
; In case of a DATA error occurs DATLIN   will be moved to CURLIN  
;   ERROR MESSAGE shows the line containing the DATA statement instead of the line containing the READ statement
; --------------------------------------------------------------------------------------------------------------------- ;
DATLIN                      = $3f               ; Ptr:  BASIC line number of current DATA item being READ
DATLIN_LO                     = DATLIN + $00    ; 
DATLIN_HI                     = DATLIN + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the address of the current DATA item in BASIC program text (RESTORE resets this pointer to TXTTAB  )
; --------------------------------------------------------------------------------------------------------------------- ;
DATPTR                      = $41               ; Ptr:  next DATA item for READ
DATPTR_LO                     = DATPTR + $00    ; 
DATPTR_HI                     = DATPTR + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the address of the current INPUT/GET/READ item in BASIC program text
; --------------------------------------------------------------------------------------------------------------------- ;
INPPTR                      = $43               ; Ptr:  input item during GET/INPUT/READ
INPPTR_LO                     = INPPTR + $00    ; 
INPPTR_HI                     = INPPTR + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Current BASIC variable name with type flags
;   - Variable names must not be (or have imbedded) any BASIC keyword - TO and ATOM are illegal because TO is a BASIC keyword
;   - The 1st character must be A-Z
;   - The 2nd character must be A-Z 0-9 - a one-character variable name has <NULL> as 2nd character
;   - More than two characters of a variable name will be ignored - "XY" and "XY2" refer to the same variable "XY"
;   - Each variable uses $07 bytes of memory regardless of it's type
; +-------------+-------------+-------------------------------------------------------------------------------------------- ;
; ! VARNAM_CHR1 ! VARNAM_CHR2 ! VARNAM_CHR2 = $00 --> variable name only one char long
; +--------------+------------+---------------------+---------+------------+-------------+-------------+-------------+-------------+
; !  1st byte   !  2nd byte   !                     !         ! 3rd byte   ! 4th byte    ! 5th byte    ! 6th byte    ! 7th byte    !
; !    bit 7    !    bit 7    ! type                ! size    !            !             !             !             !             !
; +-------------+-------------+---------------------+---------+------------+-------------+-------------+-------------+-------------+
; !      0      !      0      ! floating point      ! 5       ! exponent   ! mantissa 1  ! mantissa 2  ! mantissa 3  ! mantissa 4  !
; !      0      !      1      ! string (descriptor) ! 3       ! length     ! adr data lo ! adr data hi ! $00         ! $00         !
; !      1      !      1      ! integer             ! 2       ! value lo   ! value hi    ! $00         ! $00         ! $00         !
; +-------------+-------------+---------------------+---------+------------+-------------+-------------+-------------+-------------+
; !             !             !                     !         ! ptr to txt ! ptr to txt  ! ptr to arg  ! ptr to arg  !             !
; !      1      !      0      ! function (DEF FN)   ! 4       ! formula lo ! formula hi  ! variable lo ! variable hi ! $00         !
; +-------------+-------------+---------------------+---------+------------+-------------+-------------+-------------+-------------+
VARNAM                      = $45               ;       current BASIC variable name
VARNAM_CHR1                   = VARNAM + $00    ; 
VARNAM_CHR2                   = VARNAM + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the descriptor of the current BASIC variable
;   To the value of the current BASIC variable (the byte just after the two-char variable name)
; --------------------------------------------------------------------------------------------------------------------- ;
VARPNT                      = $47               ; Ptr:  if INTEGER - to value of VARNAM  
VARPNT_LO                     = VARPNT + $00    ;       if STRING  - to descriptor
VARPNT_HI                     = VARPNT + $01    ; 
                            
FDECPT                      = VARPNT            ;       temp store of decimal point in routine FOUTIM  
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to value of current variable during LET
; Value of second and third parameter during WAIT
; Logical file number and device number during OPEN
; Logical file number of CLOSE
; Device number of LOAD/SAVE/VERIFY
; --------------------------------------------------------------------------------------------------------------------- ;
; Temp save area for LIST cmd
; --------------------------------------------------------------------------------------------------------------------- ;
LSTPNT                      = $49               ; Ptr:  list command
LSTPNT_LO                     = LSTPNT + $00    ; 
LSTPNT_HI                     = LSTPNT + $01    ; 

ANDMSK                      = LSTPNT            ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to the BASIC variable of a FOR/NEXT loop
;   Is stored here before being pushed onto the stack
; --------------------------------------------------------------------------------------------------------------------- ;
FORPNT                      = LSTPNT            ; Ptr:  index variable for FOR/NEXT loop
FORPNT_LO                     = FORPNT + $00    ; 
FORPNT_HI                     = FORPNT + $01    ; 
                            
EORMSK                      = FORPNT + $01      ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Temp area for saving original pointer to current BASIC instruction during GET/INPUT/READ
; --------------------------------------------------------------------------------------------------------------------- ;
VARTXT                      = $4b               ;       BASIC exec pointer: temp storage for TXTPTR   during GET/INPUT/READ
VARTXT_LO                     = VARTXT + $00    ;       BASIC exec pointer: temp low  byte/precedence flag
VARTXT_HI                     = VARTXT + $01    ;       BASIC exec pointer: temp high byte
; --------------------------------------------------------------------------------------------------------------------- ;
; Math operator displacement/INPUT TXTPTR
; --------------------------------------------------------------------------------------------------------------------- ;
OPPTR                       = VARTXT            ; Ptr:  operator
OPPTR_LO                      = OPPTR + $00     ; 
OPPTR_HI                      = OPPTR + $01     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Flag comparison evaluation A <=> B of the expression evaluation routine FRMEVL  
;   If more than one comparison was used the value here will be a combination of the above values
; --------------------------------------------------------------------------------------------------------------------- ;
OPMASK                      = $4d               ; Flag: comparison evaluation FRMEVL  
OPMASK_GT                     = %00000001       ;       $01 - A > B
OPMASK_EQ                     = %00000010       ;       $02 - A = B
OPMASK_LT                     = %00000100       ;       $04 - A < B
; --------------------------------------------------------------------------------------------------------------------- ;
; Work pointer for garbage collection
; --------------------------------------------------------------------------------------------------------------------- ;
GRBPNT                      = $4e               ; Ptr:  Garbage Collection
GRBPNT_LO                     = GRBPNT + $00    ; 
GRBPNT_HI                     = GRBPNT + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Pointer to current FN descriptor in variable storage
;   Pointer to the function that is created during function definition
;   During function execution it points to where the evaluation results should be saved
; --------------------------------------------------------------------------------------------------------------------- ;
DEFPNT                      = GRBPNT            ; Ptr:  function/variable
DEFPNT_LO                     = DEFPNT + $00    ; 
DEFPNT_HI                     = DEFPNT + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
TEMPF3                      = GRBPNT            ;       temp storage for FLPT value
; --------------------------------------------------------------------------------------------------------------------- ;
; Temp pointer to the current string descriptor during memory allocation
; --------------------------------------------------------------------------------------------------------------------- ;
DSCPNT                      = $50               ; Ptr:  [FAC] temp store/string descriptor
DSCPNT_LO                     = DSCPNT + $00    ; 
DSCPNT_HI                     = DSCPNT + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Constant for garbage collection
; --------------------------------------------------------------------------------------------------------------------- ;
FOUR6                       = $53               ;       Length: STRING variable during Garbage Collection (step size)
FOUR6_03                      = STRSIZ          ;         Const: $03 - descriptors in ARRAYS are 3-bytes each
FOUR6_07                      = ADDPRC + $06    ;         Const: $07 - BASIC variables are 7-bytes each
; --------------------------------------------------------------------------------------------------------------------- ;
; Jump opcode and vector to function routine
;   JMP opcode followed by the execution address of the required function taken from the table at FUNDSP
; --------------------------------------------------------------------------------------------------------------------- ;
JMPER                       = $54               ; 
JMPER_OPCODE                  = JMPER + $00     ;       JMP opcode - jump to current BASIC function
JMPER_LO                      = JMPER + $01     ;       functions jmp vector low  byte - execution address
JMPER_HI                      = JMPER + $02     ;       functions jmp vector high byte
; --------------------------------------------------------------------------------------------------------------------- ;
; Work area for garbage collection
; --------------------------------------------------------------------------------------------------------------------- ;
BSIZE                       = JMPER_LO          ;       temp store for [FOUR6] - step size
; --------------------------------------------------------------------------------------------------------------------- ;
; Temp store
; --------------------------------------------------------------------------------------------------------------------- ;
OLDOV                       = JMPER_HI          ;       temp store for [FACOV]  
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC numeric work area
; --------------------------------------------------------------------------------------------------------------------- ;
TEMPF1                      = $57               ;       
                            
FACTMP                      = TEMPF1            ;       [FAC] temp store #1

ARYPNT                      = $58               ;  Ptr : array data
ARYPNT_LO                     = ARYPNT + $00    ;       
ARYPNT_HI                     = ARYPNT + $01    ; 

HIGHDS                      = ARYPNT            ;  Ptr : used by mulitiple routines
HIGHDS_LO                     = HIGHDS + $00    ; 
HIGHDS_HI                     = HIGHDS + $01    ; 

HIGHTR                      = $5a               ;  Ptr : used by mulitiple routines
HIGHTR_LO                     = HIGHTR + $00    ; 
HIGHTR_HI                     = HIGHTR + $01    ;       

TEMPF2                      = $5c               ;       [FAC] temp store #2

DECCNT                      = $5d               ;       value count
LOWDS                       = DECCNT            ;       

TENEXP                      = $5e               ;       exponent count

GRBTOP                      = $5f               ; Ptr : garbage collection: pointer to highest uncollected STRING
GRBTOP_LO                     = GRBTOP + $00    ; 
GRBTOP_HI                     = GRBTOP + $01    ; 

DPTFLG                      = GRBTOP            ; Flag: decimal point

LOWTR                       = GRBTOP            ; Ptr : used by mulitiple routines
LOWTR_LO                      = LOWTR + $00     ; 
LOWTR_HI                      = LOWTR + $01     ; 

EXPSGN                      = LOWTR + $01       ; Flag: exponent sign
                            
FACTMP_X                    = EXPSGN            ;       end of BASIC numeric work area
FACTMP_LEN                  = FACTMP_X - FACTMP - $01 ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; FAC - BASIC floating point accumulator #1
; --------------------------------------------------------------------------------------------------------------------- ;
FAC                         = $61               ;       main floating point accumulator
FACEXP                        = FAC + $00       ;       [FAC] #1: Exponent
FACHO                         = FAC + $01       ;       [FAC] #1: Mantissa 1
FACMOH                        = FAC + $02       ;       [FAC] #1: Mantissa 2
FACMO                         = FAC + $03       ;       [FAC] #1: Converted Integer HI
FACLO                         = FAC + $04       ;       [FAC] #1: Converted Integer LO
FACSGN                        = FAC + $05       ;       [FAC] #1: Sign
FACSGN_NEGATIVE                 = %10000000     ;         bit7=1
FACSGN_POSITIVE                 = %00000000     ;         bit7=0
; --------------------------------------------------------------------------------------------------------------------- ;
; Temp storage for FAC sign
; --------------------------------------------------------------------------------------------------------------------- ;
SGNFLG                        = $67             ; Flag: negative flag during FINT  
SGNFLG_NEGATIVE                 = $ff           ; 
SGNFLG_POSITIVE                 = $00           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; High order FAC propagation word - Overflow work area byte resulting from normalization of [FAC]
; --------------------------------------------------------------------------------------------------------------------- ;
BITS                          = $68             ; Flag: overflow resulting from normalization of [FAC]
BITS_ON                         = $ff           ;       
BITS_OFF                        = $00           ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Temp string work area
; --------------------------------------------------------------------------------------------------------------------- ;
DSCTMP                      = FAC               ;       length   of temporary string
DSCTMP1                     = DSCTMP + $01      ;       adr low  of temporary string
DSCTMP2                     = DSCTMP + $02      ;       adr high of temporary string
; --------------------------------------------------------------------------------------------------------------------- ;
; Work area arry subscripts
; --------------------------------------------------------------------------------------------------------------------- ;
INDICE                      = FACMO             ; 
INDICE_LO                     = INDICE + $00    ; 
INDICE_HI                     = INDICE + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; 
; --------------------------------------------------------------------------------------------------------------------- ;
DEGREE                      = SGNFLG            ;       
; --------------------------------------------------------------------------------------------------------------------- ;
; ARG - BASIC floating point accumulator #2
; --------------------------------------------------------------------------------------------------------------------- ;
AFAC                        = $69               ;       Auxiliary Floating point Accumulator
ARGEXP                        = AFAC + $00      ;       [FAC] #2: Exponent
ARGHO                         = AFAC + $01      ;       [FAC] #2: Mantissa 1
ARGMOH                        = AFAC + $02      ;       [FAC] #2: Mantissa 2
ARGMO                         = AFAC + $03      ;       [FAC] #2: Mantissa 3
ARGLO                         = AFAC + $04      ;       [FAC] #2: Mantissa 4
ARGSGN                        = AFAC + $05      ;       [FAC] #2: Sign
ARGSGN_NEGATIVE                 = %10000000     ;         bit7=1
ARGSGN_POSITIVE                 = %00000000     ;         bit7=0
; --------------------------------------------------------------------------------------------------------------------- ;
; [FAC] to [ARG] comparison sign
; --------------------------------------------------------------------------------------------------------------------- ;
ARISGN                      = $6f               ;       Sign: comparison result [FAC] vs [ARG]
; --------------------------------------------------------------------------------------------------------------------- ;
; Work area string handling routines / string pointer
; --------------------------------------------------------------------------------------------------------------------- ;
STRNG1                      = ARISGN            ;       $6f 
STRNG1_LO                     = STRNG1 + $00    ;       $6f 
STRNG1_HI                     = STRNG1 + $01    ;       $70 
; --------------------------------------------------------------------------------------------------------------------- ;
; Low order FAC mantissa for rounding
; --------------------------------------------------------------------------------------------------------------------- ;
FACOV                       = $70               ;       [FAC] low-order mantissa for rounding
; --------------------------------------------------------------------------------------------------------------------- ;
; series evaluation pointer
; --------------------------------------------------------------------------------------------------------------------- ;
POLYPT                      = $71               ; Ptr:  current item of polynomial table during polynomial evaluatio
POLYPT_LO                     = $71             ; 
POLYPT_HI                     = $72             ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; index to the end of the BASIC line in the BASIC text buffer during tokenization
; --------------------------------------------------------------------------------------------------------------------- ;
BUFPTR                      = POLYPT            ; Ptr:  end of BASIC line
BUFPTR_LO                     = BUFPTR + $00    ; 
BUFPTR_HI                     = BUFPTR + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; saved TXTPTR for READ, GET, INPUT, VAL
; --------------------------------------------------------------------------------------------------------------------- ;
STRNG2                      = POLYPT            ; Ptr: saved TXTPTR
STRNG2_LO                     = STRNG2 + $00    ; 
STRNG2_HI                     = STRNG2 + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Work area for building an array descriptor
; --------------------------------------------------------------------------------------------------------------------- ;
CURTOL                      = POLYPT            ; Ptr: array data pointer
CURTOL_LO                     = CURTOL + $00    ; 
CURTOL_HI                     = CURTOL + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; Work area string setup
; --------------------------------------------------------------------------------------------------------------------- ;
FBUFPT                      = POLYPT            ; Ptr: string setup
FBUFPT_LO                     = FBUFPT + $00    ; 
FBUFPT_HI                     = FBUFPT + $01    ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; CHRGET                    Does    : get next byte of BASIC Text
;                                   : placed into ZP for speed and self modification
;                           Expects : 
;                           Returns : .A=char retrieved from BASIC text
;                                   : .C=1 - not NUMERIC
;                                   : .C=0 - NUMERIC
;                                   : .Z=1 - statement terminator - <NULL> or ":"
; --------------------------------------------------------------------------------------------------------------------- ;
CHRGET                      = $73 ; inc TXTPTR_LO     ; Sub:  Get next Byte of BASIC Text (inc TXTPTR)
; --------------------------------------------------------------------------------------------------------------------- ;
                            ; $75 ; bne CHRGOT        ;       check: overflow - no
                            ; $77 ; inc TXTPTR_HI     ; 
; --------------------------------------------------------------------------------------------------------------------- ;
; CHRGOT                    Does    : get same byte of BASIC Text (keep TXTPTR)
;                           Expects : 
;                           Returns : .A=char retrieved from BASIC text
;                                   : .C=1 - not NUMERIC
;                                   : .C=0 - NUMERIC
;                                   : .Z=1 - statement terminator - <NULL> or ":"
; --------------------------------------------------------------------------------------------------------------------- ;
CHRGOT                      = $79 ; lda               ;       opcode
TXTPTR                      = $7a                     ; Ptr:  Program mode: Current byte of BASIC text   at BAS_TXT_START
TXTPTR_LO                     = TXTPTR + $00          ;       Direct  mode: Current byte of input buffer at BUF
TXTPTR_HI                     = TXTPTR + $01          ; 
; --------------------------------------------------------------------------------------------------------------------- ;
                            ; $7c ; cmp #"9" + $01    ;       test ":" for top of digits - .Z=1 if ":"
                            ; $7e ; bcs QUIT          ;       check: .GE. top of digits - yes: exit no digit
; --------------------------------------------------------------------------------------------------------------------- ;
; QNUM                      Does    : CHRGET/CHRGOT numeric/terminator test entry
;                           Expects : .A=byte to compare
;                           Returns : .C=1 - not NUMERIC
;                                   : .C=0 - NUMERIC
;                                   : .Z=1 - statement terminator - <NULL> or ":"
; --------------------------------------------------------------------------------------------------------------------- ;
QNUM                        = $80 ; cmp #" "          ;       test <SPACE>es
; --------------------------------------------------------------------------------------------------------------------- ;
                            ; $82 ; beq CHRGET        ;       check: <SPACE> - yes: skip it
                            
                            ; $84 ; sec               ; 
                            ; $85 ; sbc #"0"          ;       test digit $30-$39 - .C=0 then
                            
                            ; $87 ; sec               ; 
                            ; $88 ; sbc #$100 - "0"   ;       leaves .A unchanged - set .C=1 if < "0" - set .Z=1 if <NULL>
                            
QUIT                        ; $8a ; rts               ;       .Z=1 if ":" or <NULL>
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC RND work area / Last random number / Initial seed
; --------------------------------------------------------------------------------------------------------------------- ;
RNDX                        = $8b ; - $8f       ;      RND() seed value (five bytes) - previous result of RND()
; --------------------------------------------------------------------------------------------------------------------- ;
