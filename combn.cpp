#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>

using namespace std;

vector<int> values;
vector<int> combination;
vector<vector <int> > allCombinations;

double choose(int n, int k) {
    if(k == 0) return 1; 
    return (n * choose(n - 1, k - 1)) / k;
}

void print1d(const vector<int>& v) {
	static int count = 0;
	for(int i = 0; i < v.size(); i++) {
		cout << v[i] << " ";
	}
	cout << endl;
}

void print2d(const vector<vector<int> > &v) {
	for(int i = 0; i < v.size(); i++) {
		for(int j = 0; j < v[i].size(); j++) {
			cout << v[i][j] << " ";
		}
		cout << endl;
	}
}

void addComb(vector<vector<int> > &v, vector<int> &v2) {
	// print1d(v2);
	v.push_back(v2);
}

void go(int offset, int k) {
	if (k == 0) {
		// print1d(combination);
		addComb(allCombinations, combination);
		return;
	}
	for(int i = offset; i <= values.size() - k; ++i) {
		combination.push_back(values[i]);
		go(i + 1, k - 1);
		combination.pop_back();
	}
}

int * combn(int x, int m) {
	int num = choose(x,m);
	for(int i = 0; i < x; ++i)
		values.push_back(i+1);
	go(0,m);
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