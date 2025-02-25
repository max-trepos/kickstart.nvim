syn keyword sqlKeyword	package





hi def link sqlConditional Conditional

" Vim syntax file
" Language: Oracle Procedureal SQL (PL/SQL)
" Maintainer: Jeff Lanzarotta (jefflanzarotta at yahoo dot com)
" Original Maintainer: C. Laurence Gonsalves (clgonsal@kami.com)
" URL: http://lanzarotta.tripod.com/vim/syntax/plsql.vim.zip
" Last Change: January 23, 2012
" History: Eugene Lysyonok (lysyonok at inbox ru)
"               Added folding.
"          Geoff Evans & Bill Pribyl (bill at plnet dot org)
"               Added 9i keywords.
"          Austin Ziegler (austin at halostatue dot ca)
"               Added 8i+ features.
"
"
" For version 5.x, clear all syntax items.
" For version 6.x, quit when a syntax file was already loaded.
" if version < 600
"   syntax clear
" elseif exists("b:current_syntax")
"   finish
" endif

" Todo.
syn keyword plsqlTodo TODO FIXME XXX DEBUG NOTE
syn cluster plsqlCommentGroup contains=plsqlTodo

syn case ignore

syn match   plsqlGarbage "[^ \t()]"
syn match   plsqlIdentifier "[a-z][a-z0-9$_#]*"
syn match   plsqlHostIdentifier ":[a-z][a-z0-9$_#]*"

" When wanted, highlight the trailing whitespace.
if exists("c_space_errors")
  if !exists("c_no_trail_space_error")
    syn match plsqlSpaceError "\s\+$"
  endif

  if !exists("c_no_tab_space_error")
    syn match plsqlSpaceError " \+\t"me=e-1
  endif
endif

" Symbols.
syn match   plsqlSymbol "\(;\|,\|\.\)"

" Operators.
syn match   plsqlOperator "\(+\|-\|\*\|/\|=\|<\|>\|@\|\*\*\|!=\|\~=\)"
syn match   plsqlOperator "\(^=\|<=\|>=\|:=\|=>\|\.\.\|||\|<<\|>>\|\"\)"

" Some of Oracle's SQL keywords.
syn keyword plsqlSQLKeyword ABORT ACCESS ACCESSED ADD AFTER ALL ALTER AND ANY
syn keyword plsqlSQLKeyword AS ASC ATTRIBUTE AUDIT AUTHORIZATION AVG BASE_TABLE
syn keyword plsqlSQLKeyword BEFORE BETWEEN BY CASCADE CAST CHECK CLUSTER
syn keyword plsqlSQLKeyword CLUSTERS COLAUTH COLUMN COMMENT COMPRESS CONNECT
syn keyword plsqlSQLKeyword CONSTRAINT CRASH CURRENT DATA DATABASE
syn keyword plsqlSQLKeyword DATA_BASE DBA DEFAULT DELAY DELETE DESC DISTINCT
syn keyword plsqlSQLKeyword DROP DUAL ELSE EXCLUSIVE EXISTS EXTENDS EXTRACT
syn keyword plsqlSQLKeyword FILE FORCE FOREIGN FROM GRANT GROUP HAVING HEAP
syn keyword plsqlSQLKeyword IDENTIFIED IDENTIFIER IMMEDIATE IN INCLUDING
syn keyword plsqlSQLKeyword INCREMENT INDEX INDEXES INITIAL INSERT INSTEAD
syn keyword plsqlSQLKeyword INTERSECT INTO INVALIDATE ISOLATION KEY LIBRARY
syn keyword plsqlSQLKeyword LIKE LOCK MAXEXTENTS MINUS MODE MODIFY MULTISET
syn keyword plsqlSQLKeyword NESTED NOAUDIT NOCOMPRESS NOT NOWAIT OF OFF OFFLINE
syn keyword plsqlSQLKeyword ON ONLINE OPERATOR OPTION OR ORDER ORGANIZATION
syn keyword plsqlSQLKeyword PCTFREE PRIMARY PRIOR PRIVATE PRIVILEGES PUBLIC
syn keyword plsqlSQLKeyword QUOTA RELEASE RENAME REPLACE RESOURCE REVOKE ROLLBACK
syn keyword plsqlSQLKeyword ROW ROWLABEL ROWS SCHEMA SELECT SEPARATE SESSION SET
syn keyword plsqlSQLKeyword SHARE SIZE SPACE START STORE SUCCESSFUL SYNONYM
syn keyword plsqlSQLKeyword SYSDATE TABLE TABLES TABLESPACE TEMPORARY TO TREAT
syn keyword plsqlSQLKeyword TRIGGER TRUNCATE UID UNION UNIQUE UNLIMITED UPDATE
syn keyword plsqlSQLKeyword USE USER VALIDATE VALUES VIEW WHENEVER WHERE WITH

