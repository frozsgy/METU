#include <stdio.h>

int main() {
	unsigned int cookie_and_shifted_mult[6];
	char s[9] = "2d8c0362";
	for ( int i=0 ; i<6 ; i++ ) { 
		cookie_and_shifted_mult[i] = s[i] * s[(i+2)];
	}

	for (int i=0; i <6; i++) {
		printf("%4x\n",cookie_and_shifted_mult[i]);
	}
	return 0;
}