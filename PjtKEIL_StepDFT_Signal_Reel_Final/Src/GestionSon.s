	PRESERVE8
	THUMB   
		
; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
SortieSon DCD 0
AdressSon DCD 0
	
; ===============================================================================================
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici	
	EXPORT CallbackSon
	export SortieSon
	include  ../Driver/DriverJeuLaser.inc
	extern PWM_Set_Value_TIM3_Ch3
    extern Son ;Adresse du tableau de sons
	export StartSon
			
StartSon
    ldr r1, = AdressSon
    mov r2, #0
    str r2, [r1]
    bx lr
    

CallbackSon
	push{lr}
	ldr r1, =AdressSon
	ldr r3, =SortieSon
	ldr r0, [r1] ; r1 adresse du son, r0 valeur
	
	cmp r0, #0 ; Si adresse son vaut 0
	bne lire_son
	ldr r0, =Son
	b lire_son
	
		
lire_son

	ldrsh r2,[r0] ; half : lis sur 16 bit
	adds r2, #32768
	mov r4, #719
	mul r2, r4
	mov r4, #65536
	sdiv r2, r4
	str r2, [r3] ; stock le son dans SortieSon
	add r0, #2 ; incrémente de 16 bits
	str r0, [r1] ; stock adresse son

	mov r0, r2
	bl PWM_Set_Value_TIM3_Ch3
	
	pop{pc}
	
	END	