" PL/SQL's own keywords.
syn keyword plsqlKeyword AGENT ANY ARRAY ASSIGN AS AT AUTHID BODY 
syn keyword plsqlKeyword BULK C CHAR_BASE CHARSETFORM CHARSETID CLOSE
syn keyword plsqlKeyword COLLECT CONSTANT CONSTRUCTOR CONTEXT CREATE CURRVAL DECLARE
syn keyword plsqlKeyword DVOID EXCEPTION_INIT EXECUTE FETCH
syn keyword plsqlKeyword FINAL GOTO HASH IMMEDIATE INDICATOR
syn keyword plsqlKeyword INSTANTIABLE JAVA LANGUAGE LIBRARY MAP MAXLEN
syn keyword plsqlKeyword MEMBER NAME NEW NOCOPY NUMBER_BASE OBJECT OCICOLL
syn keyword plsqlKeyword OCIDATE OCIDATETIME OCILOBLOCATOR OCINUMBER OCIRAW
syn keyword plsqlKeyword OCISTRING OF OPAQUE OPEN OTHERS OUT
syn keyword plsqlKeyword OVERRIDING PACKAGE PARALLEL_ENABLE PARAMETERS
syn keyword plsqlKeyword PARTITION PIPELINED PRAGMA RAISE RANGE REF REPLACE 
syn keyword plsqlKeyword RESULT RETURN REVERSE ROWTYPE SB1 SELF SHORT SIZE_T
syn keyword plsqlKeyword SQL SQLCODE SQLERRM STATIC STRUCT SUBTYPE TDO THEN
syn keyword plsqlKeyword TABLE TIMEZONE_ABBR TIMEZONE_HOUR TIMEZONE_MINUTE
syn keyword plsqlKeyword TIMEZONE_REGION TYPE UNDER UNSIGNED USING VARIANCE
syn keyword plsqlKeyword VARRAY VARYING WRITE
syntax match plsqlKeyword "\<BEGIN\>"
syntax match plsqlKeyword "\<CASE\>"
syntax match plsqlKeyword "\<END\>"
syntax match plsqlKeyword "\<FUNCTION\>"
syntax match plsqlKeyword "\<IS\>"
syntax match plsqlKeyword "\<PROCEDURE\>"
syn match   plsqlKeyword "\.COUNT\>"hs=s+1
syn match   plsqlKeyword "\.EXISTS\>"hs=s+1
syn match   plsqlKeyword "\.FIRST\>"hs=s+1
syn match   plsqlKeyword "\.LAST\>"hs=s+1
syn match   plsqlKeyword "\.DELETE\>"hs=s+1
syn match   plsqlKeyword "\.PREV\>"hs=s+1
syn match   plsqlKeyword "\.NEXT\>"hs=s+1

