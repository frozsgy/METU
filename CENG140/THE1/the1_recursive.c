#include <stdio.h>

/*
      METU CENG
      2017-2018 CENG140
      TAKE HOME EXAM - 1
      PART 1 - RECURSIVE SOLUTION
      MUSTAFA OZAN ALPAY
      2309615
      Version: 1.1.0 (2018-04-14 20:05)
*/

void checkneighbours(int x, int y, int size, int ct, int field[100][100], int where, int count, int rc) {
	switch(where) {
		case 0:
			/*center*/
				if(y >= 1 && field[x][y-1] == ct) count++;
				if(y < size-1 && field[x][y+1] == ct) count++;
				if(x >= 1 && field[x-1][y] == ct) count++;
				if(x < size-1 && field[x+1][y] == ct)	count++;
				if(count > 0) {
					if(y >= 1 && field[x][y-1] == ct) {
						checkneighbours(x,y,size,ct,field,1,count,0);
					}
					if(y < size-1 && field[x][y+1] == ct) {
						checkneighbours(x,y,size,ct,field,3,count,0);
					}
					if(x >= 1 && field[x-1][y] == ct) {
						checkneighbours(x,y,size,ct,field,4,count,0);
					}
					if(x < size-1 && field[x+1][y] == ct) {
						checkneighbours(x,y,size,ct,field,2,count,0);
					}
				}
		break;
		case 1:
			/*north*/
			if(y > 1 && field[x][y-2] == ct) count++;
			if(x > 0 && field[x-1][y-1] == ct) count++;
			if(x < size-1 && field[x+1][y-1] == ct) count++;
			if(count > 1)	{
				if(y > 1 && field[x][y-2] == ct) {
					field[x][y-2]=0;
				}
				if(x > 0 && field[x-1][y-1] == ct) {
					field[x-1][y-1]=0;
				}
				if(x < size-1 && field[x+1][y-1] == ct) {
					field[x+1][y-1]=0;
				}
				field[x][y-1]=0;
				field[x][y]=ct+1;
			}
		break;
		case 2:
			/*east*/
			if(x < size-1 && field[x+2][y] == ct) count++;
			if(y > 0 && field[x+1][y-1] == ct) count++;
			if(y < size-1 && field[x+1][y+1] == ct) count++;
			if(count > 1) {
				if(x < size-1 && field[x+2][y] == ct) {
					field[x+2][y]=0;
				}
				if(y > 0 && field[x+1][y-1] == ct) {
					field[x+1][y-1]=0;
				}
				if(y < size-1 && field[x+1][y+1] == ct) {
					field[x+1][y+1]=0;
				}
				field[x+1][y]=0;
				field[x][y]=ct+1;
			}
		break;
		case 3:
			/*south*/
			if(y < size-1 && field[x][y+2] == ct) count++;
			if(x > 0 && field[x-1][y+1] == ct) count++;
			if(x < size-1 && field[x+1][y+1] == ct) count++;
			if(count > 1) {
				if(y < size-1 && field[x][y+2] == ct) {
					field[x][y+2]=0;
				}
				if(x > 0 && field[x-1][y+1] == ct) {
					field[x-1][y+1]=0;
				}
				if(x < size-1 && field[x+1][y+1] == ct) {
					field[x+1][y+1]=0;
				}
				field[x][y+1]=0;
				field[x][y]=ct+1;
			}
		break;
		case 4:
			/*west*/
			if(x > 1 && field[x-2][y] == ct) count++;
			if(y > 0 && field[x-1][y-1] == ct) count++;
			if(y < size-1 && field[x-1][y+1] == ct) count++;
			if(count > 1) {
				if(x > 1 && field[x-2][y] == ct) {
					field[x-2][y]=0;
				}
				if(y > 0 && field[x-1][y-1] == ct) {
					field[x-1][y-1]=0;
				}
				if(y < size-1 && field[x-1][y+1] == ct) {
					field[x-1][y+1]=0;
				}
				field[x-1][y]=0;
				field[x][y]=ct+1;
			}
		break;
	}
	if(rc < 4 && where == 0) {
		rc++;
		checkneighbours(x, y, size, field[x][y], field, 0, 0, rc);
	}
}

void carrots(int size, int field[100][100], int comm[3]) {
	int l, x, y;
	l=comm[0];
	x=comm[1];
	y=comm[2];
	field[x][y]+=l;
	checkneighbours(x, y, size, field[x][y], field, 0, 0, 0);
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
