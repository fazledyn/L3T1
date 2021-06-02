/*
 * ADC_Offline.c
 *
 * Created: 03-06-2021 02:14:57
 * Author : ataff
 */ 

#ifndef F_CPU
#define F_CPU 16000000UL // 16 MHz clock speed
#endif

#define D4 eS_PORTD4
#define D5 eS_PORTD5
#define D6 eS_PORTD6
#define D7 eS_PORTD7
#define RS eS_PORTC6
#define EN eS_PORTC7

#include <avr/io.h>
#include <util/delay.h>
#include "lcd.h" //Can be download from the bottom of this article

int main(void)
{
	DDRD = 0xFF;
	DDRC = 0xFF;

	Lcd4_Init();
	while(1)
	{
		Lcd4_Set_Cursor(1,1);
		Lcd4_Write_String("Nahian Chan <3");
		
		Lcd4_Set_Cursor(2,1);
		Lcd4_Write_String("Rabidoggo");
		
		_delay_ms(2000);
	}
}
