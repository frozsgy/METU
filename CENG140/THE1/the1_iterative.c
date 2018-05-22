#include <stdio.h>

/*
      METU CENG
      2017-2018 CENG140
      TAKE HOME EXAM - 1
      PART 1 - ITERATIVE SOLUTION
      MUSTAFA OZAN ALPAY
      2309615
      Version: 1.1.0 (2018-04-11 16:27)
*/

void switcher(int i, int *a, int *b) {
	switch(i) {
			case 0:
				*b-=1;
			break;
			case 1:
				*a+=1;
			break;
			case 2:
				*b+=1;
			break;
			case 3:
				*a-=1;
			break;
		}
}

int neighbour(int x, int y, int size, int field[100][100], int direction, int direction2) {
	switcher(direction2,&x,&y);
	switch(direction) {
		/* 1 N 2 E 3 S 4 W*/
		case 0:
			if(y >= 1) return field[x][y-1];
		break;
		case 2:
			if(y < size-1) return field[x][y+1];
		break;
		case 3:
			if(x >= 1) return field[x-1][y];
		break;
		case 1:
			if(x < size-1) return field[x+1][y];
		break;
	}
	return -1;
}

void checkneighbours(int x, int y, int size, int ct, int field[100][100]) {
	int i, j, watch, watch2, match, directions[4], directions2[4][4], breaking, a, b;
	match=0;
	for(i=0;i<4;directions[i]=0, i++);
	for(i=0;i<4;i++) for(j=0;j<4;directions2[i][j]=0,j++);
	for(i=0;i<4;i++) {
		watch=neighbour(x,y,size,field,i,4);
		if(watch == ct) {
			match++;
			directions[i]=1;
		}
	}
	for(i=0;i<4;i++) {
		breaking=(i+2)%4;
		if(directions[i]) {
			for(j=0;j<4;j++) {
				if(j != breaking) {
					watch2=neighbour(x,y,size,field,i,j);
					if(watch2 == ct) {
						match++;
						directions2[i][j]=1;
					}
				}
			}
		}
	}
	if(match >= 2) {
		for(i=0;i<4;i++) {
			for(j=0;j<4;j++) {
				a=x;
				b=y;
				if(directions2[i][j]) {
						switcher(i,&a,&b);
						switcher(j,&a,&b);
						field[a][b]=0;
						field[x][y]=ct+1;
				}
				a=x;
				b=y;
				if(directions[i]) {
						switcher(i,&a,&b);
						field[a][b]=0;
						field[x][y]=ct+1;
				}
			}
		}
	}
}

void carrots(int size, int field[100][100], int comm[3]) {
	int l, x, y, i;
	l=comm[0];
	x=comm[1];
	y=comm[2];
	field[x][y]+=l;
	for(i=0;i<4;i++) {
		checkneighbours(x, y, size, field[x][y], field);
	}
}

int main() {
	int n, i, j, now[3], field[100][100];
	scanf("%d",&n);
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			field[i][j]=0;
		}
	}
	while(scanf("%d %d %d",&now[0],&now[1],&now[2]) == 3) {
		carrots(n,field,now);
	}
	for (j=0;j<n;j++) {
		for (i=0;i<n;i++) {
			printf("%d ",field[i][j]);
		}
		printf("\n");
	}
	return 0;
}
