#include <iostream>
#include <algorithm>
#include <vector>
#include <time.h>
#include <omp.h>
using namespace std;

//Prints a singe vector out
void print1d(const vector<int>& v) {
  static int count = 0;
  for(int i = 0; i < v.size(); i++) {
    cout << v[i] << " ";
  }
  cout << endl;
};

//prints a 2D vector out 
void print2d(const vector<vector<int> > &v) {
  for(int i = 0; i < v.size(); i++) {
    for(int j = 0; j < v[i].size(); j++) {
      cout << v[i][j] << " ";
    }
    cout << endl;
  }
};

vector< vector<int> > combn(int n, int r) {
  vector<bool> v(n);
  fill(v.begin() + r, v.end(), true);
  vector < vector<int> > allCombinations;
  omp_set_num_threads(8);

  do {
    vector<int> combinations;
    #pragma omp parallel for
    for (int i = 0; i < n; ++i) {
      if (!v[i]) {
        #pragma omp critical
        combinations.push_back((i+1));
       }
    }
    sort(combinations.begin(), combinations.end());
    allCombinations.push_back(combinations);
   } while (std::next_permutation(v.begin(), v.end()));

   return allCombinations;
}

vector< vector<int> > combnArr(vector<int> arr, int r) {
  int n = arr.size();
  vector<bool> v(n);
  //sort(arr.begin(), arr.end());
  fill(v.begin() + r, v.end(), true);
  vector < vector<int> > allCombinations;
  omp_set_num_threads(8);

  do {
    vector<int> combinations;
    #pragma omp parallel for
    for (int i = 0; i < n; ++i) {
      if (!v[i]) {
        #pragma omp critical
        combinations.push_back(arr[i]);
       }
    }
    sort(combinations.begin(), combinations.end());
    allCombinations.push_back(combinations);
   } while (std::next_permutation(v.begin(), v.end()));

   return allCombinations;
}

int main (int argc, char** argv) {
  int x = 10;
  int m = 3;
  vector<int> arr;
  arr.push_back(5);
  arr.push_back(100);
  arr.push_back(88);
  arr.push_back(2);
  arr.push_back(1);
  arr.push_back(43);
  arr.push_back(3);
  arr.push_back(9);
  arr.push_back(0);
  arr.push_back(820);
  vector<vector<int> > vals;
  // clock_t startTime = clock();
  vals = combnArr(arr,m);
  // cout << double( clock() - startTime ) / (double)CLOCKS_PER_SEC<< " seconds." << endl;
  cout << "Total combinations: " << vals.size() << endl;
  print2d(vals);
  return 0;
}