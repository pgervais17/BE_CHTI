#include "DriverJeuLaser.h"
#include "Affichage_Valise.h"
#define Periode_Ticks 360000	//on veut une fréquence d'horloge de 72 MHz pour des interruptions de 5 ms
															//=5*72000	

int Tab[64];
int DFT_ModuleAuCarre( short int * Signal64ech, char k);
char Prio = 3;
char point[6]={0,0,0,0,0,0};

short int dma_buf[64];

void CallbackSon(void);
void StartSon(void);

void callback_Systick () {
	Start_DMA1(64);
	
	Wait_On_End_Of_DMA1();
	int seuil = 0x19000000; //seuil appromoximatif estimé -> 100 en 10.22
	for (char k=0;k<64; k++) {
		Tab[k]=DFT_ModuleAuCarre(dma_buf, k); //dma_buff remplace LeSignal qui était juste pour les tests
		if (seuil< Tab[k]) {
			switch (k) {
				case 17 : 
					point [0] ++;
					StartSon();
					break ;
				case 18 : 
					point [1] ++;
					StartSon();	
					break ;
				case 19 : 
					point [2] ++;
					StartSon();
					break ;
				case 20 : 
					point [3] ++;
					StartSon();
					break ;
				case 23 : 
					point [4] ++;
					StartSon();
					break ;
				case 24 : 
					point [5] ++;
					StartSon();
					break ;
			}
		}
	}
	Stop_DMA1;
}

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
	CLOCK_Configure();
	
	Systick_Period_ff(Periode_Ticks);
	Systick_Prio_IT(Prio, callback_Systick );
	SysTick_On ;
	SysTick_Enable_IT ;
	
	GPIO_Configure(GPIOA, 2, INPUT, ANALOG);
	
	//on active l'ADC en précisant la durée de prélevement du timer
	Init_TimingADC_ActiveADC_ff(ADC1, 72);
	
	//on choisit la pin d'entrée (PA2)
	Single_Channel_ADC(ADC1,2);

	//on configure timer 2 pour lancer l'ADC à une fréquence de 320kHz
	Init_Conversion_On_Trig_Timer_ff(ADC1, TIM2_CC2, 225);
	
	Init_ADC1_DMA1( 0, dma_buf );
	
	for (int i=0;i< 4; i++) {
		Prepare_Afficheur(i,0);
	}
//============================================================================	
	
	
while	(1)
	{
	}
}

