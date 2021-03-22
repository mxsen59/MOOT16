org 0x7c00          
bits 16

main:    
    mov     bx, 0x1000          
    mov     es, bx              
    mov     bx, 0x0             
    mov     dh, 0x0            
    mov     dl, 0x0             
    mov     ch, 0x0             
    mov     cl, 0x02
    sti
    mov     ax, 3
    int     0x10
    mov     si, boot_header
    call    print
    mov     si, boot_msg
    call    print        

read_disk:
    mov     ah, 0x02            
    mov     al, 0x01             
    int     0x13                
    jc      read_disk
    jc      disk_error            
    mov     ax, 0x1000
    mov     ds, ax              
    mov     es, ax              
    mov     fs, ax              
    mov     gs, ax              
    mov     ss, ax 
    mov 	cx, 36

    .delay:
        hlt
        loop 	.delay

    jmp     0x1000:0x0000          

disk_error:
    mov     ah, 0x0e
    mov     al, "?"
    mov     bx, 0
    int     0x10
    hlt    

print:
    pusha
    mov     bx, 0x0007  
    
    print_loop:
        mov     al, [si]
        cmp     al, 0 
        je      done
        mov     ah, 0x0e 
        int     0x10
        inc     si       
        jmp     print_loop
    
    done:
        popa
        ret

print_nl:
    pusha
    mov  bh, 0       
    mov  ax, 0x0e0d 
    int  0x10
    mov  ax, 0x0e0a 
    int  0x10
    popa
    ret

boot_header db "maseBOOT v0.0.1", 13, 10, 0
boot_msg db "Booting...", 0

times (510-($-$$)) db 0   
dw 0xaa55          