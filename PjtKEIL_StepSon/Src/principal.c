#include "DriverJeuLaser.h"
#define Periode_Ticks 720	// on a alors une fréquence de 1/720
		

void CallbackSon(void);
void StartSon(void);



int main(void) {


    CLOCK_Configure();

    Timer_1234_Init_ff( TIM4, 6552);
    Active_IT_Debordement_Timer( TIM4, 2, CallbackSon );

    PWM_Init_ff( TIM3 , 3 , Periode_Ticks );

    GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
    
    for(int i = 0; i<5000000;i++);
		StartSon();

    while    (1){
    }
}
