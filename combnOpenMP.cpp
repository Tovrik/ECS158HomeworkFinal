#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>
#include <algorithm>    // std::find
#include <omp.h>

using namespace std;

vector<int> values;
int *allCombs;
int *numEntriesPerLevel;

double choose(int n, int k) {
    if(k == 0) return 1; 
    return (n * choose(n - 1, k - 1)) / k;
}

void addComb(vector<vector<int> > &v, vector<int> &v2) {
	v.push_back(v2);
}

void findCombs(int offset, int k, vector<vector <int> > &v, vector<int> combination) {
	if (k == 0) {
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
	}
	#pragma omp barrier

	return allCombs;
}