; C-BASIC minimal BASIC ROM for C-BIOS
;
; Copyright (c) 2005 BouKiCHi.  All rights reserved.
; Copyright (c) 2026 The C-BIOS contributors.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions
; are met:
; 1. Redistributions of source code must retain the above copyright
;    notice, this list of conditions and the following disclaimer.
; 2. Redistributions in binary form must reproduce the above copyright
;    notice, this list of conditions and the following disclaimer in the
;    documentation and/or other materials provided with the distribution.
;
; THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
; IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
; OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
; IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
; INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
; NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
; THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

CHGMOD:         equ     $005F
CHPUT:          equ     $00A2
CHGET:          equ     $009F
ENASLT:         equ     $0024
RSLREG:         equ     $0138
CLIKSW:         equ     $F3DB
SCRMOD:         equ     $FCAF
CSRSW:          equ     $FCA9
CSTYLE:         equ     $FCAA
RG1SAV:         equ     $F3E0
WRTVDP:         equ     $0047
RDVRM:          equ     $004A
WRTVRM:         equ     $004D
VALTYP:         equ     $F663
USRTAB:         equ     $F39A
DAC:            equ     $F7F6

EXPTBL:         equ     $FCC1
SLTTBL:         equ     $FCC5

; The BASIC ROM occupies page 1. Program text is kept in RAM page 2 and
; interpreter state in unused work RAM at E000.
PROGRAM_START:  equ     $8000
PROGRAM_LIMIT:  equ     $C000
WORK:           equ     $E000
PGMEND:         equ     WORK+$00     ; Pointer to the end marker.
LINE_NUM:       equ     WORK+$02
LINE_PTR:       equ     WORK+$04     ; Current source line in LINEBUF.
REC_PTR:        equ     WORK+$06
TAIL_PTR:       equ     WORK+$08
INSERT_PTR:     equ     WORK+$0A
REC_SIZE:       equ     WORK+$0C
MOVE_COUNT:     equ     WORK+$0E
EXPR_VALUE:     equ     WORK+$10
EXPR_SIGN:      equ     WORK+$12
TEMP_BYTE:      equ     WORK+$13
PROGRAM_PTR:    equ     WORK+$14
RUN_STOP:       equ     WORK+$16
VAR_INDEX:      equ     WORK+$17
EXPR_OPERATOR:  equ     WORK+$18
FILE_OFFSET:    equ     WORK+$1A
FILE_LENGTH:    equ     WORK+$1C
FILE_RECORDS:   equ     WORK+$1E
FILE_POS:       equ     WORK+$20
FILE_STATE:     equ     WORK+$21
FILE_SIGN:      equ     WORK+$22
FILE_VALUE:     equ     WORK+$23
TEXT_POS:       equ     WORK+$25
TOKEN_POS:      equ     WORK+$27
RUN_ACTIVE:     equ     WORK+$29
STORE_ERROR:    equ     WORK+$2A
LEX_STATE:      equ     WORK+$2B
FLOW_CHANGED:  equ     WORK+$2C
FLOW_DEST:     equ     WORK+$2D
FLOW_DEPTH:    equ     WORK+$2F
FLOW_STACK:    equ     WORK+$40
FLOW_RETURN:   equ     WORK+$80
REL_OPERATOR:  equ     WORK+$82
REL_RESULT:    equ     WORK+$83
INPUT_VALUE:   equ     WORK+$84
TERM_VALUE:    equ     WORK+$86
TERM_OPERATOR: equ     WORK+$88
MATH_SIGN:     equ     WORK+$89
MATH_LEFT:     equ     WORK+$8A
MATH_RIGHT:    equ     WORK+$8C
MATH_RESULT:   equ     WORK+$8E
MATH_REMAINDER: equ    WORK+$90
MATH_CARRY:    equ     WORK+$92
MATH_COUNT:    equ     WORK+$93
OUTER_SIGN:    equ     WORK+$94
MATH_FUNCTION: equ     WORK+$95
STRING_SOURCE: equ     WORK+$96
STRING_DEST:   equ     WORK+$98
FOR_DEPTH:     equ     WORK+$9A
FOR_STACK:     equ     WORK+$A0
FOR_END:       equ     WORK+$E0
FOR_STEP:      equ     WORK+$E2
FOR_START:     equ     WORK+$E4
FOR_SCAN:      equ     WORK+$E6
FOR_FRAME:     equ     WORK+$E8
FOR_SKIP_DEPTH: equ    WORK+$EA
VAL_RETURN:    equ     WORK+$EC
EDIT_LENGTH:   equ     WORK+$EE
EDIT_POSITION: equ     WORK+$EF
EDIT_OLD_LENGTH: equ   WORK+$F0
EDIT_OLD_POSITION: equ WORK+$F1
EDIT_CHARACTER: equ    WORK+$F2
HISTORY_VALID: equ     WORK+$F3
HISTORY_MODE:  equ     WORK+$F4
HISTORY_LENGTH: equ    WORK+$F5
SCREEN_MODE:   equ     WORK+$F6
SCREEN_SPRITE: equ     WORK+$F7
SCREEN_CLICK:  equ     WORK+$F8
POKE_ADDRESS:  equ     WORK+$F9
POKE_VALUE:    equ     WORK+$FB
EDIT_REDRAW_BACK: equ WORK+$FC
USR_DEFINED:    equ     WORK+$30
DATA_SCAN_PTR:  equ     WORK+$32
DATA_ITEM_PTR:  equ     WORK+$34
READ_TARGET_TYPE: equ   WORK+$36
READ_TARGET_INDEX: equ  WORK+$37
DATA_LINE_TEXT: equ     WORK+$38
READ_STMT_PTR:  equ     WORK+$3A
FCB:            equ     WORK+$300
FILE_BUFFER:    equ     WORK+$400
TOKEN_BUFFER:   equ     WORK+$500
STRING_VARS:    equ     WORK+$600
LINE_HISTORY:   equ     WORK+$700
LINEBUF:        equ     WORK+$100
VARIABLES:      equ     WORK+$200     ; 26 signed 16-bit integer variables.
MAX_LINE:       equ     126

                org     $4000
                db      "AB"
                dw      bas_main
                dw      $0000
                dw      $0000
                dw      $0000
                dw      $0000
                dw      $0000
                dw      $0000

bas_main:
                xor     a
                ld      (RUN_ACTIVE),a
                ld      (FLOW_DEPTH),a
                ld      (USR_DEFINED),a
                ld      a,1
                call    CHGMOD
                ld      a,1
                ld      (CSRSW),a
                ld      (CSTYLE),a
                ld      a,1
                ld      (CLIKSW),a
                call    make_ramslot
                ld      hl,PROGRAM_START
                call    ENASLT
                ei

                call    new_program
                ld      hl,VARIABLES
                ld      (hl),0
                ld      de,VARIABLES+1
                ld      bc,51
                ldir
                xor     a
                ld      (HISTORY_VALID),a

                ld      hl,start_message
                call    print_text

command_loop:
                ld      hl,ok_prompt
                call    print_text
                ld      a,1
                ld      (HISTORY_MODE),a
                ld      hl,LINEBUF
                call    get_line
                ld      hl,LINEBUF
                call    skip_spaces
                ld      a,(hl)
                or      a
                jr      z,command_loop
                cp      '0'
                jr      c,command_immediate
                cp      '9'+1
                jr      nc,command_immediate
                call    store_program_line
                jr      command_loop
command_immediate:
                call    execute_statement
                jr      command_loop

; Read and edit a line in place. Cursor keys move within the line, Up recalls
; the previous command, and insertion/deletion redraws the edited suffix.
get_line:
                xor     a
                ld      (EDIT_LENGTH),a
                ld      (EDIT_POSITION),a
                ld      (hl),a
get_line_loop:
                call    CHGET
                cp      $0D
                jp      z,get_line_done
                cp      $08
                jr      z,get_line_backspace
                cp      $7F
                jr      z,get_line_delete
                cp      $1C
                jr      z,get_line_right
                cp      $1D
                jr      z,get_line_left
                cp      $1E
                jp      z,get_line_history
                cp      $1F
                jp      z,get_line_loop
                cp      $20
                jp      c,get_line_loop
                ld      (EDIT_CHARACTER),a
                ld      a,(EDIT_LENGTH)
                cp      MAX_LINE
                jp      nc,get_line_loop
                call    get_line_insert
                jp      get_line_loop
get_line_left:
                ld      a,(EDIT_POSITION)
                or      a
                jp      z,get_line_loop
                dec     a
                ld      (EDIT_POSITION),a
                ld      a,$1D
                call    CHPUT
                jp      get_line_loop
get_line_right:
                ld      a,(EDIT_POSITION)
                ld      c,a
                ld      a,(EDIT_LENGTH)
                cp      c
                jp      c,get_line_loop
                jp      z,get_line_loop
                inc     c
                ld      a,c
                ld      (EDIT_POSITION),a
                ld      a,$1C
                call    CHPUT
                jp      get_line_loop
get_line_backspace:
                ld      a,(EDIT_POSITION)
                or      a
                jp      z,get_line_loop
                dec     a
                ld      (EDIT_POSITION),a
                ld      (EDIT_OLD_POSITION),a
                ld      a,1
                ld      (EDIT_REDRAW_BACK),a
                jr      get_line_delete_at_position
get_line_delete:
                ld      a,(EDIT_POSITION)
                ld      c,a
                ld      a,(EDIT_LENGTH)
                cp      c
                jp      c,get_line_loop
                jp      z,get_line_loop
                ld      a,c
                ld      (EDIT_OLD_POSITION),a
                xor     a
                ld      (EDIT_REDRAW_BACK),a
get_line_delete_at_position:
                ld      a,(EDIT_LENGTH)
                ld      (EDIT_OLD_LENGTH),a
                ld      a,(EDIT_POSITION)
                ld      l,a
                ld      h,0
                ld      de,LINEBUF
                add     hl,de
                push    hl
                inc     hl
                pop     de
                ld      a,(EDIT_LENGTH)
                ld      b,a
                ld      a,(EDIT_POSITION)
                ld      c,a
                ld      a,b
                sub     c
                ld      c,a
                ld      b,0
                ldir
                ld      a,(EDIT_LENGTH)
                dec     a
                ld      (EDIT_LENGTH),a
                call    get_line_redraw
                jp      get_line_loop
get_line_insert:
                ld      a,(EDIT_POSITION)
                ld      b,a
                ld      a,(EDIT_LENGTH)
                cp      b
                jr      nz,get_line_insert_middle
                ld      l,a
                ld      h,0
                ld      de,LINEBUF
                add     hl,de
                ld      a,(EDIT_CHARACTER)
                ld      (hl),a
                inc     hl
                xor     a
                ld      (hl),a
                ld      a,(EDIT_LENGTH)
                inc     a
                ld      (EDIT_LENGTH),a
                ld      (EDIT_POSITION),a
                ld      a,(EDIT_CHARACTER)
                call    CHPUT
                ret
get_line_insert_middle:
                ld      a,(EDIT_LENGTH)
                ld      (EDIT_OLD_LENGTH),a
                ld      a,(EDIT_POSITION)
                ld      (EDIT_OLD_POSITION),a
                xor     a
                ld      (EDIT_REDRAW_BACK),a
                ld      a,(EDIT_LENGTH)
                ld      l,a
                ld      h,0
                ld      de,LINEBUF
                add     hl,de
                push    hl
                inc     hl
                ex      de,hl
                pop     hl
                ld      a,(EDIT_LENGTH)
                ld      c,a
                ld      a,(EDIT_POSITION)
                ld      b,a
                ld      a,c
                sub     b
                inc     a
                ld      c,a
                ld      b,0
                lddr
                ld      a,(EDIT_POSITION)
                ld      l,a
                ld      h,0
                ld      de,LINEBUF
                add     hl,de
                ld      a,(EDIT_CHARACTER)
                ld      (hl),a
                ld      a,(EDIT_LENGTH)
                inc     a
                ld      (EDIT_LENGTH),a
                ld      a,(EDIT_POSITION)
                inc     a
                ld      (EDIT_POSITION),a
                call    get_line_redraw
                ret
get_line_history:
                ld      a,(HISTORY_MODE)
                or      a
                jp      z,get_line_loop
                ld      a,(HISTORY_VALID)
                or      a
                jp      z,get_line_loop
                ld      a,(EDIT_LENGTH)
                ld      (EDIT_OLD_LENGTH),a
                ld      a,(EDIT_POSITION)
                ld      (EDIT_REDRAW_BACK),a
                xor     a
                ld      (EDIT_OLD_POSITION),a
                ld      a,(HISTORY_LENGTH)
                ld      (EDIT_LENGTH),a
                ld      a,(HISTORY_LENGTH)
                ld      (EDIT_POSITION),a
                ld      hl,LINE_HISTORY
                ld      de,LINEBUF
                ld      a,(HISTORY_LENGTH)
                inc     a
                ld      c,a
                ld      b,0
                ldir
                call    get_line_redraw
                jp      get_line_loop
get_line_done:
                ld      a,(EDIT_POSITION)
                ld      (EDIT_OLD_POSITION),a
                ld      a,(EDIT_LENGTH)
                ld      (EDIT_OLD_LENGTH),a
                ld      hl,LINEBUF
                ld      e,a
                ld      d,0
                add     hl,de
                xor     a
                ld      (hl),a
                ld      a,(HISTORY_MODE)
                or      a
                jr      z,get_line_done_output
                ld      a,(EDIT_LENGTH)
                or      a
                jr      z,get_line_done_output
                ld      (HISTORY_LENGTH),a
                ld      a,1
                ld      (HISTORY_VALID),a
                ld      hl,LINEBUF
                ld      de,LINE_HISTORY
                ld      a,(EDIT_LENGTH)
                inc     a
                ld      c,a
                ld      b,0
                ldir
get_line_done_output:
                ld      a,(EDIT_LENGTH)
                ld      b,a
                ld      a,(EDIT_POSITION)
                ld      c,a
                ld      a,b
                sub     c
                ld      b,a
                call    get_line_move_right_b
                ld      a,$0D
                call    CHPUT
                ld      a,$0A
                call    CHPUT
                ret

get_line_redraw:
                ld      a,(EDIT_REDRAW_BACK)
                ld      b,a
                call    get_line_move_left_b
                ld      hl,LINEBUF
                ld      a,(EDIT_OLD_POSITION)
                ld      e,a
                ld      d,0
                add     hl,de
                ld      a,(EDIT_LENGTH)
                ld      c,a
                ld      a,(EDIT_OLD_POSITION)
                ld      e,a
                ld      a,c
                sub     e
                ld      b,a
get_line_redraw_text:
                ld      a,b
                or      a
                jr      z,get_line_redraw_clear
                ld      a,(hl)
                call    CHPUT
                inc     hl
                dec     b
                jr      get_line_redraw_text
get_line_redraw_clear:
                ld      a,(EDIT_OLD_LENGTH)
                ld      b,a
                ld      a,(EDIT_LENGTH)
                cp      b
                jr      nc,get_line_redraw_restore
                ld      c,a
                ld      a,b
                sub     c
                ld      b,a
get_line_redraw_clear_loop:
                ld      a,b
                or      a
                jr      z,get_line_redraw_restore
                ld      a,' '
                call    CHPUT
                dec     b
                jr      get_line_redraw_clear_loop
get_line_redraw_restore:
                ld      a,(EDIT_OLD_LENGTH)
                ld      b,a
                ld      a,(EDIT_LENGTH)
                cp      b
                jr      c,get_line_redraw_max_length
                ld      b,a
get_line_redraw_max_length:
                ld      a,(EDIT_POSITION)
                ld      c,a
                ld      a,b
                sub     c
                ld      b,a
