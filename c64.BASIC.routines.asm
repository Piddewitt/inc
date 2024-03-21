; ------------------------------------------------------------------------------------------------------------- ;
; BASIC - Interpreter ROM ($a000 - $bfff)
; ------------------------------------------------------------------------------------------------------------- ;
                            .weak   ; avoid error: duplicate definition
; --------------------------------------------------------------------------------------------------------------------- ;
; Any symbols defined inside can be overridden by “stronger” symbols in the same scope from outside
; --------------------------------------------------------------------------------------------------------------------- ;
BCOLD                       = $a000 ; Vector: BASIC Cold Start [INIT]
BWARM                       = $a002 ; Vector: BASIC Warm Start [PANIC]
                            
BTEXT                       = $a004 ; "cbmbasic"
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC - Tables
; --------------------------------------------------------------------------------------------------------------------- ;
OPTAB                       = $a080 ; BASIC Operator  Vectors
RESLST                      = $a09e ; BASIC Primary   Command Keyword Table - only these can start a statement
MSCLST                      = $a129 ; BASIC Secondary Command Keyword Table
OPLIST                      = $a140 ; BASIC Operator  Keyword Table
FUNLST                      = $a14d ; BASIC Function  Keyword Table
EXPCON                      = $bfc4 ; BASIC Exp Constants
; --------------------------------------------------------------------------------------------------------------------- ;
ERRLST                      = $a19e ; Error Message   Table
ERRTAB                      = $a328 ; Error Message   Pointers
OKK                         = $a364 ; Misc  Messages
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC - Error numbers
; --------------------------------------------------------------------------------------------------------------------- ;
ERRNF                       = $0a   ; next without for
ERRSN                       = $0b   ; syntax
ERRRG                       = $0c   ; return without gosub
ERROD                       = $0d   ; out of data
ERRFC                       = $0e   ; illegal quantity
ERROV                       = $0f   ; overflow
ERROM                       = $10   ; out of memory
ERRUS                       = $11   ; undef'd statement
ERRBS                       = $12   ; bad subscript
ERRDD                       = $13   ; redim'd array
ERRDV0                      = $14   ; division by zero
ERRID                       = $15   ; illegal direct
ERRTM                       = $16   ; type mismatch
ERRLS                       = $17   ; string too long
ERRBD                       = $18   ; file data
ERRST                       = $19   ; formula too complex
ERRCN                       = $1a   ; can't continue
ERRUF                       = $1b   ; undef'd function
ERVFY                       = $1c   ; verify
ERLOAD                      = $1d   ; load
ERBRK                       = $1e   ; break
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC - messages
; --------------------------------------------------------------------------------------------------------------------- ;
OKMSG                       = $a364 ; OK
ERR                         = $a369 ; ERROR
INTXT                       = $a371 ; IN
REDDY                       = $a376 ; READY.
BRKTXT                      = $a381 ; BREAK
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC - Constants
; --------------------------------------------------------------------------------------------------------------------- ;
FONE                        = $b9bc ; 1.0
LOGCN2                      = $b9c1 ; LOG(n) series
SQR05                       = $b9d6 ; SQR(0.5)
SQR20                       = $b9db ; SQR(2.0)
NEGHLF                      = $b9e0 ; -1/2
LOG2                        = $b9e5 ; LN(2)
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC - Primary commands
; --------------------------------------------------------------------------------------------------------------------- ;
SCRATH                      = $a642 ; BASIC command NEW with end of statement check
SCRTCH                      = $a644 ; BASIC command NEW
CLEAR                       = $a65e ; BASIC command CLR
FOR                         = $a742 ; BASIC command FOR
RESTORE                     = $a81d ; BASIC command RESTORE
BSTOP                       = $a82f ; BASIC command STOP              ; .hbu002. 'B' added - same as KERNAL vector STOP
END                         = $a831 ; BASIC command END
CONT                        = $a857 ; BASIC command CONT
RUN                         = $a871 ; BASIC command RUN
GOSUB                       = $a883 ; BASIC command GOSUB
GOTO                        = $a8a0 ; BASIC command GOTO
RETURN                      = $a8d2 ; BASIC command RETURN
BDATA                       = $a8f8 ; BASIC command DATA              ; .hbu003. 'B' added - same as KERNAL ZP entry
IF                          = $a928 ; BASIC command IF
REM                         = $a93b ; BASIC command REM or FALSE IF
ONGOTO                      = $a94b ; BASIC command ON
LIST                        = $a69c ; BASIC command LIST
LET                         = $a9a5 ; BASIC command LET
PRINTN                      = $aa80 ; BASIC command PRINT#
CMD                         = $aa86 ; BASIC command CMD
PRINT                       = $aaa0 ; BASIC command PRINT
GET                         = $ab7b ; BASIC command GET
INPUTN                      = $aba5 ; BASIC command INPUT#
INPUT                       = $abbf ; BASIC command INPUT
NOTQTI                      = $abce ; BASIC command INPUT without prompt string
READ                        = $ac06 ; BASIC command READ
NEXT                        = $ad1e ; BASIC command NEXT
DIM                         = $b081 ; BASIC command DIM
DEF                         = $b3b3 ; BASIC command DEF FN()
POKE                        = $b824 ; BASIC command POKE
FNWAIT                      = $b82d ; BASIC command WAIT
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC - Functions
; --------------------------------------------------------------------------------------------------------------------- ;
FRE                         = $b37d ; BASIC function FRE()
POS                         = $b39e ; BASIC function POS()
STRD                        = $b465 ; BASIC function STR$()
CHR                         = $b6ec ; BASIC function CHR$()
LEFT                        = $b700 ; BASIC function LEFT$()
RIGHT                       = $b72c ; BASIC function RIGHT$()
MID                         = $b737 ; BASIC function MID$()
LEN                         = $b77c ; BASIC function LEN()
ASC                         = $b78b ; BASIC function ASC() 
VAL                         = $b7ad ; BASIC function VAL()
PEEK                        = $b80d ; BASIC function PEEK()
LOG                         = $b9ea ; BASIC function LOG()
SGN                         = $bc39 ; BASIC function SGN()
ABS                         = $bc58 ; BASIC function ABS()
SQR                         = $bf71 ; BASIC function SQR()
INT                         = $bccc ; BASIC function INT()
EXP                         = $bfed ; BASIC function EXP()
USR                         = $0310 ; BASIC function USR()
; --------------------------------------------------------------------------------------------------------------------- ;
; BASIC - Operations
; --------------------------------------------------------------------------------------------------------------------- ;
FADDT                       = $b86a ; "+" - [FAC] = [ARG] + [FAC]
FSUBT                       = $b853 ; "-" - [FAC] = [ARG] - [FAC]
FMULTT                      = $ba2b ; "*" - [FAC] = [ARG] * [FAC]
FDIVT                       = $bb12 ; "/" - [FAC] = [ARG] / [FAC]
FPWRT                       = $bf7b ; "^" - [FAC] = [ARG] ^ [FAC]
ANDOP                       = $afe9 ; BASIC command AND
OROP                        = $afe6 ; BASIC command OR
NEGOP                       = $bfb4 ; unary minus
NOTOP                       = $aed4 ; BASIC command NOT
DOREL                       = $b016 ; perform relational operations <,=,>
; --------------------------------------------------------------------------------------------------------------------- ;
; Basic - Subroutines
; --------------------------------------------------------------------------------------------------------------------- ;
FNDFOR                      = $a38a ; Ffind FOR/NEXT/RETURN entries on STACK
BLTU                        = $a3b8 ; Block transfer routine - move a block of memory up
GETSTK                      = $a3fb ; Ensure enough free STACK space ($3e=BAD_LEN) remaining
REASON                      = $a408 ; Check for enough room between ARRAYS and STRINGS
OMERR                       = $a435 ; Output ?OUT OF MEMORY error
ERROR                       = $a437 ; Indirect: Call KERNAL Error Message handler NERROR ($E38B) - which calls NERROX
NERROX                      = $a43a ; Print the error msg of the error number in .X
ERRFIN                      = $a469 ; Print the null terminated STRING pointed to by .Y/.A
READYX                      = $a474 ; Print the READY message and do a BASIC warm start - break entry
MAIN                        = $a480 ; Indirect: Call BASIC warm start NMAIN
NMAIN                       = $a483 ; Main BASIC wait for input loop - receive input and execute a BASIC direct cmd or store a BASIC line
MAIN1                       = $a49c ; Handle a new BASIC (numbered) line - DELETE or INSERT a BASIC line
FINI                        = $a52a ; Finish MAIN1
LNKPRG                      = $a533 ; Rechain BASIC program lines
INLIN                       = $a560 ; LINE INPUT
CRUNCH                      = $a579 ; Indirect: Call NCRNCH - Convert keywords into BASIC tokens
NCRNCH                      = $a57c ; Tokenize the BASIC line in BASIC text buffer
FNDLIN                      = $a613 ; Search the BASIC program text for the [LINNUM] line
FNDLNC                      = $a613 ; Search the BASIC program text for the line number in .A/.X
CLEART                      = $a663 ; Clear STRING area
FLOAD                       = $a677 ; RESTORE and clear stack - set DATA pointer to beginning
STKINI                      = $a67a ; Flush BASIC stack and clear continue pointer
STXTPT                      = $a68e ; Reset BASIC execute pointer to [TXTTAB - $01] - BASIC program start
QPLOP                       = $a71a ; Uncrunch a BASIC token
NEWSTT                      = $a7ae ; Interpreter MAIN loop - BASIC warm start
GONE                        = $a7e4 ; Execute a BASIC statement
ISCNTC                      = $a82c ; See if CRTL-C (STOP-key) was typed
DATAN                       = $a906 ; Scan ahead for next BASIC statement
LINGET                      = $a96b ; Get fixed-point line number into [LINNUM]
QINTGR                      = $a9c2 ; Assign value to NUMERIC variable
COPFLT                      = $a9d6 ; REAL variable = EXPRESSION
COPSTR                      = $a9d9 ; Assign STRING value to NUMERIC variable 
GETSPT                      = $aa2c ; Assign STRING value to NUMERIC variable - but not TI$
COPY                        = $aa52 ; Make space and copy STRING to STRING area
CRDO                        = $aad7 ; Print [CR][LF]
COMPRT                      = $aae8 ; Print <TAB>s or <SPACE>s for "," delimiter
STROUT                      = $ab1e ; Print a <NULL> terminated STRING
OUTSPC                      = $ab3b ; Print <SPACE> or <CURSOR RIGHT>
OUTQST                      = $ab45 ; Print "?"
OUTDO                       = $ab47 ; Output the character in .A
TRMNOK                      = $ab4d ; Input conversion error
QINLIN                      = $abf9 ; Print "? " and get BASIC input
INLOOP                      = $ac15 ; READ, GET or INPUT next variable from list
NUMINS                      = $ac89 ; READ, GET or INPUT is numeric
DATLOP                      = $acb8 ; Part of the READ routine which reads DATA values
VAREND                      = $acdf ; No more input requested
FRMNUM                      = $ad8a ; Evaluate expression
CHKNUM                      = $ad8d ; Check if source and destination are NUMERIC
CHKSTR                      = $ad8f ; Check if source and destination are STRING
CHKVAL                      = $ad90 ; Make sure [VALTYP] matches .C
FRMEVL                      = $ad9e ; The formula evaluator
EVAL                        = $ae83 ; Evaluate a single ASCII arithmetic term into an expression and put in [FAC]
NEVAL                       = $ae86 ; Get an arithmetic term in expression
STRTXT                      = $aebd ; Build the descriptor for a <QUOTE> enclosed STRING
PARCHK                      = $aef1 ; Evaluate expression within parentheses
CHKCLS                      = $aef7 ; test for ")" at BASIC text pos - if not: SYNTAX ERROR and warm start 
CHKOPN                      = $aefa ; test for "(" at BASIC text pos - if not: SYNTAX ERROR and warm start 
CHKCOM                      = $aefd ; test for "," at BASIC text pos - if not: SYNTAX ERROR and warm start 
SYNCHR                      = $aeff ; Ccheck if char at BASIC text pos is same as .A
SNERR                       = $af08 ; Print SYNTAX error
DOMIN                       = $af0d ; Create a unary MINUS or NOT for use in evaluation
TSTROM                      = $af14 ; Check if address points to BASIC ROM
ISVAR                       = $af28 ; Find a variable named in the BASIC text and get its value
GOOO                        = $af5d ; Get NUMERIC variable
GETTIM                      = $af84 ; Get FLOAT - read real time clock into [FAC]
QSTATV                      = $af92 ; Get FLOAT - not real time clock
ISFUN                       = $afa7 ; Process unary operators (functions)
FINGO                       = $afd6 ; Dispatch selected function in .Y
STRCMP                      = $b02e ; Do STRING "<" comparison
PTRGET                      = $b08b ; General variable scan
ISLETC                      = $b113 ; Check if .A is ASCII letter A-Z
NOTFNS                      = $b11d ; Create a new variable
FMAPTR                      = $b194 ; Setup ARRAY pointer in [ARYPNT] to 1st element in ARRAY
FLPINT                      = $b1aa ; Convert FLOATING POINT value in [FAC] to fixed INTEGER
INTIDX                      = $b1b2 ; Evaluate numeric formula at [TXTPTR] converting result to INTEGER
POSINT                      = $b1b8 ; Evaluate INTEGER expression with sign check
AYINT                       = $b1bf ; Convert [FAC] to INTEGER without sign check
ISARY                       = $b1d1 ; Locate ARRAY element or create an ARRAY
GOTARY                      = $b24d ; Get ARRAY element
BSERR                       = $b245 ; BAD SUBSCRIPT error
FCERR                       = $b248 ; ILLEGAL QUANTITY error
NOTFDD                      = $b261 ; Create new ARRAY
GIVAYF                      = $b391 ; Convert a signed INTEGER in (.A.Y) to FLOATING POINT in [FAC]
UMULT                       = $b34c ; Multiply dimensioned ARRAYs
ERRDIR                      = $b3a6 ; Check Direct Mode
GETFNM                      = $b3e1 ; Common parse routine for DEF and FNx
FNDOER                      = $b3f4 ; Evaluate FNx
STRINI                      = $b475 ; Get STRING space for the creation of a STRING
STRLIT                      = $b487 ; Build descriptor for STRING
PUTNEW                      = $b4ca ; Store descriptor in temporary descriptor STACK
GETSPA                      = $b4f4 ; Get space for character STRING at bottom of STRING space
GARBA2                      = $b526 ; Perform Garbage Collection
DVARS                       = $b5bd ; Check salvageability
GRBPAS                      = $b606 ; Collect a STRING
CAT                         = $b63d ; Concatenate two STRINGs
MOVINS                      = $b67a ; Move described STRING to [FRESPC]
FRESTR                      = $b6a3 ; Discard a temporary STRING
FRETMS                      = $b6db ; Remove an entry from the STRING descriptor stack
PREAM                       = $b761 ; Common RIGHT$/LEFT$/MID$ routine for parameter checking and setup
GTBYTC                      = $b79b ; Scan and get byte parameter to .X
GETBYT                      = $b79e ; Evaluate expression at [TXTPTR] and convert it to single byte in .X
GETNUM                      = $b7eb ; Get a 16-bit address parameter and an 8-bit parameter
GETADR                      = $b7f7 ; Convert [FAC] to a 16-bit value in [POKER]
FADDH                       = $b849 ; [FAC] = [FAC] + 0.5
FSUB                        = $b850 ; [FAC] = (.Y.A) - [FAC]
FADD                        = $b867 ; [FAC] = [FAC] + (.Y.A)
NORMAL                      = $b8d7 ; Normalise value in [FAC]
ZEROFC                      = $b8f7 ; [FAC] = 0
FADD2                       = $b8fe ; Add mantissas of [FAC] and [ARG] into [FAC]
NEGFAC                      = $b947 ; Negate [FAC]
INCFAC                      = $b96f ; Increment [FAC] mantissa
MULSHF                      = $b983 ; Shift [FAC] right .A + $08 times
SHIFTR                      = $b999 ; Main entry to right shift subroutine
ROLSHF                      = $b9b0 ; Entry short shifts with no sign extension
OVERR                       = $b97e ; Print OVERFLOW error
FMULT                       = $ba28 ; [FAC] = (.Y/.A) * [FAC]
CONUPK                      = $ba8c ; Unpack FLOATING POINT number at (.Y.A) into [ARG]
MULDIV                      = $bab7 ; Check overflow in [ARGEXP] and add exponents of [ARG] and [FAC]
MLDEXP                      = $bab9 ; Check overflow in .A and add exponents of [ARG] and [FAC]
MLDVEX                      = $bad4 ; Handle overflow and underflow
MUL10                       = $bae2 ; [FAC] = [FAC] * 10
FINML6                      = $baed ; [FAC] = [FAC] * 6
DIV10                       = $bafe ; [FAC] = [FAC] / 10
FDIVF                       = $bb07 ; [FAC] = [ARG] / (.Y.A)
FDIV                        = $bb0f ; [FAC] = (.Y.A) / [FAC]
MOVFM                       = $bba2 ; Unpack (.Y.A) into [FAC]
MOV2F                       = $bbc7 ; Round [FAC] and store in TEMP2
MOV1F                       = $bbca ; Round [FAC] and store in TEMP1
MOVVF                       = $bbd0 ; Round [FAC] and store where [FORPNT] points
MOVMF                       = $bbd4 ; Round [FAC] and store at (.Y.X)
MOVFA                       = $bbfc ; Copy [ARG] into [FAC]
MOVAF                       = $bc0c ; Copy [FAC] to [ARG] with round
MOVEF                       = $bc0f ; Copy [FAC] to [ARG] withput round
ROUND                       = $bc1b ; Round [FAC] using extension byte
SIGN                        = $bc2b ; Put SIGN of [FAC] into .A
FLOAT                       = $bc3c ; Convert .A into [FAC] as signed value -128 to +127
FCOMP                       = $bc5b ; Compare [FAC] with packed number at (.Y.A)
QINT                        = $bc9b ; Convert FLOATING POINT value to INTEGER value
FIN                         = $bcf3 ; Convert STRING to FLOATING POINT value in [FAC]
INPRT                       = $bdc2 ; Output " IN " <line number> message
LINPRT                      = $bdcd ; Print line number in (.X.A) as DECIMAL number
STROU2                      = $bdda ; Print null terminated STRING starting at (.Y.A)
FOUT                        = $bddd ; Convert [FAC] to ASCII STRING at STACK
FOUTIM                      = $be68 ; Convert JIFFY count to STRING
; --------------------------------------------------------------------------------------------------------------------- ;
                            .endweak ; 
; --------------------------------------------------------------------------------------------------------------------- ;