" PL/SQL functions.
syn keyword plsqlFunction ABS ACOS ADD_MONTHS ASCII ASCIISTR ASIN ATAN ATAN2
syn keyword plsqlFunction BFILENAME BITAND CEIL CHARTOROWID CHR COALESCE
syn keyword plsqlFunction COMMIT COMMIT_CM COMPOSE CONCAT  CONVERT  COS COSH
syn keyword plsqlFunction COUNT CUBE CURRENT_DATE CURRENT_TIME CURRENT_TIMESTAMP
syn keyword plsqlFunction DBTIMEZONE DECODE DECOMPOSE DEREF DUMP EMPTY_BLOB
syn keyword plsqlFunction EMPTY_CLOB EXISTS EXP FLOOR FROM_TZ GETBND GLB
syn keyword plsqlFunction GREATEST GREATEST_LB GROUPING HEXTORAW  INITCAP
syn keyword plsqlFunction INSTR INSTR2 INSTR4 INSTRB INSTRC ISNCHAR LAST_DAY
syn keyword plsqlFunction LEAST LEAST_UB LENGTH LENGTH2 LENGTH4 LENGTHB LENGTHC
syn keyword plsqlFunction LN LOCALTIME LOCALTIMESTAMP LOG LOWER LPAD
syn keyword plsqlFunction LTRIM LUB MAKE_REF MAX MIN MOD MONTHS_BETWEEN
syn keyword plsqlFunction NCHARTOROWID NCHR NEW_TIME NEXT_DAY NHEXTORAW
syn keyword plsqlFunction NLS_CHARSET_DECL_LEN NLS_CHARSET_ID NLS_CHARSET_NAME
syn keyword plsqlFunction NLS_INITCAP NLS_LOWER NLSSORT NLS_UPPER NULLFN NULLIF
syn keyword plsqlFunction NUMTODSINTERVAL NUMTOYMINTERVAL NVL POWER
syn keyword plsqlFunction RAISE_APPLICATION_ERROR RAWTOHEX RAWTONHEX REF
syn keyword plsqlFunction REFTOHEX ROLLBACK_NR ROLLBACK_SV ROLLUP ROUND
syn keyword plsqlFunction ROWIDTOCHAR ROWIDTONCHAR ROWLABEL RPAD RTRIM
syn keyword plsqlFunction SAVEPOINT SESSIONTIMEZONE SETBND SET_TRANSACTION_USE
syn keyword plsqlFunction SIGN SIN SINH SOUNDEX SQLCODE SQLERRM SQRT STDDEV
syn keyword plsqlFunction SUBSTR SUBSTR2 SUBSTR4 SUBSTRB SUBSTRC SUM
syn keyword plsqlFunction SYS_AT_TIME_ZONE SYS_CONTEXT SYSDATE SYS_EXTRACT_UTC
syn keyword plsqlFunction SYS_GUID SYS_LITERALTODATE SYS_LITERALTODSINTERVAL
syn keyword plsqlFunction SYS_LITERALTOTIME SYS_LITERALTOTIMESTAMP
syn keyword plsqlFunction SYS_LITERALTOTZTIME SYS_LITERALTOTZTIMESTAMP
syn keyword plsqlFunction SYS_LITERALTOYMINTERVAL SYS_OVER__DD SYS_OVER__DI
syn keyword plsqlFunction SYS_OVER__ID SYS_OVER_IID SYS_OVER_IIT
syn keyword plsqlFunction SYS_OVER__IT SYS_OVER__TI SYS_OVER__TT
syn keyword plsqlFunction SYSTIMESTAMP TAN TANH TO_ANYLOB TO_BLOB TO_CHAR
syn keyword plsqlFunction TO_CLOB TO_DATE TO_DSINTERVAL TO_LABEL TO_MULTI_BYTE
syn keyword plsqlFunction TO_NCHAR TO_NCLOB TO_NUMBER TO_RAW TO_SINGLE_BYTE
syn keyword plsqlFunction TO_TIME TO_TIMESTAMP TO_TIMESTAMP_TZ TO_TIME_TZ
syn keyword plsqlFunction TO_YMINTERVAL TRANSLATE TREAT TRIM TRUNC TZ_OFFSET UID
syn keyword plsqlFunction UNISTR UPPER UROWID USER USERENV VALUE VARIANCE
syn keyword plsqlFunction VSIZE WORK XOR
syn match   plsqlFunction "\<SYS\$LOB_REPLICATION\>"