get_line_redraw_move_cursor:
                jp      get_line_move_left_b

get_line_move_left_b:
                ld      a,b
                or      a
                ret     z
get_line_move_left_loop:
                ld      a,$1D
                call    CHPUT
                djnz    get_line_move_left_loop
                ret

get_line_move_right_b:
                ld      a,b
                or      a
                ret     z
get_line_move_right_loop:
                ld      a,$1C
                call    CHPUT
                djnz    get_line_move_right_loop
                ret

; A numbered line edits the sorted in-memory program. A blank body deletes it.
store_program_line:
                xor     a
                ld      (STORE_ERROR),a
                xor     a
                ld      (LINE_NUM),a
                ld      (LINE_NUM+1),a
store_line_number:
                ld      a,(hl)
                cp      '0'
                jr      c,store_line_number_done
                cp      '9'+1
                jr      nc,store_line_number_done
                sub     '0'
                ld      (TEMP_BYTE),a
                push    hl
                ld      hl,(LINE_NUM)
                add     hl,hl
                push    hl
                add     hl,hl
                add     hl,hl
                pop     de
                add     hl,de
                ld      a,(TEMP_BYTE)
                ld      e,a
                ld      d,0
                add     hl,de
                ld      (LINE_NUM),hl
                pop     hl
                inc     hl
                jr      store_line_number
store_line_number_done:
                call    skip_spaces
                ld      (LINE_PTR),hl
                call    find_line_position
                jr      nz,store_line_not_found
                call    remove_program_line
store_line_not_found:
                ld      hl,(LINE_PTR)
                call    skip_spaces
                ld      a,(hl)
                or      a
                ret     z

                ; The record size includes the 16-bit number and NUL byte.
                ld      de,(LINE_PTR)
                ld      hl,(LINE_PTR)
                call    string_length
                inc     bc
                inc     bc
                ld      (REC_SIZE),bc

                ; Keep two bytes after the data for the end marker.
                ld      hl,(PGMEND)
                ld      de,(REC_SIZE)
                add     hl,de
                inc     hl
                inc     hl
                ld      de,PROGRAM_LIMIT
                or      a
                sbc     hl,de
                jr      c,store_line_space_ok
                jr      z,store_line_space_ok
                ld      a,1
                ld      (STORE_ERROR),a
                ld      hl,out_of_memory
                call    print_text
                ret
store_line_space_ok:
                ; Move existing records and the end marker right from the back.
                ld      hl,(PGMEND)
                inc     hl
                inc     hl
                ld      de,(INSERT_PTR)
                or      a
                sbc     hl,de
                ld      (MOVE_COUNT),hl
                ld      hl,(PGMEND)
                inc     hl
                ld      de,(REC_SIZE)
                add     hl,de
                ex      de,hl
                ld      hl,(PGMEND)
                inc     hl
                ld      bc,(MOVE_COUNT)
                lddr

                ; Write the line number and source text at the insertion point.
                ld      hl,(INSERT_PTR)
                ld      de,(LINE_NUM)
                ld      (hl),e
                inc     hl
                ld      (hl),d
                inc     hl
                ex      de,hl
                ld      hl,(LINE_PTR)
                ld      bc,(REC_SIZE)
                dec     bc
                dec     bc
                ldir

                ld      hl,(PGMEND)
                ld      de,(REC_SIZE)
                add     hl,de
                ld      (PGMEND),hl
                ld      (hl),$FF
                inc     hl
                ld      (hl),$FF
                ret

; Find insertion position; Z is set when an existing line number matches.
find_line_position:
                ld      hl,PROGRAM_START
find_line_loop:
                ld      (INSERT_PTR),hl
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                dec     hl
                ld      a,d
                cp      $FF
                jr      nz,find_line_compare
                ld      a,e
                cp      $FF
                jr      z,find_line_not_found
find_line_compare:
                ld      bc,(LINE_NUM)
                ld      a,b
                cp      d
                jr      c,find_line_not_found
                jr      nz,find_line_next
                ld      a,c
                cp      e
                jr      c,find_line_not_found
                ret     z
find_line_next:
                inc     hl
                inc     hl
find_line_skip_text:
                ld      a,(hl)
                inc     hl
                or      a
                jr      nz,find_line_skip_text
                jr      find_line_loop
find_line_not_found:
                xor     a
                inc     a
                ret

statement_input:
                xor     a
                ld      (HISTORY_MODE),a
                call    skip_spaces
                ld      a,(hl)
                call    letter_to_index
                jp      c,statement_syntax
                ld      (VAR_INDEX),a
                inc     hl
                ld      a,(hl)
                cp      '$'
                jr      z,statement_input_string
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      a,'?'
                call    CHPUT
                ld      hl,LINEBUF
                call    get_line
                ld      hl,LINEBUF
                call    parse_expression
                jp      c,statement_syntax
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      de,(EXPR_VALUE)
                call    store_numeric_variable
                ret

statement_input_string:
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      a,'?'
                call    CHPUT
                ld      hl,LINEBUF
                call    get_line
                ld      hl,LINEBUF
                call    store_string_input
                ret

store_string_input:
                ld      (STRING_SOURCE),hl
                ld      a,(VAR_INDEX)
                ld      l,a
                ld      h,0
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                ld      de,STRING_VARS
                add     hl,de
                ld      (STRING_DEST),hl
                ld      a,31
                ld      (MATH_COUNT),a
store_string_input_loop:
                ld      hl,(STRING_SOURCE)
                ld      a,(hl)
                or      a
                jr      z,store_string_input_end
                ld      de,(STRING_DEST)
                ld      (de),a
                inc     de
                ld      (STRING_DEST),de
                inc     hl
                ld      (STRING_SOURCE),hl
                ld      a,(MATH_COUNT)
                dec     a
                ld      (MATH_COUNT),a
                jr      nz,store_string_input_loop
                ld      hl,(STRING_SOURCE)
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
store_string_input_end:
                ld      de,(STRING_DEST)
                xor     a
                ld      (de),a
                ret

statement_data:
                ret

statement_read:
statement_read_target:
                call    skip_spaces
                ld      a,(hl)
                call    letter_to_index
                jp      c,statement_syntax
                ld      (READ_TARGET_INDEX),a
                inc     hl
                ld      a,(hl)
                cp      '$'
                jr      nz,statement_read_numeric_target
                ld      a,1
                ld      (READ_TARGET_TYPE),a
                inc     hl
                jr      statement_read_target_delimiter
statement_read_numeric_target:
                xor     a
                ld      (READ_TARGET_TYPE),a
statement_read_target_delimiter:
                call    skip_spaces
                ld      a,(hl)
                cp      ','
                jr      z,statement_read_target_valid
                or      a
                jp      nz,statement_syntax
statement_read_target_valid:
                ld      (READ_STMT_PTR),hl
                call    get_next_data_item
                jp      c,read_out_of_data
                ld      a,(READ_TARGET_TYPE)
                or      a
                jr      nz,statement_read_string
                call    parse_expression
                jp      c,statement_syntax
                ld      de,(EXPR_VALUE)
                ld      a,(READ_TARGET_INDEX)
                ld      (VAR_INDEX),a
                call    store_numeric_variable
                call    data_commit_item
                jp      c,statement_syntax
                jr      statement_read_next_target
statement_read_string:
                call    read_string_data_item
                jp      c,statement_syntax
statement_read_next_target:
                ld      hl,(READ_STMT_PTR)
                ld      a,(hl)
                cp      ','
                ret     nz
                inc     hl
                jr      statement_read_target

statement_restore:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jr      z,statement_restore_start
                call    parse_expression
                jp      c,statement_syntax
                bit     7,d
                jp      nz,statement_syntax
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      (LINE_NUM),de
                call    find_line_position
                ld      hl,(INSERT_PTR)
                ld      (DATA_SCAN_PTR),hl
                jr      statement_restore_clear_item
statement_restore_start:
                ld      hl,PROGRAM_START
                ld      (DATA_SCAN_PTR),hl
statement_restore_clear_item:
                ld      hl,0
                ld      (DATA_ITEM_PTR),hl
                ret

; Return HL at the next DATA field. Carry means there are no more DATA fields.
get_next_data_item:
                ld      hl,(DATA_ITEM_PTR)
                ld      a,h
                or      l
                ret     nz
get_next_data_line:
                ld      hl,(DATA_SCAN_PTR)
                ld      a,(hl)
                cp      $FF
                jr      nz,get_next_data_line_present
                inc     hl
                ld      a,(hl)
                cp      $FF
                jr      z,get_next_data_error
                dec     hl
get_next_data_line_present:
                inc     hl
                inc     hl
                ld      (DATA_LINE_TEXT),hl
                call    skip_spaces
                ld      de,kw_data
                call    match_keyword
                jr      nz,get_next_data_skip_line
                ld      a,(hl)
                cp      ' '
                jr      z,get_next_data_found
                cp      ','
                jr      z,get_next_data_found
                or      a
                jr      z,get_next_data_found
                jr      get_next_data_skip_line
get_next_data_found:
                ld      (DATA_ITEM_PTR),hl
get_next_data_skip_line:
                ld      hl,(DATA_LINE_TEXT)
get_next_data_skip_loop:
                ld      a,(hl)
                inc     hl
                or      a
                jr      nz,get_next_data_skip_loop
                ld      (DATA_SCAN_PTR),hl
                ld      a,(DATA_ITEM_PTR)
                ld      l,a
                ld      a,(DATA_ITEM_PTR+1)
                ld      h,a
                ld      a,h
                or      l
                jr      nz,get_next_data_return
                jr      get_next_data_line
get_next_data_return:
                or      a
                ret
get_next_data_error:
                scf
                ret

; Advance the persistent DATA cursor from the delimiter at HL.
data_commit_item:
                call    skip_spaces
                ld      a,(hl)
                cp      ','
                jr      z,data_commit_more
                or      a
                jr      nz,data_commit_error
                ld      hl,0
                ld      (DATA_ITEM_PTR),hl
                or      a
                ret
data_commit_more:
                inc     hl
                ld      (DATA_ITEM_PTR),hl
                or      a
                ret
data_commit_error:
                scf
                ret

read_string_data_item:
                call    skip_spaces
                ld      a,(READ_TARGET_INDEX)
                ld      l,a
                ld      h,0
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                ld      de,STRING_VARS
                add     hl,de
                ld      (STRING_DEST),hl
                ld      a,31
                ld      (MATH_COUNT),a
                ld      a,(DATA_ITEM_PTR)
                ld      l,a
                ld      a,(DATA_ITEM_PTR+1)
                ld      h,a
                call    skip_spaces
                ld      a,(hl)
                cp      $22
                jr      nz,read_string_bare_start
                inc     hl
                ld      a,1
                ld      (TEMP_BYTE),a
                jr      read_string_copy_loop
read_string_bare_start:
                xor     a
                ld      (TEMP_BYTE),a
read_string_copy_loop:
                ld      a,(hl)
                or      a
                jr      z,read_string_end
                ld      b,a
                ld      a,(TEMP_BYTE)
                or      a
                ld      a,b
                jr      z,read_string_bare_delimiter
                cp      $22
                jr      z,read_string_quote_end
                jr      read_string_store_char
read_string_bare_delimiter:
                cp      ','
                jr      z,read_string_end
read_string_store_char:
                ld      a,(MATH_COUNT)
                or      a
                jr      z,read_string_error
                ld      a,b
                ld      de,(STRING_DEST)
                ld      (de),a
                inc     de
                ld      (STRING_DEST),de
                inc     hl
                ld      a,(MATH_COUNT)
                dec     a
                ld      (MATH_COUNT),a
                jr      read_string_copy_loop
read_string_quote_end:
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                cp      ','
                jr      z,read_string_end
                or      a
                jr      nz,read_string_error
                jr      read_string_end
read_string_end:
                ld      de,(STRING_DEST)
                xor     a
                ld      (de),a
                jp      data_commit_item
read_string_error:
                scf
                ret

read_out_of_data:
                ld      hl,out_of_data_error
                jp      print_text

statement_if:
                call    parse_expression
                jp      c,statement_syntax
                ld      de,(EXPR_VALUE)
                ld      (INPUT_VALUE),de
                ld      a,(hl)
                cp      '='
                jr      z,statement_if_equal
                cp      '<'
                jr      z,statement_if_less
                cp      '>'
                jr      z,statement_if_greater
                jp      statement_syntax
statement_if_equal:
                ld      a,0
                jr      statement_if_relation
statement_if_less:
                inc     hl
                ld      a,(hl)
                cp      '='
                jr      z,statement_if_less_equal
                cp      '>'
                jr      z,statement_if_not_equal
                dec     hl
                ld      a,1
                jr      statement_if_relation
statement_if_less_equal:
                ld      a,3
                jr      statement_if_relation
statement_if_not_equal:
                ld      a,5
                jr      statement_if_relation
statement_if_greater:
                inc     hl
                ld      a,(hl)
                cp      '='
                jr      z,statement_if_greater_equal
                dec     hl
                ld      a,2
                jr      statement_if_relation
statement_if_greater_equal:
                ld      a,4
statement_if_relation:
                ld      (REL_OPERATOR),a
                inc     hl
                call    parse_expression
                jp      c,statement_syntax
                call    compare_signed
                ld      (REL_RESULT),a
                ld      a,(REL_OPERATOR)
                cp      0
                jr      z,statement_if_test_eq
                cp      1
                jr      z,statement_if_test_lt
                cp      2
                jr      z,statement_if_test_gt
                cp      3
                jr      z,statement_if_test_le
                cp      4
                jr      z,statement_if_test_ge
                ld      a,(REL_RESULT)
                cp      1
                jr      z,statement_if_false
                jr      statement_if_true
statement_if_test_eq:
                ld      a,(REL_RESULT)
                cp      1
                jr      z,statement_if_true
                jr      statement_if_false
statement_if_test_lt:
                ld      a,(REL_RESULT)
                or      a
                jr      z,statement_if_true
                jr      statement_if_false
statement_if_test_gt:
                ld      a,(REL_RESULT)
                cp      2
                jr      z,statement_if_true
                jr      statement_if_false
statement_if_test_le:
                ld      a,(REL_RESULT)
                cp      2
                jr      nz,statement_if_true
                jr      statement_if_false
statement_if_test_ge:
                ld      a,(REL_RESULT)
                or      a
                jr      nz,statement_if_true
                jr      statement_if_false
statement_if_true:
                call    skip_spaces
                ld      de,kw_then
                call    match_keyword
                jp      nz,statement_syntax
                call    skip_spaces
                ld      a,(hl)
                cp      '0'
                jr      c,statement_if_execute
                cp      '9'+1
                jr      nc,statement_if_execute
                ld      a,(RUN_ACTIVE)
                or      a
                jp      z,statement_syntax
                call    parse_line_target
                jp      c,statement_syntax
                call    find_target_line
                jp      c,statement_line_error
                ld      (FLOW_DEST),hl
                ld      a,1
                ld      (FLOW_CHANGED),a
                ret
statement_if_execute:
                call    execute_statement
                ret
statement_if_false:
                call    skip_spaces
                ld      de,kw_then
                call    match_keyword
                jp      nz,statement_syntax
                ret

statement_goto:
                ld      a,(RUN_ACTIVE)
                or      a
                jp      z,statement_syntax
                call    parse_line_target
                jp      c,statement_syntax
                call    find_target_line
                jp      c,statement_line_error
                ld      (FLOW_DEST),hl
                ld      a,1
                ld      (FLOW_CHANGED),a
                ret

