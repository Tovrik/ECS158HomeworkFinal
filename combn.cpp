#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>
#include <algorithm>    // std::find

using namespace std;

vector<int> values;
//vector<int> combination;
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



void addComb(vector<vector<int> > &v, vector<int> &v2) {
  v.push_back(v2);
}

void findCombs(int offset, int k, vector<int> &combination, vector<vector <int> > &v) {
  if (k == 0) {
    //#pragma omp critical
    //print1d(combination);
    #pragma omp critical
    addComb(allCombinations, combination);
    return;
  }
  for(int i = offset; i <= values.size() - k; ++i) {
    combination.push_back(values[i]);
    findCombs(i + 1, k - 1, combination, v);
    combination.pop_back();
  }
}

void findEntriesPerLevel(int *array, int x, int m) {
  array[0] = 0;
  for(int i = 1; i < x - m + 1; i++) {
    array[i] = array[i] + (choose(x - i - 1, m - 1) * m);
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
  //combination.reserve(5);

  #pragma omp parallel for
  for(int i = 1; i <= x - m + 1; i++){  
    // Local to each thread.
    // May easily run out of space but meh.
    vector<vector <int> > levelCombinations;
    vector<int> combination;
    combination.push_back(i);
    findCombs(i, m - 1, combination, levelCombinations);
    // vectorToArray(levelCombinations, allCombs, numEntriesPerLevel[i - 1]);
    combination.pop_back();
  }
  //#pragma omp barrier
  //print2d(allCombinations);

  return allCombs;
}



int main (int argc, char** argv) {

  int x = 8;
  int m = 3;
  int * vals;
    vals = combn(x,m);
    int count = 0;
    // /print2d(vals);
    print2d(allCombinations);
    return 0;
}
