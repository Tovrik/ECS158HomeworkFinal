#include <iostream>
#include <algorithm>
#include <vector>
#include <time.h>
#include <omp.h>
using namespace std;

vector < vector<int> > allCombinations;

int iter_factorial(int n)
{
  int ret = 1;
  for(unsigned int i = 1; i <= n; ++i)
    ret *= i;
  return ret;
}

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

void combn(vector<bool> permutation, int index) {
  vector<int> calculatedCombo;
  // Determine the number of 0's and the positions
  for(int i = 0; i < permutation.size(); i++) {
    if(!permutation[i]) {
      calculatedCombo.push_back(i+1);
    }
  }

  allCombinations[index] = calculatedCombo;
}

void calculateCombinations(int n, int r) {
  // Calculate total combinations and allocate well in advance
  allCombinations.resize( iter_factorial(n) / (iter_factorial(r) * iter_factorial(n - r)) );

  // Local Permutation storer
  vector< vector<bool> > allPermutations;
  omp_set_num_threads(8);
  vector<bool> v(n);
  fill(v.begin() + r, v.end(), true);

  // Push back all the permutations of 1's and 0's
  do {
    allPermutations.push_back(v);
  } while(std::next_permutation(v.begin(), v.end()));

  int s = allPermutations.size();
  #pragma omp parallel for
  for(int i = 0; i < s; ++i) {
    combn(allPermutations[i], i);
  }

}

vector< vector<int> > combnArr(vector<int> arr, int r) {
  int n = arr.size();
  vector<bool> v(n);
  //sort(arr.begin(), arr.end());
  fill(v.begin() + r, v.end(), true);
  
  omp_set_num_threads(8);

  do {
    vector<int> combinations;
    #pragma omp parallel for
    for (int i = 0; i < n; ++i) {
      cout << v[i];
      if (!v[i]) {
        #pragma omp critical
        combinations.push_back(arr[i]);
       }
       cout << endl;
    }
    sort(combinations.begin(), combinations.end());
    allCombinations.push_back(combinations);
   } while (std::next_permutation(v.begin(), v.end()));

  return allCombinations;
}

int main (int argc, char** argv) {
  int x = 5;
  int m = 3;
  // vector<int> arr;
  // arr.push_back(5);
  // arr.push_back(100);
  // arr.push_back(88);
  // arr.push_back(2);
  // arr.push_back(1);
  // arr.push_back(43);
  // arr.push_back(3);
  // arr.push_back(9);
  // arr.push_back(0);
  // arr.push_back(820);
  // vector<vector<int> > vals(10);
  clock_t startTime = clock();
  calculateCombinations(x,m);
  double z =  double( clock() - startTime ) / (double)CLOCKS_PER_SEC;
  print2d(allCombinations);
  cout << "Total combinations: " << allCombinations.size() << endl;
  cout << "Total seconds = " << z << endl;
  //print2d(allCombinations);
  return 0;
}