statement_gosub:
                ld      a,(RUN_ACTIVE)
                or      a
                jp      z,statement_syntax
                ld      a,(FLOW_DEPTH)
                cp      8
                jp      nc,statement_gosub_stack_error
                push    hl
                ld      hl,(PROGRAM_PTR)
                inc     hl
                inc     hl
statement_gosub_find_end:
                ld      a,(hl)
                inc     hl
                or      a
                jr      nz,statement_gosub_find_end
                ld      (FLOW_RETURN),hl
                pop     hl
                call    parse_line_target
                jp      c,statement_syntax
                call    find_target_line
                jp      c,statement_line_error
                ld      (FILE_LENGTH),hl
                ld      a,(FLOW_DEPTH)
                add     a,a
                ld      e,a
                ld      d,0
                ld      hl,FLOW_STACK
                add     hl,de
                ld      de,(FLOW_RETURN)
                ld      (hl),e
                inc     hl
                ld      (hl),d
                ld      a,(FLOW_DEPTH)
                inc     a
                ld      (FLOW_DEPTH),a
                ld      hl,(FILE_LENGTH)
                ld      (FLOW_DEST),hl
                ld      a,1
                ld      (FLOW_CHANGED),a
                ret

statement_return:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      a,(RUN_ACTIVE)
                or      a
                jp      z,statement_syntax
                ld      a,(FLOW_DEPTH)
                or      a
                jp      z,statement_return_error
                dec     a
                ld      (FLOW_DEPTH),a
                add     a,a
                ld      e,a
                ld      d,0
                ld      hl,FLOW_STACK
                add     hl,de
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                ex      de,hl
                ld      (FLOW_DEST),hl
                ld      a,1
                ld      (FLOW_CHANGED),a
                ret

statement_for:
                ld      a,(RUN_ACTIVE)
                or      a
                jp      z,statement_syntax
                ld      a,(FOR_DEPTH)
                cp      8
                jp      nc,statement_for_stack_error
                call    skip_spaces
                ld      a,(hl)
                call    letter_to_index
                jp      c,statement_syntax
                ld      (VAR_INDEX),a
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                cp      '='
                jp      nz,statement_syntax
                inc     hl
                call    parse_expression
                jp      c,statement_syntax
                ld      (FOR_START),de
                call    store_numeric_variable
                call    skip_spaces
                ld      de,kw_to
                call    match_keyword
                jp      nz,statement_syntax
                call    parse_expression
                jp      c,statement_syntax
                ld      (FOR_END),de
                call    skip_spaces
                ld      de,kw_step
                call    match_keyword
                jr      nz,statement_for_default_step
                call    parse_expression
                jp      c,statement_syntax
                ld      (FOR_STEP),de
                jr      statement_for_check_end
statement_for_default_step:
                ld      de,1
                ld      (FOR_STEP),de
statement_for_check_end:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      hl,(FOR_STEP)
                ld      a,h
                or      l
                jp      z,statement_syntax
                ld      hl,(PROGRAM_PTR)
                inc     hl
                inc     hl
statement_for_body_end:
                ld      a,(hl)
                inc     hl
                or      a
                jr      nz,statement_for_body_end
                ld      (FOR_SCAN),hl
                ld      hl,(FOR_START)
                ld      (INPUT_VALUE),hl
                ld      hl,(FOR_END)
                ld      (EXPR_VALUE),hl
                call    compare_signed
                ld      (REL_RESULT),a
                ld      a,(FOR_STEP+1)
                bit     7,a
                jr      nz,statement_for_negative_step
                ld      a,(REL_RESULT)
                cp      2
                jp      z,statement_for_skip
                jr      statement_for_push
statement_for_negative_step:
                ld      a,(REL_RESULT)
                or      a
                jp      z,statement_for_skip
statement_for_push:
                ld      a,(FOR_DEPTH)
                call    for_frame_address
                ld      a,(VAR_INDEX)
                ld      (hl),a
                inc     hl
                ld      de,(FOR_END)
                ld      (hl),e
                inc     hl
                ld      (hl),d
                inc     hl
                ld      de,(FOR_STEP)
                ld      (hl),e
                inc     hl
                ld      (hl),d
                inc     hl
                ld      de,(FOR_SCAN)
                ld      (hl),e
                inc     hl
                ld      (hl),d
                ld      a,(FOR_DEPTH)
                inc     a
                ld      (FOR_DEPTH),a
                ret

statement_for_skip:
                xor     a
                ld      (FOR_SKIP_DEPTH),a
statement_for_skip_loop:
                ld      hl,(FOR_SCAN)
                ld      a,(hl)
                cp      $FF
                jp      z,statement_line_error
                inc     hl
                inc     hl
                ld      de,kw_for
                call    match_keyword
                jr      nz,statement_for_skip_next
                ld      a,(FOR_SKIP_DEPTH)
                inc     a
                ld      (FOR_SKIP_DEPTH),a
                jr      statement_for_skip_advance
statement_for_skip_next:
                ld      hl,(FOR_SCAN)
                inc     hl
                inc     hl
                ld      de,kw_next
                call    match_keyword
                jr      nz,statement_for_skip_advance
                ld      a,(FOR_SKIP_DEPTH)
                or      a
                jr      z,statement_for_skip_found
                dec     a
                ld      (FOR_SKIP_DEPTH),a
                jr      statement_for_skip_advance
statement_for_skip_found:
                ld      hl,(FOR_SCAN)
                inc     hl
                inc     hl
statement_for_skip_find_end:
                ld      a,(hl)
                inc     hl
                or      a
                jr      nz,statement_for_skip_find_end
                ld      (FLOW_DEST),hl
                ld      a,1
                ld      (FLOW_CHANGED),a
                ret
statement_for_skip_advance:
                ld      hl,(FOR_SCAN)
                inc     hl
                inc     hl
statement_for_skip_find_zero:
                ld      a,(hl)
                inc     hl
                or      a
                jr      nz,statement_for_skip_find_zero
                ld      (FOR_SCAN),hl
                jr      statement_for_skip_loop

statement_next:
                ld      a,(RUN_ACTIVE)
                or      a
                jp      z,statement_syntax
                ld      a,(FOR_DEPTH)
                or      a
                jp      z,statement_next_error
                dec     a
                push    hl
                call    for_frame_address
                ld      (FOR_FRAME),hl
                pop     hl
                push    hl
                ld      hl,(FOR_FRAME)
                ld      a,(hl)
                ld      (VAR_INDEX),a
                pop     hl
                call    skip_spaces
                ld      a,(hl)
                or      a
                jr      z,statement_next_name_ok
                call    letter_to_index
                jp      c,statement_next_bad_variable
                ld      b,a
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_next_trailing_text
                ld      hl,(FOR_FRAME)
                ld      a,(hl)
                cp      b
                jp      nz,statement_next_mismatch
statement_next_name_ok:
                ld      a,(VAR_INDEX)
                add     a,a
                ld      e,a
                ld      d,0
                ld      hl,VARIABLES
                add     hl,de
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                ld      hl,(FOR_FRAME)
                inc     hl
                inc     hl
                inc     hl
                ld      c,(hl)
                inc     hl
                ld      b,(hl)
                ex      de,hl
                add     hl,bc
                ex      de,hl
                call    store_numeric_variable
                ld      (INPUT_VALUE),de
                ld      hl,(FOR_FRAME)
                inc     hl
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                ex      de,hl
                ld      (EXPR_VALUE),hl
                call    compare_signed
                ld      (REL_RESULT),a
                ld      hl,(FOR_FRAME)
                ld      de,3
                add     hl,de
                ld      a,(hl)
                inc     hl
                or      (hl)
                bit     7,(hl)
                jr      nz,statement_next_negative
                ld      a,(REL_RESULT)
                cp      2
                jr      nz,statement_next_repeat
                jr      statement_next_done
statement_next_negative:
                ld      a,(REL_RESULT)
                or      a
                jr      nz,statement_next_repeat
statement_next_done:
                ld      a,(FOR_DEPTH)
                dec     a
                ld      (FOR_DEPTH),a
                ret
statement_next_repeat:
                ld      hl,(FOR_FRAME)
                ld      de,5
                add     hl,de
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                ex      de,hl
                ld      (FLOW_DEST),hl
                ld      a,1
                ld      (FLOW_CHANGED),a
                ret

for_frame_address:
                add     a,a
                add     a,a
                add     a,a
                ld      e,a
                ld      d,0
                ld      hl,FOR_STACK
                add     hl,de
                ret

parse_line_target:
                call    parse_expression
                ret     c
                ld      hl,(EXPR_VALUE)
                ld      (LINE_NUM),hl
                call    skip_spaces
                ld      a,(hl)
                or      a
                ret     z
                scf
                ret

compare_signed:
                ld      hl,(INPUT_VALUE)
                ld      de,(EXPR_VALUE)
                ld      a,h
                xor     d
                bit     7,a
                jr      nz,compare_signed_different_sign
                bit     7,h
                jr      nz,compare_signed_both_negative
                or      a
                sbc     hl,de
                jr      z,compare_signed_equal
                jr      c,compare_signed_less
                ld      a,2
                ret
compare_signed_both_negative:
                or      a
                sbc     hl,de
                jr      z,compare_signed_equal
                jr      c,compare_signed_greater
                xor     a
                ret
compare_signed_different_sign:
                bit     7,h
                jr      nz,compare_signed_less
                ld      a,2
                ret
compare_signed_greater:
                ld      a,2
                ret
compare_signed_less:
                xor     a
                ret
compare_signed_equal:
                ld      a,1
                ret

find_target_line:
                ld      hl,PROGRAM_START
find_target_loop:
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                dec     hl
                ld      a,d
                cp      $FF
                jr      nz,find_target_compare
                ld      a,e
                cp      $FF
                jr      z,find_target_missing
find_target_compare:
                ld      bc,(LINE_NUM)
                ld      a,b
                cp      d
                jr      c,find_target_missing
                jr      nz,find_target_next
                ld      a,c
                cp      e
                jr      c,find_target_missing
                jr      z,find_target_found
find_target_next:
                inc     hl
                inc     hl
find_target_skip:
                ld      a,(hl)
                inc     hl
                or      a
                jr      nz,find_target_skip
                jr      find_target_loop
find_target_found:
                or      a
                ret
find_target_missing:
                scf
                ret

statement_line_error:
                ld      hl,line_error
                jp      print_text
statement_return_error:
                ld      hl,return_error
                jp      print_text
statement_gosub_stack_error:
                ld      hl,gosub_stack_error
                jp      print_text
statement_for_stack_error:
                ld      hl,for_stack_error
                jp      print_text
statement_next_error:
                ld      hl,next_error
                jp      print_text
statement_next_mismatch:
                ld      hl,next_mismatch_error
                jp      print_text
statement_next_bad_variable:
                ld      hl,next_variable_error
                jp      print_text
statement_next_trailing_text:
                ld      hl,next_trailing_error
                jp      print_text

; Delete the record at INSERT_PTR, shifting all following bytes left.
remove_program_line:
                ld      hl,(INSERT_PTR)
                ld      (REC_PTR),hl
                inc     hl
                inc     hl
remove_find_end:
                ld      a,(hl)
                inc     hl
                or      a
                jr      nz,remove_find_end
                ld      (TAIL_PTR),hl

                ld      de,(PGMEND)
                inc     de
                inc     de
                ex      de,hl
                ld      de,(TAIL_PTR)
                or      a
                sbc     hl,de
                ld      (MOVE_COUNT),hl
                ld      hl,(TAIL_PTR)
                ld      de,(REC_PTR)
                ld      bc,(MOVE_COUNT)
                ldir

                ld      hl,(TAIL_PTR)
                ld      de,(REC_PTR)
                or      a
                sbc     hl,de
                ld      de,(PGMEND)
                or      a
                ex      de,hl
                sbc     hl,de
                ld      (PGMEND),hl
                ld      hl,(REC_PTR)
                ld      (INSERT_PTR),hl
                ret

; MSX-DOS FCB file I/O. Filenames are quoted 8.3 names on the current drive.
; The disk BASIC hooks in C-DISK are not involved; BDOS must be present.
parse_file_spec:
                call    skip_spaces
                ld      a,(hl)
                cp      $22
                jr      z,parse_file_spec_start
                scf
                ret
parse_file_spec_start:
                inc     hl
                push    hl
                ld      hl,FCB
                ld      b,36
                xor     a
parse_file_fcb_clear:
                ld      (hl),a
                inc     hl
                djnz    parse_file_fcb_clear
                ld      hl,FCB+9
                ld      (hl),'B'
                inc     hl
                ld      (hl),'A'
                inc     hl
                ld      (hl),'S'
                pop     hl
                ld      a,(hl)
                call    uppercase_a
                cp      'A'
                jr      c,parse_file_name_init
                cp      'P'+1
                jr      nc,parse_file_name_init
                ld      b,a
                inc     hl
                ld      a,(hl)
                cp      ':'
                jr      nz,parse_file_name_drive_rollback
                ld      a,b
                sub     'A'-1
                ld      (FCB),a
                inc     hl
                jr      parse_file_name_init
parse_file_name_drive_rollback:
                dec     hl
parse_file_name_init:
                ld      a,1
                ld      (FILE_STATE),a
                ld      a,0
                ld      (FILE_RECORDS),a
parse_file_name:
                ld      a,(hl)
                cp      $22
                jr      z,parse_file_spec_done
                cp      '.'
                jr      z,parse_file_extension
                or      a
                jp      z,parse_file_spec_error
                call    uppercase_a
                ld      b,a
                ld      a,(FILE_STATE)
                cp      1
                jr      nz,parse_file_name_ext
                ld      a,(FILE_RECORDS)
                cp      8
                jr      nc,parse_file_spec_error
                ld      e,a
                ld      d,0
                ld      a,b
                push    hl
                ld      hl,FCB+1
                add     hl,de
                ld      (hl),a
                pop     hl
                ld      a,(FILE_RECORDS)
                inc     a
                ld      (FILE_RECORDS),a
                inc     hl
                jr      parse_file_name
parse_file_name_ext:
                ld      a,(FILE_RECORDS)
                cp      3
                jr      nc,parse_file_spec_error
                ld      e,a
                ld      d,0
                ld      a,b
                push    hl
                ld      hl,FCB+9
                add     hl,de
                ld      (hl),a
                pop     hl
                ld      a,(FILE_RECORDS)
                inc     a
                ld      (FILE_RECORDS),a
                inc     hl
                jr      parse_file_name
parse_file_extension:
                ld      a,(FILE_STATE)
                or      a
                jr      z,parse_file_spec_error
                ld      a,(FILE_RECORDS)
                or      a
                jr      z,parse_file_spec_error
                xor     a
                ld      (FILE_STATE),a
                ld      (FILE_RECORDS),a
                inc     hl
                jr      parse_file_name
parse_file_spec_done:
                ld      a,(FILE_RECORDS)
                or      a
                jr      z,parse_file_spec_error
                ld      a,(FILE_STATE)
                or      a
                jr      nz,parse_file_spec_close
                ld      a,(FILE_RECORDS)
                or      a
                jr      z,parse_file_spec_error
parse_file_spec_close:
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                or      a
                jr      z,parse_file_spec_ok
                ld      a,(FILE_SIGN)
                cp      1
                jr      nz,parse_file_spec_error
                ld      a,(hl)
                cp      ','
                jr      nz,parse_file_spec_error
parse_file_spec_ok:
                or      a
                ret
parse_file_spec_error:
                scf
                ret

; Read one byte from the sequential 128-byte DOS DMA records.
file_get_byte:
                ld      a,(FILE_POS)
                cp      128
                jr      nz,file_get_byte_buffer
                ld      de,FCB
                ld      c,$14
                call    5
                or      a
                jr      nz,file_get_byte_error
                xor     a
                ld      (FILE_POS),a
