/*
 * HW_1.c
 *
 *  Created on: 16 févr. 2017
 *      Author: Soufiane El Abdouni
 */
#include <stdio.h>
#include "system.h"

int main(void)
{

	volatile int * mycustom   =   (int*) MY_CUSTOM_IP_0_BASE;
	volatile int * button     =   (int*) BUTTON_BASE;
	volatile int * switches   =   (int*) SWITCHES_BASE;

	*(mycustom) = 1;//enable
	*(mycustom+2) = 100000;//periode

	while(1)
	{
		*(mycustom+1) = *switches;//dutty cycle

		if(!*button)
		{
			*(mycustom) = 0; // mise du enable a 0
			printf(" Le duty cycle est de %d/%d \n",*(mycustom+1), 15);//lecture du dutty cycle
			while(!*button)
			{} // temporiseur temps qu'on reste appuyer
			*(mycustom) = 1;//remise du enable a 1
		}

	}
	return 0;
}

