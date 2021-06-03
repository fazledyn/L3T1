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
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdlib.h>

#include "lcd.h"


volatile uint16_t adc_total;

ISR (ADC_vect) {
	uint8_t low = ADCL;
	adc_total = (ADCH << 8) | low;
}

int main(void)
{
	DDRD = 0xFF;
	DDRC = 0xFF;
    /*
        ADMUX   = REFS1 REFS0 ADLAR MUX(4-0)
                  0     0     0     0 0 0 0 1
        ADCSRA  = ADEN ADSC ADATE ADIF ADIE ADPS(2-0)
                  1     ?     1     ?   ?     1 0 0
    */
    ADMUX  = 0b00000001;
    ADCSRA = 0b10001100;

	Lcd4_Init();
	Lcd4_Set_Cursor(1,1);
	Lcd4_Write_String("Voltage:");
	
	char voltage_string[10];
	float adc_float;
	sei();
	
	while(1)
	{
		ADCSRA |= (1 << ADSC);				// Start conversion
		while (ADCSRA & (1 << ADSC)) {}		// Wait for conversion to over
		
		adc_float = (adc_total * 4.00)/1024;
		dtostrf(adc_float, 6, 4, voltage_string);
		
		Lcd4_Set_Cursor(2,1);
		Lcd4_Write_String(voltage_string);
	}
	
	return 0;
}