file_get_byte_buffer:
                ld      a,(FILE_POS)
                ld      e,a
                ld      d,0
                ld      hl,FILE_BUFFER
                add     hl,de
                ld      a,(hl)
                inc     e
                ld      a,e
                ld      (FILE_POS),a
                dec     e
                ld      a,(hl)
                or      a
                ret
file_get_byte_error:
                scf
                ret

; Append A to LINEBUF at TEXT_POS.
buffer_append:
                push    hl
                push    de
                push    af
                ld      hl,(TEXT_POS)
                ld      a,h
                or      a
                jr      nz,buffer_append_overflow
                ld      a,l
                cp      MAX_LINE+1
                jr      nc,buffer_append_overflow
                ld      de,LINEBUF
                add     hl,de
                pop     af
                ld      (hl),a
                ld      hl,(TEXT_POS)
                inc     hl
                ld      (TEXT_POS),hl
                pop     de
                pop     hl
                or      a
                ret
buffer_append_overflow:
                pop     af
                pop     de
                pop     hl
                ld      a,1
                ld      (FILE_SIGN),a
                scf
                ret

; Convert the signed 16-bit FILE_VALUE to decimal in LINEBUF.
buffer_number:
                ld      hl,(FILE_VALUE)
                bit     7,h
                jr      z,buffer_number_positive
                ld      a,'-'
                call    buffer_append
                xor     a
                sub     l
                ld      l,a
                ld      a,0
                sbc     a,h
                ld      h,a
                jr      buffer_unsigned
buffer_unsigned:
buffer_number_positive:
                xor     a
                ld      (FILE_STATE),a
                ld      bc,10000
                call    decimal_digit
                call    buffer_digit
                ld      bc,1000
                call    decimal_digit
                call    buffer_digit
                ld      bc,100
                call    decimal_digit
                call    buffer_digit
                ld      bc,10
                call    decimal_digit
                call    buffer_digit
                ld      a,l
                call    buffer_digit_force
                ret
buffer_digit:
                or      a
                jr      nz,buffer_digit_set
                ld      a,(FILE_STATE)
                or      a
                ret     z
                ld      a,'0'
                jp      buffer_append
buffer_digit_set:
                ld      (TEMP_BYTE),a
                ld      a,1
                ld      (FILE_STATE),a
                ld      a,(TEMP_BYTE)
buffer_digit_force:
                add     a,'0'
                jp      buffer_append

load_program:
                call    check_dos
                jp      c,dos_required
                xor     a
                ld      (FILE_SIGN),a
                call    parse_file_spec
                jp      c,statement_syntax
                ld      de,FCB
                ld      c,$0F
                call    5
                or      a
                jp      nz,file_not_found
                ld      de,FILE_BUFFER
                ld      c,$1A
                call    5
                ld      a,128
                ld      (FILE_POS),a
                call    file_get_byte
                jp      c,file_read_error
                cp      $FF
                jp      nz,file_format_error
                call    new_program
load_program_line:
                call    file_get_byte
                jp      c,file_read_error
                ld      (TEMP_BYTE),a
                call    file_get_byte
                jp      c,file_read_error
                or      a
                jr      nz,load_program_link_present
                ld      a,(TEMP_BYTE)
                or      a
                jp      z,load_program_done
                jp      file_format_error
load_program_link_present:
                call    file_get_byte
                jp      c,file_read_error
                ld      (LINE_NUM),a
                call    file_get_byte
                jp      c,file_read_error
                ld      (LINE_NUM+1),a
load_program_line_number:
                ld      hl,0
                ld      (TEXT_POS),hl
                xor     a
                ld      (LEX_STATE),a
                ld      hl,(LINE_NUM)
                ld      (FILE_VALUE),hl
                ld      a,h
                cp      $FF
                jr      nz,load_program_line_number_ok
                ld      a,l
                cp      $FA
                jp      nc,file_format_error
load_program_line_number_ok:
                xor     a
                ld      (FILE_SIGN),a
                call    buffer_unsigned
                ld      a,' '
                call    buffer_append
load_program_token:
                call    file_get_byte
                jp      c,file_read_error
                or      a
                jp      z,load_program_store_line
                ld      (TEMP_BYTE),a
                ld      a,(LEX_STATE)
                cp      2
                jr      z,load_token_raw_char
                ld      a,(TEMP_BYTE)
                cp      $22
                jr      z,load_token_quote
                ld      a,(LEX_STATE)
                or      a
                jr      nz,load_token_raw_char
                ld      a,(TEMP_BYTE)
                cp      $0F
                jr      z,load_token_byte_number
                cp      $0C
                jr      z,load_token_hex_number
                cp      $1C
                jr      z,load_token_word_number
                cp      $11
                jr      c,load_token_keyword
                cp      $1B
                jr      c,load_token_digit
                cp      $3A
                jr      z,load_token_keyword
                cp      $80
                jr      nc,load_token_keyword
                call    buffer_append
                jr      load_program_token
load_token_quote:
                ld      a,(LEX_STATE)
                xor     1
                ld      (LEX_STATE),a
                ld      a,$22
                call    buffer_append
                jr      load_program_token
load_token_raw_char:
                ld      a,(TEMP_BYTE)
                call    buffer_append
                jr      load_program_token
load_token_digit:
                sub     $11
                add     a,'0'
                call    buffer_append
                jr      load_program_token
load_token_byte_number:
                call    file_get_byte
                jp      c,file_read_error
                ld      (FILE_VALUE),a
                xor     a
                ld      (FILE_VALUE+1),a
                call    buffer_number
                jr      load_program_token
load_token_hex_number:
                call    file_get_byte
                jp      c,file_read_error
                ld      (FILE_VALUE),a
                call    file_get_byte
                jp      c,file_read_error
                ld      (FILE_VALUE+1),a
                call    buffer_number
                jp      load_program_token
load_token_word_number:
                call    file_get_byte
                jp      c,file_read_error
                ld      (FILE_VALUE),a
                call    file_get_byte
                jp      c,file_read_error
                ld      (FILE_VALUE+1),a
                call    buffer_number
                jp      load_program_token
load_token_keyword:
                ld      (TEMP_BYTE),a
                cp      $FF
                jr      z,load_token_extended
                cp      $3A
                jr      nz,load_token_keyword_lookup
                call    file_get_byte
                jp      c,file_read_error
                cp      $8F
                jp      nz,file_format_error
                ld      hl,text_rem
                call    buffer_text
                ld      a,2
                ld      (LEX_STATE),a
                jp      load_program_token
load_token_keyword_lookup:
                ld      a,(TEMP_BYTE)
                cp      $EE
                jr      c,load_token_keyword_lookup_table
                cp      $F6
                jr      nc,load_token_keyword_lookup_table
                sub     $EE
                ld      e,a
                ld      d,0
                ld      hl,operator_decode_table
                add     hl,de
                ld      a,(hl)
                call    buffer_append
                jp      load_program_token
load_token_keyword_lookup_table:
                cp      $8F
                jr      z,load_token_rem
                ld      hl,token_keyword_table
load_token_keyword_loop:
                ld      a,(hl)
                or      a
                jp      z,file_format_error
                ld      b,a
                ld      a,(TEMP_BYTE)
                cp      b
                jr      nz,load_token_keyword_next
                inc     hl
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                ex      de,hl
                call    buffer_text
                jp      load_program_token
load_token_keyword_next:
                inc     hl
                inc     hl
                inc     hl
                jr      load_token_keyword_loop
load_token_rem:
                ld      hl,text_rem
                call    buffer_text
                ld      a,2
                ld      (LEX_STATE),a
                jp      load_program_token
load_token_extended:
                call    file_get_byte
                jp      c,file_read_error
                ld      (TEMP_BYTE),a
                ld      hl,extended_token_table
load_token_extended_loop:
                ld      a,(hl)
                or      a
                jp      z,file_format_error
                ld      b,a
                ld      a,(TEMP_BYTE)
                cp      b
                jr      nz,load_token_extended_next
                inc     hl
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                ex      de,hl
                call    buffer_text
                jp      load_program_token
load_token_extended_next:
                inc     hl
                inc     hl
                inc     hl
                jr      load_token_extended_loop
load_program_store_line:
                ld      a,(FILE_SIGN)
                or      a
                jp      nz,file_format_error
                ld      a,(LEX_STATE)
                cp      1
                jp      z,file_format_error
                xor     a
                call    buffer_append
                ld      hl,LINEBUF
                call    store_program_line
                ld      a,(STORE_ERROR)
                or      a
                jp      nz,file_load_out_of_memory
                jp      load_program_line
load_program_done:
                call    close_file
                or      a
                jp      nz,file_close_error
                ld      hl,load_ok
                call    print_text
                ret

buffer_text:
                ld      a,(hl)
                or      a
                ret     z
                call    buffer_append
                inc     hl
                jr      buffer_text

close_file:
                ld      de,FCB
                ld      c,$10
                call    5
                ret

file_not_found:
                ld      hl,file_not_found_text
                jp      print_text
file_read_error:
                call    close_file
                call    new_program
                ld      hl,file_read_error_text
                jp      print_text
file_format_error:
                call    close_file
                call    new_program
                ld      hl,file_format_error_text
                jp      print_text
file_load_out_of_memory:
                call    close_file
                call    new_program
                ld      hl,out_of_memory
                jp      print_text
file_close_error:
                ld      hl,file_close_error_text
                jp      print_text

save_program:
                call    check_dos
                jp      c,dos_required
                xor     a
                ld      (FILE_SIGN),a
                call    parse_file_spec
                jp      c,statement_syntax
                ld      de,FCB
                ld      c,$13
                call    5
                ld      de,FCB
                ld      c,$16
                call    5
                or      a
                jp      nz,file_write_error
                ld      de,FILE_BUFFER
                ld      c,$1A
                call    5
                xor     a
                ld      (FILE_POS),a
                ld      hl,1
                ld      (FILE_OFFSET),hl
                ld      a,$FF
                call    file_put_byte
                jp      c,file_write_abort
                ld      hl,PROGRAM_START
                ld      (PROGRAM_PTR),hl
save_program_line:
                ld      hl,(PROGRAM_PTR)
                ld      a,(hl)
                cp      $FF
                jr      nz,save_program_line_data
                inc     hl
                ld      a,(hl)
                cp      $FF
                jr      z,save_program_end
save_program_line_data:
                ld      a,(hl)
                ld      (LINE_NUM),a
                inc     hl
                ld      a,(hl)
                ld      (LINE_NUM+1),a
                inc     hl
                ld      (LINE_PTR),hl
                call    string_length
                ld      (PROGRAM_PTR),hl
                call    build_token_line
                ld      hl,(FILE_OFFSET)
                ld      de,5
                add     hl,de
                ld      de,(TOKEN_POS)
                add     hl,de
                ld      (FILE_LENGTH),hl
                ld      de,$8000
                add     hl,de
                ld      a,l
                call    file_put_byte
                jp      c,file_write_abort
                ld      a,h
                call    file_put_byte
                jp      c,file_write_abort
                ld      hl,(LINE_NUM)
                ld      a,l
                call    file_put_byte
                jp      c,file_write_abort
                ld      a,h
                call    file_put_byte
                jp      c,file_write_abort
                ld      hl,TOKEN_BUFFER
                ld      bc,(TOKEN_POS)
save_program_token:
                ld      a,b
                or      c
                jr      z,save_program_eol
                ld      a,(hl)
                inc     hl
                push    bc
                call    file_put_byte
                pop     bc
                jp      c,file_write_abort
                dec     bc
                jr      save_program_token
save_program_eol:
                xor     a
                call    file_put_byte
                jp      c,file_write_abort
                ld      hl,(FILE_LENGTH)
                ld      (FILE_OFFSET),hl
                jr      save_program_line
save_program_end:
                xor     a
                call    file_put_byte
                jp      c,file_write_abort
                xor     a
                call    file_put_byte
                jp      c,file_write_abort
save_program_pad:
                ld      a,(FILE_POS)
                or      a
                jr      z,save_program_close
                xor     a
                call    file_put_byte
                jp      c,file_write_abort
                jr      save_program_pad
save_program_close:
                call    close_file
                or      a
                jp      nz,file_close_error
                ld      hl,save_ok
                jp      print_text
file_write_abort:
                call    close_file
file_write_error:
                ld      hl,file_write_error_text
                jp      print_text

file_put_byte:
                push    hl
                push    af
                ld      a,(FILE_POS)
                ld      e,a
                ld      d,0
                ld      hl,FILE_BUFFER
                add     hl,de
                pop     af
                ld      (hl),a
                ld      a,(FILE_POS)
                inc     a
                ld      (FILE_POS),a
                cp      128
                jr      z,file_put_byte_flush
                or      a
                pop     hl
                ret
file_put_byte_flush:
                call    file_write_record
                pop     hl
                ret

file_write_record:
                ld      de,FCB
                ld      c,$15
                call    5
                or      a
                jr      nz,file_write_record_error
                xor     a
                ld      (FILE_POS),a
                or      a
                ret
file_write_record_error:
                scf
                ret

check_dos:
                ld      a,($0005)
                cp      $C3
                ret     z
                scf
                ret
dos_required:
                ld      hl,dos_required_text
                jp      print_text

; Convert a supported source statement to MSX BASIC intermediate codes.
build_token_line:
                ld      hl,0
                ld      (TOKEN_POS),hl
                ld      a,0
                ld      (FILE_STATE),a
                ld      hl,(LINE_PTR)
                call    skip_spaces
                ld      de,kw_print
                call    match_keyword
                jp      z,token_start_print
                ld      de,kw_let
                call    match_keyword
                jp      z,token_start_let
                ld      de,kw_list
                call    match_keyword
                jp      z,token_start_list
                ld      de,kw_run
                call    match_keyword
                jp      z,token_start_run
                ld      de,kw_new
                call    match_keyword
                jp      z,token_start_new
                ld      de,kw_cls
                call    match_keyword
                jp      z,token_start_cls
                ld      de,kw_screen
                call    match_keyword
                jp      z,token_start_screen
                ld      de,kw_bload
                call    match_keyword
                jp      z,token_start_bload
                ld      de,kw_data
                call    match_keyword
                jp      z,token_start_data
                ld      de,kw_read
                call    match_keyword
                jp      z,token_start_read
                ld      de,kw_restore
                call    match_keyword
                jp      z,token_start_restore
                ld      de,kw_def
                call    match_keyword
                jp      z,token_start_def
                ld      de,kw_poke
                call    match_keyword
                jp      z,token_start_poke
                ld      de,kw_vpoke
                call    match_keyword
                jp      z,token_start_vpoke
                ld      de,kw_end
                call    match_keyword
                jp      z,token_start_end
                ld      de,kw_rem
                call    match_keyword
                jp      z,token_start_rem
                ld      de,kw_input
                call    match_keyword
                jp      z,token_start_input
                ld      de,kw_if
                call    match_keyword
                jp      z,token_start_if
                ld      de,kw_goto
                call    match_keyword
                jp      z,token_start_goto
                ld      de,kw_gosub
                call    match_keyword
                jp      z,token_start_gosub
                ld      de,kw_return
                call    match_keyword
                jp      z,token_start_return
                ld      de,kw_for
                call    match_keyword
                jp      z,token_start_for
                ld      de,kw_next
                call    match_keyword
                jp      z,token_start_next
                ld      hl,(LINE_PTR)
                call    skip_spaces
                jr      token_scan
token_start_print:
                ld      a,$91
                jr      token_start_keyword
token_start_let:
                ld      a,$88
                jr      token_start_keyword
token_start_list:
                ld      a,$93
                jr      token_start_keyword
token_start_run:
                ld      a,$8A
                jr      token_start_keyword