" PL/SQL CREATE Exceptions
syn keyword plsqlException ACCESS_INTO_NULL CASE_NOT_FOUND COLLECTION_IS_NULL
syn keyword plsqlException CURSOR_ALREADY_OPEN DUP_VAL_ON_INDEX INVALID_CURSOR EXCEPTION EXIT 
syn keyword plsqlException INVALID_NUMBER LOGIN_DENIED NO_DATA_FOUND
syn keyword plsqlException NOT_LOGGED_ON PROGRAM_ERROR ROWTYPE_MISMATCH
syn keyword plsqlException SELF_IS_NULL STORAGE_ERROR SUBSCRIPT_BEYOND_COUNT
syn keyword plsqlException SUBSCRIPT_OUTSIDE_LIMIT SYS_INVALID_ROWID
syn keyword plsqlException TIMEOUT_ON_RESOURCE TOO_MANY_ROWS VALUE_ERROR
syn keyword plsqlException ZERO_DIVIDE

" Oracle Pseudo Colums.
syn keyword plsqlPseudo CURRVAL LEVEL NEXTVAL ROWID ROWNUM

if exists("plsql_highlight_triggers")
  syn keyword plsqlTrigger INSERTING UPDATING DELETING
endif

" Conditionals.
syn keyword plsqlConditional ELSIF ELSE IF THEN CASE WHEN
syn match   plsqlConditional "\<END IF\>"

" Loops.
syn keyword plsqlRepeat FOR LOOP WHILE FORALL
syn match   plsqlRepeat "\<END\s\+LOOP\>"

" Various types of comments.
if exists("c_comment_strings")
  syntax match plsqlCommentSkip contained "^\s*\*\($\|\s\+\)"
  syntax region plsqlCommentString contained start=+L\="+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=plsqlCommentSkip
  syntax region plsqlComment2String contained start=+L\="+ skip=+\\\\\|\\"+ end=+"+ end="$"
  syntax region plsqlCommentL start="--" skip="\\$" end="$" keepend contains=@plsqlCommentGroup,plsqlComment2String,plsqlCharLiteral,plsqlBooleanLiteral,plsqlNumbersCom,plsqlSpaceError
  syntax region plsqlComment
    \ start="/\*" end="\*/"
    \ extend
    \ contains=@plsqlCommentGroup,plsqlComment2String,plsqlCharLiteral,plsqlBooleanLiteral,plsqlNumbersCom,plsqlSpaceError
else
  syntax region plsqlCommentL start="--" skip="\\$" end="$" keepend contains=@plsqlCommentGroup,plsqlSpaceError
  syntax region plsqlComment
    \ start="/\*" end="\*/"
    \ extend
    \ contains=@plsqlCommentGroup,plsqlSpaceError
endif

syn sync ccomment plsqlComment
syn sync ccomment plsqlCommentL

" To catch unterminated string literals.
syn match   plsqlStringError "'.*$"

" Various types of literals.
syn match   plsqlNumbers transparent "\<[+-]\=\d\|[+-]\=\.\d" contains=plsqlIntLiteral,plsqlFloatLiteral
syn match   plsqlNumbersCom contained transparent "\<[+-]\=\d\|[+-]\=\.\d" contains=plsqlIntLiteral,plsqlFloatLiteral
syn match   plsqlIntLiteral contained "[+-]\=\d\+"
syn match   plsqlFloatLiteral contained "[+-]\=\d\+\.\d*"
syn match   plsqlFloatLiteral contained "[+-]\=\d*\.\d*"
syn match   plsqlCharLiteral    "'[^']'"
syn region plsqlStringLiteral
  \ start="'"
  \ skip="''"
  \ end="'"
  \ keepend extend
syn keyword plsqlBooleanLiteral TRUE FALSE NULL

