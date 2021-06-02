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
    unsigned int adc_level = 0x0000;
    float voltage;
    char voltage_string[10];

	DDRD = 0xFF;
	DDRC = 0xFF;

    /*
        ADMUX   = REFS1 REFS0 ADLAR MUX(4-0)
                  0     1     0     0 0 0 0 1
        ADCSRA  = ADEN ADSC ADATE ADIF ADIE ADPS(2-0)
                  1     ?     1     ?   ?     1 0 0
    */
    ADMUX  = 0b01000001;
    ADCSRA = 0b10000100;

	Lcd4_Init();
	while(1)
	{
        // Start the conversion by putting the flag
        ADCSRA |= (1 << ADSC);
        // Wait for the conversion to over
        while (ADCSRA & (1 << ADSC)) {}

        adc_level |= ADCL;
        adc_level |= (ADCH << 8);

        voltage = (adc_level * 4.00)/16;
        gcvt(voltage, 10, voltage_string);

		Lcd4_Set_Cursor(1,1);
		Lcd4_Write_String("Voltage:");
		
		Lcd4_Set_Cursor(2,1);
		Lcd4_Write_String(voltage_string);
		
		_delay_ms(2000);
	}
}