token_start_new:
                ld      a,$94
                jr      token_start_keyword
token_start_cls:
                ld      a,$9F
                jr      token_start_keyword
token_start_screen:
                ld      a,$C5
                jr      token_start_keyword
token_start_bload:
                ld      a,$CF
                jr      token_start_keyword
token_start_data:
                ld      a,$84
                jr      token_start_keyword
token_start_read:
                ld      a,$87
                jr      token_start_keyword
token_start_restore:
                ld      a,$8C
                jr      token_start_keyword
token_start_def:
                ld      a,$97
                jr      token_start_keyword
token_start_poke:
                ld      a,$98
                jr      token_start_keyword
token_start_vpoke:
                ld      a,$C6
                jr      token_start_keyword
token_start_end:
                ld      a,$81
                jr      token_start_keyword
token_start_input:
                ld      a,$85
                jr      token_start_keyword
token_start_if:
                ld      a,$8B
                jr      token_start_keyword
token_start_goto:
                ld      a,$89
                jr      token_start_keyword
token_start_gosub:
                ld      a,$8D
                jr      token_start_keyword
token_start_return:
                ld      a,$8E
                jr      token_start_keyword
token_start_for:
                ld      a,$82
                jr      token_start_keyword
token_start_next:
                ld      a,$83
token_start_keyword:
                call    token_append
                jr      token_scan
token_start_rem:
                ld      a,$3A
                call    token_append
                ld      a,$8F
                call    token_append
                ld      a,2
                ld      (FILE_STATE),a
                jr      token_scan
token_scan:
                ld      a,(hl)
                or      a
                ret     z
                ld      a,(FILE_STATE)
                cp      2
                jp      z,token_scan_comment_char
                ld      a,(hl)
                cp      $22
                jr      nz,token_scan_not_quote
                ld      a,(FILE_STATE)
                xor     1
                ld      (FILE_STATE),a
                ld      a,(hl)
                call    token_append
                inc     hl
                jr      token_scan
token_scan_not_quote:
                ld      a,(FILE_STATE)
                and     1
                jp      nz,token_scan_raw
                ld      a,(hl)
                cp      '&'
                jp      z,token_scan_radix
                ld      de,kw_peek
                call    match_function
                jp      z,token_function_peek
                ld      de,kw_vpeek
                call    match_function
                jp      z,token_function_vpeek
                ld      de,kw_usr
                call    match_function
                jp      z,token_function_usr
                ld      de,kw_str
                call    match_function
                jp      z,token_function_str
                ld      de,kw_val
                call    match_function
                jp      z,token_function_val
                ld      de,kw_abs
                call    match_function
                jp      z,token_function_abs
                ld      de,kw_sgn
                call    match_function
                jp      z,token_function_sgn
                ld      de,kw_int
                call    match_function
                jp      z,token_function_int
                ld      de,kw_sqr
                call    match_function
                jp      z,token_function_sqr
                ld      de,kw_len
                call    match_function
                jp      z,token_function_len
                ld      a,(hl)
                cp      'T'
                jp      nz,token_scan_number_test
                push    hl
                ld      de,kw_then
                call    match_keyword
                pop     hl
                jp      z,token_scan_then
                push    hl
                ld      de,kw_to
                call    match_keyword
                pop     hl
                jp      z,token_scan_to
                push    hl
                ld      de,kw_step
                call    match_keyword
                pop     hl
                jr      nz,token_scan_number_test
                ld      a,$DF
                call    token_append
                ld      de,4
                add     hl,de
                jp      token_scan
token_scan_then:
                ld      a,$DA
                call    token_append
                ld      de,4
                add     hl,de
                jp      token_scan
token_scan_to:
                ld      a,$D9
                call    token_append
                ld      de,2
                add     hl,de
                jp      token_scan
token_function_str:
                ld      a,$93
                jr      token_function_emit
token_function_val:
                ld      a,$94
                jr      token_function_emit
token_function_peek:
                ld      a,$97
                jr      token_function_emit
token_function_vpeek:
                ld      a,$98
                jr      token_function_emit
token_function_usr:
                ld      a,$DD
                call    token_append
                ld      a,'('
                call    token_append
                jp      token_scan
token_function_abs:
                ld      a,$86
                jr      token_function_emit
token_function_sgn:
                ld      a,$84
                jr      token_function_emit
token_function_int:
                ld      a,$85
                jr      token_function_emit
token_function_sqr:
                ld      a,$87
                jr      token_function_emit
token_function_len:
                ld      a,$92
token_function_emit:
                push    af
                ld      a,$FF
                call    token_append
                pop     af
                call    token_append
                ld      a,'('
                call    token_append
                jp      token_scan
token_scan_number_test:
                ld      a,(hl)
                cp      '0'
                jr      c,token_scan_raw
                cp      '9'+1
                jr      nc,token_scan_raw
                call    token_number
                jp      token_scan
token_scan_radix:
                push    hl
                inc     hl
                ld      a,(hl)
                call    uppercase_a
                cp      'H'
                jr      z,token_scan_radix_prefix
                cp      'B'
                jr      nz,token_scan_radix_not_literal
token_scan_radix_prefix:
                pop     hl
                call    token_scan_radix_copy
                jp      token_scan
token_scan_radix_not_literal:
                pop     hl
                jp      token_scan_raw
token_scan_radix_copy:
                ld      a,(hl)
                call    token_append
                inc     hl
                ld      a,(hl)
                call    uppercase_a
                call    token_append
                inc     hl
token_scan_radix_copy_digits:
                ld      a,(hl)
                cp      '0'
                jr      c,token_scan_radix_copy_done
                cp      '9'+1
                jr      c,token_scan_radix_copy_digit
                call    uppercase_a
                cp      'A'
                jr      c,token_scan_radix_copy_done
                cp      'F'+1
                jr      nc,token_scan_radix_copy_done
token_scan_radix_copy_digit:
                ld      a,(hl)
                call    token_append
                inc     hl
                jr      token_scan_radix_copy_digits
token_scan_radix_copy_done:
                ret
token_scan_raw:
                ld      a,(FILE_STATE)
                or      a
                jr      nz,token_scan_raw_char
                ld      a,(hl)
                cp      '>'
                jr      z,token_operator_gt
                cp      '='
                jr      z,token_operator_eq
                cp      '<'
                jr      z,token_operator_lt
                cp      '+'
                jr      z,token_operator_plus
                cp      '-'
                jr      z,token_operator_minus
                cp      '*'
                jr      z,token_operator_mul
                cp      '/'
                jr      z,token_operator_div
token_scan_raw_char:
                ld      a,(hl)
                call    token_append
                inc     hl
                jp      token_scan
token_operator_gt:
                ld      a,$EE
                jr      token_operator_emit
token_operator_eq:
                ld      a,$EF
                jr      token_operator_emit
token_operator_lt:
                ld      a,$F0
                jr      token_operator_emit
token_operator_plus:
                ld      a,$F1
                jr      token_operator_emit
token_operator_minus:
                ld      a,$F2
                jr      token_operator_emit
token_operator_mul:
                ld      a,$F3
                jr      token_operator_emit
token_operator_div:
                ld      a,$F4
token_operator_emit:
                call    token_append
                inc     hl
                jp      token_scan
token_scan_comment_char:
                ld      a,(hl)
                call    token_append
                inc     hl
                jp      token_scan

token_number:
                ld      bc,0
token_number_loop:
                ld      a,(hl)
                cp      '0'
                jr      c,token_number_done
                cp      '9'+1
                jr      nc,token_number_done
                sub     '0'
                ld      (TEMP_BYTE),a
                push    hl
                ld      h,b
                ld      l,c
                add     hl,hl
                push    hl
                add     hl,hl
                add     hl,hl
                pop     de
                add     hl,de
                ld      a,(TEMP_BYTE)
                ld      e,a
                ld      d,0
                add     hl,de
                ld      b,h
                ld      c,l
                pop     hl
                inc     hl
                jr      token_number_loop
token_number_done:
                ld      a,b
                or      a
                jr      nz,token_number_word
                ld      a,c
                cp      10
                jr      nc,token_number_byte
                add     a,$11
                jp      token_append
token_number_byte:
                ld      a,$0F
                call    token_append
                ld      a,c
                jp      token_append
token_number_word:
                ld      a,$1C
                call    token_append
                ld      a,c
                call    token_append
                ld      a,b
                jp      token_append

token_append:
                push    hl
                push    de
                push    af
                ld      hl,(TOKEN_POS)
                ld      de,TOKEN_BUFFER
                add     hl,de
                pop     af
                ld      (hl),a
                ld      hl,(TOKEN_POS)
                inc     hl
                ld      (TOKEN_POS),hl
                pop     de
                pop     hl
                ret

; Execute a single immediate or stored statement.
execute_statement:
                call    skip_spaces
                ld      a,(hl)
                or      a
                ret     z
                ld      de,kw_print
                call    match_keyword
                jp      z,statement_print
                ld      de,kw_let
                call    match_keyword
                jp      z,statement_let
                ld      de,kw_list
                call    match_keyword
                jp      z,statement_list
                ld      de,kw_run
                call    match_keyword
                jp      z,statement_run
                ld      de,kw_new
                call    match_keyword
                jp      z,statement_new
                ld      de,kw_cls
                call    match_keyword
                jp      z,statement_cls
                ld      de,kw_screen
                call    match_keyword
                jp      z,statement_screen
                ld      de,kw_poke
                call    match_keyword
                jp      z,statement_poke
                ld      de,kw_vpoke
                call    match_keyword
                jp      z,statement_vpoke
                ld      de,kw_help
                call    match_keyword
                jp      z,statement_help
                ld      de,kw_end
                call    match_keyword
                jp      z,statement_end
                ld      de,kw_rem
                call    match_keyword
                ret     z
                ld      de,kw_input
                call    match_keyword
                jp      z,statement_input
                ld      de,kw_read
                call    match_keyword
                jp      z,statement_read
                ld      de,kw_restore
                call    match_keyword
                jp      z,statement_restore
                ld      de,kw_data
                call    match_keyword
                jp      z,statement_data
                ld      de,kw_if
                call    match_keyword
                jp      z,statement_if
                ld      de,kw_goto
                call    match_keyword
                jp      z,statement_goto
                ld      de,kw_gosub
                call    match_keyword
                jp      z,statement_gosub
                ld      de,kw_return
                call    match_keyword
                jp      z,statement_return
                ld      de,kw_for
                call    match_keyword
                jp      z,statement_for
                ld      de,kw_next
                call    match_keyword
                jp      z,statement_next
                ld      de,kw_load
                call    match_keyword
                jp      z,statement_load
                ld      de,kw_save
                call    match_keyword
                jp      z,statement_save
                ld      de,kw_bload
                call    match_keyword
                jp      z,statement_bload
                ld      de,kw_def
                call    match_keyword
                jp      z,statement_def_usr

                ; A single alphabetic variable followed by '=' is shorthand LET.
                ld      a,(hl)
                call    letter_to_index
                jp      c,statement_syntax
                ld      (VAR_INDEX),a
                inc     hl
                ld      a,(hl)
                cp      '$'
                jp      z,statement_let_string
                call    skip_spaces
                ld      a,(hl)
                cp      '='
                jp      nz,statement_syntax
                jp      statement_let_var

statement_print:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jr      z,statement_print_empty
                cp      $22
                jr      z,statement_print_string
                push    hl
                call    print_str_function
                jr      nc,statement_print_str_done
                pop     hl
                push    hl
                call    print_string_variable
                jr      nc,statement_print_var_done
                pop     hl
                call    parse_expression
                jp      c,statement_syntax
                push    hl
                ld      hl,(EXPR_VALUE)
                call    print_signed
                pop     hl
                jp      statement_print_separator
statement_print_str_done:
                pop     bc
                jr      statement_print_after_item
statement_print_var_done:
                pop     bc
                jr      statement_print_after_item
statement_print_string:
                inc     hl
statement_print_string_loop:
                ld      a,(hl)
                or      a
                jp      z,statement_syntax
                cp      $22
                jr      z,statement_print_string_end
                call    CHPUT
                inc     hl
                jr      statement_print_string_loop
statement_print_string_end:
                inc     hl
statement_print_after_item:
                jr      statement_print_separator
statement_print_empty:
                call    print_newline
                ret
statement_print_separator:
                call    skip_spaces
                ld      a,(hl)
                cp      ';'
                jr      z,statement_print_semicolon
                cp      ','
                jr      z,statement_print_comma
                cp      '+'
                jr      z,statement_print_semicolon
                or      a
                jp      nz,statement_syntax
                call    print_newline
                ret
statement_print_semicolon:
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                or      a
                ret     z
                cp      ';'
                jr      z,statement_print_semicolon
                cp      ','
                jr      z,statement_print_comma
                cp      '+'
                jr      z,statement_print_semicolon
                cp      $22
                jr      z,statement_print_string
                push    hl
                call    print_str_function
                jr      nc,statement_print_semicolon_str_done
                pop     hl
                push    hl
                call    print_string_variable
                jr      nc,statement_print_semicolon_var_done
                pop     hl
                call    parse_expression
                jp      c,statement_syntax
                push    hl
                ld      hl,(EXPR_VALUE)
                call    print_signed
                pop     hl
                jr      statement_print_separator
statement_print_semicolon_str_done:
                pop     bc
                jr      statement_print_after_item
statement_print_semicolon_var_done:
                pop     bc
                jr      statement_print_after_item
statement_print_comma:
                inc     hl
                ld      a,' '
                call    CHPUT
                call    skip_spaces
                ld      a,(hl)
                or      a
                ret     z
                cp      $22
                jr      z,statement_print_string
                cp      '+'
                jr      z,statement_print_semicolon
                push    hl
                call    print_str_function
                jp      nc,statement_print_comma_str_done
                pop     hl
                push    hl
                call    print_string_variable
                jp      nc,statement_print_comma_var_done
                pop     hl
                call    parse_expression
                jp      c,statement_syntax
                push    hl
                ld      hl,(EXPR_VALUE)
                call    print_signed
                pop     hl
                jp      statement_print_separator
statement_print_comma_str_done:
                pop     bc
                jp      statement_print_after_item
statement_print_comma_var_done:
                pop     bc
                jp      statement_print_after_item

; Carry set when the input is not a string variable; otherwise prints A$-Z$.
print_string_variable:
                push    hl
                ld      a,(hl)
                call    letter_to_index
                jr      c,print_string_variable_fail
                ld      (VAR_INDEX),a
                inc     hl
                ld      a,(hl)
                cp      '$'
                jr      nz,print_string_variable_fail
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                cp      ';'
                jr      z,print_string_variable_ok
                cp      ','
                jr      z,print_string_variable_ok
                cp      '+'
                jr      z,print_string_variable_ok
                or      a
                jr      nz,print_string_variable_fail
print_string_variable_ok:
                pop     hl
                inc     hl
                inc     hl
                push    hl
                ld      a,(VAR_INDEX)
                ld      l,a
                ld      h,0
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                ld      de,STRING_VARS
                add     hl,de
                ld      b,32
print_string_variable_loop:
                ld      a,(hl)
                or      a
                jr      z,print_string_variable_done
                call    CHPUT
                inc     hl
                djnz    print_string_variable_loop
print_string_variable_done:
                pop     hl
                or      a
                ret
print_string_variable_fail:
                pop     hl
                scf
                ret

print_str_function:
                ld      de,kw_str
                call    match_function
                jr      z,print_str_function_matched
                scf
                ret
print_str_function_matched:
                call    parse_expression
                jr      c,print_str_function_error
                call    skip_spaces
                ld      a,(hl)
                cp      ')'
                jr      nz,print_str_function_error
                inc     hl
                push    hl
                ld      hl,(EXPR_VALUE)
                call    print_signed
                pop     hl
                or      a
                ret
