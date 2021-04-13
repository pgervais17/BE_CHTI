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
	export CallbackSon
	export SortieSon
	
    import Son ;Adresse du tableau de sons

CallbackSon
	
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

	bx lr
	
	END	