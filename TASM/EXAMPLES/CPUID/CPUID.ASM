;       cpuid.asm 
;
;       CPU detector program.
;
;       Copyright (c) 1993 by Borland International, Inc.
;
;       Build with the provided makefile: make -B


        TITLE CPUID
        JUMPS
        .model small
        .stack 100h
        .data
saved_cpuid     dd      ?
vendor_id       db      12 dup (?)
cpu_type        db      ?
themodel        db      ?
stepping        db      ?
id_flag         db      0
intel_proc      db      0
id_msg          db      "This system has a$"
c8086           db      "n 8086/8088 microprocessor$"
c286            db      "n Intel 286 microprocessor$"
c386            db      "n Intel386 (TM) microprocessor$"
c486            db      "n Intel486 (TM) DX microprocessor$"
Pentium         db      " Pentium(TM) microprocessor", 13, 10, "$"
intel           db      "This system contains a Genuine Intel Processor", 13, 10, "$"
modelmsg        db      "Model:         $"
steppingmsg     db      "Stepping:      $"
familymsg       db      "Processor Family: $"
period          db      ".",13,10,"$"
dataCR          db      ?,13,10,"$"
intel_id        db      "GenuineIntel"

.code
.8086            ; This part of the program must run on an 8086
start:  mov     ax,@data
        mov     ds, ax                  ;set segment register
        mov     es, ax                  ;set segment register
        and     sp, not 3               ;align stack to avoid AC fault
        call    get_cpuid
        call    print
        mov     ax,4c00h                ; terminate program
        int     21h

get_cpuid        proc

;       8086 CPU check
;       Bits 12-15 are always set on the 8086 processor
;
check_8086:
        pushf                           ;save FLAGS
        pop     bx                      ;store FLAGS in BX
        mov     ax, 0fffh               ;clear bits 12-15
        and     ax, bx                  ;  in FLAGS
        push    ax                      ;store new FLAGS calue on stack
        popf                            ;replace current FLAGS value
        pushf                           ;set new flags
        pop     ax                      ;store new flags in AX
        and     ax, 0f000h              ;if bits 12-15 are set, then CPU
        cmp     ax, 0f000h              ;  is an 8086/8088
        mov     cpu_type, 0             ; save the CPU type
        je      end_get_cpuid


;
;       Intel 286 CPU check
;       Bits 12-15 are always clear on the Intel processor.
;
check_80286:
.286
        or      bx, 0f000h              ;try to set bits 12-15
        push    bx
        popf
        pushf
        pop     ax
        and     ax, 0f000h              ; if bits 12-15 are cleared,
                                        ;       CPU=Intel 286
        mov     cpu_type, 2             ; turn on Intel 286 Cpu flag
        jz      end_get_cpuid           ; if CPU is intel 286, check
                                        ; for Intel 287 math coprocessor

;       Intel386 CPU check
;       The AC bit (bit 18), is a new bit introduced in the EFLAGS
;       register on the Intel486 DX CPU to generate alignment faults.
;       This bit can not be set on the Intel386 CPU.
;
check_intel386:
.386
        pushfd
        pop     eax                     ;get original EFLAGS
        mov     ecx,eax                 ; save original EFLAGS
        xor     eax,40000h              ;flip AC bit in EFLAGS
        push    eax                     ; save for EFLAGS
        popfd                           ; copy to EFLAGS
        pushfd                          ; push EFLAGS
        pop     eax                     ; get new EFLAGS value
        xor     eax,ecx                 ; can't toggle AC bit, CPU=Intel386
        mov     cpu_type, 3             ; turn on Intel386 CPU flag
        je      end_get_cpuid           ; if CPU is Intel386, now check
                                        ; for an Intel 287 or Intel387 MCP

;     Intel486 DX CPU, Intel 487 SX MCP, and Intel486 SX CPU checking
;
;     Checking for the ability to set/clear the ID flag (bit 21) in EFLAGS
;     which diferentiates between Pentium (or greater) and the Intel486.
;     If the ID flag is set then the CPUID instruction can be used to
;     determine the final version of the chip, else it's a 486
;
;
check_Intel486:
.486
        mov     cpu_type, 4             ;turn on Intel486 CPU flag
        pushfd                          ;push original EFLAGS
        pop     eax                     ; get original EFLAGS in eax
        mov     ecx,eax                 ;save original EFLAGS in ecx
        or      eax,200000h             ; flip ID bit in EFLAGS
        push    eax                     ;save for EFLAGS
        popfd                           ;copy to EFLAGS
        pushfd                          ;push EFLAGS
        pop     eax                     ;get new EFLAGS value
        xor     eax,ecx
        je      end_get_cpuid           ;if ID bit cannot be changed,
                                        ;CPU=Intel486 without CPUID
                                        ;instruction functionality

