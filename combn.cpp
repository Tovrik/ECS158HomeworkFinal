#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>
#include <algorithm>    // std::find
#include <omp.h>

using namespace std;

vector<int> values;
// vector<int> combination;
vector<vector <int> > allCombinations;
int *allCombs;
int *numEntriesPerLevel;

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

void printArray(int a[], int size, int m) {
	for(int i = 0; i < size; i++){
		if(i % m == 0)
			cout << endl;
		cout << a[i] << " ";
	}
	cout << endl;
}


void addComb(vector<vector<int> > &v, vector<int> &v2) {
	v.push_back(v2);
}

void findCombs(int offset, int k, vector<vector <int> > &v, vector<int> combination) {
	if (k == 0) {
		// print1d(combination);
		addComb(v, combination);
		return;
	}
	for(int i = offset; i <= values.size() - k; ++i) {
		combination.push_back(values[i]);
		findCombs(i + 1, k - 1, v, combination);
		combination.pop_back();
	}
}

void findEntriesPerLevel(int *array, int x, int m) {
	array[0] = 0;
	for(int i = 1; i < x - m + 1; i++) {
		array[i] = array[i - 1] + (choose(x - i, m - 1) * m);
	}
}

void vectorToArray(vector<vector <int> > &v, int a[], int startIndex) {
	vector< vector<int> >::const_iterator row; 
    vector<int>::const_iterator col; 
    int index = startIndex;

    for (row = v.begin(); row != v.end(); ++row)
    { 
         for (col = row->begin(); col != row->end(); ++col)
         { 
            a[index] = *col; 
            index++;
         } 
    } 
}

int * combn(int x, int m) {
	int size = choose(x,m); 
	for(int i = 0; i < x; ++i)
		values.push_back(i+1);

	allCombs = new int[size * m];
	numEntriesPerLevel = new int[x - m + 1];
	findEntriesPerLevel(numEntriesPerLevel, x, m);


	#pragma omp parallel for schedule(dynamic)
	for(int i = 1; i <= x - m + 1; i++){
		vector<vector <int> > levelCombinations;
		vector<int> combination;
		combination.push_back(i);
		findCombs(i, m - 1, levelCombinations, combination);
		vectorToArray(levelCombinations, allCombs, numEntriesPerLevel[i - 1]);
		combination.pop_back();
		// print2d(levelCombinations);
	}
	// printArray(allCombs, size * m, m);
	#pragma omp barrier

	return allCombs;
}



int main (int argc, char** argv) {

	int x = 28;
	int m = 14;
	int * vals;
	double startTime, endTime;
	startTime = omp_get_wtime();
    vals = combn(x,m);
    endTime = omp_get_wtime();

	printf("%f,",endTime-startTime);


    int count = 0;

    delete[] allCombs;
    delete[] numEntriesPerLevel;

    return 0;
}