" The built-in types.
syn keyword plsqlStorage ANYDATA ANYTYPE BFILE BINARY_INTEGER BLOB BOOLEAN
syn keyword plsqlStorage BYTE CHAR CHARACTER CLOB CURSOR DATE DAY DEC DECIMAL
syn keyword plsqlStorage DOUBLE DSINTERVAL_UNCONSTRAINED FLOAT HOUR
syn keyword plsqlStorage INT INTEGER INTERVAL LOB LONG MINUTE
syn keyword plsqlStorage MLSLABEL MONTH NATURAL NATURALN NCHAR NCHAR_CS NCLOB
syn keyword plsqlStorage NUMBER NUMERIC NVARCHAR PLS_INT PLS_INTEGER
syn keyword plsqlStorage POSITIVE POSITIVEN PRECISION RAW REAL RECORD
syn keyword plsqlStorage SECOND SIGNTYPE SMALLINT STRING SYS_REFCURSOR TABLE TIME
syn keyword plsqlStorage TIMESTAMP TIMESTAMP_UNCONSTRAINED
syn keyword plsqlStorage TIMESTAMP_TZ_UNCONSTRAINED
syn keyword plsqlStorage TIMESTAMP_LTZ_UNCONSTRAINED UROWID VARCHAR
syn keyword plsqlStorage VARCHAR2 YEAR YMINTERVAL_UNCONSTRAINED ZONE

" A type-attribute is really a type.
syn match plsqlTypeAttribute  "%\(TYPE\|ROWTYPE\)\>"

" All other attributes.
syn match plsqlAttribute "%\(BULK_EXCEPTIONS\|BULK_ROWCOUNT\|ISOPEN\|FOUND\|NOTFOUND\|ROWCOUNT\)\>"

" This'll catch mis-matched close-parens.
syn cluster plsqlParenGroup contains=plsqlParenError,@plsqlCommentGroup,plsqlCommentSkip,plsqlIntLiteral,plsqlFloatLiteral,plsqlNumbersCom
if exists("c_no_bracket_error")
  syn region plsqlParen transparent start='(' end=')' contains=ALLBUT,@plsqlParenGroup,@plsqlFoldingGroupIgnore
  syn match plsqlParenError ")"
  syn match plsqlErrInParen contained "[{}]"
else
  syn region plsqlParen transparent start='(' end=')' contains=ALLBUT,@plsqlParenGroup,@plsqlFoldingGroupIgnore,plsqlErrInBracket
  syn match plsqlParenError "[\])]"
  syn match plsqlErrInParen contained "[{}]"
  syn region plsqlBracket transparent start='\[' end=']' contains=ALLBUT,@plsqlParenGroup,@plsqlFoldingGroupIgnore,plsqlErrInParen
  syn match plsqlErrInBracket contained "[);{}]"
endif


" folding procedures and functions

syn cluster plsqlFoldingGroupIgnore contains=plsqlProcedureDeclaration

syntax region plsqlProcedureJava
  \ matchgroup=NONE
  \ start="\(\/\*\(\(\*\/\)\@!\_.\)*\*\/\_s*\)\?\(\(\(overriding\s*\)\?member\|constructor\|static\)\s*\)\?\<\(procedure\|function\)\>\s*\(\k*\)\_[^;]\{-}\<\(is\|as\)\>\_s*language\_s*java\_s*name"
  \ matchgroup=plsqlStringLiteral
  \ end="'\_[^']*'\_s*;"
  \ keepend extend
  \ fold
  \ contains=ALLBUT,plsqlProcedure,plsqlProcedureDeclaration,plsqlProcedureBlock,plsqlBlock,plsqlProcedureJava,plsqlErrInBracket,plsqlStringLiteral

syntax region plsqlProcedure
  \ start="\(\/\*\(\(\*\/\)\@!\_.\)*\*\/\_s*\)\?\(\(\(overriding\s*\)\?member\|constructor\|static\)\s*\)\?\<\(procedure\|function\)\>\s*\(\k*\)\_[^;]\{-}\<is\>\(\_s*language\)\@!"
  \ end="\<end\>\s*\(\(if\|loop\|case\)\@!\k*\s*\)\?;"
  \ keepend extend
  \ fold
  \ contains=ALLBUT,plsqlProcedure,plsqlProcedureJava,plsqlBlock,plsqlErrInBracket