;       Otherwise, execute CPUID instruction to determine vendor,
;       family, model and stepping.

check_vendor:
.586
        mov     id_flag, 1              ; set flag for indicating use of
                                        ;CPUID inst
        mov     eax, 0                  ;set up for CPUID instruction
        cpuid
        mov     dword ptr vendor_id, ebx; Test for "GenuineIntel" vendor id.
        mov     dword ptr  vendor_id[+4], edx
        mov     dword ptr vendor_id[+8], ecx
        mov     si, offset vendor_id
        mov     di, offset intel_id
        mov     cx, length intel_id
compare:
        repe    cmpsb
        cmp     cx, 0                   ; must be a GenuineIntel if ecx =0
        jne     cpuid_data

intel_processor:
        mov     intel_proc, 1
        mov     [intel-1], ' '          ; add a space so the Genuine Intel 
                                        ; message prints out.

cpuid_data:
        mov     eax, 1
        cpuid
        mov     saved_cpuid,eax         ;save for future use
        and     eax, 0F00H              ; mask everything but family
        shr     eax, 8
        mov     cpu_type, al            ; set cpu_type with family

        mov     eax,saved_cpuid         ;restore data
        mov     stepping, al
        and     stepping, 0FH           ; isolate stepping info

        mov     eax, saved_cpuid
        mov     themodel, al
        and     themodel, 0F0H          ; isolate model info
        shr     themodel, 4

end_get_cpuid:
.8086
        ret
get_cpuid       endp

;
;       This procedure prints the appropriate cpuid string
;       If the CPUID instruction was supported, it prints out
;       the cpuid info.

print   proc
        push    ax
        push    bx
        push    cx
        push    dx
        cmp     id_flag, 1              ; if set to 1, cpu supported CPUID
                                        ; instruction
                                        ; print detailed CPUID information
        je      print_cpuid_data

        mov     dx, offset id_msg 
        mov     ah, 9h
        int     21h                     ; print initial message

print_86:
        cmp     cpu_type, 0
        jne     print_286
        mov     dx, offset c8086
        mov     ah, 9h
        int     21h
        jmp     end_print

print_286:
        cmp     cpu_type, 2
        jne     print_386
        mov     dx, offset c286
        mov     ah, 9h
        int     21h
        jmp     end_print


print_386:
        cmp     cpu_type, 3
        jne     print_486
        mov     dx, offset c386
        mov     ah, 9h
        int     21h
        jmp     end_print


print_486:
        mov     dx, offset  c486
        mov     ah, 9h
        int     21h
        jmp     end_print

print_cpuid_data:

        cmp     cpu_type, 5
        jne     print_cpuid_cont

        mov     dx, offset Pentium
        mov     ah, 9
        int     21h

print_cpuid_cont:
        mov     dx, offset familymsg    ;print family msg
        mov     ah, 9h
        int     21h
        mov     al, cpu_type
        mov     byte ptr dataCR, al
        add     byte ptr dataCR, 30H    ; convert to ASCII
        mov     dx,  offset dataCR      ; print family info
        mov     ah, 9h
        int     21h

        mov     dx, offset steppingmsg  ; print stepping msg
        mov     ah, 9h
        int     21h
        mov     al, stepping
        mov     byte ptr dataCR, al
        add     byte ptr dataCR, 30H    ; convert to ASCII
        mov     dx, offset dataCR       ; print stepping info
        mov     ah, 9h
        int     21h

        mov     dx, offset modelmsg     ; print model msg
        mov     ah, 9h
        int     21h
        mov     al, themodel
        mov     byte ptr dataCR, al
        add     byte ptr dataCR, 30H    ; convert to ASCII
        mov     dx, offset dataCR       ; print stepping info
        mov     ah, 9h
        int     21h
end_print:
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
print   endp

        end     start

