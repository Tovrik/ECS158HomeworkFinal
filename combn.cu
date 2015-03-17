#include <thrust/device_vector.h>
#include <thrust/copy.h>
#include <list>
#include <vector>
#include <algorithm>
#include <iostream>
#include <stdio.h>
#include <thrust/reverse.h>
#include <thrust/iterator/counting_iterator.h>
#include <thrust/functional.h>
#include <thrust/sequence.h>
#include <thrust/execution_policy.h>
// struct find_one {
//   __device__ int operator(int& x) const {
//     return 
//   }
// };

// template<typename It>
// bool next_permutation1(It begin, It end) {
//     if (begin == end)
//                 return false;

//         It i = begin;
//         ++i;
//         if (i == end)
//                 return false;

//         i = end;
//         --i;

//         while (true)
//         {
//                 It j = i;
//                 --i;

//                 if (*i < *j)
//                 {
//                         It k = end;

//                         while (!(*i < *--k))
//                                 /* pass */;

//                         iter_swap(i, k);
//                         reverse(j, end);
//                         return true;
//                 }

//                 if (i == begin)
//                 {
//                         reverse(begin, end);
//                         return false;
//                 }
//         }
// };

struct is_zero
  {
    __host__ __device__
    bool operator()(const bool x)
    {
      return (x == 0);
    }
  };

 void calculateCombinations(int n, int r) {
  //std:: vector< std:: vector<bool> > allPermutations;
  //omp_set_num_threads(8);
  std:: vector<int> v(n);
  std:: fill(v.begin() + r, v.end(), 1);
  thrust:: host_vector<int> allBits(50);
  int offset = 0;
  // storage for the nonzero indices
  //  thrust::device_vector<int> seq(n);
  // thrust::sequence(seq.begin(), seq.end(), 0);
  // thrust::device_vector<int> out(r);
  // compute indices of nonzero elements
  //  thrust::device_vector<int> indices(n);
  // typedef thrust::device_vector<int>::iterator IndexIterator;
  // thrust::counting_iterator<int> first(0);
  // thrust::counting_iterator<int> last = first + n;
   

  do {
    //thrust::copy(v.begin(), v.end(), std::ostream_iterator<float>(std::cout, " "));
    // allPermutations.push_back(v);
    // IndexIterator indices_end = thrust::copy_if(thrust::make_counting_iterator(0),
    //                                            thrust::make_counting_iterator(n),
    //                                            v.begin(),
    //                                            indices.begin(),
    //                                            is_zero());
    //printf("\n");
    // thrust:: copy_if (v.begin(), v.end(), seq.begin(), out.begin(), thrust::identity<int>());
    //thrust::device_vector<int> d_vec(v.begin(), v.end());
    //thrust::copy_if(d_vec.begin(), d_vec.end(), indices.begin(), is_zero());
    thrust::copy(v.begin(), v.end(), allBits.begin()+offset);
    offset += n;
    printf("\n");
  } while(next_permutation(v.begin(), v.end()));
thrust::copy(allBits.begin(), allBits.end(), std::ostream_iterator<float>(std::cout, " "));
  // storage for the nonzero indices
   
  //int s = allPermutations.size();
  // #pragma omp parallel for
  //  for(int i = 0; i < s; ++i) {
  //   combn(allPermutations[i], i);
  // }
//   thrust::device_vector< thrust::device_vector<bool> > d_vec(h_list.begin(), h_list.end
// ());
  //printf("s = %d", s);
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
  int x = 5;
  int m = 3;
  calculateCombinations(x, m);
  return 0;
}