ideal
p686
model flat,stdcall,nt

struc base0
  struc subs1	;'Directive not allowed inside structure definition'?
field01	dd ?	; some fileds
  ends		;.close base0
  struc subs2	;.new structure subs2
field02	dd ?	; some fileds
  ends		; close subs2
ends		; close segment?

struc base1
  struc subs2	; struc filed with type subs2?
field12	dd ?	; some fileds
  ends
ends

end
