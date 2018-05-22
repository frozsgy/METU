#include <stdio.h>

/*
      METU CENG
      2017-2018 CENG140
      TAKE HOME EXAM - 1
      PART 2
      MUSTAFA OZAN ALPAY
      2309615
      Version: 1.0.0 (2018-04-14 16:38)
*/

int bigger(int x, int y) {
	return x>y ? x : y;
}

int rabbit(int x, int y, int size, int movement, int field[100][100], char route[]) {
	int south, east, which;
	if (x >= size || y >= size) {
		return 0;
	}
	if(y+1 == size && x+1 == size) {
		return field[x][y];
	}
	south=rabbit(x,y+1,size,movement+1,field,route);
	east=rabbit(x+1,y,size,movement+1,field,route);
	which=bigger(south,east);
	if(!movement) {
		route[0]=(which == south ? 'S' : 'E');
	}
	return which+field[x][y];
}

void router(int x, int y, int size, int field[100][100], int movement, char route[]) {
	int south, east, which;
	if(movement < 2*(size-1)) {
			south=rabbit(x,y+1,size,movement+1,field,route);
			east=rabbit(x+1,y,size,movement+1,field,route);
			which=bigger(south,east);
			if(south == east && (x+1 == size || y+1 == size)) {
				if(x+1 == size) {
					route[movement+1]='S';
					router(x,y+1,size,field,movement+1,route);
				}
				else {
					route[movement+1]='E';
					router(x+1,y,size,field,movement+1,route);
				}
			}
			else {
				if(which == south) {
					route[movement+1]='S';
					router(x,y+1,size,field,movement+1,route);
				}
				else {
					route[movement+1]='E';
					router(x+1,y,size,field,movement+1,route);
				}
		}
	}
}

int main() {
	int n, i, j, sonuc, field[100][100];
	char route[210];
	scanf("%d",&n);
	for(i=0;i<n;i++){
		for(j=0;j<n;j++) {
			scanf("%d ",&field[j][i]);
		}
	}
	sonuc=rabbit(0,0,n,0,field,route);
	if(route[0] == 'S') {
		router(0,1,n,field,0,route);
	}
	else {
		router(1,0,n,field,0,route);
	}
	for (j=0;j<(2*(n-1));j++) {
		printf("%c ",route[j]);
	}
	printf(", final energy: %d\n",sonuc*40);
	return 0;
}
