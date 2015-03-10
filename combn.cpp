#include <stdio.h>
#include <stdlib.h>
#include <iostream>

using namespace std;


int choose(int n, int k) {
    if(k == 0) 
    	return 1;
    return (n * choose(n - 1, k - 1)) / k;
}

int * combn(int x, int m) {
	int *ret = new int[choose(x,m)];
	int loc = 0;
	for(int i = 1; i <= x; i++) {
		for(int j = i + 1; j < x; j++) {
			ret[loc] = i;
			loc++;
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
	int * vals;
    vals = combn(x,m);
    int count = 0;
    for (int i = 0; i < choose(x,m); i++) {
    	cout << vals[i] << endl;
    	count++;
    	if(count % m == 0) cout << endl;
    }
    return 0;
}