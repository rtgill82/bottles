;
; BSD 3-Clause License
;
; Copyright (c) 2025 Robert Gill <rtgill82@gmail.com>
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions are met:
;
; 1. Redistributions of source code must retain the above copyright notice, this
;    list of conditions and the following disclaimer.
;
; 2. Redistributions in binary form must reproduce the above copyright notice,
;    this list of conditions and the following disclaimer in the documentation
;    and/or other materials provided with the distribution.
;
; 3. Neither the name of the copyright holder nor the names of its
;    contributors may be used to endorse or promote products derived from
;    this software without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
; DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
; CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
; OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;

%include "common.inc"
%include "bootsec.inc"

  CPU		286
  BITS		16

  BOOTADDR	EQU	0x7c00

  SECTION .bss
ABSOLUTE 0x500

count	RESW	1

  SECTION .text

EXTERN _start
_start:
	xor	ax, ax
	mov	ds, ax

	push	word 8
	push	word BOOTADDR + fat12_bootsec.bs_oem_name
	call	write
	add	sp, 4

	call	newline

	mov	ax, ss
	push	ax
	call	print_hex
	add	sp, 2

	putchar	':'

	mov	ax, sp
	push	ax
	call	print_hex
	add	sp, 2

	call	newline

	mov	ah, 0x86
	mov	cx, 0x4c
	mov	dx, 0x4b40
	int	0x15

	mov	word [count], 99
bloop:
	call	bottle_count
	cmp	word [count], 1
	je	s1
	call	print_bottles
	jmp	m1
s1:
	call	print_bottle
m1:
	call	newline

	call	bottle_count
	cmp	word [count], 1
	je	s2
	call	print_no_wall
	jmp	m2
s2:
	call	print_bottle_no_wall
m2:
	call	newline

	push	word PASS_LEN
	push	word pass_str
	call	write
	add	sp, 4

	call	newline

	dec	word [count]
	call	bottle_count

	cmp	word [count], 1
	je	s3
	call	print_bottles
	jmp	m3
s3:
	call	print_bottle
m3:
	cmp	word [count], 0
	jz	finish

	call	newline
	call	newline
	jmp	bloop

finish:
	call	newline
	cli
	hlt

newline:
	putchar 13
	putchar 10
	ret

bottle_count:
	push	word [count]
	call	print_dec
	add	sp, 2
	putchar	' '
	ret

print_bottles:
	push	word BOTTLES_LEN
	push	word bottles_str
	call	write
	add	sp, 4
	ret

print_bottle:
	push	word 6
	push	word bottles_str
	call	write

	push	word 21
	push	word bottles_str + 7
	call	write
	add	sp, 8
	ret

print_no_wall:
	push	word 15
	push	word bottles_str
	call	write
	add	sp, 4
	putchar	'.'
	ret

print_bottle_no_wall:
	push	word 6
	push	word bottles_str
	call	write

	push	word 8
	push	word bottles_str + 7
	call	write
	add	sp, 8

	putchar	'.'
	ret

bottles_str	EQU	bottles_str2 + 2
bottles_str2	DB	"bottles of beer on the wall."
BOTTLES_LEN	EQU	$-bottles_str2

pass_str	EQU	pass_str2 + 2
pass_str2	DB	"Take one down and pass it around."
PASS_LEN	EQU	$-pass_str2

; vim: set filetype=nasm:
