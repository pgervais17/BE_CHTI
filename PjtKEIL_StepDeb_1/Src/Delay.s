	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
	export VarTime
VarTime	dcd 0

	
; ===============================================================================================
	
;constantes (équivalent du #define en C)
TimeValue	equ 900000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette manière de créer une temporisation n'est clairement pas la bonne manière de procéder :
; - elle est peu précise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'accés écr/lec de variable en RAM
; - le mécanisme d'appel / retour sous programme
;
; et donc possède un intérêt pour débuter en ASM pur

Delay_100ms proc
	
	    ldr r0,=VarTime;r0=&VarTime (adresse de VarTime et non valeur)  		  
						  
		ldr r1,=TimeValue;r1=&TimeValue
		str r1,[r0]; stockage en dur de l'adresse de VarTime
		
BoucleTempo	
		ldr r1,[r0]; r1=VarTime   				
						
		subs r1,#1; r1=VarTime-1
		str  r1,[r0]; stockage de l'adresse de VarTime
		bne	 BoucleTempo; vérifie le registre d'état et fais un branchement met à jour le flag 
			
		bx lr; return 0, fin de la fonction -
		endp
		
		
	END	