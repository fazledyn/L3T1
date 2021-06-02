/*
 * offline1.c
 *
 * Created: 10-04-2021 15:51:30
 * Author : fazledyn
 */ 

#define F_CPU 1000000

#include <stdbool.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>


volatile bool staticMode;

char col[8] = {
	0b00000001,
	0b00000010,
	0b00000100,
	0b00001000,
	0b00010000,
	0b00100000,
	0b01000000,
	0b10000000
};

volatile char row[8] = {
	0b00000000,
	0b00110110,
	0b01001001,
	0b01001001,
	0b01001001,
	0b01001001,
	0b01111111,
	0b00000000
};


ISR(INT1_vect) {
	staticMode = !staticMode;
}


int circularRightShift(int n) {
	return (n >> 1)|(n << (8 - 1));
}

void shiftDigit() {
	int j;
	for (j=0; j < 8; j++) {
		row[j] = circularRightShift(row[j]);
	}
}


int main(void) {
	
	DDRB = 0b11111111;
	DDRA = 0b11111111;
	
	GICR = 0x80;
	MCUCR = 0x0C;
	sei();
	
	int i = 0;
	staticMode = true;
	
    while (1)
	{	
		if (staticMode)
		{
			PORTA =  col[i];
			PORTB = ~row[i];
			i++;
			_delay_ms(1);
			
			if (i > 7)	i = 0;
		}
		else
		{
			shiftDigit();
			for (i=0; i < 8; i++)
			{
				PORTA =  col[i];
				PORTB = ~row[i];
				_delay_ms(1);
			}
			_delay_ms(75);  // <--------------------------- Movement rate
		}
	}
}
