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

struc fat12_bootsec
  .bs_jmp_boot:		resb	3
  .bs_oem_name:		resb	8
  .bpb_byts_per_sec:	resw	1
  .bpb_sec_per_clus:	resb	1
  .bpb_rsvd_sec_cnt:	resw	1
  .bpb_num_fats:	resw	1
  .bpb_root_ent_cnt:	resw	1
  .bpb_tot_sec_16:	resw	1
  .bpb_media:		resb	1
  .bpb_fat_sz_16:	resw	1
  .bpb_sec_per_trk:	resw	1
  .bpb_num_heads:	resw	1
  .bpb_hidd_sec:	resd	1
  .bpb_tot_sec_32:	resd	1
  .bs_drv_num:		resb	1
  .bs_reserved1:	resb	1
  .bs_boot_sig:		resb	1
  .bs_vol_id:		resd	1
  .bs_vol_lab:		resb	11
  .bs_fil_sys_type:	resb	8
  .bs_boot_code:	resb	448
  .signature_word:	resw	1
endstruc

; vim: set filetype=nasm:
