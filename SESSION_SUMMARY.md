# C-BASIC Session Summary

Workspace: `/Users/vampier/Desktop/cbios-0.29a`

This note captures the C-BASIC and keyboard work completed in this conversation
so it can be continued in a fresh session. The workspace is not a Git
repository.

## Implemented C-BASIC features

- Expanded the integer BASIC subset with control flow, loops, strings and
  functions, MSX-DOS FCB-based `LOAD`/`SAVE`, screen mode/click options, and
  memory access features.
- Added `POKE`, `VPOKE`, `PEEK(...)`, and `VPEEK(...)` parsing, statement
  dispatch, tokenization, and import token tables in `src/basic.asm`.
  - POKE/PEEK use 16-bit CPU addresses.
  - Negative POKE/PEEK addresses wrap naturally; `POKE -1,170` addresses
    `$FFFF`.
  - VPOKE/VPEEK support VRAM addresses 0-16383; writes accept byte values
    0-255.
  - Use `PEEK`/`VPEEK` as expressions, e.g. `PRINT PEEK(0)`.
- Added infix integer `MOD` with the same precedence as `*` and `/`.
  Remainder follows the dividend sign (`-5 MOD 2` -> `-1`).
- Updated `doc/cbasic.txt` with commands, limits, examples, memory ranges,
  screen and keyclick behavior, editing controls, and key-repeat expectations.
- Added immediate-mode `BLOAD "file",R` and `BLOAD "file",S` in `src/basic.asm`.
  The loader reads the standard `$FE` binary header and loads RAM payloads
  before transferring to the execution address, or writes payloads to VRAM
  without execution. It defaults to `.BIN`, checks the destination range,
  rejects truncated data, and closes the DOS file on errors. RAM loads are
  limited to `$C000-$FFFF` while excluding C-BASIC's `$E000-$E7FF` work area;
  VRAM loads are limited to `$0000-$3FFF`.
- Added BLOAD tokenization/import support for token `$CF`, and documented its
  syntax and limits in `doc/cbasic.txt`. BLOAD is currently immediate-only;
  actual DOS file loading still needs runtime verification.
- Added `DEF USR=address` and integer `USR(expression)` support in
  `src/basic.asm`, including tokenization/import using the MSX tokens `$97`
  (`DEF`) and `$DD` (`USR`). USR passes/returns an integer through `DAC+2`
  with `VALTYP=2`, using `USRTAB` for its entry address. USR cannot run before
  DEF has assigned the entry point.
- Added `DATA`, `READ`, and `RESTORE [line]` to `src/basic.asm`. DATA fields
  are read sequentially across stored program lines; RUN and NEW reset the
  cursor, and RESTORE resets it to the first DATA line at or after its optional
  line number. READ supports the interpreter's numeric and string scalar
  variables, including quoted strings with commas. Added standard MSX token
  import/export handling for DATA `$84`, READ `$87`, and RESTORE `$8C`, HELP
  text, and usage documentation.
- Added hexadecimal (`&H...`) and binary (`&B...`) integer literals to the
  expression parser. Tokenization preserves these forms in stored program
  lines, and the BASIC file importer handles MSX's `$0C` hexadecimal constant
  token. `&HFF` and `&B11111111` both evaluate to 255; invalid binary digits
  are rejected.
- Runtime-tested literals in openMSX: direct expressions, lowercase hex,
  arithmetic, assignments and stored `DATA`/`READ` values all worked. Both
  invalid `&B2` and correct values were confirmed from emulator screen output.
- Runtime-verified DATA/READ/RESTORE in the installed openMSX app
  (`/Applications/openMSX.app/Contents/MacOS/openmsx`) using the packaged
  BASIC ROM. Numeric values, quoted strings with commas, bare strings, reads
  spanning DATA lines, `RESTORE` and `RESTORE line`, and `?OUT OF DATA` all
  behaved as expected. openMSX `type` needed a slower frequency (`-freq 5`)
  to avoid dropped keys with the BIOS keyboard debounce.
- C-BASIC startup requests a visible underline cursor via `CSRSW`/`CSTYLE`.

## Keyboard editor and repeat work

- The command line editor supports insertion, cursor movement, Backspace,
  Delete, and Up-arrow history.
- Typing at the end of the input line was optimized to append just the new
  character; middle edits redraw the changed suffix.
- Backspace redraw logic was revised to delete before the cursor.
- The earlier C-BIOS repeat implementation repeatedly cleared `OLDKEY` and
  rescanned the matrix to fake another key-down. This has now been replaced by
  tracking one printable physical key (`KEYRPT_CHAR`, row, and active-low bit
  mask in `src/systemvars.asm` at `$F380-$F383`).
- Keyboard matrix scans still detect key-down edges through `NEWKEY` versus
  `OLDKEY`; only a real key-down queues the initial character. Repeat checks
  the tracked physical key's actual `NEWKEY` bit, stops on key-up, and inserts
  the cached character after the delay without changing `OLDKEY`.
- The latest keyboard scanner accepts a transition after two matching scans.
  Current repeat constants in `src/main.asm`: initial delay 60 scan ticks and
  repeat interval 12 ticks. Runtime verification is still needed on the user's
  machine.
- The implementation reserves `$F380-$F383`, previously marked for disabled
  interslot helper routines. If those helper entry points are enabled later,
  relocate this private state.
- User reports:
  - Typing `CLS` produced duplicates such as `CCLSS`.
  - Typing `COLOR` produced examples like `color1115,0,` or `ccolor15,0,0`.
  - Duplicates became intermittent; user suspected repeat state was not
    resetting on key change/key-up.
  - The latest overhaul specifically removes the forced `OLDKEY` reset/re-scan
    behavior and validates key-up against the tracked active-low physical bit.
  - Runtime verification is still needed on the user's machine.
- Current repeat definitions are in `src/main.asm` near line 45:
  `KEY_REPEAT_DELAY: equ 60`, `KEY_REPEAT_INTERVAL: equ 12`.
- The last user specifically requested a summary, so no further keyboard
  changes have been made since the last repeat-delay build.

## Build and packaging state

- Build command: `make -B Z80_ASSEMBLER=sjasmplus all`
- The latest full build succeeded after BLOAD, USR, DATA, READ, RESTORE and
  radix literal support were added. The packaged
  `roms/cbios_basic.rom` matches `derived/bin/cbios_basic.rom` byte-for-byte
  (SHA1 `2c2c13c13208e60d30329227aa3953454fd48013`, 16 KB).
- BLOAD has not yet been runtime-tested with an MSX-DOS disk image, and USR has
  not been tested against an actual machine-language routine.

## Important files

- `src/basic.asm`: BASIC command editor, statements, expression parser,
  tokenization, file token maps, DOS `BLOAD`, `DEF USR`/`USR(...)`, and
  `DATA`/`READ`/`RESTORE`.
  Key editor code near lines 175-460;
  POKE/VPOKE handlers near 2957; MOD parser around 3110; PEEK/VPEEK near
  3340+; signed atom parse around 3680.
- `src/main.asm`: BIOS keyboard scanner/repeat and keyboard buffer.
- `src/systemvars.asm`: MSX system variables, including `REPCNT`, `OLDKEY`,
  `NEWKEY`, and `KEYBUF`.
- `doc/cbasic.txt`: user-facing BASIC feature list and behavior.
- `roms/cbios_basic.rom`, `roms/cbios_main_*.rom`: packaged images.

## Next priorities

1. Runtime-test BLOAD with an MSX-DOS-compatible BDOS and representative binary
   files for both `,R` and `,S`, including malformed/truncated files.
2. Test `DEF USR=...` and `USR(...)` with a small machine-language routine that
   reads and writes the documented integer value at `DAC+2`.
3. Ask the user to test quick typing (`COLOR`/`CLS` and longer text), key-up
   after short taps, and deliberate held-key repeat using the latest main BIOS
   ROMs; tune from that feedback only if necessary.
4. If further keyboard changes are needed, test transition cases: key released
   before delay, two distinct keys pressed in succession, multiple keys held,
   and releasing the tracked key while another key remains down.
5. User has also previously said `POKE`, `VPOKE`, `PEEK`, `VPEEK` and `WIDTH`
   showed syntax errors. The user clarified `POKE -1,170` should target 65535,
   and negative literal parsing was fixed by clearing carry in `parse_atom_sign`.
   They later confirmed quick separate taps still duplicated in their installed
   setup, but it was not confirmed whether latest rebuilt main BIOS images were
   installed. `WIDTH` was explicitly kept documentation-only; C-BASIC does not
   implement the WIDTH statement. Avoid conflating WIDTH with VRAM POKE.