syntax region plsqlProcedureDeclaration
  \ start="\<is\>"
  \ end="\(\<begin\>\)\@="
  \ contained keepend
  \ contains=ALLBUT,plsqlProcedureDeclaration,plsqlBlock,plsqlErrInBracket

syntax region plsqlProcedureBlock
  \ matchgroup=plsqlKeyword
  \ start="\<begin\>"
  \ matchgroup=NONE
  \ end="\<end\>\s*\(\(if\|loop\|case\)\@!\k*\s*\)\?;"
  \ contained keepend
  \ contains=ALLBUT,plsqlProcedureDeclaration,plsqlErrInBracket,plsqlProcedureBlock

syntax region plsqlBlock
   \ start="\<begin\>"
   \ end="\<end\>\s*;"
   \ keepend extend
   \ contains=ALLBUT,plsqlProcedureDeclaration,plsqlProcedureBlock,plsqlErrInBracket

syntax region plsqlCaseBlock
   \ matchgroup=plsqlKeyword
   \ start="\<case\>"
   \ end="\<end\>\(\s*\(if\|loop\)\)\@!\(\s*\<case\>\)\?"
   \ contained keepend extend
   \ contains=ALLBUT,plsqlProcedure,plsqlProcedureDeclaration,plsqlProcedureBlock,plsqlErrInBracket


if exists( "g:plsql_syntax_test_flag") && g:plsql_syntax_test_flag[0] == "1"
  hi plsqlProcedureDeclaration guifg='blue'
  hi plsqlProcedureBlock guifg='red'
  hi plsqlProcedure guifg='green'
  hi plsqlCaseBlock guifg='pink'
else
  hi plsqlProcedureDeclaration NONE
  hi plsqlProcedureBlock NONE
  hi plsqlProcedure NONE
endif

" Syntax Synchronizing
syn sync minlines=1000 maxlines=2000

" Define the default highlighting.
" For version 5.x and earlier, only when not done already.
" For version 5.8 and later, only when an item doesn't have highlighting yet.
if version >= 508 || !exists("did_plsql_syn_inits")
  if version < 508
    let did_plsql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink plsqlAttribute		Macro
  HiLink plsqlBlockError	Error
  HiLink plsqlBooleanLiteral	Boolean
  HiLink plsqlCharLiteral	Character
  HiLink plsqlComment		Comment
  HiLink plsqlCommentL		Comment
  HiLink plsqlConditional	Conditional
  HiLink plsqlError		Error
  HiLink plsqlErrInBracket	Error
  HiLink plsqlErrInBlock	Error
  HiLink plsqlErrInParen	Error
  HiLink plsqlException		Function
  HiLink plsqlFloatLiteral	Float
  HiLink plsqlFunction		Function
  HiLink plsqlGarbage		Error
  HiLink plsqlHostIdentifier	Label
  HiLink plsqlIdentifier	Normal
  HiLink plsqlIntLiteral	Number
  HiLink plsqlOperator		Operator
  HiLink plsqlParen		Normal
  HiLink plsqlParenError	Error
  HiLink plsqlSpaceError	Error
  HiLink plsqlPseudo		PreProc
  HiLink plsqlKeyword		Keyword
  HiLink plsqlRepeat		Repeat
  HiLink plsqlStorage		StorageClass
  HiLink plsqlSQLKeyword	Function
  HiLink plsqlStringError	Error
  HiLink plsqlStringLiteral	String
  HiLink plsqlCommentString	String
  HiLink plsqlComment2String	String
  HiLink plsqlSymbol		Normal
  HiLink plsqlTrigger		Function
  HiLink plsqlTypeAttribute	StorageClass
  HiLink plsqlTodo		Todo

  delcommand HiLink
endif

hi! def link plsqlConditional	DraculaOrange
hi! def link plsqlException	DraculaOrange
hi! def link plsqlSQLKeyword	Tag

let b:current_syntax = "plsql"

" vim: ts=8 sw=2
