

#include "DriverJeuLaser.h"


void CallbackSon(void);

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();

// configuration du Timer 4 en d�bordement 100ms
	
//** Placez votre code l� ** // 
GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL);
	
Timer_1234_Init_ff( TIM4, 6552);
	

// Activation des interruptions issues du Timer 4
// Association de la fonction � ex�cuter lors de l'interruption : timer_callback
// cette fonction (si �crite en ASM) doit �tre conforme � l'AAPCS
Active_IT_Debordement_Timer( TIM4, 2, CallbackSon );	
//** Placez votre code l� ** // 	
Run_Timer( TIM4 );
	
	
// configuration de PortB.1 (PB1) en sortie push-pull
GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL);
	
//============================================================================	
	
	
while	(1)
	{
	}
}

