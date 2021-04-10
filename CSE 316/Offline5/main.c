/*
 * offline1.c
 *
 * Created: 10-04-2021 15:51:30
 * Author : ataff
 */ 

#define F_CPU 1000000

#include <stdbool.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>


volatile bool staticMode;
volatile char col[8] = {1, 2, 4, 8, 16, 32, 64, 128};
volatile char row[8] = {
	0b00000000,
	0b01111100,
	0b01000010,
	0b01000010,
	0b01111100,
	0b01000010,
	0b01000010,
	0b01111100
};


ISR(INT1_vect) {
	staticMode = !staticMode;
}

void shiftDigit() {
	int k;
	char temp = row[7];
	for (k=7; k > 0; k--) {
		row[k] = row[k-1];
	}
	row[0] = temp;
}

int main(void)
{
	
	DDRB = 0xFF;
	DDRC = 0xFF;
	
	GICR = 0x80;
	MCUCR = 0x0C;
	sei();
	
	int i = 0;
	staticMode = true;
	
    while (1) {
		
		if (staticMode) {
			
			PORTC =  col[i];
			PORTB = ~row[i];
			i++;
			_delay_ms(1);
			
			if (i > 7)	i = 0;
			
		}
		else {
			
			shiftDigit();
			for (i=0; i < 8; i++) {
				PORTC =  col[i];
				PORTB = ~row[i];
				_delay_ms(1);
			}
			_delay_ms(50);  // <--------------------------- Blinking rate
			
		}
	}

}

