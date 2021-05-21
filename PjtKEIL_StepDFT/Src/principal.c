

#include "DriverJeuLaser.h"

extern short int LeSignal;
int Tab[64];
int DFT_ModuleAuCarre( short int * Signal64ech, char k);



int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();

	for (char k=0;k<64; k++) {
		Tab[k]=DFT_ModuleAuCarre (&LeSignal, k);
	}
	
	

//============================================================================	
	
	
while	(1)
	{
	}
}

