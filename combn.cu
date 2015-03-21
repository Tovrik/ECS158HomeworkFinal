#include <thrust/device_vector.h>
#include <thrust/copy.h>
#include <thrust/iterator/zip_iterator.h>
#include <thrust/device_vector.h>
#include <thrust/tuple.h>
#include <vector>
#include <algorithm>
#include <iostream>
#include <stdio.h>
#include <thrust/reverse.h>
#include <thrust/iterator/counting_iterator.h>
#include <thrust/functional.h>
#include <thrust/sequence.h>
#include <thrust/remove.h>

typedef thrust::tuple<int, int>            tpl2int;
typedef thrust::device_vector<int>::iterator intiter;
typedef thrust::counting_iterator<int>     countiter;
typedef thrust::tuple<intiter, countiter>  tpl2intiter;
typedef thrust::zip_iterator<tpl2intiter>  idxzip;

long long int factorial(int n) {
  long int prod = 1;
  long int i;
  for(i = 1; i <= n; i++) {
    prod = prod * i;
  }
  return prod;
};


struct find_index : public thrust::unary_function<tpl2int, int>
{
  __host__ __device__ int operator()(const tpl2int& x) const
  {
    // If an element is true, then you get the y coordinate of the position
    if (x.get<0>() == 0) {
      return (x.get<1>() % 5)+1;
    }
    else return -1;
   }
};

struct remove_one {
  __host__ __device__
  bool operator() (const int i) {
    return i != -1;
  }
};

thrust::host_vector<int> calculateCombinations(int n, int r) {
  std::vector<int> v(n);
  std::fill(v.begin() + r, v.end(), 1);
  int chooseSize = factorial(n) / (factorial(n-r)*factorial(r));
  thrust::host_vector<int> allBits( chooseSize * n  );
  int offset = 0;

  do {
    thrust::copy(v.begin(), v.end(), allBits.begin() + offset);
    offset += n;
  } while(next_permutation(v.begin(), v.end()));

  thrust::device_vector<int> dev_bits = allBits;
  thrust::device_vector<int> allPositions(dev_bits.size());
  thrust::counting_iterator<int> first_iter(0);
  thrust::counting_iterator<int> last_iter = first_iter + dev_bits.size();
  thrust::device_vector<int> allComb(chooseSize * r);
  
  idxzip first = thrust::make_zip_iterator(thrust::make_tuple(dev_bits.begin(), first_iter));
  idxzip last = thrust::make_zip_iterator(thrust::make_tuple(dev_bits.end(), last_iter));
  thrust:: transform(first, last, allPositions.begin(), find_index());
  thrust:: copy_if(allPositions.begin(), allPositions.end(), allComb.begin(), remove_one());
  
  thrust:: host_vector<int> returnArray(allComb.size());
  thrust:: copy(allComb.begin(), allComb.end(), returnArray.begin());
  return returnArray; 
}
int main (int argc, char** argv) {
  int x = 5;
  int m = 3;
  thrust::host_vector<int> vals = calculateCombinations(x, m);

  for(int i = 0; i < vals.size(); i++) {
    if(i % m == 0) {
      std::cout << std::endl;
    }
    std::cout << vals[i] << " ";
  }
  std::cout << std::endl;
  return 0;
}
