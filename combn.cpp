#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>

using namespace std;

vector<int> values;
vector<int> combination;
vector<vector <int> > allCombinations;


//custom implementation of the choose function (n_Choose_k)
double choose(int n, int k) {
    if(k == 0) return 1; 
    return (n * choose(n - 1, k - 1)) / k;
}


//Prints a singe vector out
void print1d(const vector<int>& v) {
	static int count = 0;
	for(int i = 0; i < v.size(); i++) {
		cout << v[i] << " ";
	}
	cout << endl;
}

//prints a 2D vector out 
void print2d(const vector<vector<int> > &v) {
	for(int i = 0; i < v.size(); i++) {
		for(int j = 0; j < v[i].size(); j++) {
			cout << v[i][j] << " ";
		}
		cout << endl;
	}
}

//pushes a 1D vector onto a 2D vector
void addComb(vector<vector<int> > &v, vector<int> &v2) {
	// print1d(v2);
	v.push_back(v2);
}

//work function that recursively finds combinations
//offset is the start value, k is the number of values to look for in the combination
void findCombs(int offset, int k) {
	if (k == 0) {
		// print1d(combination);
		addComb(allCombinations, combination);
		return;
	}
	for(int i = offset; i <= values.size() - k; ++i) {
		combination.push_back(values[i]);
		findCombs(i + 1, k - 1);
		combination.pop_back();
	}
}

//
int * combn(int x, int m) {
	int num = choose(x,m);
	for(int i = 0; i < x; ++i)
		values.push_back(i+1);
	findCombs(0,m);
	print2d(allCombinations);



	int *ret = new int[num * m];


	return ret;
}




// template <typename T> 
// T * combn(T x, int m) {

	
// }



int main (int argc, char** argv) {

	int x = 10;
	int m = 3;
	int * vals;
    vals = combn(x,m);
    int count = 0;

    // cout << choose(45,22);
    return 0;
}