INCLUDE Irvine32.inc
MAX_LENGTH=100
.data
startingText byte "1) Vigenere Cipher",0dh,0ah
			 byte "2) Diffie Hellman Key Exchange",0dh,0ah
			 byte "3) ROT13",0dh,0ah
			 byte "4) Reil Fence Cipher",0dh,0ah
			 byte "5) Exit ",0
				
;----Vigenere Cipher
vigEnc byte "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ",0
vigTextInfo byte "Enter Text: ",0
vigKeyInfo byte "Enter Key: ",0
vigText byte MAX_LENGTH dup(?)
vigKey byte MAX_LENGTH dup(?)
vigKeyNew byte MAX_LENGTH dup (?)
vigTextLength dword ?
vigKeyLength dword ?
vigEncText byte "Encrypted Vigenere Cipher Text is: ",0



;----Diffie Hellman
prime dword 23
base dword 5
enterAlice byte "Enter private key for alice: ",0
enterBob byte "Enter private key for bob: ",0
privateAlice dword ?
privateBob dword ?
publicAlice dword ?
publicBob dword ?
sharedAlice dword ?
sharedBob dword ?
result dword ?
baseF dword ?
exponent dword ?
modulus dword ?
publicAliceText byte "Public key for alice is: ",0
publicBobText byte "Public key for bob is: ",0
sharedAliceText byte "Shared key for alice is: ",0
sharedBobText byte "Shared key for bob is: ",0
tempVar1 dword ?
tempVar2 dword ?
tempBase dword ?
tempExp dword ?
tempMod dword ?
 




;----ROT13
rotTextInfo byte "Enter Text",0
rotText byte MAX_LENGTH dup(?)
rotTextLength dword ?
rotShift dword 13

;----RailFence Cipher
rfText byte MAX_LENGTH dup(?)
rf1 byte MAX_LENGTH dup(?)
rf2 byte MAX_LENGTH dup(?)
rfTextLength dword ?


.code
main PROC
start_program:
call clrscr
mov edx,offset startingText 
call writestring
mov eax,0
call readdec
cmp eax,1
je vigcipher_label
cmp eax,2
je diffie_label
cmp eax,3
je rot13_label
cmp eax,4
je railfence_label
cmp eax,5
je exit_label


vigcipher_label:
mov ecx,MAX_LENGTH
mov edx,offset vigTextInfo
call writestring
call crlf
mov edx,offset vigText
call readstring
mov vigTextLength,eax
;call writedec
mov ecx,MAX_LENGTH
mov edx,offset vigKeyInfo
call writestring
call crlf
mov edx,offset vigKey
call readstring
mov vigKeyLength,eax
call vigenere_cipher

call waitmsg
jmp start_program



diffie_label:
mov edx,offset enterAlice
call writestring
call readdec

mov privateAlice,eax


mov edx,offset enterBob
call writestring
call readdec

mov privateBob,eax




;public keys
mov eax,base
mov ecx,privateAlice
mov edx,prime
call diffie_mod
mov publicAlice,eax



mov eax,base
mov ecx,privateBob
mov edx,prime
call diffie_mod
mov publicBob,eax

;shared keys
mov eax,publicBob
mov ecx,privateAlice
mov edx,prime
call diffie_mod
mov sharedAlice,eax


mov eax,publicAlice
mov ecx,privateBob
mov edx,prime
call diffie_mod
mov sharedBob,eax


mov edx,offset publicAliceText
call writestring
mov eax,publicAlice
call writedec
call crlf

mov edx,offset publicBobText
call writestring
mov eax,publicBob
call writedec
call crlf

mov edx,offset sharedAliceText
call writestring
mov eax,sharedAlice
call writedec
call crlf

mov edx,offset sharedBobText
call writestring
mov eax,sharedBob
call writedec
call crlf





call waitmsg
jmp start_program

rot13_label:
mov ecx,MAX_LENGTH
mov edx,offset rotTextInfo
call writestring
call crlf
mov edx,offset rotText
call readstring
mov rotTextLength,eax

call rot13_cipher
call waitmsg
jmp start_program


railfence_label:
mov ecx,MAX_LENGTH
mov edx,offset rotTextInfo
call writestring
call crlf
mov edx,offset rfText
call readstring
mov rfTextLength,eax

call railfence_cipher

call waitmsg
jmp start_program

exit_label:
exit
main endp


;--Vigenere Cipher Procedure
vigenere_cipher PROC
enter 0,0
mov esi,0
mov edi,0
mov eax,1
mov ecx,vigTextLength
makingNewKey:
	cmp esi,vigKeyLength
	je makeZero
	jmp continuee

	makeZero:
		mov esi,0
	continuee:
	mov bl,vigKey[esi]
	mov vigKeyNew[edi],bl

	add esi,1
	add edi,1
	loop makingNewKey

	mov edx,offset vigKeyNew
	;call writestring


	mov edx,offset vigEncText
	call writestring
	mov ecx,vigTextLength
	mov esi,0
	mov eax,0
	l2:
		mov al,vigKeyNew[esi]
		sub al,65
		add vigText[esi],al
		mov al,vigText[esi]
		sub al,65
		movzx edi,al
		movzx eax,vigEnc[edi]
		call writechar
		add esi,1
		loop l2

	call crlf


leave
ret
vigenere_cipher endp

;--ROT13 CIPHER PROCEDURE
rot13_cipher proc
enter 0,0
mov esi,0
mov ecx,rotTextLength
rot_print:
	mov al,rotText[esi]
	sub al,65
	add eax,rotShift
	movzx edi,al
	mov al,vigEnc[edi]
	call writechar
	add esi,1
	loop rot_print

	call crlf

leave
ret
rot13_cipher endp

;---Railfence Cipher Procedure
railfence_cipher proc
enter 0,0
mov esi,0
mov edi,0
mov ecx,rfTextLength
rfloop:
	mov al,rfText[esi]
	call writechar
	sub ecx,1
	add esi,2
	loop rfloop


mov esi,1
mov ecx,rfTextLength
rfloop1:
	mov al,rfText[esi]
	call writechar
	sub ecx,1
	add esi,2
	loop rfloop1




call crlf
leave
ret
railfence_cipher endp



diffie_mod proc

mov tempBase,eax
mov tempExp,ecx
mov tempMod,edx

mov ebx,1;result
mov esi,ecx
mov edx,0

mod_label:
	mov eax,exponent
	cmp esi,0
	jna exitOutofLabel
	
	and esi,1
	jz skipMult

	
	mov eax,tempBase
	mul ebx
	mov ecx,tempMod
	div ecx

	mov ebx,edx
	

	skipMult:
		mov eax,tempBase
		mul eax

		mov ecx,tempMod
		div ecx
		
		mov tempBase,edx

		shr esi,1
		jmp mod_label


exitOutofLabel:
mov eax,ebx
ret
diffie_mod endp

end main