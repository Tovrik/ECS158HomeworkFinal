#include <thrust/device_vector.h>
#include <thrust/copy.h>
#include <thrust/iterator/zip_iterator.h>
#include <thrust/device_vector.h>
#include <thrust/tuple.h>
#include <list>
#include <vector>
#include <algorithm>
#include <iostream>
#include <stdio.h>
#include <thrust/reverse.h>
#include <thrust/iterator/counting_iterator.h>
#include <thrust/functional.h>
#include <thrust/sequence.h>
#include <thrust/remove.h>
#include <thrust/execution_policy.h>

typedef thrust::tuple<int, int>            tpl2int;
typedef thrust::device_vector<int>::iterator intiter;
typedef thrust::counting_iterator<int>     countiter;
typedef thrust::tuple<intiter, countiter>  tpl2intiter;
typedef thrust::zip_iterator<tpl2intiter>  idxzip;

int factorial(int n) {
  int prod = 1;
  for(int i = 1; i <= n; i++) {
    prod *= i;
  }
  return prod;
}


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

 void calculateCombinations(int n, int r) {
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
  //const int dev_bits_size = allBits.size();
  //thrust:: device_vector<int> seq(dev_bits_size);
  //thrust:: sequence(seq.begin(), seq.end(), 0);
  thrust::device_vector<int> allPositions(dev_bits.size());
  // thrust::copy(dev_bits.begin(), dev_bits.end(), std::ostream_iterator<float>(std::cout, " "));
  thrust::device_vector<int> indices(dev_bits.size());
  //typedef thrust::device_vector<int>::iterator IndexIterator;
  thrust::counting_iterator<int> first_iter(0);
  thrust::counting_iterator<int> last_iter = first_iter + dev_bits.size();
  // thrust::copy_if(dev_bits.begin(), dev_bits.end(), seq.begin(), indices.begin(), iseven());

  thrust::device_vector<int> allComb(chooseSize * r);
  
  idxzip first = thrust::make_zip_iterator(thrust::make_tuple(dev_bits.begin(), first_iter));
  idxzip last = thrust::make_zip_iterator(thrust::make_tuple(dev_bits.end(), last_iter));
  // //find_index fi();
   thrust::transform(first, last, allPositions.begin(), find_index());
 // // indices now contains [1,2,5,7]
  //idxzip iter(thrust::make_tuple(0, 1));
 // std::cout << "BLA = " << std:: endl;
 //  std::cout << thrust::get<0>(first[0]) << std::endl;;
 //  std::cout << thrust::get<0>(first[1]) << std::endl;;
  //std::cout << thrust::get<1>(first[7]) << std::endl;;
   //thrust::copy_if(in_array, in_array + size, out_array, is_not_zero);
  thrust:: copy_if(allPositions.begin(), allPositions.end(), allComb.begin(), remove_one());
  thrust::copy(allComb.begin(), allComb.end(), std::ostream_iterator<float>(std::cout, " "));
  printf("\n");
}


/* 
 * Computes the next lexicographical permutation of the specified vector in place,
 * returning whether a next permutation existed. (Returns false when the argument
 * is already the last possible permutation.)
 */

//prints a 2D vector out 
// void print2d(const vector<vector<int> > &v) {
//   for(int i = 0; i < v.size(); i++) {
//     for(int j = 0; j < v[i].size(); j++) {
//       cout << v[i][j] << " ";
//     }
//     cout << endl;
//   }
// };

// thrust:: host_vector< thrust:: host_vector<bool> > combn(int n, int r) {
//   thrust:: host_vector< thrust:: host_vector<bool> > allPermutations;
//   thrust:: host_vector<bool> v(n);
//   thrust:: fill(v.begin() + r, v.end(), true);
//   //do {
//     allPermutations.push_back(v);
  //} while(next_permutation1(v));

  // int s = allPermutations.size();
  // #pragma omp parallel for
  // for(int i = 0; i < s; ++i) {
  //   combn(allPermutations[i], i);
  // }







  // thrust:: device_vector<bool> v(n);
  // thrust:: fill(v.begin() + r, v.end(), true);
  // thrust:: device_vector < thrust:: device_vector<int> > allCombinations;

  // do {
  //   thrust:: device_vector<int> combinations;
  //   for (int i = 0; i < n; ++i) {
  //     if (!v[i]) {
  //       #pragma omp critical
  //       combinations.push_back((i+1));
  //      }
  //   }
  //   sort(combinations.begin(), combinations.end());
  //   allCombinations.push_back(combinations);
  //  } while (std::next_permutation(v.begin(), v.end()));

//    return allPermutations;
// }

int main (int argc, char** argv) {
  int x = 10;
  int m = 3;
  calculateCombinations(x, m);
  return 0;
}
