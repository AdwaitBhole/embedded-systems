/*
 * hmk_2.c
 *
 *  Created on: 24 févr. 2017
 *      Author: Soufiane El Abdouni
 */
#include <stdio.h>
#include <system.h>
#include <math.h>
#include "terasic_includes.h"
#include "accelerometer_adxl345_spi.h"

int main()
{
	alt_u8 id;     //alt u8 car voir dans le .c de l'acc il a ete definis comme ca
	alt_16 g_XYZ[3];
	int y=0;
	int wait;
	int blk =0 ;
	printf("coucou piloupilou!\n");

	volatile int * mycustom   =   (int*) MY_CUSTOM_IP_0_BASE;
	volatile int * button     =   (int*) BUTTON_BASE;

	*(mycustom) = 1;//enable
	*(mycustom+2) = 100000;//periode

	//activation accelerometre
    ADXL345_SPI_Init(TERASIC_SPI_3WIRE_0_BASE);

    //recup id et affichage
    ADXL345_SPI_IdRead(TERASIC_SPI_3WIRE_0_BASE, &id);

    while(1){
    	if(!*button)//lorsqu on appuye sur key1
    			{
    		        wait=0;
    				while(wait < 400000) wait++;// stabilisation car variation de la valeurs su bouton lors du relachement
    				blk = !blk;
    			}

        if(blk==0)
        {
    	ADXL345_SPI_XYZ_Read(TERASIC_SPI_3WIRE_0_BASE,g_XYZ);//recuperation valeur acc. dans les 3 dir
    	*(mycustom+3) = ALT_CI_MY_CUSTOM_INST_0(g_XYZ[0]+280,0);// ecriture dans la memoire des valeurs des led a l'adresse 3
    	 y=g_XYZ[1]+15; //calibration on veut qu'on soit proche de 0 lorsqu on est a plat
    	    if (y>= -7 & y<= 7)
    	          y = 0;//dutty cycle
    	     else if (y >= 269)
    	    	          y = 269;//dutty cycle
    	     else if (y <= -255)
    	    	          y =-255;

    	     if(y<=0)
    	    	 *(mycustom+1)= (int)(((y+245))*15.0/255.0);//dutty cycle
    	     if(y>0)
    	        	*(mycustom+1)= (int)(((260-y))*15.0/269.0);
         }
    }

    return 0 ;
}

