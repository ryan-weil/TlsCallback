EXTERN tls_callback:NEAR

externdef __imp_GetCommandLineA:PROC
externdef __imp_MessageBoxA:PROC
   
PUBLIC   _tls_index
PUBLIC   _tls_used

IMAGE_TLS_DIRECTORY STRUCT
StartAddressOfRawData    QWORD ?
EndAddressOfRawData    QWORD ?
AddressOfIndex    QWORD ?
AddressOfCallBacks    QWORD ?
SizeOfZeroFill   DWORD ?
Characteristics    DWORD ?
IMAGE_TLS_DIRECTORY ENDS

;=======================================
.code   
   
tlsfunc    PROC
   sub rsp, 28h
   
   ;xor r9, r9
   ;lea r8, [msg]
   ;lea rdx, [tlsmsg]
   ;xor rcx, rcx
   
   ;call qword ptr[__imp_MessageBoxA]

   call tls_callback
   
   add rsp, 28h

   ret
tlsfunc   ENDP

;===============================================

.data      

msg   BYTE "Hello World!",0   
tlsmsg   BYTE "I'm the no-CRT TLS callback!",0
label2  BYTE "Command line is",0

_tls_index QWORD 0
array_tls_index QWORD _tls_index, 0
array_tls_func QWORD tlsfunc, 0

;===============================================
;THIS IS WHAT the struct initialization now looks like.  Thanks to aw27.

_tls_used   IMAGE_TLS_DIRECTORY <0,0,array_tls_index,array_tls_func,0,0>   

 
END