print_str_function_error:
                scf
                ret

statement_let:
                call    skip_spaces
                ld      a,(hl)
                call    letter_to_index
                jp      c,statement_syntax
                ld      (VAR_INDEX),a
                inc     hl
                ld      a,(hl)
                cp      '$'
                jp      z,statement_let_string
statement_let_var:
                call    skip_spaces
                ld      a,(hl)
                cp      '='
                jp      nz,statement_syntax
                inc     hl
                call    parse_expression
                jp      c,statement_syntax
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      a,(VAR_INDEX)
                ld      de,(EXPR_VALUE)
                call    store_numeric_variable
                ret

statement_let_string:
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                cp      '='
                jp      nz,statement_syntax
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                cp      $22
                jp      nz,statement_syntax
                inc     hl
                ld      (STRING_SOURCE),hl
                ld      a,(VAR_INDEX)
                ld      l,a
                ld      h,0
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                ld      de,STRING_VARS
                add     hl,de
                ld      (STRING_DEST),hl
                ld      a,31
                ld      (MATH_COUNT),a
statement_let_string_copy:
                ld      hl,(STRING_SOURCE)
                ld      a,(hl)
                or      a
                jp      z,statement_syntax
                cp      $22
                jr      z,statement_let_string_end
                ld      de,(STRING_DEST)
                ld      (de),a
                inc     de
                ld      (STRING_DEST),de
                inc     hl
                ld      (STRING_SOURCE),hl
                ld      a,(MATH_COUNT)
                dec     a
                ld      (MATH_COUNT),a
                jr      nz,statement_let_string_copy
                ld      a,(hl)
                cp      $22
                jp      nz,statement_syntax
statement_let_string_end:
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      de,(STRING_DEST)
                xor     a
                ld      (de),a
                ret

store_numeric_variable:
                push    hl
                push    de
                ld      a,(VAR_INDEX)
                add     a,a
                ld      e,a
                ld      d,0
                ld      hl,VARIABLES
                add     hl,de
                pop     de
                ld      (hl),e
                inc     hl
                ld      (hl),d
                pop     hl
                ret

statement_list:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      hl,PROGRAM_START
statement_list_loop:
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                inc     hl
                ld      a,d
                cp      $FF
                jr      nz,statement_list_line
                ld      a,e
                cp      $FF
                ret     z
statement_list_line:
                push    hl
                ex      de,hl
                call    print_unsigned
                ld      a,' '
                call    CHPUT
                pop     hl
statement_list_text:
                ld      a,(hl)
                inc     hl
                or      a
                jr      z,statement_list_end
                call    CHPUT
                jr      statement_list_text
statement_list_end:
                call    print_newline
                jr      statement_list_loop

statement_run:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      a,0
                ld      (RUN_STOP),a
                ld      (FLOW_CHANGED),a
                ld      (FLOW_DEPTH),a
                ld      (FOR_DEPTH),a
                ld      hl,PROGRAM_START
                ld      (DATA_SCAN_PTR),hl
                ld      hl,0
                ld      (DATA_ITEM_PTR),hl
                inc     a
                ld      (RUN_ACTIVE),a
                ld      hl,PROGRAM_START
statement_run_loop:
                ld      (PROGRAM_PTR),hl
                ld      a,(hl)
                cp      $FF
                jr      nz,statement_run_line
                inc     hl
                ld      a,(hl)
                cp      $FF
                jr      z,statement_run_done
statement_run_line:
                inc     hl
                inc     hl
                push    hl
                call    execute_statement
                pop     hl
                ld      a,(RUN_STOP)
                or      a
                jr      nz,statement_run_done
                ld      a,(FLOW_CHANGED)
                or      a
                jr      z,statement_run_next
                xor     a
                ld      (FLOW_CHANGED),a
                ld      hl,(FLOW_DEST)
                jr      statement_run_loop
statement_run_next:
                ld      a,(hl)
                inc     hl
                or      a
                jr      nz,statement_run_next
                jr      statement_run_loop
statement_run_done:
                xor     a
                ld      (RUN_ACTIVE),a
                ret

statement_new:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                call    new_program
                ld      hl,VARIABLES
                ld      (hl),0
                ld      de,VARIABLES+1
                ld      bc,51
                ldir
                ld      hl,STRING_VARS
                ld      (hl),0
                ld      de,STRING_VARS+1
                ld      bc,831
                ldir
                ret
statement_cls:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      a,$0C
                call    CHPUT
                ret
statement_screen:
                ld      a,$FF
                ld      (SCREEN_MODE),a
                ld      (SCREEN_SPRITE),a
                ld      (SCREEN_CLICK),a
                call    skip_spaces
                ld      a,(hl)
                or      a
                jr      nz,statement_screen_mode
                xor     a
                ld      (SCREEN_MODE),a
                jr      statement_screen_apply
statement_screen_mode:
                cp      ','
                jr      z,statement_screen_optional_args
                call    parse_expression
                jp      c,statement_syntax
                ld      a,d
                or      a
                jp      nz,statement_screen_invalid
                ld      a,e
                cp      2
                jp      nc,statement_screen_invalid
                ld      (SCREEN_MODE),a
                call    skip_spaces
                ld      a,(hl)
                or      a
                jr      z,statement_screen_apply
                cp      ','
                jp      nz,statement_syntax
statement_screen_optional_args:
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                cp      ','
                jr      z,statement_screen_click_delimiter
                or      a
                jr      z,statement_screen_apply
                call    parse_expression
                jp      c,statement_syntax
                ld      a,d
                or      a
                jp      nz,statement_screen_invalid
                ld      a,e
                cp      2
                jp      nc,statement_screen_invalid
                ld      (SCREEN_SPRITE),a
                call    skip_spaces
                ld      a,(hl)
                or      a
                jr      z,statement_screen_apply
                cp      ','
                jp      nz,statement_syntax
                inc     hl
statement_screen_click_arg:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      z,statement_syntax
                call    parse_expression
                jp      c,statement_syntax
                ld      a,d
                or      a
                jp      nz,statement_screen_invalid
                ld      a,e
                cp      2
                jp      nc,statement_screen_invalid
                ld      (SCREEN_CLICK),a
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                jr      statement_screen_apply
statement_screen_click_delimiter:
                inc     hl
                jr      statement_screen_click_arg
statement_screen_apply:
                ld      a,(SCREEN_CLICK)
                cp      $FF
                jr      z,statement_screen_change_mode
                ld      (CLIKSW),a
statement_screen_change_mode:
                ld      a,(SCREEN_MODE)
                cp      $FF
                jr      z,statement_screen_set_sprite
                call    CHGMOD
statement_screen_set_sprite:
                ld      a,(SCREEN_SPRITE)
                cp      $FF
                ret     z
                ld      a,(SCRMOD)
                cp      1
                ret     nz
                ld      a,(SCREEN_SPRITE)
                or      a
                ld      a,(RG1SAV)
                jr      z,statement_screen_sprite_8x8
                set     1,a
                jr      statement_screen_sprite_write
statement_screen_sprite_8x8:
                res     1,a
statement_screen_sprite_write:
                ld      (RG1SAV),a
                ld      b,a
                ld      c,1
                call    WRTVDP
                ret
statement_screen_invalid:
                ld      hl,screen_argument_error
                jp      print_text
statement_poke:
                call    parse_expression
                jp      c,statement_syntax
                ld      (POKE_ADDRESS),de
                call    skip_spaces
                ld      a,(hl)
                cp      ','
                jp      nz,statement_syntax
                inc     hl
                call    parse_expression
                jp      c,statement_syntax
                call    validate_poke_value
                jp      c,statement_poke_range_error
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      a,e
                ld      (POKE_VALUE),a
                ld      hl,(POKE_ADDRESS)
                ld      a,(POKE_VALUE)
                ld      (hl),a
                ret
statement_vpoke:
                call    parse_expression
                jp      c,statement_syntax
                ld      a,d
                cp      64
                jp      nc,statement_poke_range_error
                ld      (POKE_ADDRESS),de
                call    skip_spaces
                ld      a,(hl)
                cp      ','
                jp      nz,statement_syntax
                inc     hl
                call    parse_expression
                jp      c,statement_syntax
                call    validate_poke_value
                jp      c,statement_poke_range_error
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      a,e
                ld      (POKE_VALUE),a
                ld      hl,(POKE_ADDRESS)
                ld      a,(POKE_VALUE)
                call    WRTVRM
                ret
validate_poke_value:
                bit     7,d
                jr      nz,validate_poke_value_error
                ld      a,d
                or      a
                jr      nz,validate_poke_value_error
                or      a
                ret
validate_poke_value_error:
                scf
                ret
statement_poke_range_error:
                ld      hl,poke_range_error
                jp      print_text
statement_help:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      hl,help_message
                call    print_text
                ret
statement_load:
                ld      a,(RUN_ACTIVE)
                or      a
                jp      nz,file_command_during_run
                jp      load_program
statement_save:
                ld      a,(RUN_ACTIVE)
                or      a
                jp      nz,file_command_during_run
                jp      save_program
statement_bload:
                ld      a,(RUN_ACTIVE)
                or      a
                jp      nz,file_command_during_run
                call    check_dos
                jp      c,dos_required
                ld      a,1
                ld      (FILE_SIGN),a
                call    parse_file_spec
                push    af
                xor     a
                ld      (FILE_SIGN),a
                pop     af
                jp      c,statement_syntax
                call    skip_spaces
                ld      a,(hl)
                cp      ','
                jp      nz,statement_syntax
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                call    uppercase_a
                cp      'R'
                jr      z,statement_bload_ram
                cp      'S'
                jp      nz,statement_syntax
                ld      (TEMP_BYTE),a
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                jr      statement_bload_open
statement_bload_ram:
                ld      (TEMP_BYTE),a
                inc     hl
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
statement_bload_open:
                ld      a,(FILE_STATE)
                or      a
                jr      z,statement_bload_extension_done
                ld      a,'B'
                ld      (FCB+9),a
                ld      a,'I'
                ld      (FCB+10),a
                ld      a,'N'
                ld      (FCB+11),a
statement_bload_extension_done:
                ld      de,FCB
                ld      c,$0F
                call    5
                or      a
                jp      nz,file_not_found
                ld      de,FILE_BUFFER
                ld      c,$1A
                call    5
                ld      a,128
                ld      (FILE_POS),a
                call    file_get_byte
                jp      c,bload_read_error
                cp      $FE
                jp      nz,bload_format_error
                call    file_get_byte
                jp      c,bload_read_error
                ld      (POKE_ADDRESS),a
                call    file_get_byte
                jp      c,bload_read_error
                ld      (POKE_ADDRESS+1),a
                call    file_get_byte
                jp      c,bload_read_error
                ld      (FILE_LENGTH),a
                call    file_get_byte
                jp      c,bload_read_error
                ld      (FILE_LENGTH+1),a
                call    file_get_byte
                jp      c,bload_read_error
                ld      (FILE_OFFSET),a
                call    file_get_byte
                jp      c,bload_read_error
                ld      (FILE_OFFSET+1),a
                ld      a,(TEMP_BYTE)
                cp      'S'
                jr      z,bload_validate_vram
                ld      a,(POKE_ADDRESS+1)
                cp      $C0
                jp      c,bload_range_error
                ld      hl,(POKE_ADDRESS)
                ld      de,$E800
                or      a
                sbc     hl,de
                jr      nc,bload_validate_cpu_end
                ld      hl,(FILE_LENGTH)
                ld      de,$E000
                or      a
                sbc     hl,de
                jp      nc,bload_range_error
bload_validate_cpu_end:
                jr      bload_validate_length
bload_validate_vram:
                ld      a,(POKE_ADDRESS+1)
                and     $C0
                jp      nz,bload_range_error
                ld      a,(FILE_LENGTH+1)
                and     $C0
                jp      nz,bload_range_error
bload_validate_length:
                ld      hl,(FILE_LENGTH)
                ld      de,(POKE_ADDRESS)
                or      a
                sbc     hl,de
                jp      c,bload_range_error
                inc     hl
                ld      a,h
                or      l
                jp      z,bload_range_error
                ld      (FILE_LENGTH),hl
bload_data_loop:
                call    file_get_byte
                jp      c,bload_read_error
                ld      hl,(POKE_ADDRESS)
                ld      a,(TEMP_BYTE)
                cp      'S'
                jr      z,bload_store_vram
                ld      (hl),a
                jr      bload_store_done
bload_store_vram:
                call    WRTVRM
bload_store_done:
                ld      hl,(POKE_ADDRESS)
                inc     hl
                ld      (POKE_ADDRESS),hl
                ld      hl,(FILE_LENGTH)
                dec     hl
                ld      (FILE_LENGTH),hl
                ld      a,h
                or      l
                jr      nz,bload_data_loop
                call    close_file
                or      a
                jp      nz,file_close_error
                ld      a,(TEMP_BYTE)
                cp      'S'
                jr      z,bload_success
                ld      hl,(FILE_OFFSET)
                call    bload_execute_entry
bload_success:
                ld      hl,bload_ok_text
                jp      print_text
bload_execute_entry:
                jp      (hl)
bload_read_error:
                call    close_file
                ld      hl,file_read_error_text
                jp      print_text
bload_format_error:
                call    close_file
                ld      hl,bload_format_error_text
                jp      print_text
bload_range_error:
                call    close_file
                ld      hl,bload_range_error_text
                jp      print_text
statement_def_usr:
                call    skip_spaces
                ld      de,kw_usr
                call    match_keyword
                jp      nz,statement_syntax
                call    skip_spaces
                ld      a,(hl)
                cp      '='
                jp      nz,statement_syntax
                inc     hl
                call    parse_expression
                jp      c,statement_syntax
                ld      (POKE_ADDRESS),de
                call    skip_spaces
                ld      a,(hl)
                or      a
                jp      nz,statement_syntax
                ld      de,(POKE_ADDRESS)
                ld      (USRTAB),de
                ld      a,1
                ld      (USR_DEFINED),a
                ret
file_command_during_run:
                ld      hl,file_command_run_error
                jp      print_text
statement_end:
                call    skip_spaces
                ld      a,(hl)
                or      a
                jr      nz,statement_syntax
                ld      a,1
                ld      (RUN_STOP),a
                ret
statement_syntax:
                ld      a,(RUN_ACTIVE)
                or      a
                jr      z,statement_syntax_immediate
                ld      hl,syntax_error_line
                call    print_text
                ld      hl,(PROGRAM_PTR)
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                ex      de,hl
                call    print_unsigned
                call    print_newline
                ret
statement_syntax_immediate:
                ld      hl,syntax_error
                call    print_text
                ret

; Parse signed 16-bit integer expressions with normal arithmetic precedence.
parse_expression:
                call    parse_term
                ret     c
                ld      (EXPR_VALUE),de
parse_expression_next:
                call    skip_spaces
                ld      a,(hl)
                cp      '+'
                jr      z,parse_expression_add
                cp      '-'
                jr      z,parse_expression_sub
                or      a
                ret
parse_expression_add:
                xor     a
                ld      (EXPR_OPERATOR),a
                jr      parse_expression_operand
parse_expression_sub:
                ld      a,1
                ld      (EXPR_OPERATOR),a
parse_expression_operand:
                inc     hl
                call    parse_term
                ret     c
                ld      bc,(EXPR_VALUE)
                ld      a,(EXPR_OPERATOR)
                or      a
                jr      nz,parse_expression_subtract
                ex      de,hl
                add     hl,bc
                ex      de,hl
                jr      parse_expression_save
