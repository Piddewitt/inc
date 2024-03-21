; -------------------------------------------------------------------------------------------------------------- ;
; BASIC command primary tokens
; -------------------------------------------------------------------------------------------------------------- ;
BAS_END                     = $80 ; ENDTK
BAS_FOR                     = $81 ; FORTK
BAS_NEXT                    = $82 ; 
BAS_DATA                    = $83 ; DATATK
BAS_INPUT#                  = $84 ; 
BAS_INPUT                   = $85 ; 
BAS_DIM                     = $86 ; 
BAS_READ                    = $87 ; 
BAS_LET                     = $88 ; 
BAS_GOTO                    = $89 ; GOTOTK
BAS_RUN                     = $8a ; 
BAS_IF                      = $8b ; 
BAS_RESTORE                 = $8c ; 
BAS_GOSUB                   = $8d ; GOSUTK
BAS_RETURN                  = $8e ; 
BAS_REM                     = $8f ; REMTK
BAS_STOP                    = $90 ; 
BAS_ON                      = $91 ; 
BAS_WAIT                    = $92 ; 
BAS_LOAD                    = $93 ; 
BAS_SAVE                    = $94 ; 
BAS_VERIFY                  = $95 ; 
BAS_DEF                     = $96 ; 
BAS_POKE                    = $97 ; 
BAS_PRINT#                  = $98 ; 
BAS_PRINT                   = $99 ; PRINTK
BAS_CONT                    = $9a ; 
BAS_LIST                    = $9b ; 
BAS_CLR                     = $9c ; 
BAS_CMD                     = $9d ; 
BAS_SYS                     = $9e ; 
BAS_OPEN                    = $9f ; 
BAS_CLOSE                   = $a0 ; 
BAS_GET                     = $a1 ; 
BAS_NEW                     = $a2 ; SCRATK
; -------------------------------------------------------------------------------------------------------------- ;
; BASIC command secondary tokens
; -------------------------------------------------------------------------------------------------------------- ;
BAS_TAB                     = $a3 ; TABTK
BAS_TO                      = $a4 ; TOTK
BAS_FN                      = $a5 ; FNTK
BAS_SPC                     = $a6 ; SPCTK
BAS_THEN                    = $a7 ; THENTK
BAS_NOT                     = $a8 ; NOTTK
BAS_STEP                    = $a9 ; STEPTK
; -------------------------------------------------------------------------------------------------------------- ;
; BASIC arithmetic/logic operator tokens
; -------------------------------------------------------------------------------------------------------------- ;
BAS_PLUS                    = $aa ; PLUSTK    + (Addition)
BAS_MINUS                   = $ab ; MINUTK    − (Subtraction)
BAS_MULT                    = $ac ;           * (Multiplication)
BAS_DIV                     = $ad ;           / (Division)
BAS_POWER                   = $ae ;           ^ (Power)
BAS_AND                     = $af ; 
BAS_OR                      = $b0 ; 
BAS_GT                      = $b1 ; GREATK    > (greater-than operator)
BAS_EQ                      = $b2 ; EQULTK    = (equals operator)
BAS_LT                      = $b3 ; LESSTK    < (less-than operator)
BAS_SGN                     = $b4 ; 
BAS_INT                     = $b5 ; 
BAS_ABS                     = $b6 ; 
BAS_USR                     = $b7 ; 
BAS_FRE                     = $b8 ; 
; -------------------------------------------------------------------------------------------------------------- ;
; BASIC function tokens
; -------------------------------------------------------------------------------------------------------------- ;
BAS_POS                     = $b9 ; 
BAS_SQR                     = $ba ; 
BAS_RND                     = $bb ; 
BAS_LOG                     = $bc ; 
BAS_EXP                     = $bd ; 
BAS_COS                     = $be ; 
BAS_SIN                     = $bf ; 
BAS_TAN                     = $c0 ; 
BAS_ATN                     = $c1 ; 
BAS_PEEK                    = $c2 ; 
BAS_LEN                     = $c3 ; 
BAS_STRS                    = $c4 ; 
BAS_VAL                     = $c5 ; 
BAS_ASC                     = $c6 ; 
BAS_CHRS                    = $c7 ; 
BAS_LEFTS                   = $c8 ; 
BAS_RIGHTS                  = $c9 ; 
BAS_MIDS                    = $ca ; 
; -------------------------------------------------------------------------------------------------------------- ;
; BASIC command token
; -------------------------------------------------------------------------------------------------------------- ;
BAS_GO                      = $cb ; GOTK
BAS_PI                      = $ff ; 
; -------------------------------------------------------------------------------------------------------------- ;
