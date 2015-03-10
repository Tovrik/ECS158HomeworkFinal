#include <stdio.h>
#include <stdlib.h>
#include <iostream>

using namespace std;




int * combn(int x, int m) {
	int *ret = new int[x * m];

	int loc = 0;
	for(int i = 0; i < x; i++) {
		for(int j = i; j < i + m; j++) {
			ret[loc] = j;
			loc++;
		}
	}
	return ret;
}


template <typename T> 
T * combn(T x, int m) {

	
}


int main (int argc, char** argv) {

	int x = 10;
	int m = 2;
	int * vals[x * m];
    vals = combn(x,m);
    for (int i = 0; i < x * m; i++) {
    	cout << vals[x];
    }
    return 0;
}