parse_expression_subtract:
                ld      hl,(EXPR_VALUE)
                or      a
                sbc     hl,de
                ex      de,hl
parse_expression_save:
                ld      (EXPR_VALUE),de
                jr      parse_expression_next

parse_term:
                call    parse_atom
                ret     c
                ld      (TERM_VALUE),de
parse_term_next:
                call    skip_spaces
                ld      a,(hl)
                cp      '*'
                jr      z,parse_term_multiply
                cp      '/'
                jr      z,parse_term_divide
                call    match_mod_operator
                jr      z,parse_term_modulo
                ld      de,(TERM_VALUE)
                or      a
                ret
parse_term_multiply:
                xor     a
                ld      (TERM_OPERATOR),a
                jr      parse_term_operand
parse_term_divide:
                ld      a,1
                ld      (TERM_OPERATOR),a
                jr      parse_term_operand
parse_term_modulo:
                ld      a,2
                ld      (TERM_OPERATOR),a
parse_term_operand:
                inc     hl
                call    parse_atom
                ret     c
                ld      (MATH_RIGHT),de
                ld      hl,(TERM_VALUE)
                ld      (MATH_LEFT),hl
                ld      a,(TERM_OPERATOR)
                or      a
                jr      nz,parse_term_check_modulo
                call    multiply_signed
                jr      parse_term_result
parse_term_check_modulo:
                cp      2
                jr      z,parse_term_do_modulo
                call    divide_signed
                ret     c
                jr      parse_term_result
parse_term_do_modulo:
                ld      a,(MATH_LEFT+1)
                and     $80
                ld      (OUTER_SIGN),a
                call    divide_signed
                ret     c
                ld      hl,(MATH_REMAINDER)
                ld      a,(OUTER_SIGN)
                or      a
                call    nz,negate_hl
                ex      de,hl
                jr      parse_term_result
parse_term_result:
                ld      (TERM_VALUE),de
                jr      parse_term_next

match_mod_operator:
                push    hl
                ld      de,kw_mod
                call    match_keyword
                jr      nz,match_mod_operator_fail
                ld      a,(hl)
                call    uppercase_a
                cp      '$'
                jr      z,match_mod_operator_fail
                cp      'A'
                jr      c,match_mod_operator_ok
                cp      'Z'+1
                jr      c,match_mod_operator_fail
match_mod_operator_ok:
                pop     bc
                xor     a
                ret
match_mod_operator_fail:
                pop     hl
                ld      a,1
                or      a
                ret

multiply_signed:
                ld      hl,(MATH_LEFT)
                ld      de,(MATH_RIGHT)
                ld      a,h
                xor     d
                and     $80
                ld      (MATH_SIGN),a
                bit     7,h
                call    nz,negate_hl
                ld      (MATH_LEFT),hl
                ex      de,hl
                bit     7,h
                call    nz,negate_hl
                ld      (MATH_RIGHT),hl
                ld      hl,0
                ld      (MATH_RESULT),hl
                ld      b,16
multiply_signed_loop:
                ld      hl,(MATH_RIGHT)
                bit     0,l
                jr      z,multiply_signed_shift
                ld      hl,(MATH_RESULT)
                ld      de,(MATH_LEFT)
                add     hl,de
                ld      (MATH_RESULT),hl
multiply_signed_shift:
                ld      hl,(MATH_RIGHT)
                srl     h
                rr      l
                ld      (MATH_RIGHT),hl
                ld      hl,(MATH_LEFT)
                add     hl,hl
                ld      (MATH_LEFT),hl
                djnz    multiply_signed_loop
                ld      hl,(MATH_RESULT)
                ld      a,(MATH_SIGN)
                or      a
                call    nz,negate_hl
                ex      de,hl
                or      a
                ret

divide_signed:
                ld      hl,(MATH_LEFT)
                ld      de,(MATH_RIGHT)
                ld      a,h
                xor     d
                and     $80
                ld      (MATH_SIGN),a
                bit     7,h
                call    nz,negate_hl
                ld      (MATH_LEFT),hl
                ex      de,hl
                bit     7,h
                call    nz,negate_hl
                ld      (MATH_RIGHT),hl
                ld      a,h
                or      l
                jr      nz,divide_signed_start
                scf
                ret
divide_signed_start:
                ld      hl,0
                ld      (MATH_RESULT),hl
                ld      (MATH_REMAINDER),hl
                ld      b,16
divide_signed_loop:
                ld      hl,(MATH_LEFT)
                add     hl,hl
                ld      (MATH_LEFT),hl
                ld      a,0
                adc     a,0
                ld      (MATH_CARRY),a
                ld      hl,(MATH_REMAINDER)
                add     hl,hl
                ld      a,(MATH_CARRY)
                or      a
                jr      z,divide_signed_no_carry
                inc     hl
divide_signed_no_carry:
                ld      (MATH_REMAINDER),hl
                ld      hl,(MATH_RESULT)
                add     hl,hl
                ld      (MATH_RESULT),hl
                ld      de,(MATH_RIGHT)
                ld      hl,(MATH_REMAINDER)
                or      a
                sbc     hl,de
                jr      c,divide_signed_next
                ld      (MATH_REMAINDER),hl
                ld      hl,(MATH_RESULT)
                inc     hl
                ld      (MATH_RESULT),hl
divide_signed_next:
                djnz    divide_signed_loop
                ld      hl,(MATH_RESULT)
                ld      a,(MATH_SIGN)
                or      a
                call    nz,negate_hl
                ex      de,hl
                or      a
                ret

negate_hl:
                xor     a
                sub     l
                ld      l,a
                ld      a,0
                sbc     a,h
                ld      h,a
                ret

; Parse one decimal number, variable or parenthesized-free unary minus atom.
; Returns DE=value, HL=next byte, carry set on invalid input.
parse_atom:
                call    skip_spaces
                ld      a,(hl)
                cp      '-'
                jr      nz,parse_atom_positive
                ld      a,1
                ld      (EXPR_SIGN),a
                inc     hl
                call    skip_spaces
                jr      parse_atom_value
parse_atom_positive:
                xor     a
                ld      (EXPR_SIGN),a
parse_atom_value:
                ld      de,kw_abs
                call    match_function
                jr      z,parse_function_abs
                ld      de,kw_sgn
                call    match_function
                jr      z,parse_function_sgn
                ld      de,kw_int
                call    match_function
                jr      z,parse_function_int
                ld      de,kw_sqr
                call    match_function
                jr      z,parse_function_sqr
                ld      de,kw_len
                call    match_function
                jr      z,parse_function_len
                ld      de,kw_val
                call    match_function
                jr      z,parse_function_val
                ld      de,kw_peek
                call    match_function
                jp      z,parse_function_peek
                ld      de,kw_vpeek
                call    match_function
                jp      z,parse_function_vpeek
                ld      de,kw_usr
                call    match_function
                jp      z,parse_function_usr_start
                ld      a,(hl)
                cp      '('
                jp      nz,parse_atom_numeric
                ld      a,(EXPR_SIGN)
                push    af
                inc     hl
                call    parse_expression
                jr      c,parse_atom_parenthesis_error
                ld      a,(hl)
                cp      ')'
                jr      nz,parse_atom_parenthesis_error
                inc     hl
                ld      de,(EXPR_VALUE)
                pop     af
                ld      (EXPR_SIGN),a
                jp      parse_atom_sign
parse_atom_parenthesis_error:
                pop     af
                jp      parse_atom_error
parse_function_abs:
                ld      a,1
                jr      parse_function_start
parse_function_sgn:
                ld      a,2
                jr      parse_function_start
parse_function_int:
                ld      a,3
                jr      parse_function_start
parse_function_sqr:
                ld      a,5
                jr      parse_function_start
parse_function_len:
                ld      a,4
                push    af
                ld      a,(EXPR_SIGN)
                push    af
                call    parse_string_length
                jp      c,parse_function_error
                ld      (EXPR_VALUE),de
                jr      parse_function_close
parse_function_val:
                ld      a,6
                push    af
                ld      a,(EXPR_SIGN)
                push    af
                call    parse_val_number
                jp      c,parse_function_error
                ld      (EXPR_VALUE),de
                jr      parse_function_close
parse_function_peek:
                ld      a,7
                jr      parse_function_memory_start
parse_function_vpeek:
                ld      a,8
                jr      parse_function_memory_start
parse_function_usr_start:
                ld      a,9
parse_function_memory_start:
                push    af
                ld      a,(EXPR_SIGN)
                push    af
                call    parse_expression
                jp      c,parse_function_error
                ld      (EXPR_VALUE),de
                jr      parse_function_close
parse_function_start:
                push    af
                ld      a,(EXPR_SIGN)
                push    af
                call    parse_expression
                jp      c,parse_function_error
                ld      de,(EXPR_VALUE)
parse_function_close:
                call    skip_spaces
                ld      a,(hl)
                cp      ')'
                jp      nz,parse_function_error
                inc     hl
                pop     af
                ld      (EXPR_SIGN),a
                pop     af
                cp      1
                jp      nz,parse_function_not_abs
                bit     7,d
                call    nz,negate_de
                jp      parse_function_done
parse_function_not_abs:
                cp      2
                jp      nz,parse_function_not_sgn
                ld      a,d
                or      e
                jp      z,parse_function_done
                bit     7,d
                jp      nz,parse_function_negative
                ld      de,1
                jp      parse_function_done
parse_function_negative:
                ld      de,$FFFF
                jp      parse_function_done
parse_function_not_sgn:
                cp      5
                jp      nz,parse_function_not_sqr
                bit     7,d
                jp      nz,parse_function_math_error
                ld      (MATH_LEFT),de
                ld      hl,0
                ld      (MATH_RESULT),hl
                ld      hl,1
                ld      (MATH_RIGHT),hl
parse_sqr_loop:
                ld      hl,(MATH_LEFT)
                ld      de,(MATH_RIGHT)
                or      a
                sbc     hl,de
                jr      c,parse_sqr_done
                ld      (MATH_LEFT),hl
                ld      hl,(MATH_RESULT)
                inc     hl
                ld      (MATH_RESULT),hl
                ld      hl,(MATH_RIGHT)
                inc     hl
                inc     hl
                ld      (MATH_RIGHT),hl
                jr      parse_sqr_loop
parse_sqr_done:
                ld      de,(MATH_RESULT)
                jp      parse_function_done
parse_function_not_sqr:
                cp      7
                jp      z,parse_function_peek_value
                cp      8
                jp      z,parse_function_vpeek_value
                cp      9
                jp      z,parse_function_usr
                jp      parse_function_done
parse_function_vpeek_value:
                ld      a,d
                cp      64
                jp      nc,parse_function_math_error
                push    hl
                ex      de,hl
                call    RDVRM
                pop     hl
                ld      e,a
                ld      d,0
                jp      parse_function_done
parse_function_usr:
                ld      a,(USR_DEFINED)
                or      a
                jp      z,parse_function_math_error
                ld      (DAC+2),de
                ld      a,2
                ld      (VALTYP),a
                push    hl
                ld      hl,usr_call_return
                push    hl
                ld      hl,(USRTAB)
                jp      (hl)
usr_call_return:
                ld      de,(DAC+2)
                ld      a,2
                ld      (VALTYP),a
                pop     hl
                jp      parse_function_done
parse_function_peek_value:
                push    hl
                ex      de,hl
                ld      a,(hl)
                pop     hl
                ld      e,a
                ld      d,0
parse_function_done:
                jp      parse_atom_sign
parse_function_math_error:
                scf
                ret
parse_function_error:
                pop     af
                pop     af
                jp      parse_atom_error

parse_string_length:
                call    skip_spaces
                ld      a,(hl)
                cp      $22
                jr      z,parse_string_length_literal
                call    letter_to_index
                jr      c,parse_string_length_error
                ld      b,a
                inc     hl
                ld      a,(hl)
                cp      '$'
                jr      nz,parse_string_length_error
                inc     hl
                ld      a,b
                ld      l,a
                ld      h,0
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                ld      de,STRING_VARS
                add     hl,de
                ld      bc,0
parse_string_length_var_loop:
                ld      a,(hl)
                or      a
                jr      z,parse_string_length_done
                inc     hl
                inc     bc
                jr      parse_string_length_var_loop
parse_string_length_literal:
                inc     hl
                ld      bc,0
parse_string_length_lit_loop:
                ld      a,(hl)
                or      a
                jr      z,parse_string_length_error
                cp      $22
                jr      z,parse_string_length_lit_done
                inc     hl
                inc     bc
                jr      parse_string_length_lit_loop
parse_string_length_lit_done:
                inc     hl
parse_string_length_done:
                ld      d,b
                ld      e,c
                or      a
                ret
parse_string_length_error:
                scf
                ret

parse_val_number:
                call    copy_string_argument
                ret     c
                push    hl
                ld      hl,LINEBUF
                call    parse_expression
                jr      c,parse_val_number_error
                call    skip_spaces
                ld      a,(hl)
                or      a
                jr      nz,parse_val_number_error
                ld      de,(EXPR_VALUE)
                pop     hl
                or      a
                ret
parse_val_number_error:
                pop     hl
                scf
                ret

copy_string_argument:
                call    skip_spaces
                ld      (VAL_RETURN),hl
                ld      hl,0
                ld      (TEXT_POS),hl
                ld      hl,(VAL_RETURN)
                ld      a,(hl)
                cp      $22
                jr      z,copy_string_literal
                call    letter_to_index
                jr      c,copy_string_argument_error
                ld      (VAR_INDEX),a
                inc     hl
                ld      a,(hl)
                cp      '$'
                jr      nz,copy_string_argument_error
                inc     hl
                push    hl
                ld      a,(VAR_INDEX)
                ld      l,a
                ld      h,0
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                ld      de,STRING_VARS
                add     hl,de
copy_string_variable_loop:
                ld      a,(hl)
                or      a
                jr      z,copy_string_variable_done
                call    buffer_append
                jr      c,copy_string_argument_stack_error
                inc     hl
                jr      copy_string_variable_loop
copy_string_variable_done:
                pop     hl
                jr      copy_string_argument_end
copy_string_literal:
                inc     hl
copy_string_literal_loop:
                ld      a,(hl)
                or      a
                jr      z,copy_string_argument_error
                cp      $22
                jr      z,copy_string_literal_done
                call    buffer_append
                jr      c,copy_string_argument_error
                inc     hl
                jr      copy_string_literal_loop
copy_string_literal_done:
                inc     hl
copy_string_argument_end:
                xor     a
                call    buffer_append
                ret
copy_string_argument_stack_error:
                pop     de
                scf
                ret
copy_string_argument_error:
                scf
                ret
parse_atom_numeric:
                ld      a,(hl)
                cp      '&'
                jp      z,parse_atom_radix
                cp      '0'
                jp      c,parse_atom_variable
                cp      '9'+1
                jp      nc,parse_atom_variable
                ld      bc,0
parse_atom_number:
                ld      a,(hl)
                cp      '0'
                jr      c,parse_atom_number_done
                cp      '9'+1
                jr      nc,parse_atom_number_done
                sub     '0'
                ld      (TEMP_BYTE),a
                push    hl
                ld      h,b
                ld      l,c
                add     hl,hl
                push    hl
                add     hl,hl
                add     hl,hl
                pop     de
                add     hl,de
                ld      a,(TEMP_BYTE)
                ld      e,a
                ld      d,0
                add     hl,de
                ld      b,h
                ld      c,l
                pop     hl
                inc     hl
                jr      parse_atom_number
parse_atom_number_done:
                ld      d,b
                ld      e,c
                jp      parse_atom_sign
parse_atom_radix:
                inc     hl
                ld      a,(hl)
                call    uppercase_a
                cp      'H'
                jr      z,parse_atom_hex_prefix
                cp      'B'
                jr      z,parse_atom_binary_prefix
                jp      parse_atom_error
