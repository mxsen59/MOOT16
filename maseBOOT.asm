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
    sti
    mov     ax, 3
    int     0x10
    mov     ah, 0x0e
    mov     al, "$"
    mov     bh, 0
    int     0x10
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

times (510-($-$$)) db 0   
dw 0xaa55               
