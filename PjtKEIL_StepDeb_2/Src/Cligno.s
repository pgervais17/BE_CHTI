	PRESERVE8
	THUMB   
		
			

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
FlagCligno DCD 0 ; initialisation var flag 
	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		


	include  ../Driver/DriverJeuLaser.inc
	EXPORT timer_callback



timer_callback proc
	
	;si (FlagCligno==0)
		;FlagCligno=1
		;registre GPIOB_Clear
	
	;sinon (FlagCligno==1) 
		;FlagCligno=0
		;registre GPIOB_Set
	;si FlagCligno=0
	push {r4,r5,lr}
	ldr r4,=FlagCligno
	ldr r5, [r4]
	cmp r5, #0
	bne sinon
	mov r0, #1
	bl GPIOB_Clear
	
	;mettre flag à 1
	mov r5, #1
	str r5, [r4]
	pop {r4,r5,pc}
	
sinon

	;mettre flag à 0
	mov r5, #0
	str r5, [r4]

	mov r1, #1
	bl GPIOB_Set

	pop {r4,r5,pc}
	endp
	end

		
	END	