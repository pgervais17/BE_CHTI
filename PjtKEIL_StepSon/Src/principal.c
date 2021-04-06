

#include "DriverJeuLaser.h"


void CallbackSon(void);

int main(void)
{
CLOCK_Configure();

Timer_1234_Init_ff( TIM4, 6552);
	
Active_IT_Debordement_Timer( TIM4, 2, CallbackSon );	
	
Run_Timer( TIM4 );
while	(1)
	{
	}
}