parse_atom_hex_prefix:
                ld      a,16
                jr      parse_atom_radix_start
parse_atom_binary_prefix:
                ld      a,2
parse_atom_radix_start:
                ld      (MATH_COUNT),a
                inc     hl
                ld      (VAL_RETURN),hl
                ld      de,0
                ld      (MATH_LEFT),de
                xor     a
                ld      (MATH_CARRY),a
parse_atom_radix_loop:
                ld      hl,(VAL_RETURN)
                ld      a,(hl)
                call    uppercase_a
                cp      '0'
                jr      c,parse_atom_radix_done
                cp      '9'+1
                jr      c,parse_atom_radix_decimal
                cp      'A'
                jr      c,parse_atom_radix_done
                cp      'F'+1
                jr      nc,parse_atom_radix_done
                sub     'A'-10
                jr      parse_atom_radix_digit
parse_atom_radix_decimal:
                sub     '0'
parse_atom_radix_digit:
                ld      b,a
                ld      a,(MATH_COUNT)
                cp      2
                ld      a,b
                jp      z,parse_atom_binary_digit_check
                jr      parse_atom_radix_store_digit
parse_atom_binary_digit_check:
                cp      2
                jp      nc,parse_atom_error
parse_atom_radix_store_digit:
                ld      (TEMP_BYTE),a
                ld      a,(MATH_COUNT)
                cp      2
                jr      z,parse_atom_radix_shift_binary
                ld      hl,(MATH_LEFT)
                add     hl,hl
                add     hl,hl
                add     hl,hl
                add     hl,hl
                jr      parse_atom_radix_add_digit
parse_atom_radix_shift_binary:
                ld      hl,(MATH_LEFT)
                add     hl,hl
parse_atom_radix_add_digit:
                ld      a,(TEMP_BYTE)
                ld      e,a
                ld      d,0
                add     hl,de
                ld      (MATH_LEFT),hl
                ld      a,1
                ld      (MATH_CARRY),a
                ld      hl,(VAL_RETURN)
                inc     hl
                ld      (VAL_RETURN),hl
                jr      parse_atom_radix_loop
parse_atom_radix_done:
                ld      a,(MATH_CARRY)
                or      a
                jp      z,parse_atom_error
                ld      hl,(VAL_RETURN)
                push    hl
                ld      de,(MATH_LEFT)
                pop     hl
                jr      parse_atom_sign
parse_atom_variable:
                call    letter_to_index
                jr      c,parse_atom_error
                add     a,a
                ld      e,a
                ld      d,0
                push    hl
                ld      hl,VARIABLES
                add     hl,de
                ld      e,(hl)
                inc     hl
                ld      d,(hl)
                pop     hl
                inc     hl
parse_atom_sign:
                ld      a,(EXPR_SIGN)
                or      a
                ret     z
                ex      de,hl
                xor     a
                sub     l
                ld      l,a
                ld      a,0
                sbc     a,h
                ld      h,a
                ex      de,hl
                or      a
                ret
parse_atom_error:
                scf
                ret

match_function:
                push    hl
match_function_loop:
                ld      a,(de)
                or      a
                jr      z,match_function_end
                ld      a,(de)
                ld      c,a
                ld      a,(hl)
                call    uppercase_a
                cp      c
                jr      nz,match_function_fail
                inc     hl
                inc     de
                jr      match_function_loop
match_function_end:
                ld      a,(hl)
                cp      '('
                jr      nz,match_function_fail
                inc     hl
                pop     bc
                xor     a
                ret
match_function_fail:
                pop     hl
                ld      a,1
                or      a
                ret

negate_de:
                ex      de,hl
                call    negate_hl
                ex      de,hl
                ret

; Compare the input at HL with the keyword at DE, case-insensitively.
; On success, Z is set and HL points after the keyword. Failure restores HL.
match_keyword:
                push    hl
match_keyword_loop:
                ld      a,(de)
                or      a
                jr      z,match_keyword_end
                ld      a,(de)
                ld      c,a
                ld      a,(hl)
                call    uppercase_a
                cp      c
                jr      nz,match_keyword_fail
                inc     hl
                inc     de
                jr      match_keyword_loop
match_keyword_end:
match_keyword_ok:
                pop     bc
                xor     a
                ret
match_keyword_fail:
                pop     hl
                ld      a,1
                or      a
                ret

letter_to_index:
                call    uppercase_a
                cp      'A'
                jr      c,letter_invalid
                cp      'Z'+1
                jr      nc,letter_invalid
                sub     'A'
                or      a
                ret
letter_invalid:
                scf
                ret

uppercase_a:
                cp      'a'
                ret     c
                cp      'z'+1
                ret     nc
                sub     $20
                ret

skip_spaces:
                ld      a,(hl)
                cp      ' '
                ret     nz
                inc     hl
                jr      skip_spaces

string_length:
                ld      bc,0
string_length_loop:
                ld      a,(hl)
                inc     hl
                inc     bc
                or      a
                jr      nz,string_length_loop
                ret

new_program:
                ld      hl,PROGRAM_START
                ld      (PGMEND),hl
                ld      (DATA_SCAN_PTR),hl
                ld      hl,0
                ld      (DATA_ITEM_PTR),hl
                ld      hl,PROGRAM_START
                ld      (hl),$FF
                inc     hl
                ld      (hl),$FF
                ret

print_text:
                ld      a,(hl)
                or      a
                ret     z
                call    CHPUT
                inc     hl
                jr      print_text

print_newline:
                ld      a,$0D
                call    CHPUT
                ld      a,$0A
                call    CHPUT
                ret

; Print signed HL in decimal without leading zeroes.
print_signed:
                bit     7,h
                jr      z,print_unsigned
                push    hl
                ld      a,'-'
                call    CHPUT
                pop     hl
                xor     a
                sub     l
                ld      l,a
                ld      a,0
                sbc     a,h
                ld      h,a

print_unsigned:
                ld      d,0
                ld      bc,10000
                call    decimal_digit
                call    emit_digit
                ld      bc,1000
                call    decimal_digit
                call    emit_digit
                ld      bc,100
                call    decimal_digit
                call    emit_digit
                ld      bc,10
                call    decimal_digit
                call    emit_digit
                ld      a,l
                add     a,'0'
                call    CHPUT
                ret

decimal_digit:
                xor     a
decimal_digit_loop:
                push    af
                or      a
                sbc     hl,bc
                jr      c,decimal_digit_done
                pop     af
                inc     a
                jr      decimal_digit_loop
decimal_digit_done:
                add     hl,bc
                pop     af
                ret

emit_digit:
                or      a
                jr      nz,emit_digit_nonzero
                bit     0,d
                ret     z
                jr      emit_digit_output
emit_digit_nonzero:
                ld      d,1
emit_digit_output:
                add     a,'0'
                call    CHPUT
                ret

; Return the RAM slot currently assigned to page 3 in A.
make_ramslot:
                call    RSLREG
                rlca
                rlca
                and     $03
                ld      c,a
                ld      b,0
                ld      ix,EXPTBL
                add     ix,bc
                ld      e,a
                ld      a,(ix)
                and     $80
                jr      z,make_ramslot_primary
                or      e
                ld      e,a
                inc     ix
                inc     ix
                inc     ix
                inc     ix
                ld      a,(ix)
                rrca
                rrca
                rrca
                rrca
                and     $0C
                or      e
                ret
make_ramslot_primary:
                ld      a,e
                ret

start_message:
                db      "C-BASIC 0.14",$0D,$0A
                db      "Integer BASIC for C-BIOS",$0D,$0A
                db      "Type HELP for commands.",$0D,$0A,$00
ok_prompt:      db      "Ok",$0D,$0A,$00
syntax_error:   db      "?SYNTAX ERROR",$0D,$0A,$00
syntax_error_line: db   "?SYNTAX ERROR IN LINE ",$00
out_of_memory:  db      "?OUT OF MEMORY",$0D,$0A,$00
help_message:
                db      "PRINT expr or ",$22,"text",$22,$0D,$0A
                db      "LET A=expr; A=expr",$0D,$0A
                db      "Numbered lines, LIST, RUN, NEW",$0D,$0A
                db      "DEF USR=address; USR(expression)",$0D,$0A
                db      "DATA; READ A,A$; RESTORE [line]",$0D,$0A
                db      "LOAD ",$22,"file.bas",$22,"; SAVE ",$22,"file.bas",$22,$0D,$0A
                db      "BLOAD ",$22,"file.bin",$22,",R or ,S",$0D,$0A
                db      "INPUT A/A$; IF; GOTO; GOSUB; RETURN",$0D,$0A
                db      "FOR/NEXT; A$-Z$ strings; LEN, STR$, VAL",$0D,$0A
                db      "ABS, SGN, INT, SQR; + - * / and parentheses",$0D,$0A
                db      "SCREEN 0/1; click: SCREEN ,,0/1",$0D,$0A
                db      "PEEK/VPEEK; POKE/VPOKE",$0D,$0A
                db      "Arrows edit; UP recalls previous command.",$0D,$0A,$00
load_ok:        db      "Loaded",$0D,$0A,$00
save_ok:        db      "Saved",$0D,$0A,$00
dos_required_text:
                db      "?MSX-DOS REQUIRED",$0D,$0A,$00
file_not_found_text:
                db      "?FILE NOT FOUND",$0D,$0A,$00
file_read_error_text:
                db      "?FILE READ ERROR",$0D,$0A,$00
file_write_error_text:
                db      "?FILE WRITE ERROR",$0D,$0A,$00
file_format_error_text:
                db      "?UNSUPPORTED BASIC FILE",$0D,$0A,$00
file_close_error_text:
                db      "?FILE CLOSE ERROR",$0D,$0A,$00
bload_ok_text:
                db      "Loaded",$0D,$0A,$00
bload_format_error_text:
                db      "?INVALID BINARY FILE",$0D,$0A,$00
bload_range_error_text:
                db      "?BLOAD ADDRESS OUT OF RANGE",$0D,$0A,$00
file_command_run_error:
                db      "?LOAD/SAVE/BLOAD NOT ALLOWED IN RUN",$0D,$0A,$00
poke_range_error:
                db      "?ADDRESS OR VALUE OUT OF RANGE",$0D,$0A,$00
screen_argument_error:
                db      "?SCREEN MODE/OPTION OUT OF RANGE",$0D,$0A,$00
line_error:     db      "?UNDEFINED LINE",$0D,$0A,$00
return_error:   db      "?RETURN WITHOUT GOSUB",$0D,$0A,$00
gosub_stack_error: db   "?GOSUB NESTING TOO DEEP",$0D,$0A,$00
for_stack_error: db    "?FOR NESTING TOO DEEP",$0D,$0A,$00
next_error:     db      "?NEXT WITHOUT FOR",$0D,$0A,$00
next_mismatch_error: db "?NEXT VARIABLE MISMATCH",$0D,$0A,$00
next_variable_error: db "?INVALID NEXT VARIABLE",$0D,$0A,$00
next_trailing_error: db "?EXTRA TEXT AFTER NEXT",$0D,$0A,$00
out_of_data_error:
                db      "?OUT OF DATA",$0D,$0A,$00
text_end:       db      "END",0
text_let:       db      "LET",0
text_run:       db      "RUN",0
text_print:     db      "PRINT",0
text_list:      db      "LIST",0
text_new:       db      "NEW",0
text_cls:       db      "CLS",0
text_screen:    db      "SCREEN",0
text_poke:      db      "POKE",0
text_vpoke:     db      "VPOKE",0
text_rem:       db      "REM",0
text_input:     db      "INPUT",0
text_if:        db      "IF",0
text_goto:      db      "GOTO",0
text_gosub:     db      "GOSUB",0
text_return:    db      "RETURN",0
text_then:      db      "THEN",0
text_for:       db      "FOR",0
text_next:      db      "NEXT",0
text_to:        db      "TO",0
text_step:      db      "STEP",0
text_abs:       db      "ABS",0
text_sgn:       db      "SGN",0
text_int:       db      "INT",0
text_sqr:       db      "SQR",0
text_len:       db      "LEN",0
text_str:       db      "STR$",0
text_val:       db      "VAL",0
text_peek:      db      "PEEK",0
text_vpeek:     db      "VPEEK",0
text_bload:     db      "BLOAD",0
text_def:       db      "DEF",0
text_usr:       db      "USR",0
text_data:      db      "DATA",0
text_read:      db      "READ",0
text_restore:   db      "RESTORE",0

; Tokenized statement codes accepted by the importer.
token_keyword_table:
                db      $81
                dw      text_end
                db      $88
                dw      text_let
                db      $8A
                dw      text_run
                db      $91
                dw      text_print
                db      $93
                dw      text_list
                db      $94
                dw      text_new
                db      $9F
                dw      text_cls
                db      $C5
                dw      text_screen
                db      $98
                dw      text_poke
                db      $C6
                dw      text_vpoke
                db      $CF
                dw      text_bload
                db      $97
                dw      text_def
                db      $DD
                dw      text_usr
                db      $84
                dw      text_data
                db      $87
                dw      text_read
                db      $8C
                dw      text_restore
                db      $85
                dw      text_input
                db      $8B
                dw      text_if
                db      $89
                dw      text_goto
                db      $8D
                dw      text_gosub
                db      $8E
                dw      text_return
                db      $DA
                dw      text_then
                db      $82
                dw      text_for
                db      $83
                dw      text_next
                db      $D9
                dw      text_to
                db      $DF
                dw      text_step
                db      0
                dw      0

extended_token_table:
                db      $84
                dw      text_sgn
                db      $85
                dw      text_int
                db      $86
                dw      text_abs
                db      $87
                dw      text_sqr
                db      $92
                dw      text_len
                db      $93
                dw      text_str
                db      $94
                dw      text_val
                db      $97
                dw      text_peek
                db      $98
                dw      text_vpeek
                db      0
                dw      0

operator_decode_table:
                db      '>'
                db      '='
                db      '<'
                db      '+'
                db      '-'
                db      '*'
                db      '/'
                db      '^'

kw_print:       db      "PRINT",0
kw_let:         db      "LET",0
kw_list:        db      "LIST",0
kw_run:         db      "RUN",0
kw_new:         db      "NEW",0
kw_cls:         db      "CLS",0
kw_screen:      db      "SCREEN",0
kw_poke:        db      "POKE",0
kw_vpoke:       db      "VPOKE",0
kw_help:        db      "HELP",0
kw_end:         db      "END",0
kw_rem:         db      "REM",0
kw_load:        db      "LOAD",0
kw_save:        db      "SAVE",0
kw_input:       db      "INPUT",0
kw_if:          db      "IF",0
kw_goto:        db      "GOTO",0
kw_gosub:       db      "GOSUB",0
kw_return:      db      "RETURN",0
kw_then:        db      "THEN",0
kw_for:         db      "FOR",0
kw_next:        db      "NEXT",0
kw_to:          db      "TO",0
kw_step:        db      "STEP",0
kw_mod:         db      "MOD",0
kw_abs:         db      "ABS",0
kw_sgn:         db      "SGN",0
kw_int:         db      "INT",0
kw_sqr:         db      "SQR",0
kw_len:         db      "LEN",0
kw_str:         db      "STR$",0
kw_val:         db      "VAL",0
kw_peek:        db      "PEEK",0
kw_vpeek:       db      "VPEEK",0
kw_bload:       db      "BLOAD",0
kw_def:         db      "DEF",0
kw_usr:         db      "USR",0
kw_data:        db      "DATA",0
kw_read:        db      "READ",0
kw_restore:     db      "RESTORE",0

                ds      $8000-$,$FF
